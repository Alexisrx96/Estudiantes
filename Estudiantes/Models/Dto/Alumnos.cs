using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Web.Mvc;

namespace Estudiantes.Models.Dto
{
    public class Alumnos
    {

        [Key]
        [StringLength(8)]
        [DisplayName("Código")]
        public string IdAlumno { get; set; }

        [Required]
        [MaxLength(25)]
        [DisplayName("Nombres")]
        public string NombresAlumno { get; set; }

        [Required]
        [MaxLength(25)]
        [DisplayName("Primer apellido")]
        public string PrimerApellido { get; set; }

        [Required]
        [MaxLength(25)]
        [DisplayName("Segundo apellido")]
        public string SegundoApellido { get; set; }
        
        [DataType(DataType.Date)]
        [DisplayName("Fecha de nacimiento")]
        public DateTime? FechaNacimiento { get; set; }

        [Required]
        [DisplayName("Año de ingreso")]
        [DateGreaterThan("FechaNacimiento")]
        [Range(2000,2200)]
        [ReadOnly(true)]
        public int AnioIngreso { get; set; }


        public virtual ICollection<GradosAlumnos> GradosAlumnos { get; set; }
    }

    [AttributeUsage(AttributeTargets.Property)]
    public class DateGreaterThanAttribute : ValidationAttribute, IClientValidatable
    {

        private string DateToCompareFieldName { get; set; }

        public DateGreaterThanAttribute(string dateToCompareFieldName)
        {
            DateToCompareFieldName = dateToCompareFieldName;
        }

        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            int laterDate = (int)value;

            DateTime? earlierDate = (DateTime)validationContext.ObjectType.GetProperty(DateToCompareFieldName).GetValue(validationContext.ObjectInstance, null);
            if (earlierDate.Value == null)
            {
                return ValidationResult.Success;
            }
            if ((laterDate-5) > earlierDate.Value.Year)
            {
                return ValidationResult.Success;
            }
            else
            {
                return new ValidationResult(string.Format("El campo {0} debe ser menor", DateToCompareFieldName));
            }
        }
        
        //Retorna las validaciones que serán utilizadas en el lado del cliente
        public IEnumerable<ModelClientValidationRule> GetClientValidationRules(ModelMetadata metadata, ControllerContext context)
        {
            var clientValidationRule = new ModelClientValidationRule()
            {
                ErrorMessage = string.Format("El campo {0} debe ser menor", DateToCompareFieldName),
                ValidationType = "dategreaterthan"
            };

            clientValidationRule.ValidationParameters.Add("datetocomparefieldname", DateToCompareFieldName);

            return new[] { clientValidationRule };
        }

    }
}
