namespace FLUtils
{
    using System;
    using System.Text;

    public static class ExceptionUtils
    {
        public static string Get(Exception exception)
        {
            if (exception == null)
            {
                return string.Empty;
            }

            StringBuilder builder = new StringBuilder();
            AppendException(builder, exception, 0);
            return builder.ToString();
        }

        private static void AppendException(StringBuilder builder, Exception exception, int depth)
        {
            if (depth > 0)
            {
                builder.AppendLine();
                builder.AppendLine("Inner exception:");
            }

            builder.AppendLine(exception.GetType().FullName);
            builder.AppendLine(exception.Message);

            if (!string.IsNullOrEmpty(exception.StackTrace))
            {
                builder.AppendLine();
                builder.AppendLine(exception.StackTrace);
            }

            if (exception.InnerException != null)
            {
                AppendException(builder, exception.InnerException, depth + 1);
            }
        }
    }
}
