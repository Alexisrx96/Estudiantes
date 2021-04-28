using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace Estudiantes.Models.Dto
{
    public partial class TiposNotas
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public byte IdTipoNota { get; set; }

        [Required]
        [StringLength(15)]
        public string TipoNota { get; set; }

        public byte IdMateria { get; set; }

        public int ponderacion { get; set; }

        public virtual Materias Materias { get; set; } 
        public virtual ICollection<Notas> Notas { get; set; }
    }
}
