# Архитектура Для Версии 1.3.1.1

Это моя карта того, как работает `FreelancerModStudio/` в версии `1.3.1.1`. Я держу здесь фокус на runtime-приложении: старт, загрузка данных, редакторы, 3D designer, настройки, обновления и места, где модули связаны друг с другом.

## Общая Форма Runtime

Приложение - это .NET Framework 4.8 WinForms desktop app с WPF, встроенным в область 3D-редактора. Главная оболочка находится в `Forms/MainForm.cs`, а dockable-интерфейс строится через DockPanelSuite.

На верхнем уровне я смотрю на приложение как на четыре слоя:

- `Helper` классы отвечают за сервисы старта: настройки, шаблоны, обновления, показ исключений, строковые helper-операции и метаданные сборки.
- `Data` классы держат редактируемую модель: распарсенные INI-блоки и опции, template metadata, undo-записи, clipboard payloads, сериализацию и чтение/запись файлов.
- `Forms` и `Controls` отвечают за WinForms UI: главную оболочку, табличный редактор, окна настроек, property editing и переиспользуемые UI-хелперы.
- `SystemDesigner` отвечает за WPF/Helix 3D-view и превращает INI table blocks в визуальные объекты.

`FLUtils` теперь не внешний submodule в этом рабочем дереве. Я держу его как локальный utility-проект с `AssemblyUtils` и `ExceptionUtils`, а основное приложение ссылается на него напрямую.

## Поток Старта

Точка входа - `Program.Main()`. Она включает WinForms visual styles, ставит обработчик unhandled exception и передает реальный bootstrap в `Helper.Program.Start()`.

`Helper.Program.Start()` поднимает приложение в таком порядке:

- Загружает сохраненные настройки через `Helper.Settings.Load()`.
- Ставит скачанное обновление, если updater state говорит, что оно готово.
- Загружает `Template.xml` через `Helper.Template.Load()`.
- Настраивает общий UI rendering.
- Удаляет уже примененный installer, если update state разрешает cleanup.
- Проверяет обновления по сохраненному расписанию.
- Запускает `MainForm`.
- Сохраняет настройки при закрытии.

Это значит, что `Template.xml` и settings являются runtime input. Если один из них сломан, приложение может компилироваться, но редактор будет вести себя неправильно.

## Главная Оболочка

`MainForm` - это координатор. Он восстанавливает dock layout, открывает файлы из command line, инициализирует `PropertiesForm`, инициализирует `SystemEditorForm` и держит команды меню.

Главные обязанности `MainForm`:

- Открывать файлы и выбирать file type template, если автоматического определения недостаточно.
- Хранить recent-file list в settings.
- Создавать документы `FrmTableEditor` для открытых INI-файлов.
- Показывать, скрывать или обновлять 3D System Designer в зависимости от активного документа.
- Передавать selection из table editor в 3D-view.
- Передавать selection и manipulation из 3D-view обратно в активный table editor.
- Сохранять layout, размер окна, fullscreen state и другие UI settings.

Главная связь здесь event-based. `FrmTableEditor` поднимает события data/selection/visibility/document. `SystemEditorForm` поднимает события selection, file-open и data-manipulation. `MainForm` стоит между ними и синхронизирует оба представления.

## Поток Table Editor

`Forms/TableEditorForm.cs` - основной document editor для распарсенных INI-данных. Он получает template index и путь к файлу, читает файл через `FileManager` и держит редактируемый контент в `EditorIniData`.

Редактор template-aware. Он использует `Helper.Template.Data.Files[templateIndex]`, чтобы знать:

- какие block names можно добавлять;
- какие options принадлежат блоку;
- может ли блок встречаться несколько раз;
- какая option является идентификатором отображаемого имени блока;
- какой value type должен приниматься.

Table editor оборачивает каждый распарсенный блок в `TableBlock`. `TableBlock` несет display state: index, modified state, visibility, object type, archetype и tooltip data. Когда я редактирую properties, добавляю блоки, удаляю блоки, вставляю блоки или двигаю строки, editor записывает изменение через `UndoManager<ChangedData>`.

Для типов файлов, которые можно визуализировать, `FrmTableEditor.SetViewerType()` мапит template index в `ViewerType`:

- system files используют `ViewerType.System`;
- universe files используют `ViewerType.Universe`;
- solar archetypes используют `ViewerType.SolarArchetype`;
- asteroid, ship, equipment и effect explosion files используют `ViewerType.ModelPreview`;
- все остальное использует `ViewerType.None`.

## Модель Данных

INI editing model разделен на raw/editor data и UI-friendly table data.

