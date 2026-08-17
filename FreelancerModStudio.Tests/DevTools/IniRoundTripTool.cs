namespace FreelancerModStudio.Tests
{
    using System.IO;
    using FreelancerModStudio.Data;
    using FreelancerModStudio.Data.INI;
    using FreelancerModStudio.Data.IO;

    public static class IniRoundTripTool
    {
        public static void ResaveFiles(string sourcePath, string targetPath)
        {
            DirectoryInfo directory = new DirectoryInfo(sourcePath);
            FileInfo[] files = directory.GetFiles("*.ini");

            if (files.Length > 0 && !Directory.Exists(targetPath))
            {
                Directory.CreateDirectory(targetPath);
            }

            foreach (FileInfo file in files)
            {
                ResaveFile(file.FullName, Path.Combine(targetPath, file.Name));
            }

            foreach (DirectoryInfo subDirectory in directory.GetDirectories())
            {
                ResaveFiles(subDirectory.FullName, Path.Combine(targetPath, subDirectory.Name));
            }
        }

        private static void ResaveFile(string sourceFile, string targetFile)
        {
            int templateIndex = Helper.Template.Data.GetIndex(sourceFile);
            if (templateIndex == -1)
            {
                return;
            }

            FileManager fileManager = new FileManager(sourceFile)
                {
                    WriteEmptyLine = true,
                    WriteSpaces = true,
                };
            EditorIniData data = fileManager.Read(FileEncoding.Automatic, templateIndex);

            fileManager.File = targetFile;
            fileManager.Write(data);
        }
    }
}
