using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Estudiantes.Models.Dao
{
    public class DbContext
    {
        protected string Server { get; set; }
        protected string DataBase { get; set; }
        protected string ConectionString { get; set; }

        public DbContext()
        {
            Server = ".\\SQLEXPRESS";
            DataBase = "Alumnos";
            ConectionString = $"Data Source={Server};Initial Catalog={DataBase};Integrated Security=True";
        }
    }
}
