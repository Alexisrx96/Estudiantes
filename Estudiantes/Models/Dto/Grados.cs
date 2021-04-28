using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace Estudiantes.Models.Dto
{
    public class Grados
    {
        [Key]
        public byte IdGrado { get; set; }

        [Required]
        [StringLength(30)]
        public string NombreGrado { get; set; }
        
        public virtual ICollection<GradosAlumnos> GradosAlumnos { get; set; }
        public virtual ICollection<Materias> Materias { get; set; }
    }
}
