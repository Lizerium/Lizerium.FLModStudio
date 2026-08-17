# Build And Release For Version 1.3.1.1

This document describes how I build, test, and package version `1.3.1.1`.

## Project Version

The release version for this documentation is `1.3.1.1`.

The places I keep aligned are:

- `Setup/setup.iss` for the installer version, artifact name, and updater metadata.
- README and documentation headings so the docs clearly match this release.

## Build Requirements

I build this project on Windows with Visual Studio/MSBuild tooling.

Required pieces:

- Visual Studio 2022 or compatible MSBuild.
- .NET Framework 4.8 Developer Pack.
- NuGet package restore through MSBuild.
- Inno Setup for installer packaging.

The main application, `FLUtils`, and both test projects target .NET Framework 4.8. `HelixEngine` targets .NET Framework 4.6 and is referenced by the main application.

## Debug Build

From the repository root:

```powershell
& "C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe" FreelancerModStudio.sln /v:m
```

This builds the solution with the default Debug configuration.

## Release Build

The installer expects release binaries under `FreelancerModStudio/bin/Release`, so before packaging I run:

```powershell
& "C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe" FreelancerModStudio.sln /p:Configuration=Release /v:m
```

## Tests

After a Debug build, I run:

```powershell
& "C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe" FLUtils.Tests\bin\Debug\FLUtils.Tests.dll
& "C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe" FreelancerModStudio.Tests\bin\Debug\FreelancerModStudio.Tests.dll
```

If I want the real Freelancer model smoke test to run, I set `FREELANCER_DATA_PATH` before launching the second command.

## Installer

The main installer script is `Setup/setup.iss`. For version `1.3.1.1`, it creates an output file named:

```text
FreelancerModStudio-1.3.1.1.exe
```

The script packages the release executable, local libraries, generated XML serializers, runtime facade assemblies, `Template.xml`, and default settings XML files.

## Update Source

The updater reads the raw `Setup/setup.iss` file from the release repository:

```text
https://raw.githubusercontent.com/Lizerium/Lizerium.FLModStudio/master/Setup/setup.iss
```

In version `1.3.1.1`, the updater extracts `MyAppVersion` and builds this release asset URL:

```text
https://github.com/Lizerium/Lizerium.FLModStudio/releases/download/1.3.1.1/FreelancerModStudio-1.3.1.1.exe
```

When I publish a new release, I update `#define MyAppVersion` in `Setup/setup.iss` and publish the installer to the matching GitHub release tag. If the version changes but the release asset is missing, the app can detect an update but fail during download.

## Release Checklist

- Build Debug and run the MSTest projects.
- Build Release.
- Confirm `FreelancerModStudio/bin/Release` contains `FreelancerModStudio.exe`, `FLUtils.dll`, and `HelixEngine.dll`.
- Build the Inno Setup installer from `Setup/setup.iss`.
- Publish the installer to the GitHub release tag matching `MyAppVersion`.
- Confirm the raw `Setup/setup.iss` file is reachable from the release repository.
