// CRUD de paises - Node.js + Express + MySQL
const express = require('express');
const mysql = require('mysql2/promise');
const path = require('path');

const app = express();
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

const db = mysql.createPool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'paises_app',
  password: process.env.DB_PASS || 'paises123',
  database: process.env.DB_NAME || 'Paises_7A',
});

// LISTAR
app.get('/api/paises', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM paises ORDER BY pais_id');
    res.json(rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// VER UNO
app.get('/api/paises/:id', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM paises WHERE pais_id = ?', [req.params.id]);
    if (!rows.length) return res.status(404).json({ error: 'No existe' });
    res.json(rows[0]);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// CREAR
app.post('/api/paises', async (req, res) => {
  const { pais_id, pais_descripcion } = req.body;
  if (!pais_id || !pais_descripcion) return res.status(400).json({ error: 'Faltan datos' });
  try {
    await db.query('INSERT INTO paises (pais_id, pais_descripcion) VALUES (?, ?)', [pais_id, pais_descripcion]);
    res.status(201).json({ pais_id, pais_descripcion });
  } catch (e) { res.status(400).json({ error: e.message }); }
});

// MODIFICAR
app.put('/api/paises/:id', async (req, res) => {
  const { pais_descripcion } = req.body;
  if (!pais_descripcion) return res.status(400).json({ error: 'Falta la descripcion' });
  try {
    const [r] = await db.query('UPDATE paises SET pais_descripcion = ? WHERE pais_id = ?', [pais_descripcion, req.params.id]);
    if (!r.affectedRows) return res.status(404).json({ error: 'No existe' });
    res.json({ pais_id: Number(req.params.id), pais_descripcion });
  } catch (e) { res.status(400).json({ error: e.message }); }
});

// BORRAR
app.delete('/api/paises/:id', async (req, res) => {
  try {
    const [r] = await db.query('DELETE FROM paises WHERE pais_id = ?', [req.params.id]);
    if (!r.affectedRows) return res.status(404).json({ error: 'No existe' });
    res.json({ ok: true });
  } catch (e) {
    // si tiene provincias cargadas la foreign key no deja borrarlo
    res.status(400).json({ error: 'No se puede borrar: ' + e.message });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`CRUD de paises en http://localhost:${PORT}`));
