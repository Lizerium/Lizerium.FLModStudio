namespace FreelancerModStudio.Tests
{
    using System;
    using System.IO;
    using FreelancerModStudio.SystemDesigner;

    public static class UtfModelSmokeTool
    {
        public static void ValidateDirectory(string directory, bool include3db)
        {
            foreach (string file in Directory.GetFiles(directory))
            {
                string extension = Path.GetExtension(file);

                if (extension != null &&
                    (extension.Equals(".cmp", StringComparison.OrdinalIgnoreCase) ||
                     (include3db && extension.Equals(".3db", StringComparison.OrdinalIgnoreCase))))
                {
                    UtfModel.LoadModel(file);
                }
            }

            foreach (string subDirectory in Directory.GetDirectories(directory))
            {
                ValidateDirectory(subDirectory, include3db);
            }
        }
    }
}
