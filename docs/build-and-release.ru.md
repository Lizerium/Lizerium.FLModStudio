# Сборка И Релиз Для Версии 1.3.1.1

Этот документ описывает, как я собираю, тестирую и пакую версию `1.3.1.1`.

## Версия Проекта

Release version для этой документации - `1.3.1.1`.

Места, которые я держу синхронными:

- `Setup/setup.iss` для версии installer, имени artifact и updater metadata.
- README и headings документации, чтобы было понятно, к какому релизу относятся docs.

## Требования Для Сборки

Я собираю проект на Windows через Visual Studio/MSBuild tooling.

Нужны:

- Visual Studio 2022 или совместимый MSBuild.
- .NET Framework 4.8 Developer Pack.
- NuGet package restore через MSBuild.
- Inno Setup для упаковки installer.

Основное приложение, `FLUtils` и оба test projects таргетят .NET Framework 4.8. `HelixEngine` таргетит .NET Framework 4.6 и подключается к main application.

## Debug Build

Из корня репозитория:

```powershell
& "C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe" FreelancerModStudio.sln /v:m
```

Это собирает решение в default Debug configuration.

## Release Build

Installer ожидает release binaries в `FreelancerModStudio/bin/Release`, поэтому перед упаковкой я запускаю:

```powershell
& "C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe" FreelancerModStudio.sln /p:Configuration=Release /v:m
```

## Тесты

После Debug build я запускаю:

```powershell
& "C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe" FLUtils.Tests\bin\Debug\FLUtils.Tests.dll
& "C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe" FreelancerModStudio.Tests\bin\Debug\FreelancerModStudio.Tests.dll
```

Если я хочу запустить smoke test на реальных Freelancer models, я задаю `FREELANCER_DATA_PATH` перед второй командой.

## Installer

Основной installer script - `Setup/setup.iss`. Для версии `1.3.1.1` он создает output file:

```text
FreelancerModStudio-1.3.1.1.exe
```

Скрипт пакует release executable, local libraries, generated XML serializers, runtime facade assemblies, `Template.xml` и default settings XML files.

## Источник Обновлений

Updater читает raw `Setup/setup.iss` из release repository:

```text
https://raw.githubusercontent.com/Lizerium/Lizerium.FLModStudio/master/Setup/setup.iss
```

В версии `1.3.1.1` updater достает `MyAppVersion` и строит такой release asset URL:

```text
https://github.com/Lizerium/Lizerium.FLModStudio/releases/download/1.3.1.1/FreelancerModStudio-1.3.1.1.exe
```

Когда я публикую новый релиз, я обновляю `#define MyAppVersion` в `Setup/setup.iss` и публикую installer в GitHub release tag с такой же версией. Если версия поменяется, а release asset отсутствует, приложение сможет обнаружить update, но download упадет.

## Release Checklist

- Собрать Debug и прогнать MSTest projects.
- Собрать Release.
- Проверить, что `FreelancerModStudio/bin/Release` содержит `FreelancerModStudio.exe`, `FLUtils.dll` и `HelixEngine.dll`.
- Собрать Inno Setup installer из `Setup/setup.iss`.
- Опубликовать installer в GitHub release tag, который совпадает с `MyAppVersion`.
- Проверить, что raw `Setup/setup.iss` доступен из release repository.
