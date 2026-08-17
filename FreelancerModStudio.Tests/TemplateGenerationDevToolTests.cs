namespace FreelancerModStudio.Tests
{
    using System.IO;
    using Microsoft.VisualStudio.TestTools.UnitTesting;

    [TestClass]
    public class TemplateGenerationDevToolTests
    {
        [TestMethod]
        public void GenerateTemplate_GroupsKnownFreelancerFiles()
        {
            string root = TestData.CreateFreelancerDataTree();
            string output = Path.Combine(root, "Template.generated.xml");

            TemplateGenerationDevTool.GenerateTemplate(root, output);

            string xml = File.ReadAllText(output);
            StringAssert.Contains(xml, "fx\\fuse.ini");
            StringAssert.Contains(xml, "damage_root");
            StringAssert.Contains(xml, "nickname");
            Assert.AreEqual(1, TestData.CountOccurrences(xml, "<File name="), "Grouped fuse files should produce one template file.");
        }
    }
}
