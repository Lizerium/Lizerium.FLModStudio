# Architecture For Version 1.3.1.1

This document is my map of how `FreelancerModStudio/` works in version `1.3.1.1`. I keep it focused on the runtime application: startup, data loading, editors, the 3D designer, settings, updates, and the places where the modules talk to each other.

## Runtime Shape

The application is a .NET Framework 4.8 WinForms desktop app with WPF hosted inside the 3D editor area. The main shell is `Forms/MainForm.cs`, and it uses DockPanelSuite to show document tabs, docked tool windows, and the System Designer.

At a high level I treat the app as four cooperating layers:

- `Helper` classes own startup services: settings, templates, update checks, exception display, string helpers, and assembly metadata.
- `Data` classes own the editable model: parsed INI blocks/options, template metadata, undo records, clipboard payloads, serializers, and file readers/writers.
- `Forms` and `Controls` own the WinForms user interface: main shell, table editor, options dialogs, property editing, and reusable UI helpers.
- `SystemDesigner` owns the WPF/Helix 3D view and maps INI table blocks into visual content.

`FLUtils` is no longer an external submodule in this working tree. I keep it as a local utility project with `AssemblyUtils` and `ExceptionUtils`, and the main application references it directly.

## Startup Flow

The entry point is `Program.Main()`. It enables WinForms visual styles, installs an unhandled exception handler, and delegates real bootstrapping to `Helper.Program.Start()`.

`Helper.Program.Start()` does the application setup in this order:

- Load persisted settings through `Helper.Settings.Load()`.
- Install a downloaded update if the updater state says one is ready.
- Load `Template.xml` through `Helper.Template.Load()`.
- Configure shared UI rendering.
- Remove an installer that was already applied, if the update state says it can be cleaned.
- Check for updates according to the saved schedule.
- Run `MainForm`.
- Save settings on shutdown.

This means `Template.xml` and settings are runtime inputs. If either one is broken, the app may start with bad editor behavior even when the binaries compile.

## Main Shell

`MainForm` is the coordinator. It restores the dock layout, opens command-line files, initializes `PropertiesForm`, initializes `SystemEditorForm`, and owns the menu commands.

The most important responsibilities in `MainForm` are:

- Open files and choose a template file type when automatic detection is not enough.
- Keep a recent-file list in settings.
- Create `FrmTableEditor` documents for opened INI files.
- Show, hide, or refresh the 3D System Designer depending on the active document.
- Relay table-editor selection changes into the 3D view.
- Relay 3D selection and manipulation changes back into the active table editor.
- Save layout, window size, fullscreen state, and other UI settings.

The main coupling point is event-based. `FrmTableEditor` raises data/selection/visibility/document events. `SystemEditorForm` raises selection, file-open, and data-manipulation events. `MainForm` sits between them and keeps both views synchronized.

## Table Editor Flow

`Forms/TableEditorForm.cs` is the default document editor for parsed INI data. It receives a template index and a file path, reads the file through `FileManager`, and stores the editable content in `EditorIniData`.

The editor is template-aware. It uses `Helper.Template.Data.Files[templateIndex]` to know:

- Which block names can be added.
- Which options belong to a block.
- Whether a block can appear multiple times.
- Which option identifies the displayed block name.
- Which value type should be accepted.

The table editor wraps each parsed block into `TableBlock`. `TableBlock` carries display state such as index, modified state, visibility, object type, archetype, and tooltip data. When I edit properties, add blocks, delete blocks, paste blocks, or move rows, the editor records the change through `UndoManager<ChangedData>`.

For file types that can be visualized, `FrmTableEditor.SetViewerType()` maps the template index into a `ViewerType`:

- system files use `ViewerType.System`.
- universe files use `ViewerType.Universe`.
- solar archetypes use `ViewerType.SolarArchetype`.
- asteroid, ship, equipment, and effect explosion files use `ViewerType.ModelPreview`.
- everything else uses `ViewerType.None`.

## Data Model

The INI editing model is split into raw/editor data and UI-friendly table data.

