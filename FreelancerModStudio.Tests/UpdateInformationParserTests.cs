namespace FreelancerModStudio.Tests
{
    using System;
    using FreelancerModStudio.AutoUpdate;
    using Microsoft.VisualStudio.TestTools.UnitTesting;

    [TestClass]
    public class UpdateInformationParserTests
    {
        [TestMethod]
        public void Parse_CreatesUpdateInformationFromSetupScriptVersion()
        {
            const string content = @"
#define MyAppSetupName 'Freelancer Mod Studio'
#define MyAppVersion '1.3.1.1'

[Setup]
OutputBaseFilename=FreelancerModStudio-{#MyAppVersion}
";

            UpdateInformation information = UpdateInformationParser.Parse(content);

            Assert.IsNotNull(information);
            Assert.AreEqual(new Version(1, 3, 1, 1), information.Version);
            Assert.AreEqual(
                new Uri("https://github.com/Lizerium/Lizerium.FLModStudio/releases/download/1.3.1.1/FreelancerModStudio-1.3.1.1.exe"),
                information.FileUri);
            Assert.IsFalse(information.Silent);
        }

        [TestMethod]
        public void Parse_ReturnsNullWhenSetupScriptDoesNotContainVersion()
        {
            UpdateInformation information = UpdateInformationParser.Parse("[Setup]");

            Assert.IsNull(information);
        }
    }
}
