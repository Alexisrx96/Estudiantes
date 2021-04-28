using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Estudiantes.Models;
using Estudiantes.Models.Dto;
using Estudiantes.Models.Dao;

namespace Estudiantes.Controllers
{
    public class GradosController : Controller
    {/*
        private GradosDao db = new GradosDao();

        // GET: Grados
        public ActionResult Index()
        {
            return View(db.());
        }

        // GET: Grados/Details/5
        public ActionResult Details(byte? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Grados grados = db.Grados.Find(id);
            if (grados == null)
            {
                return HttpNotFound();
            }
            return View(grados);
        }

        // GET: Grados/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Grados/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "IdGrado,NombreGrado")] Grados grados)
        {
            if (ModelState.IsValid)
            {
                db.Grados.Add(grados);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(grados);
        }

        // GET: Grados/Edit/5
        public ActionResult Edit(byte? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Grados grados = db.Grados.Find(id);
            if (grados == null)
            {
                return HttpNotFound();
            }
            return View(grados);
        }

        // POST: Grados/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "IdGrado,NombreGrado")] Grados grados)
        {
            if (ModelState.IsValid)
            {
                db.Entry(grados).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(grados);
        }

        // GET: Grados/Delete/5
        public ActionResult Delete(byte? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Grados grados = db.Grados.Find(id);
            if (grados == null)
            {
                return HttpNotFound();
            }
            return View(grados);
        }

        // POST: Grados/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(byte id)
        {
            Grados grados = db.Grados.Find(id);
            db.Grados.Remove(grados);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }*/
    }
}