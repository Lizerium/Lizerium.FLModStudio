# Тесты И Developer Tools Для Версии 1.3.1.1

Этот документ описывает, как я организую тесты и вынесенные developer tools в версии `1.3.1.1`.

## Тестовые Проекты

В решении есть два MSTest-проекта:

- `FLUtils.Tests/` покрывает восстановленную локальную библиотеку `FLUtils`.
- `FreelancerModStudio.Tests/` покрывает parsing/dev-tool behavior приложения, который можно тестировать без запуска WinForms UI.

Оба проекта таргетят .NET Framework 4.8 и прикреплены к `FreelancerModStudio.sln`.

## FLUtils.Tests

`FLUtils.Tests` специально маленький. Он проверяет utility behavior, от которого зависит основное приложение:

- `AssemblyUtilsTests.cs` проверяет assembly name, company, copyright и version fallback behavior.
- `ExceptionUtilsTests.cs` проверяет форматирование exception details, включая inner exceptions.

Этот проект заменил временный console runner. Теперь это нормальная MSTest library, поэтому Visual Studio Test Explorer может обнаруживать и запускать ее так же, как основной test project.

## FreelancerModStudio.Tests

`FreelancerModStudio.Tests` держит тестируемые project tools и smoke coverage:

- `TemplateGenerationDevToolTests.cs` проверяет helper генерации template, вынесенный из старого `DevTest.cs`.
- `IniRoundTripToolTests.cs` проверяет INI parse/write round-trip behavior.
- `UtfModelSmokeToolTests.cs` проверяет model-loading smoke behavior, когда доступны реальные Freelancer data.
- `TestData.cs` централизует маленькие fixtures и environment-based paths.

Старый `FreelancerModStudio/DevTest.cs` больше не runtime app code. Его полезное поведение живет в `FreelancerModStudio.Tests/DevTools/`.

## Smoke Tests Через Environment

Часть smoke tests требует реальные Freelancer assets. Я не хардкожу такие пути в репозитории.

Когда я хочу запускать эти тесты, я задаю:

```powershell
$env:FREELANCER_DATA_PATH = "D:\Games\Freelancer\DATA"
```

Если переменная не задана, asset-dependent test пропускается, а не ломает обычный локальный test run.

## Запуск Тестов

После сборки решения я запускаю:

```powershell
& "C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe" FLUtils.Tests\bin\Debug\FLUtils.Tests.dll
& "C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe" FreelancerModStudio.Tests\bin\Debug\FreelancerModStudio.Tests.dll
```

Ожидаемый baseline для версии `1.3.1.1`:

- `FLUtils.Tests`: все тесты проходят.
- `FreelancerModStudio.Tests`: обычные deterministic tests проходят, а real-asset smoke test пропускается, если `FREELANCER_DATA_PATH` не задан.

## Что Держать В Тестах

Я держу тесты сфокусированными на поведении, которое можно запускать без полного UI:

- template generation и validation helpers.
- INI parsing и writing.
- utility libraries.
- model-loading smoke checks за environment variable.
- data transformations, которые использует editor.

Полное WinForms interaction в этой версии пока в основном manual. Если позже я добавлю автоматизированное UI-покрытие, я должен описать runner и prerequisites здесь.
