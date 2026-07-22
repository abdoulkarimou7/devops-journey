const request = require('supertest');
const app = require('./app');
const pool = require('./db');

describe('GET /tasks', () => {
  it('should respond with an array', async () => {
    const res = await request(app).get('/tasks');
    expect(res.statusCode).toBe(200);
    expect(Array.isArray(res.body)).toBe(true);
  });
});

afterAll(async () => {
  await pool.end();
});