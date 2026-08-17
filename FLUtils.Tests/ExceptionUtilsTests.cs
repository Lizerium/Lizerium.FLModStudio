namespace FLUtils.Tests
{
    using System;
    using Microsoft.VisualStudio.TestTools.UnitTesting;

    [TestClass]
    public class ExceptionUtilsTests
    {
        [TestMethod]
        public void Get_IncludesOuterExceptionDetails()
        {
            var exception = new InvalidOperationException("Outer failure");

            string details = ExceptionUtils.Get(exception);

            StringAssert.Contains(details, "InvalidOperationException");
            StringAssert.Contains(details, "Outer failure");
        }

        [TestMethod]
        public void Get_IncludesInnerExceptionDetails()
        {
            var exception = new InvalidOperationException("Outer failure", new ArgumentException("Inner failure"));

            string details = ExceptionUtils.Get(exception);

            StringAssert.Contains(details, "ArgumentException");
            StringAssert.Contains(details, "Inner failure");
        }

        [TestMethod]
        public void Get_ReturnsEmptyStringForNullException()
        {
            Assert.AreEqual(string.Empty, ExceptionUtils.Get(null));
        }
    }
}
