#include "scripts\products.iss"

#include "scripts\products\stringversion.iss"
#include "scripts\products\winversion.iss"
#include "scripts\products\fileversion.iss"
#include "scripts\products\dotnetfxversion.iss"

//#include "scripts\products\ngen.iss"
#include "scripts\products\msi31.iss"
#include "scripts\products\dotnetfx35sp1.iss"

#define MyAppSetupName 'Freelancer Mod Studio'
#define MyAppVersion '1.3.1.1'

[Setup]
AppName={#MyAppSetupName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppSetupName} {#MyAppVersion}
AppCopyright=Copyright © stfx 2009-2013, Freelancer Aftermath 2019-2020
VersionInfoVersion={#MyAppVersion}
VersionInfoCompany=Freelancer Aftermath
AppPublisher=Lizerium                                             
AppPublisherURL=https://github.com/Lizerium/Lizerium.FLModStudio
AppUpdatesURL=https://raw.githubusercontent.com/Lizerium/Lizerium.FLModStudio/master/Setup/setup.iss
OutputBaseFilename=FreelancerModStudio-{#MyAppVersion}
DefaultGroupName={#MyAppSetupName}
DefaultDirName={pf}\{#MyAppSetupName}
UninstallDisplayIcon={app}\FreelancerModStudio.exe
OutputDir=bin
SourceDir=.
AllowNoIcons=yes
WizardImageFile=src\FreelancerModManager.bmp
WizardSmallImageFile=src\FreelancerModManager_small.bmp
SolidCompression=yes

MinVersion=0,6
PrivilegesRequired=admin
ArchitecturesAllowed=x86 x64
ArchitecturesInstallIn64BitMode=x64 ia64

[Languages]
Name: "en"; MessagesFile: "compiler:Default.isl"
Name: "de"; MessagesFile: "compiler:Languages\German.isl"

[Tasks]
Name: "assocfileextension"; Description: "{cm:AssocFileExtension,{#MyAppSetupName},.ini}"
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "..\FreelancerModStudio\bin\Release\FreelancerModStudio.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\FLUtils.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\FreelancerModStudio.XmlSerializers.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\HelixEngine.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\Microsoft.Win32.Primitives.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\netstandard.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\ObjectListView.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.AppContext.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Collections.Concurrent.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Collections.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Collections.NonGeneric.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Collections.Specialized.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.ComponentModel.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.ComponentModel.EventBasedAsync.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.ComponentModel.Primitives.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.ComponentModel.TypeConverter.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Console.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Data.Common.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Diagnostics.Contracts.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Diagnostics.Debug.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Diagnostics.FileVersionInfo.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Diagnostics.Process.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Diagnostics.StackTrace.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Diagnostics.TextWriterTraceListener.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Diagnostics.Tools.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Diagnostics.TraceSource.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Diagnostics.Tracing.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Drawing.Primitives.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Dynamic.Runtime.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Globalization.Calendars.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Globalization.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Globalization.Extensions.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.IO.Compression.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.IO.Compression.ZipFile.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.IO.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.IO.FileSystem.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.IO.FileSystem.DriveInfo.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.IO.FileSystem.Primitives.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.IO.FileSystem.Watcher.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.IO.IsolatedStorage.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.IO.MemoryMappedFiles.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.IO.Pipes.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.IO.UnmanagedMemoryStream.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Linq.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Linq.Expressions.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Linq.Parallel.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Linq.Queryable.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Net.Http.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Net.NameResolution.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Net.NetworkInformation.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Net.Ping.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Net.Primitives.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Net.Requests.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Net.Security.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Net.Sockets.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Net.WebHeaderCollection.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Net.WebSockets.Client.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Net.WebSockets.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.ObjectModel.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Reflection.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Reflection.Extensions.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Reflection.Primitives.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Resources.Reader.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Resources.ResourceManager.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Resources.Writer.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Runtime.CompilerServices.VisualC.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Runtime.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Runtime.Extensions.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Runtime.Handles.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Runtime.InteropServices.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Runtime.InteropServices.RuntimeInformation.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Runtime.Numerics.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Runtime.Serialization.Formatters.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Runtime.Serialization.Json.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Runtime.Serialization.Primitives.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Runtime.Serialization.Xml.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Security.Claims.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Security.Cryptography.Algorithms.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Security.Cryptography.Csp.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Security.Cryptography.Encoding.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Security.Cryptography.Primitives.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Security.Cryptography.X509Certificates.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Security.Principal.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Security.SecureString.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Text.Encoding.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Text.Encoding.Extensions.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Text.RegularExpressions.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Threading.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Threading.Overlapped.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Threading.Tasks.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Threading.Tasks.Parallel.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Threading.Thread.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Threading.ThreadPool.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Threading.Timer.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.ValueTuple.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Xml.ReaderWriter.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Xml.XDocument.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Xml.XmlDocument.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Xml.XmlSerializer.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Xml.XPath.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\System.Xml.XPath.XDocument.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\WeifenLuo.WinFormsUI.Docking.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\WeifenLuo.WinFormsUI.Docking.ThemeVS2015.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\de\FreelancerModStudio.resources.dll"; DestDir: "{app}\de"; Flags: ignoreversion
Source: "..\FreelancerModStudio\bin\Release\Template.xml"; DestDir: "{app}"; Flags: ignoreversion
Source: "src\Settings_en.xml"; DestName: "FreelancerModStudio.xml"; DestDir: "{userappdata}\Freelancer Mod Studio"; Languages: en; Flags: onlyifdoesntexist
Source: "src\Settings_de.xml"; DestName: "FreelancerModStudio.xml"; DestDir: "{userappdata}\Freelancer Mod Studio"; Languages: de; Flags: onlyifdoesntexist

[UninstallDelete]
Name: "{userappdata}\Freelancer Mod Studio\FreelancerModStudio.Layout.xml"; Type: files
Name: "{userappdata}\Freelancer Mod Studio\FreelancerModStudio.xml"; Type: files
Name: "{userappdata}\Freelancer Mod Studio"; Type: dirifempty

[Icons]
Name: "{group}\Freelancer Mod Studio"; Filename: "{app}\FreelancerModStudio"
Name: "{group}\{cm:UninstallProgram,Freelancer Mod Studio}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppSetupName}"; Filename: "{app}\FreelancerModStudio.exe"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\FreelancerModStudio"; Filename: "{app}\FreelancerModStudio.exe"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\FreelancerModStudio.exe"; Description: "{cm:LaunchProgram,FreelancerModStudio}"; Flags: nowait postinstall skipifsilent

[Registry]
Root: HKCR; Subkey: ".ini"; ValueType: string; ValueName: ""; ValueData: "FreelancerModStudio"; Flags: uninsdeletevalue; Tasks: assocfileextension
Root: HKCR; Subkey: "FreelancerModStudio"; ValueType: string; ValueName: ""; ValueData: "{#MyAppSetupName}"; Flags: uninsdeletekey; Tasks: assocfileextension
Root: HKCR; Subkey: "FreelancerModStudio\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\FreelancerModStudio.exe,0"; Tasks: assocfileextension
Root: HKCR; Subkey: "FreelancerModStudio\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\FreelancerModStudio.exe"" ""%1"""; Tasks: assocfileextension

[Code]
function InitializeSetup(): boolean;
begin
	//init windows version
	initwinversion();

	msi31('3.1');

	//install .netfx 3.5 sp1
	dotnetfx35sp1();

	Result := true;
end;
