using System;
using System.Text.RegularExpressions;

namespace FreelancerModStudio.AutoUpdate
{
    internal static class UpdateInformationParser
    {
        internal const string ReleaseRepositoryUrl = "https://github.com/Lizerium/Lizerium.FLModStudio";
        internal const string DefaultCheckFileUrl = "https://raw.githubusercontent.com/Lizerium/Lizerium.FLModStudio/master/Setup/setup.iss";

        public static UpdateInformation Parse(string content)
        {
            if (string.IsNullOrWhiteSpace(content))
            {
                return null;
            }

            Match versionMatch = Regex.Match(
                content,
                @"^\s*#define\s+MyAppVersion\s+'(?<version>[^']+)'\s*$",
                RegexOptions.Multiline);

            if (!versionMatch.Success)
            {
                return null;
            }

            Version version = new Version(versionMatch.Groups["version"].Value);
            string fileName = GetOutputFileName(content, version);

            return new UpdateInformation
                       {
                           Version = version,
                           FileUri = new Uri(string.Format("{0}/releases/download/{1}/{2}", ReleaseRepositoryUrl, version, fileName)),
                           Silent = false
                       };
        }

        private static string GetOutputFileName(string content, Version version)
        {
            Match outputMatch = Regex.Match(
                content,
                @"^\s*OutputBaseFilename\s*=\s*(?<name>[^\r\n]+)\s*$",
                RegexOptions.Multiline);

            string fileName = outputMatch.Success ? outputMatch.Groups["name"].Value.Trim() : "FreelancerModStudio-{#MyAppVersion}";
            fileName = fileName.Replace("{#MyAppVersion}", version.ToString());

            return fileName.EndsWith(".exe", StringComparison.OrdinalIgnoreCase) ? fileName : fileName + ".exe";
        }
    }
}
