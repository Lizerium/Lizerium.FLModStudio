namespace FreelancerModStudio.Tests
{
    using System;
    using Microsoft.VisualStudio.TestTools.UnitTesting;

    [TestClass]
    public class UtfModelSmokeToolTests
    {
        [TestMethod]
        public void ValidateFreelancerDataModels_UsesExplicitEnvironmentPath()
        {
            string dataPath = Environment.GetEnvironmentVariable("FREELANCER_DATA_PATH");
            if (string.IsNullOrWhiteSpace(dataPath))
            {
                Assert.Inconclusive("Set FREELANCER_DATA_PATH to run the full Freelancer UTF model smoke test.");
            }

            UtfModelSmokeTool.ValidateDirectory(dataPath, include3db: true);
        }
    }
}
