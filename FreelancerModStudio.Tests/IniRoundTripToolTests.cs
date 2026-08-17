namespace FreelancerModStudio.Tests
{
    using System.IO;
    using FreelancerModStudio;
    using Microsoft.VisualStudio.TestTools.UnitTesting;

    [TestClass]
    public class IniRoundTripToolTests
    {
        [TestMethod]
        public void ResaveFiles_RewritesKnownIniFilesUsingGeneratedTemplate()
        {
            string root = TestData.CreateFreelancerDataTree();
            string template = Path.Combine(root, "Template.generated.xml");
            string target = Path.Combine(root, "resaved");

            TemplateGenerationDevTool.GenerateTemplate(root, template);
            Helper.Template.Load(template);

            IniRoundTripTool.ResaveFiles(root, target);

            string resavedFile = Path.Combine(target, "fx", "fuse.ini");
            Assert.IsTrue(File.Exists(resavedFile), "Expected the known INI file to be resaved.");
            string content = File.ReadAllText(resavedFile);
            StringAssert.Contains(content, "[damage_root]");
            StringAssert.Contains(content, "nickname = root_fuse");
        }
    }
}
