const request = require('supertest');
const mysql = require('mysql2/promise');
const app = require('./server'); // Импортируем сервер

// Настройка тестовой базы данных
const dbConfig = {
    host: 'localhost',
    user: 'root',
    password: '@Hasbik1609D',
    database: 'avia_db'
};

// Тест на получение списка акций
test('GET /api/promotions - Получение списка акций', async () => {
    const response = await request(app).get('/api/promotions');
    expect(response.status).toBe(200);
    expect(Array.isArray(response.body)).toBeTruthy();
});

// Тест на добавление сообщения
test('POST /api/messages - Добавление сообщения', async () => {
    const messageData = { username: 'testuser', message: 'Тестовое сообщение' };
    
    const response = await request(app)
        .post('/api/messages')
        .send(messageData);

    expect(response.status).toBe(200);
    expect(response.body.success).toBeTruthy();
});

// Тест на удаление сообщения
test('DELETE /api/messages/:id - Удаление сообщения', async () => {
    const db = await mysql.createConnection(dbConfig);
    const [rows] = await db.execute('INSERT INTO messages (username, message) VALUES (?, ?)', ['testuser', 'Тест']);
    const messageId = rows.insertId;

    const response = await request(app).delete(`/api/messages/${messageId}`);
    expect(response.status).toBe(200);
    expect(response.text).toBe('Сообщение удалено');
    
    await db.end();
});
