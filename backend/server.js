const express = require('express');
const { Pool } = require('pg');
const cors = require('cors');
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const app = express();

const PORT = process.env.PORT || 3000;

// Настройка подключения к PostgreSQL
const pool = new Pool({
  host: process.env.PGHOST,
  user: process.env.PGUSER,
  password: process.env.PGPASSWORD,
  database: process.env.PGDATABASE,
  port: 5432,
  ssl: { 
    rejectUnauthorized: false // Обязательно для Neon.tech!
  }
});

// Middleware
app.use(cors());
app.use(express.json());

// Проверка подключения к БД
pool.connect()
  .then(() => console.log('Connected to PostgreSQL'))
  .catch(err => console.error('Connection error:', err));

// Статические файлы
const frontendPath = path.join(__dirname, '..', 'frontend');
app.use(express.static(frontendPath));
app.use('/uploads', express.static('uploads'));

// Маршруты
app.get('/', (req, res) => {
  res.sendFile(path.join(frontendPath, 'login.html'));
});

// Получение имени пользователя (требует настройки сессий)
app.get('/get-username', async (req, res) => {
  try {
    // Реализуйте логику сессий через JWT или библиотеку сессий
    res.status(501).json({ error: 'Not implemented' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error' });
  }
});

// API для получения списка акций
app.get("/api/promotions", async (req, res) => {
  try {
    const { rows } = await pool.query("SELECT * FROM promotions");
    res.json(rows);
  } catch (err) {
    console.error("Ошибка запроса:", err);
    res.status(500).json({ error: "Ошибка сервера" });
  }
});

// Обработка сообщений
app.post('/api/messages', async (req, res) => {
  try {
    const { username, message } = req.body;
    const { rows } = await pool.query(
      'INSERT INTO messages (username, message) VALUES ($1, $2) RETURNING *',
      [username, message]
    );
    res.json({ success: true, data: rows[0] });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: 'Ошибка сервера' });
  }
});

// Получение сообщений
app.get('/api/messages', async (req, res) => {
  try {
    const { rows } = await pool.query('SELECT * FROM messages');
    res.json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: 'Ошибка сервера' });
  }
});

// Удаление сообщения
app.delete('/api/messages/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const { rowCount } = await pool.query('DELETE FROM messages WHERE id = $1', [id]);
    
    if (rowCount > 0) {
      res.status(200).send('Сообщение удалено');
    } else {
      res.status(404).send('Сообщение не найдено');
    }
  } catch (err) {
    console.error('Ошибка удаления:', err);
    res.status(500).send('Ошибка сервера');
  }
});

// Загрузка файлов
const storage = multer.diskStorage({
  destination: 'uploads/',
  filename: (req, file, cb) => {
    const userID = req.body.userID;
    const ext = path.extname(file.originalname);
    cb(null, `${userID}_profile${ext}`);
  }
});
const upload = multer({ storage });

app.post('/uploadProfileImage', upload.single('profileImage'), async (req, res) => {
  try {
    const userID = req.body.userID;
    const filePath = `uploads/${req.file.filename}`;

    const { rows } = await pool.query(
      'UPDATE users SET profileImage = $1 WHERE userID = $2 RETURNING *',
      [filePath, userID]
    );
    
    res.json({ message: 'Изображение обновлено', data: rows[0] });
  } catch (err) {
    console.error('Ошибка обновления:', err);
    res.status(500).json({ error: 'Ошибка сервера' });
  }
});

// Авторизация
app.post('/login', async (req, res) => {
  try {
    const { login, password } = req.body;
    const userQuery = await pool.query(
      'SELECT u.*, r.roleName FROM users u LEFT JOIN roles r ON u.roleID = r.roleID WHERE login = $1 AND password = $2',
      [login, password]
    );

    if (userQuery.rows.length === 0) {
      return res.status(401).json({ message: 'Неверные данные' });
    }

    const user = userQuery.rows[0];
    res.json({
      userID: user.userid,
      login: user.login,
      personalName: user.personalname,
      roleID: user.rolename,
      balancePoints: user.balancepoints,
      totalMiles: user.totalmiles,
      profileImage: user.profileimage
    });
  } catch (err) {
    console.error('Ошибка авторизации:', err);
    res.status(500).json({ message: 'Ошибка сервера' });
  }
});

// Рейсы
app.get('/api/flights', async (req, res) => {
  try {
    const { rows } = await pool.query(`
      SELECT 
        f.flightid AS "flightID",
        f.departuredate AS "departureDate",
        f.arrivaldate AS "arrivalDate",
        f.departurefrom AS "departureFrom",
        f.destinationto AS "destinationTo",
        f.availableseats AS "availableSeats",
        f.price,
        f.flightnumber AS "flightNumber",
        t.name AS "tariffName"
      FROM flight f
      JOIN tariff t ON f.tariffid = t.tariffid
    `);
    res.json(rows);
  } catch (err) {
    console.error('Ошибка получения рейсов:', err);
    res.status(500).json({ error: 'Ошибка сервера' });
  }
});

// Пользователи
app.get('/users', async (req, res) => {
  try {
    const { rows } = await pool.query(`
      SELECT 
        u.userid AS "userID",
        u.login,
        u.personalname AS "personalName",
        u.totalmiles AS "totalMiles",
        u.balancepoints AS "balancePoints",
        r.rolename AS "roleName"
      FROM users u
      LEFT JOIN roles r ON u.roleid = r.roleid
      WHERE u.roleid != 2
    `);
    res.json(rows);
  } catch (err) {
    console.error('Ошибка получения пользователей:', err);
    res.status(500).json({ error: 'Ошибка сервера' });
  }
});

// Удаление пользователя
app.delete('/users/:personalName', async (req, res) => {
  try {
    const { personalName } = req.params;
    const { rowCount } = await pool.query(
      'DELETE FROM users WHERE personalName = $1',
      [personalName]
    );

    if (rowCount > 0) {
      res.json({ message: 'Пользователь удалён' });
    } else {
      res.status(404).json({ message: 'Пользователь не найден' });
    }
  } catch (err) {
    console.error('Ошибка удаления:', err);
    res.status(500).json({ error: 'Ошибка сервера' });
  }
});

// Добавление пользователя
app.post('/api/users', async (req, res) => {
  try {
    const { login, password, personalName, roleID } = req.body;
    const { rows } = await pool.query(
      'INSERT INTO users (login, password, personalName, roleID) VALUES ($1, $2, $3, $4) RETURNING *',
      [login, password, personalName, roleID]
    );
    res.status(201).json(rows[0]);
  } catch (err) {
    console.error('Ошибка добавления:', err);
    res.status(500).json({ error: 'Ошибка сервера' });
  }
});

app.listen(PORT, () => {
  console.log(`Сервер запущен на порту ${PORT}`);
});

module.exports = app;
