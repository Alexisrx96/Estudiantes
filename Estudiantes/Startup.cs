using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Estudiantes.Startup))]
namespace Estudiantes
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
