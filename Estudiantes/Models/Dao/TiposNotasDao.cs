using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Estudiantes.Models.Dao
{
    class TiposNotasDao:DbContext
    {
        /*
        public DataTable ListaTiposNotas()
        {
            command = new SqlCommand();
            DataTable TiposNotnas = new DataTable();
            command.Connection = this.AbrirConexion();
            command.CommandText = "SP_ListarTiposNotas";
            command.CommandType = CommandType.StoredProcedure;
            leerFilas = command.ExecuteReader();
            TiposNotnas.Load(leerFilas);
            leerFilas.Close();
            this.CerrarConexion();
            return TiposNotnas;
        }*/
    }
}
