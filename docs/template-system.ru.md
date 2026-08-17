# Система Шаблонов Для Версии 1.3.1.1

Этот документ описывает, как я использую `Template.xml` в версии `1.3.1.1`.

## Назначение

`Template.xml` - это контракт между сырыми Freelancer INI-файлами и UI редактора. Приложение не воспринимает каждый INI как безымянный текстовый файл. Сначала оно читает template, а потом по нему решает, какие файлы известны, какие блоки могут существовать, какие options принадлежат блоку и какие значения достаточно валидны, чтобы показать их в property editor.

## Где Загружается

`Helper.Template.Load()` загружает template из application startup path через настроенный `Resources.TemplatePath`. Во время старта `Helper.Program.Start()` сначала грузит settings, потом template, и только после этого показывает `MainForm`.

После загрузки `Helper.Template.Load()` находит важные built-in file indexes:

- system file.
- universe file.
- solar archetype file.
- asteroid archetype file.
- ship archetype file.
- equipment file.
- effect explosions file.

Эти индексы потом используются в `FrmTableEditor`, чтобы выбрать правильный `ViewerType`.

## Schema В Коде

`Data/Template.cs` - кодовое представление XML. Root называется `FreelancerModStudio-Template-1.0`.

Главные template objects:

- `TemplateData` - полный template document.
- `File` - один поддерживаемый data file type и paths, по которым он определяется.
- `Block` - named INI section с options, multiplicity и optional identifier.
- `Option` - named INI option с type, parent, category, enum, rename metadata и description.
- `Language`, `Category` и `Description` - metadata для localized descriptions в UI.
- `CostumTypes` и `CostumEnum` - custom value lists.

Написание `Costum` - часть существующей code model в этой версии, поэтому я оставляю его как есть, если отдельно не планирую compatibility migration.

## Как Это Использует Редактор

Когда я открываю файл, `MainForm` определяет template index и создает `FrmTableEditor`. Table editor читает файл через `FileManager`, а потом использует `Helper.Template.Data.Files[templateIndex]`, чтобы собрать editing experience.

Template управляет:

- Add menu для новых блоков.
- default options, которые создаются внутри нового блока.
- заменой single-instance block, когда `multiple` равен false.
- identifier option, которая используется как читаемое имя блока.
- property-grid categories и descriptions.
- базовой валидацией значений через `Template.OptionType`.

Если значение не подходит к ожидаемому option type, `FrmTableEditor` отклоняет property-grid change и сохраняет editor data консистентными.

## Как Это Использует 3D

Template также является переключателем, который решает, можно ли открыть 3D designer для документа. `FrmTableEditor.SetViewerType()` мапит special template indexes в system, universe, solar archetype или model preview modes.

`SystemParser` затем интерпретирует известные block/option names и мапит их в 3D content. Например, system objects, zones, lights и universe systems определяются из table blocks, которые пришли из template-aware INI parsing.

## Template Generation Dev Tool

Старая логика из `DevTest.cs` теперь считается developer tool в тестовом проекте, а не runtime-кодом приложения. В версии `1.3.1.1` helper генерации шаблона лежит в `FreelancerModStudio.Tests/DevTools/TemplateGenerationDevTool.cs`.

Я использую его, чтобы сканировать реальные Freelancer data и находить формы block/option. MSTest wrapper проверяет поведение на контролируемых test data, а сам tool не попадает в shipped WinForms application.

## Правила Поддержки

Когда я редактирую `Template.xml`, я проверяю три вещи:

- приложение все еще загружает template на старте;
- затронутый file type все еще открывается в `FrmTableEditor`;
- если file type визуальный, соответствующий `ViewerType` и поведение `SystemParser` все еще имеют смысл.

Когда я переименовываю block или option, я думаю, нужна ли `renameFrom` metadata, чтобы старые данные продолжали читаться.
