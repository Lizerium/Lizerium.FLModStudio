namespace FreelancerModStudio.Tests
{
    using System;
    using System.IO;

    internal static class TestData
    {
        public static string CreateFreelancerDataTree()
        {
            string root = Path.Combine(Path.GetTempPath(), "FreelancerModStudio.Tests", Guid.NewGuid().ToString("N"));
            string fx = Path.Combine(root, "fx");
            Directory.CreateDirectory(fx);

            File.WriteAllText(
                Path.Combine(fx, "fuse.ini"),
                "[damage_root]" + Environment.NewLine +
                "nickname = root_fuse" + Environment.NewLine +
                "lifetime = 1" + Environment.NewLine);

            File.WriteAllText(
                Path.Combine(fx, "fuse_br_destroyer.ini"),
                "[damage_root]" + Environment.NewLine +
                "nickname = br_destroyer_fuse" + Environment.NewLine +
                "lifetime = 2" + Environment.NewLine);

            return root;
        }

        public static int CountOccurrences(string value, string find)
        {
            int count = 0;
            int index = 0;
            while ((index = value.IndexOf(find, index, StringComparison.Ordinal)) != -1)
            {
                count++;
                index += find.Length;
            }

            return count;
        }
    }
}
