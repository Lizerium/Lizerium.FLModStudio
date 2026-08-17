<div align="center" style="margin: 20px 0; padding: 10px; background: #1c1917; border-radius: 10px;">
  <strong>🌐 Язык: </strong>
  
  <span style="color: #F5F752; margin: 0 10px;">
    ✅ 🇷🇺 Русский (текущий)
  </span>
  | 
  <a href="./README.md" style="color: #0891b2; margin: 0 10px;">
    🇺🇸 English
  </a>
</div>

---

> [!NOTE]
> Этот проект является частью экосистемы **Lizerium** и относится к направлению:
>
> - [`Lizerium.Software.Structs`](https://github.com/Lizerium/Lizerium.Software.Structs)
>
> Если вы ищете связанные инженерные и вспомогательные инструменты, начните оттуда.

# Lizerium Freelancer Mod Studio

Mod Studio - это мой форк Windows IDE для редактирования данных модов Microsoft Freelancer. Я использую его как структурированный INI-редактор с шаблонами, dockable-интерфейсом на WinForms и 3D System Designer на WPF/Helix.

Эта документация описывает версию `1.3.1.1`. Когда я меняю поведение приложения в будущих версиях, я оставляю версию в заголовке каждого документа, чтобы было понятно, для какого состояния проекта написаны заметки.

> [!NOTE]
> [Изменения](CHANGELOG.md)

## Что Умеет

- Открывает INI-подобные файлы Freelancer и раскладывает их на редактируемые блоки и опции.
- Использует `Template.xml`, чтобы понимать допустимые типы файлов, блоки, опции, типы значений, описания и категории.
- Дает табличный редактор с undo/redo, copy/paste, drag-and-drop сортировкой, подсветкой измененных строк и редактированием через property grid.
- Показывает системы, universe-записи, архетипы, equipment, корабли, эффекты, зоны, источники света и связи в 3D-редакторе там, где это поддерживает тип файла.
- Хранит настройки пользователя, тему, обновления, recent files, layout, цвета и пользовательские шаблоны блоков.
- Проверяет и ставит обновления через Inno Setup installer flow.

## Структура Решения

- `FreelancerModStudio/` - основное WinForms/WPF-приложение.
- `FLUtils/` - локальная utility-библиотека, восстановленная внутрь репозитория.
- `HelixEngine/` - библиотека поддержки 3D/WPF-рендеринга.
- `FreelancerModStudio.Tests/` - MSTest-покрытие и вынесенные developer smoke tools для основного приложения.
- `FLUtils.Tests/` - MSTest-покрытие для восстановленной utility-библиотеки.
- `Setup/` - Inno Setup скрипты установщика основного приложения.
- `SystemWatcher/` - старый companion/update-related проект, который остается в дереве решения.
- `docs/` - документация по архитектуре, сборке, тестам и шаблонной системе.

## Документация

- [Архитектура](docs/architecture.ru.md)
- [Система шаблонов](docs/template-system.ru.md)
- [Тесты и developer tools](docs/testing-and-devtools.ru.md)
- [Сборка и релиз](docs/build-and-release.ru.md)
- [English README](README.md)

## Требования

- Windows.
- Visual Studio 2022 или совместимые MSBuild-инструменты.
- .NET Framework 4.8 Developer Pack для основного приложения, `FLUtils` и тестовых проектов.
- Inno Setup, когда я собираю установщик из `Setup/setup.iss`.

`HelixEngine` пока таргетит .NET Framework 4.6, а восстановленные проекты приложения и тестов таргетят .NET Framework 4.8.

## Сборка

Из корня репозитория:

```powershell
& "C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe" FreelancerModStudio.sln /v:m
```

Для Release-сборки, которую ожидает установщик:

```powershell
& "C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe" FreelancerModStudio.sln /p:Configuration=Release /v:m
```

## Тесты

После сборки я запускаю тестовые сборки через Visual Studio Test Platform:

```powershell
& "C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe" FLUtils.Tests\bin\Debug\FLUtils.Tests.dll
& "C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe" FreelancerModStudio.Tests\bin\Debug\FreelancerModStudio.Tests.dll
```

Один smoke-тест специально пропускается, если я не задал `FREELANCER_DATA_PATH` на реальную папку Freelancer `DATA`.

## Источник Обновлений

Updater читает опубликованный installer script напрямую:

```text
https://raw.githubusercontent.com/Lizerium/Lizerium.FLModStudio/master/Setup/setup.iss
```

Он достает `#define MyAppVersion '1.3.1.1'` из `Setup/setup.iss` и строит release asset URL так:

```text
https://github.com/Lizerium/Lizerium.FLModStudio/releases/download/1.3.1.1/FreelancerModStudio-1.3.1.1.exe
```

## Ранние авторы

- [stfx](https://github.com/DomGries) - 2009-2013
- [Freelancer Aftermath](https://github.com/AftermathFreelancer) - 2019-2020
- [Lazrius](https://github.com/Lazrius) - 2020
