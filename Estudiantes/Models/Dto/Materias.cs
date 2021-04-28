
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;
namespace Estudiantes.Models.Dto
{
    public class Materias
    {

        [Key]
        public byte IdMateria { get; set; }

        [Required]
        [StringLength(30)]
        public string NombreMateria { get; set; }
        
        public virtual ICollection<TiposNotas> TiposNotas { get; set; }
        
        public virtual ICollection<Grados> Grados { get; set; }
    }
}
