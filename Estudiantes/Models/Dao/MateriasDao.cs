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
    class MateriasDao : DbContext
    {
        public IList<Materias> VerMaterias()
        {
            List<Materias> materias = new List<Materias>();
            try
            {
                using (SqlConnection connection = new SqlConnection(ConectionString))
                {
                    connection.Open();
                    string cmdText = "SP_ListarMaterias";
                    using (SqlCommand command = new SqlCommand(cmdText, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        using (SqlDataReader reader = command.ExecuteReader())
                        {

                            while (reader.Read())
                            {
                                materias.Add(new Materias()
                                {
                                    IdMateria = reader.GetByte(0),
                                    NombreMateria = reader.GetString(1)
                                });
                            }
                        }
                    }
                }
            }
            catch (SqlException)
            {

                throw;
            }
            return materias;
        }

        public Materias VerMateria(Byte idMateria)
        {
            Materias alumno = null;
            try
            {
                using (SqlConnection connection = new SqlConnection(ConectionString))
                {
                    connection.Open();
                    string cmdText = "SP_VerMateria";
                    using (SqlCommand command = new SqlCommand(cmdText, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@IdMateria", idMateria);
                        using (SqlDataReader reader = command.ExecuteReader())
                        {

                            while (reader.Read())
                            {
                                alumno = new Materias()
                                {
                                    IdMateria = reader.GetByte(0),
                                    NombreMateria = reader.GetString(1)
                                };
                            }
                        }
                    }
                }
            }
            catch (SqlException)
            {

                throw;
            }
            return alumno;
        }

        public void InsertarMateria(Materias materia)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConectionString))
                {
                    connection.Open();
                    string cmdText = "SP_InsertarMaterias";
                    using (SqlCommand command = new SqlCommand(cmdText, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@NombreMateria", materia.NombreMateria);
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (SqlException)
            {

                throw;
            }
        }

        public void ModificarMateria(Materias materia)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConectionString))
                {
                    connection.Open();
                    string cmdText = "SP_EditarMaterias";
                    using (SqlCommand command = new SqlCommand(cmdText, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@IdMateria", materia.IdMateria);
                        command.Parameters.AddWithValue("@NombreMateria", materia.NombreMateria);
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (SqlException)
            {

                throw;
            }
        }

        public void EliminarMateria(byte idMateria)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConectionString))
                {
                    connection.Open();
                    string cmdText = "SP_EliminarMaterias";
                    using (SqlCommand command = new SqlCommand(cmdText, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@IdMateria", idMateria);
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (SqlException)
            {

                throw;
            }
        }
    }
}
