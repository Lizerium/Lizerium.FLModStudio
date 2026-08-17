namespace FLUtils.Tests
{
    using Microsoft.VisualStudio.TestTools.UnitTesting;

    [TestClass]
    public class AssemblyUtilsTests
    {
        [TestMethod]
        public void Name_UsesFallbackAssemblyProductWhenEntryAssemblyIsUnavailable()
        {
            Assert.AreEqual("FLUtils", AssemblyUtils.Name);
        }

        [TestMethod]
        public void Version_UsesFallbackAssemblyVersionWhenEntryAssemblyIsUnavailable()
        {
            Assert.AreEqual(typeof(AssemblyUtils).Assembly.GetName().Version, AssemblyUtils.Version);
        }

        [TestMethod]
        public void Company_UsesFallbackAssemblyCompanyWhenEntryAssemblyIsUnavailable()
        {
            Assert.AreEqual("FreelancerAftermath", AssemblyUtils.Company);
        }

        [TestMethod]
        public void Copyright_UsesFallbackAssemblyCopyrightWhenEntryAssemblyIsUnavailable()
        {
            Assert.AreEqual("Copyright (c) FreelancerAftermath", AssemblyUtils.Copyright);
        }
    }
}
