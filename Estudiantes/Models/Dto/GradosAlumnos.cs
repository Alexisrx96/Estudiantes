
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;
namespace Estudiantes.Models.Dto
{
    public class GradosAlumnos
    {
        [Key]
        public int IdGradoAlumno { get; set; }

        [Required]
        [StringLength(8)]
        public string IdAlumno { get; set; }

        public byte IdGrado { get; set; }

        [Required]
        [StringLength(1)]
        public string Seccion { get; set; }

        public byte NoLista { get; set; }

        public int Anio { get; set; }

        public virtual Alumnos Alumnos { get; set; }

        public virtual Grados Grados { get; set; }
        
        public virtual ICollection<Notas> Notas { get; set; }
    }
}
