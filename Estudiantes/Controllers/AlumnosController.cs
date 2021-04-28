using Estudiantes.Models.Dao;
using Estudiantes.Models.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace Estudiantes.Controllers
{
    public class AlumnosController : Controller
    {
        private AlumnoDao db = new AlumnoDao();
        // GET: Alumnos
        public ActionResult Index()
        {
            IList<Alumnos> alumnos = db.VerAlumnos();
            return View(alumnos);
        }

        // GET: Alumnos/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Alumnos alumno = db.VerAlumno(id);
            if (alumno == null)
            {
                return HttpNotFound();
            }
            return View(alumno);
        }

        // GET: Alumnos/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Alumnos/Create
        [HttpPost]
        public ActionResult Create([Bind(Include = "NombresAlumno,PrimerApellido,SegundoApellido,FechaNacimiento,AnioIngreso")] Alumnos alumno)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    db.InsertarAlumno(alumno);
                    return RedirectToAction("Index");
                }
                else
                    return View(alumno);
            }
            catch
            {
                return View(alumno);
            }

        }

        // GET: Alumnos/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Alumnos alumno = db.VerAlumno(id);
            if (alumno == null)
            {
                return HttpNotFound();
            }
            return View(alumno);
        }

        // POST: Alumnos/Edit/5
        [HttpPost]
        public ActionResult Edit([Bind(Include = "IdAlumno,NombresAlumno,PrimerApellido,SegundoApellido,FechaNacimiento,AnioIngreso")] Alumnos alumno)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    db.ModificarAlumno(alumno);
                    return RedirectToAction("Index");
                }
                else
                    return View(alumno);
            }
            catch
            {
                return View(alumno);
            }

        }

        // GET: Alumnos/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Alumnos alumno = db.VerAlumno(id);
            if (alumno == null)
            {
                return HttpNotFound();
            }
            return View(alumno);
        }

        // POST: Alumnos/Delete/5
        [HttpPost]
        public ActionResult Delete([Bind(Include = "IdAlumno")] Alumnos alumno)
        {
            try
            {
                db.EliminarAlumno(alumno.IdAlumno);
                return RedirectToAction("Index");
            }
            catch
            {
                return View(alumno);
            }
        }
    }
}