- `IniBlock`, `IniOption` и `IniOptions` представляют распарсенную INI-структуру.
- `EditorIniData`, `EditorIniBlock`, `EditorIniOption` и `EditorIniEntry` добавляют template indexes и editor-specific state.
- `TableBlock`, `TableData` и родственные table-классы дают list-view rows, display labels, change flags и 3D metadata.
- `ChangedData` описывает обратимые изменения для undo/redo.
- `FileManager`, `IniManager`, `BiniManager` и `UtfManager` отвечают за file formats, которые понимает редактор.

Я стараюсь держать большую часть editor behavior вокруг этой модели. Forms должны отображать или менять `TableBlock` и `EditorIniData`; parser/writer классы должны переводить эти объекты в файлы и обратно.

## Template System

`Data/Template.cs` описывает XML-схему, которая читается из `Template.xml`. Root сериализуется как `FreelancerModStudio-Template-1.0`.

Template files задают:

- поддерживаемые Freelancer data file types;
- paths, которые относятся к каждому file type;
- valid blocks для каждого file type;
- valid options для каждого блока;
- option types вроде string, int, double, bool, vector, rgb, path и arrays;
- categories и descriptions для property editor;
- custom enum-like values.

`Helper.Template.Load()` дополнительно находит special file indexes: system, universe, solar archetype, asteroid archetype, ship archetype, equipment и effect explosions. Именно эти индексы связывают общий table editor со специализированными 3D modes.

## System Designer

`SystemDesigner` - это 3D-слой. Он использует WPF 3D и Helix, чтобы показать Freelancer content, полученный из `TableBlock` data.

Главные части:

- `SystemEditorForm` хостит viewport и публикует события в `MainForm`.
- `Presenter` владеет viewport content, selection, manipulation, camera actions, model loading, universe connections и visual refresh.
- `SystemParser` мапит значения `TableBlock` в content objects и записывает измененные 3D values обратно в table blocks.
- `Analyzer` читает universe/system relationships и строит connections.
- `UtfModel` грузит Freelancer model data, когда доступен реальный model preview.
- `SystemDesigner/Content` содержит visual object types: systems, zones, objects, lights и connections.

Designer поддерживает selection sync в обе стороны. Выбор строки может выбрать 3D object, а клик по 3D object может выбрать соответствующий table block. Manipulation во viewport создает old/new snapshots `TableBlock`, которые `MainForm` отправляет обратно в активный table editor как обычное undoable data change.

## Settings И Persistence

`Helper.Settings` грузит и сохраняет user settings в application data folder. Settings включают:

- general preferences.
- language и theme.
- update schedule и updater state.
- editor colors и 3D colors.
- recent files.
- form layout и sizes.
- user-created block templates.

`Helper.Settings.LoadTemplates()` копирует сохраненные user templates в template-aware menus, которые использует `FrmTableEditor`. Так workflow "create template from selected object" становится доступен позже как reusable insert actions.

## Обновления

Updater разделен между `Helper.Update` и namespace `AutoUpdate`. Проверка обновления скачивает raw `Setup/setup.iss` из `Lizerium/Lizerium.FLModStudio`, достает `MyAppVersion`, строит GitHub release asset URL, сравнивает эту версию с `AssemblyUtils.Version` и может скачать installer в настроенную update location.

Installer flow хранит состояние:

- `Downloaded` значит, что installer есть и его надо запустить.
- `Installed` значит, что новая версия может удалить installer file.
- Старые Google Code и `AftermathFreelancer/FLModStudio` update URLs из settings мигрируются на raw `Setup/setup.iss` URL репозитория `Lizerium/Lizerium.FLModStudio`.

Release script в `Setup/setup.iss` ожидает release binaries из `FreelancerModStudio/bin/Release` и пакует `FreelancerModStudio.exe`, `FLUtils.dll`, generated serializers, `HelixEngine.dll`, runtime facade assemblies, `Template.xml` и default settings files.

## Практические Точки Расширения

Когда я добавляю новый поддерживаемый INI file type, я обычно начинаю с `Template.xml`, потом проверяю parser/editor behavior через `FreelancerModStudio.Tests`.

Когда я добавляю новый visual object type, я ожидаю правки в `SystemParser`, `ContentType`, соответствующем `Content` классе и `Presenter.CreateContent()`.

Когда я меняю editing behavior, я смотрю `FrmTableEditor`, `UndoManager<ChangedData>`, `ChangedData` и property-grid классы вместе, потому что это основной edit pipeline.

Когда я меняю startup, update или settings behavior, я смотрю `Helper.Program`, `Helper.Settings`, `Helper.Template` и `Helper.Update` вместе, потому что порядок bootstrapping важен.
