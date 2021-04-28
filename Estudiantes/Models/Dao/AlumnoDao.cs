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
    class AlumnoDao:DbContext
    {
        public IList<Alumnos> VerAlumnos(string condicion = "")
        {
            List<Alumnos> alumnos = new List<Alumnos>();
            try
            {
                using (SqlConnection connection = new SqlConnection(ConectionString))
                {
                    connection.Open();
                    string cmdText = "SP_BuscarAlumnos";
                    using (SqlCommand command = new SqlCommand(cmdText, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@IdAlumno", condicion);
                        using (SqlDataReader reader = command.ExecuteReader())
                        {

                            while (reader.Read())
                            {
                                alumnos.Add(new Alumnos()
                                {
                                    IdAlumno = reader.GetString(0),
                                    NombresAlumno = reader.GetString(1),
                                    PrimerApellido = reader.GetString(2),
                                    SegundoApellido = reader.GetString(3),
                                    FechaNacimiento = reader.GetDateTime(4),
                                    AnioIngreso = reader.GetInt32(5)
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
            return alumnos;
        }

        public Alumnos VerAlumno(string idAlumno)
        {
            Alumnos alumno = null;
            try
            {
                using (SqlConnection connection = new SqlConnection(ConectionString))
                {
                    connection.Open();
                    string cmdText = "SP_BuscarAlumno";
                    using (SqlCommand command = new SqlCommand(cmdText, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@IdAlumno", idAlumno);
                        using (SqlDataReader reader = command.ExecuteReader())
                        {

                            while (reader.Read())
                            {
                                alumno = new Alumnos()
                                {
                                    IdAlumno = reader.GetString(0),
                                    NombresAlumno = reader.GetString(1),
                                    PrimerApellido = reader.GetString(2),
                                    SegundoApellido = reader.GetString(3),
                                    FechaNacimiento = reader.GetDateTime(4),
                                    AnioIngreso = reader.GetInt32(5)
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

        public void InsertarAlumno(Alumnos alumno)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConectionString))
                {
                    connection.Open();
                    string cmdText = "SP_InsertarAlumno";
                    using (SqlCommand command = new SqlCommand(cmdText, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@NombreAlumno", alumno.NombresAlumno);
                        command.Parameters.AddWithValue("@PrimerApellido", alumno.PrimerApellido);
                        command.Parameters.AddWithValue("@SegundoApellido", alumno.SegundoApellido);
                        command.Parameters.AddWithValue("@AnioIngreso", alumno.AnioIngreso);
                        command.Parameters.AddWithValue("@FechaNacimiento", alumno.FechaNacimiento);
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (SqlException)
            {

                throw;
            }
        }

        public void ModificarAlumno(Alumnos alumno)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConectionString))
                {
                    connection.Open();
                    string cmdText = "SP_EditarAlumno";
                    using (SqlCommand command = new SqlCommand(cmdText, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@NombreAlumno", alumno.NombresAlumno);
                        command.Parameters.AddWithValue("@PrimerApellido", alumno.PrimerApellido);
                        command.Parameters.AddWithValue("@SegundoApellido", alumno.SegundoApellido);
                        command.Parameters.AddWithValue("@AnioIngreso", alumno.AnioIngreso);
                        command.Parameters.AddWithValue("@FechaNacimiento", alumno.FechaNacimiento);
                        command.Parameters.AddWithValue("@IdAlumno", alumno.IdAlumno);
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (SqlException)
            {

                throw;
            }
        }

        public void EliminarAlumno(string idAlumno)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConectionString))
                {
                    connection.Open();
                    string cmdText = "SP_EliminarAlumno";
                    using (SqlCommand command = new SqlCommand(cmdText, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@IdAlumno", idAlumno);
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
