# Template System For Version 1.3.1.1

This document describes how I use `Template.xml` in version `1.3.1.1`.

## Purpose

`Template.xml` is the contract between raw Freelancer INI files and the editor UI. The application does not treat every INI as an anonymous text file. It reads a template first, then uses that template to decide which files are known, which blocks can exist, which options belong to a block, and which values are valid enough to expose in the property editor.

## Where It Loads

`Helper.Template.Load()` loads the template from the application startup path using the configured `Resources.TemplatePath`. During startup, `Helper.Program.Start()` loads settings first and the template second, before `MainForm` is shown.

After loading, `Helper.Template.Load()` finds the important built-in file indexes:

- system file.
- universe file.
- solar archetype file.
- asteroid archetype file.
- ship archetype file.
- equipment file.
- effect explosions file.

Those indexes are later used by `FrmTableEditor` to pick the correct `ViewerType`.

## Schema In Code

`Data/Template.cs` is the code representation of the XML. The root is `FreelancerModStudio-Template-1.0`.

The important template objects are:

- `TemplateData` - the full template document.
- `File` - one supported data file type and the paths that identify it.
- `Block` - a named INI section with options, multiplicity, and optional identifier.
- `Option` - a named INI option with type, parent, category, enum, rename metadata, and description.
- `Language`, `Category`, and `Description` - metadata used for localized descriptions in the UI.
- `CostumTypes` and `CostumEnum` - custom value lists.

The spelling `Costum` is part of the existing code model in this version, so I leave it as-is unless I plan a compatibility migration.

## How Editing Uses It

When I open a file, `MainForm` resolves a template index and creates `FrmTableEditor`. The table editor reads the file through `FileManager` and then uses `Helper.Template.Data.Files[templateIndex]` to build the editing experience.

The template controls:

- the Add menu for new blocks.
- the default options created inside a new block.
- single-instance block replacement when `multiple` is false.
- the identifier option used as a readable block name.
- property-grid categories and descriptions.
- basic value validation through `Template.OptionType`.

When a value does not match the expected option type, `FrmTableEditor` rejects the property-grid change and keeps the editor data consistent.

## How 3D Uses It

The template is also the switch that decides whether the 3D designer can open for a document. `FrmTableEditor.SetViewerType()` maps special template indexes into system, universe, solar archetype, or model preview modes.

`SystemParser` then interprets known block/option names and maps them into 3D content. For example, system objects, zones, lights, and universe systems are all detected from table blocks that came from template-aware INI parsing.

## Template Generation Dev Tool

The old `DevTest.cs` logic is now treated as a developer tool in the test project instead of runtime application code. In version `1.3.1.1`, `FreelancerModStudio.Tests/DevTools/TemplateGenerationDevTool.cs` contains the template-generation helper.

I use it to scan real Freelancer data and discover block/option shapes. The MSTest wrapper verifies the behavior with controlled test data, and the tool itself stays out of the shipped WinForms application.

## Maintenance Rules

When I edit `Template.xml`, I check three things:

- The application can still load the template at startup.
- The affected file type still opens in `FrmTableEditor`.
- If the file type is visual, the matching `ViewerType` and `SystemParser` behavior still make sense.

When I rename a block or option, I consider whether `renameFrom` metadata is needed so older data can still be understood.
