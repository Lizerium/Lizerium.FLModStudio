# Testing And Developer Tools For Version 1.3.1.1

This document describes how I organize tests and extracted developer tools in version `1.3.1.1`.

## Test Projects

The solution has two MSTest projects:

- `FLUtils.Tests/` covers the restored local `FLUtils` library.
- `FreelancerModStudio.Tests/` covers application parsing/dev-tool behavior that can be tested without launching the WinForms UI.

Both projects target .NET Framework 4.8 and are attached to `FreelancerModStudio.sln`.

## FLUtils.Tests

`FLUtils.Tests` is intentionally small. It verifies the utility behavior that the main app depends on:

- `AssemblyUtilsTests.cs` checks assembly name, company, copyright, and version fallback behavior.
- `ExceptionUtilsTests.cs` checks exception detail formatting, including inner exceptions.

This project replaced the temporary console runner. Because it is now a real MSTest library, Visual Studio Test Explorer can discover and run it like the main test project.

## FreelancerModStudio.Tests

`FreelancerModStudio.Tests` owns testable project tooling and smoke coverage:

- `TemplateGenerationDevToolTests.cs` checks the template-generation helper that was extracted from the old `DevTest.cs`.
- `IniRoundTripToolTests.cs` checks INI parse/write round-trip behavior.
- `UtfModelSmokeToolTests.cs` checks model-loading smoke behavior when real Freelancer data is available.
- `TestData.cs` centralizes small fixtures and environment-based paths.

The old `FreelancerModStudio/DevTest.cs` file is no longer runtime app code. Its useful behavior lives under `FreelancerModStudio.Tests/DevTools/`.

## Environment-Gated Smoke Tests

Some smoke tests need real Freelancer assets. I do not hardcode those paths in the repository.

When I want those tests to run, I set:

```powershell
$env:FREELANCER_DATA_PATH = "D:\Games\Freelancer\DATA"
```

If the variable is not set, the asset-dependent test is skipped instead of failing the normal local test run.

## Running Tests

After building the solution, I run:

```powershell
& "C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe" FLUtils.Tests\bin\Debug\FLUtils.Tests.dll
& "C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe" FreelancerModStudio.Tests\bin\Debug\FreelancerModStudio.Tests.dll
```

The expected baseline for version `1.3.1.1` is:

- `FLUtils.Tests`: all tests pass.
- `FreelancerModStudio.Tests`: normal deterministic tests pass, and the real-asset smoke test is skipped unless `FREELANCER_DATA_PATH` is set.

## What Belongs In Tests

I keep tests focused on behavior that can run without opening the full UI:

- template generation and validation helpers.
- INI parsing and writing.
- utility libraries.
- model-loading smoke checks behind an environment variable.
- data transformations used by the editor.

Full WinForms interaction is still mostly manual in this version. If I add more automated UI coverage later, I should document the runner and prerequisites here.