- `IniBlock`, `IniOption`, and `IniOptions` represent parsed INI structures.
- `EditorIniData`, `EditorIniBlock`, `EditorIniOption`, and `EditorIniEntry` add template indexes and editor-specific state.
- `TableBlock`, `TableData`, and related table classes provide list-view rows, display labels, change flags, and 3D metadata.
- `ChangedData` describes reversible edits for undo/redo.
- `FileManager`, `IniManager`, `BiniManager`, and `UtfManager` handle the file formats the editor understands.

The project intentionally keeps most editor behavior around this model. Forms should display or mutate `TableBlock` and `EditorIniData`; parser/writer classes should translate those objects to and from files.

## Template System

`Data/Template.cs` defines the XML schema consumed from `Template.xml`. The root is serialized as `FreelancerModStudio-Template-1.0`.

Template files define:

- supported Freelancer data file types.
- paths that belong to each file type.
- valid blocks for each file type.
- valid options for each block.
- option types such as string, int, double, bool, vector, rgb, path, and arrays.
- categories and descriptions used by the property editor.
- custom enum-like values.

`Helper.Template.Load()` also identifies special file indexes: system, universe, solar archetype, asteroid archetype, ship archetype, equipment, and effect explosions. Those indexes are what connect the general table editor to the specialized 3D modes.

## System Designer

`SystemDesigner` is the 3D layer. It uses WPF 3D and Helix to display Freelancer content derived from `TableBlock` data.

The important parts are:

- `SystemEditorForm` hosts the viewport and exposes events to `MainForm`.
- `Presenter` owns viewport content, selection, manipulation, camera actions, model loading, universe connections, and visual refresh.
- `SystemParser` maps `TableBlock` values into content objects and writes changed 3D values back into table blocks.
- `Analyzer` reads universe/system relationships and produces connections.
- `UtfModel` loads Freelancer model data where a real model preview is available.
- `SystemDesigner/Content` contains visual object types such as systems, zones, objects, lights, and connections.

The designer supports selection sync both ways. Selecting a row can select a 3D object, and clicking a 3D object can select the matching table block. Manipulation in the viewport creates old/new `TableBlock` snapshots, which `MainForm` sends back to the active table editor as a normal undoable data change.

## Settings And Persistence

`Helper.Settings` loads and saves user settings under the application data folder. Settings include:

- general preferences.
- language and theme.
- update schedule and updater state.
- editor colors and 3D colors.
- recent files.
- form layout and sizes.
- user-created block templates.

`Helper.Settings.LoadTemplates()` copies saved user templates into the template-aware menus used by `FrmTableEditor`. That is how the "create template from selected object" workflow becomes available later as reusable insert actions.

## Updates

The updater is split between `Helper.Update` and the `AutoUpdate` namespace. The update check downloads the raw `Setup/setup.iss` file from `Lizerium/Lizerium.FLModStudio`, extracts `MyAppVersion`, builds the GitHub release asset URL, compares that version with `AssemblyUtils.Version`, and can download the installer into the configured update location.

The installer flow is stateful:

- `Downloaded` means an installer exists and should be launched.
- `Installed` means the new version can clean up the installer file.
- Old Google Code and `AftermathFreelancer/FLModStudio` update URLs in settings are migrated to the `Lizerium/Lizerium.FLModStudio` raw `Setup/setup.iss` URL.

The release script in `Setup/setup.iss` expects release binaries from `FreelancerModStudio/bin/Release` and packages `FreelancerModStudio.exe`, `FLUtils.dll`, generated serializers, `HelixEngine.dll`, runtime facade assemblies, `Template.xml`, and default settings files.

## Practical Extension Points

When I add a new supported INI file type, I usually start with `Template.xml`, then verify the parser/editor behavior through `FreelancerModStudio.Tests`.

When I add a new visual object type, I expect to touch `SystemParser`, `ContentType`, the relevant `Content` class, and `Presenter.CreateContent()`.

When I change editing behavior, I check `FrmTableEditor`, `UndoManager<ChangedData>`, `ChangedData`, and the property-grid classes together because they are the main edit pipeline.

When I change startup, update, or settings behavior, I check `Helper.Program`, `Helper.Settings`, `Helper.Template`, and `Helper.Update` together because boot order matters.
