using System.Web;
using System.Web.Optimization;

[assembly: WebActivatorEx.PostApplicationStartMethod(
      typeof(WebApplication5.SemanticUIStart), "PostStart")]


namespace WebApplication5
{
    public static class SemanticUIStart
    {
        public static void PostStart()
        {
            BundleTable.Bundles.Add(new ScriptBundle("~/bundles/semantic").
			   Include("~/Scripts/semantic.js",
			           "~/Scripts/semantic.site.js"));
			   
            BundleTable.Bundles.Add(new StyleBundle("~/Content/semantic").
			   Include("~/Content/semantic.css",
			           "~/Content/semantic.site.css"));
        }
    }
}