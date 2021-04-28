using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Estudiantes.Models.Dto;
using Estudiantes.Models.Dao;

namespace Estudiantes.Controllers
{
     
    public class MateriasController : Controller
    {
        private MateriasDao db = new MateriasDao();

        // GET: Materias
        public ActionResult Index()
        {
            return View(db.VerMaterias());
        }

        // GET: Materias/Details/5
        public ActionResult Details(byte? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Materias materias = db.VerMateria(id.Value);
            if (materias == null)
            {
                return HttpNotFound();
            }
            return View(materias);
        }

        // GET: Materias/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Materias/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "IdMateria,NombreMateria")] Materias materias)
        {
            if (ModelState.IsValid)
            {
                db.InsertarMateria(materias);
                return RedirectToAction("Index");
            }

            return View(materias);
        }

        // GET: Materias/Edit/5
        public ActionResult Edit(byte? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Materias materias = db.VerMateria(id.Value);
            if (materias == null)
            {
                return HttpNotFound();
            }
            return View(materias);
        }

        // POST: Materias/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "IdMateria,NombreMateria")] Materias materias)
        {
            if (ModelState.IsValid)
            {
                db.ModificarMateria(materias);
                return RedirectToAction("Index");
            }
            return View(materias);
        }

        // GET: Materias/Delete/5
        public ActionResult Delete(byte? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Materias materias = db.VerMateria(id.Value);
            if (materias == null)
            {
                return HttpNotFound();
            }
            return View(materias);
        }

        // POST: Materias/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(byte id)
        {
            db.EliminarMateria(id);
            return RedirectToAction("Index");
        }
    }
}
