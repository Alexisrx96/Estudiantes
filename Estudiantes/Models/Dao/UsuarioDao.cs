using Estudiantes.Models.Dto;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace Estudiantes.Models.Dao
{
    class UsuarioDao:DbContext
    {/*
        DataTable usuarios = new DataTable();
        public DataTable VerUsuarios(string condicion)
        {
            command = new SqlCommand();
            command.Connection = this.AbrirConexion();
            command.CommandText = "SP_BuscarUsuarios";
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@condicion", condicion);
            leerFilas = command.ExecuteReader();
            usuarios.Load(leerFilas);
            leerFilas.Close();
            this.CerrarConexion();
            return usuarios;
        }
        public DataTable VerUsuarioSeleccionado(string condicion)
        {
            command = new SqlCommand();
            command.Connection = this.AbrirConexion();
            command.CommandText = "SP_BuscarUsuario";
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@condicion", condicion);
            leerFilas = command.ExecuteReader();
            usuarios.Load(leerFilas);
            leerFilas.Close();
            this.CerrarConexion();
            return usuarios;
        }
        public bool HayUsuarios()
        {
            bool hayUsuarios;
            command = new SqlCommand();
            command.Connection = this.AbrirConexion();
            command.CommandText = "SP_BuscarUsuarios";
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@condicion", "");
            leerFilas = command.ExecuteReader();
            if (leerFilas.HasRows)
            {
                leerFilas.Close();
                this.CerrarConexion();
                hayUsuarios= true;
            }
            else
            {
                leerFilas.Close();
                this.CerrarConexion();
                hayUsuarios = false;
            }
            return hayUsuarios;
        }
        public bool ValidarInicio(string pNomUsuarios, string pContrasenia)
        {
            bool validado;
            command = new SqlCommand();
            command.Connection = this.AbrirConexion(); ;
            command.CommandText = "SP_ComprobarUsuario";
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@NomUsuario", pNomUsuarios);
            command.Parameters.AddWithValue("@Contrasenia", pContrasenia);
            leerFilas = command.ExecuteReader();
            if (leerFilas.HasRows)
            {
                leerFilas.Close();
                this.CerrarConexion();
                validado = true;
            }
            else
            {
                leerFilas.Close();
                this.CerrarConexion();
                validado = false;
            }
            return validado; 
        }
        public void Insert( string pNombre, string pApellido,string pNombUsuario, string pContrasenia, int pEstado)
        {
            command = new SqlCommand();
            command.Connection = conexion;
            command.CommandText = "SP_InsertarUsuario";
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@NombresUsuario", pNombre);
            command.Parameters.AddWithValue("@ApellidosUsuario", pApellido);
            command.Parameters.AddWithValue("@NomUsuario", pNombUsuario);
            command.Parameters.AddWithValue("@Contrasenia", pContrasenia);
            command.Parameters.AddWithValue("@Estado", pEstado);
            conexion.Open();
            command.ExecuteNonQuery();
            conexion.Close();
        }
        public string UsuarioSeleccionado(int indice, string condicion)
        {
            string nomUsuario;
            usuarios = VerUsuarios(condicion);
            DataRow usuarioSerleccionado = usuarios.Rows[indice];
            nomUsuario = usuarioSerleccionado[2].ToString();
            return nomUsuario;
            
        }
        public void EditarUsuario(string pNombre,string pApellido, string pNomUsuario,int pEstado,string pCondicion)
        {
            command = new SqlCommand();
            command.Connection = conexion;
            command.CommandText = "SP_EditarUsuario";
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@NombresUsuario", pNombre);
            command.Parameters.AddWithValue("@ApellidosUsuario", pApellido);
            command.Parameters.AddWithValue("@NomUsuario", pNomUsuario);
            command.Parameters.AddWithValue("@Estado", pEstado);
            command.Parameters.AddWithValue("@Condicion", pCondicion);
            conexion.Open();
            command.ExecuteNonQuery();
            conexion.Close();
        }
        public void EliminarUsuario(string pNomUsuario)
        {
            command = new SqlCommand();
            command.Connection = conexion;
            command.CommandText = "SP_EliminarUsuario";
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@NomUsuario", pNomUsuario);
            conexion.Open();
            command.ExecuteNonQuery();
            conexion.Close();
        }
        */
    }
}