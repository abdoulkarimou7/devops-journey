const express = require('express');
const app = express();

app.use(express.json()); // permet de lire du JSON envoyé dans les requêtes

let tasks = []; // stockage temporaire en mémoire
let nextId = 1;

// Lister toutes les tâches
app.get('/tasks', (req, res) => {
  res.json(tasks);
});

// Créer une tâche
app.post('/tasks', (req, res) => {
  const task = { id: nextId++, title: req.body.title, done: false };
  tasks.push(task);
  res.status(201).json(task);
});

// Marquer une tâche comme terminée
app.put('/tasks/:id', (req, res) => {
  const task = tasks.find(t => t.id === parseInt(req.params.id));
  if (!task) return res.status(404).json({ error: 'Task not found' });
  task.done = true;
  res.json(task);
});

// Supprimer une tâche
app.delete('/tasks/:id', (req, res) => {
  tasks = tasks.filter(t => t.id !== parseInt(req.params.id));
  res.status(204).send();
});

app.listen(3000, () => {
  console.log('Server running on port 3000');
});