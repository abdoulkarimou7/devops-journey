const express = require('express');
const pool = require('./db');
const app = express();

app.use(express.json());

// Lister toutes les tâches
app.get('/tasks', async (req, res) => {
  const result = await pool.query('SELECT * FROM tasks ORDER BY id');
  res.json(result.rows);
});

// Créer une tâche
app.post('/tasks', async (req, res) => {
  const result = await pool.query(
    'INSERT INTO tasks (title) VALUES ($1) RETURNING *',
    [req.body.title]
  );
  res.status(201).json(result.rows[0]);
});

// Marquer une tâche comme terminée
app.put('/tasks/:id', async (req, res) => {
  const result = await pool.query(
    'UPDATE tasks SET done = TRUE WHERE id = $1 RETURNING *',
    [req.params.id]
  );
  if (result.rows.length === 0) return res.status(404).json({ error: 'Task not found' });
  res.json(result.rows[0]);
});

// Supprimer une tâche
app.delete('/tasks/:id', async (req, res) => {
  await pool.query('DELETE FROM tasks WHERE id = $1', [req.params.id]);
  res.status(204).send();
});

app.listen(3000, () => {
  console.log('Server running on port 3000');
});