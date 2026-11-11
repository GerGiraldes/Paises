# paises - CRUD de paises (Paises_7A)

Node.js + Express + MySQL.

## Base de datos
```bash
sudo mysql < paises_7A.sql
```
Crea la base `Paises_7A`, las tablas `paises` y `provincias`, carga los paises de Latinoamerica, las provincias de Argentina y un usuario `paises_app` para la aplicacion.

## Correr
```bash
npm install
npm start
```
Abrir http://localhost:3000 — se puede agregar, editar, borrar y listar paises.

API: `GET/POST /api/paises`, `GET/PUT/DELETE /api/paises/:id`
