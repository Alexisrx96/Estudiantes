
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;
namespace Estudiantes.Models.Dto
{
    public class Notas
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int IdGradoAlumno { get; set; }

        [Key]
        [Column(Order = 1)]
        public byte IdTipoNota { get; set; }

        [Key]
        [Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Anio { get; set; }

        [Column(TypeName = "numeric")]
        public decimal Nota { get; set; }

        public virtual GradosAlumnos GradosAlumnos { get; set; }

        public virtual TiposNotas TiposNotas { get; set; }
    }
}
