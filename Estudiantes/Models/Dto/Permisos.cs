
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;
namespace Estudiantes.Models.Dto
{
    public class Permisos
    {
        [Key]
        public int IdPermiso { get; set; }

        [Required]
        [StringLength(20)]
        public string NombrePermiso { get; set; }
        public virtual ICollection<Usuarios> Usuarios { get; set; }
    }
}
