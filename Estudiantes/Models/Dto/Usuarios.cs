
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;
namespace Estudiantes.Models.Dto
{
    public class Usuarios
    {

        [Key]
        [StringLength(20)]
        public string IdUsuario { get; set; }

        [Required]
        [StringLength(25)]
        public string Nombres { get; set; }

        [Required]
        [StringLength(25)]
        public string Apellidos { get; set; }

        [Required]
        [StringLength(25)]
        [DataType(DataType.Password)]
        public string Contrasenia { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Confirmar contraseña")]
        [Compare("Contrasenia", ErrorMessage = "La contraseña y la contraseña de confirmación no coinciden.")]
        public string ConfirmPassword { get; set; }

        public bool EstadoActivo { get; set; }
        
        public virtual ICollection<Permisos> Permisos { get; set; }
    }
}
