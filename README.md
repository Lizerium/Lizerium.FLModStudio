<div align="center" style="margin: 20px 0; padding: 10px; background: #1c1917; border-radius: 10px;">
  <strong>🌐 Language: </strong>
  
  <a href="./README.ru.md" style="color: #F5F752; margin: 0 10px;">
    🇷🇺 Russian
  </a>
  | 
  <span style="color: #0891b2; margin: 0 10px;">
    ✅ 🇺🇸 English (current)
  </span>
</div>

---

> [!NOTE]
> This project is part of the **Lizerium** ecosystem and belongs to:
>
> - [`Lizerium.Frameworks.Structs`](https://github.com/Lizerium/Lizerium.Frameworks.Structs)
>
> If you are looking for related engineering and utility tools, start there.

# Lizerium Freelancer Mod Studio

Mod Studio is my fork Windows desktop IDE for editing Microsoft Freelancer mod data. I use it as a structured INI editor with template-aware validation, a dockable WinForms workspace, and a 3D system designer built on WPF/Helix.

The current documentation describes version `1.3.1.1`. When I change the application behavior in later releases, I keep the version in each document heading so it is clear which codebase the notes describe.

> [!NOTE]
> [Changelog](CHANGELOG.md)

## What It Does

- Opens Freelancer INI-style data files and maps them into editable blocks and options.
- Uses `Template.xml` to know which file types, blocks, options, value types, descriptions, and categories are valid.
- Provides a table editor with undo/redo, copy/paste, drag-and-drop ordering, modified-state coloring, and property-grid editing.
- Visualizes systems, universe entries, archetypes, equipment, ships, effects, zones, lights, and connections in the 3D editor where the selected file type supports it.
- Stores user settings, themes, update preferences, recent files, layout, colors, and reusable block templates.
- Checks and installs application updates through the Inno Setup installer flow.

## Solution Layout

- `FreelancerModStudio/` - the main WinForms/WPF application.
- `FLUtils/` - local utility library restored into the repository.
- `HelixEngine/` - 3D/WPF rendering support library.
- `FreelancerModStudio.Tests/` - MSTest coverage and extracted developer smoke tools for the main application.
- `FLUtils.Tests/` - MSTest coverage for the restored utility library.
- `Setup/` - Inno Setup installer scripts for the main application.
- `SystemWatcher/` - older companion/update-related project files kept in the solution tree.
- `docs/` - architecture, build, testing, and template-system documentation.

## Documentation

- [Architecture](docs/architecture.md)
- [Template System](docs/template-system.md)
- [Testing and Developer Tools](docs/testing-and-devtools.md)
- [Build and Release](docs/build-and-release.md)
- [Russian README](README.ru.md)

## Requirements

- Windows.
- Visual Studio 2022 or compatible MSBuild tooling.
- .NET Framework 4.8 Developer Pack for the main application, `FLUtils`, and the test projects.
- Inno Setup when I need to build the installer from `Setup/setup.iss`.

`HelixEngine` still targets .NET Framework 4.6, while the restored application projects target .NET Framework 4.8.

## Build

From the repository root:

```powershell
& "C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe" FreelancerModStudio.sln /v:m
```

For a release build used by the installer:

```powershell
& "C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe" FreelancerModStudio.sln /p:Configuration=Release /v:m
```

## Tests

After building, I run the test assemblies with Visual Studio Test Platform:

```powershell
& "C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe" FLUtils.Tests\bin\Debug\FLUtils.Tests.dll
& "C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe" FreelancerModStudio.Tests\bin\Debug\FreelancerModStudio.Tests.dll
```

One smoke test is intentionally skipped unless I set `FREELANCER_DATA_PATH` to a real Freelancer `DATA` directory.

## Update Source

The updater reads the published installer script directly:

```text
https://raw.githubusercontent.com/Lizerium/Lizerium.FLModStudio/master/Setup/setup.iss
```

It extracts `#define MyAppVersion '1.3.1.1'` from `Setup/setup.iss` and builds the release asset URL as:

```text
https://github.com/Lizerium/Lizerium.FLModStudio/releases/download/1.3.1.1/FreelancerModStudio-1.3.1.1.exe
```

## Early authors

- [stfx](https://github.com/DomGries) - 2009-2013
- [Freelancer Aftermath](https://github.com/AftermathFreelancer) - 2019-2020
- [Lazrius](https://github.com/Lazrius) - 2020
