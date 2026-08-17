namespace FLUtils
{
    using System;
    using System.Reflection;

    public static class AssemblyUtils
    {
        public static string Name => GetAttribute<AssemblyProductAttribute>(x => x.Product) ?? GetAssembly().GetName().Name;

        public static Version Version => GetAssembly().GetName().Version;

        public static string Copyright => GetAttribute<AssemblyCopyrightAttribute>(x => x.Copyright) ?? string.Empty;

        public static string Company => GetAttribute<AssemblyCompanyAttribute>(x => x.Company) ?? string.Empty;

        private static Assembly GetAssembly()
        {
            return Assembly.GetEntryAssembly() ?? Assembly.GetCallingAssembly();
        }

        private static string GetAttribute<T>(Func<T, string> selector)
            where T : Attribute
        {
            object[] attributes = GetAssembly().GetCustomAttributes(typeof(T), false);
            if (attributes.Length == 0)
            {
                return null;
            }

            return selector((T)attributes[0]);
        }
    }
}
