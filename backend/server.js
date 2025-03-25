const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const bodyParser = require('body-parser');
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const app = express();

const PORT = 3000;

app.use(cors());
app.use(bodyParser.json());

// Подключение к базе данных
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '@Hasbik1609D',
    database: 'avia_db'
});

app.get('/', (req, res) => {
    res.send('Сервер работает! Добро пожаловать в API.');
});


// Указываем правильный путь к frontend
const frontendPath = path.join(__dirname, '..', 'frontend');
app.use(express.static(frontendPath));

app.get('/', (req, res) => {
    res.sendFile(path.join(frontendPath, 'login.html'));
});

db.connect(err => {
    if (err) {
        console.error('Ошибка подключения к БД:', err);
    } else {
        console.log('Подключение к MySQL успешно!');
    }
});

// Middleware для обработки JSON данных
app.use(bodyParser.json());
app.use(cors());


app.get('/get-username', (req, res) => {
    if (!req.session.userID) {
        return res.status(401).json({ error: 'Не авторизован' });
    }

    res.json({ username: req.session.username });
});

app.use('/uploads', express.static('uploads'));



// API для получения списка акций
app.get("/api/promotions", (req, res) => {
    db.query("SELECT * FROM promotions", (err, results) => {
        if (err) {
            console.error("Ошибка запроса:", err);
            res.status(500).json({ error: "Ошибка сервера" });
            return;
        }
        res.json(results);
    });
});

// API для обработки отправки сообщения
app.post('/api/messages', (req, res) => {
    const { username, message } = req.body;

    if (!username || !message) {
        return res.status(400).json({ success: false, message: 'Не все поля заполнены' });
    }

    const query = 'INSERT INTO messages (username, message) VALUES (?, ?)';
    db.query(query, [username, message], (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ success: false, message: 'Ошибка при сохранении сообщения' });
        }
        res.json({ success: true, message: 'Сообщение успешно отправлено' });
    });
});

app.get('/api/messages', (req, res) => {
    const query = 'SELECT * FROM messages';
    db.query(query, (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ success: false, message: 'Ошибка при получении сообщений' });
        }
        res.json(result);
    });
});

// Обработчик для DELETE-запроса
app.delete('/api/messages/:id', (req, res) => {
    const messageId = req.params.id; // Получаем ID сообщения из URL

    // Запрос для удаления записи из таблицы 'messages'
    db.query('DELETE FROM messages WHERE id = ?', [messageId], (err, result) => {
        if (err) {
            console.error('Ошибка при удалении записи:', err);
            res.status(500).send('Ошибка сервера');
            return;
        }

        if (result.affectedRows > 0) {
            res.status(200).send('Сообщение удалено');
        } else {
            res.status(404).send('Сообщение не найдено');
        }
    });
});


// Настройка multer для загрузки файлов
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, 'uploads/'); // Папка для хранения изображений
    },
    filename: function (req, file, cb) {
        const userID = req.body.userID;
        const fileExtension = path.extname(file.originalname);
        cb(null, `${userID}_profile${fileExtension}`);
    }
});

const upload = multer({ storage: storage });

// Маршрут для загрузки изображения профиля
app.post('/uploadProfileImage', upload.single('profileImage'), (req, res) => {
    const userID = req.body.userID;
    const filePath = 'uploads/${req.file.filename}';

    // Обновление пути к изображению в базе данных
    const sql = 'UPDATE users SET profileImage = ? WHERE userID = ?';
    db.query(sql, [filePath, userID], (err, results) => {
        if (err) {
            console.error('Ошибка обновления профиля:', err);
            return res.status(500).json({ error: 'Ошибка обновления профиля' });
        }
        res.json({ message: 'Изображение профиля обновлено', filePath });
    });
});

// Маршрут для обработки входа пользователя
app.post('/login', (req, res) => {
    const { login, password } = req.body;

    // Проверка логина и пароля в базе данных
    const sql = 'SELECT * FROM users WHERE login = ? AND password = ?';
    db.query(sql, [login, password], (err, results) => {
        if (err) {
            console.error('Ошибка при проверке данных пользователя:', err);
            return res.status(500).json({ message: 'Ошибка при проверке данных пользователя' });
        }

        if (results.length > 0) {
            const user = results[0];

            // Получаем информацию о роли
            const roleSql = 'SELECT roleName FROM roles WHERE roleID = ?';
            db.query(roleSql, [user.roleID], (err, roleResults) => {
                if (err) {
                    console.error('Ошибка при получении роли:', err);
                    return res.status(500).json({ message: 'Ошибка при получении роли' });
                }

                const userRole = roleResults.length > 0 ? roleResults[0].roleName : 'Unknown';
                const userData = {
                    userID: user.userID,
                    login: user.login,
                    personalName: user.personalName,
                    roleID: userRole,
                    balancePoints: user.balancePoints,
                    totalMiles: user.totalMiles,
                    profileImage: user.profileImage
                };

                res.json(userData); // Отправляем данные пользователя в ответ
            });
        } else {
            res.status(401).json({ message: 'Неверный логин или пароль' });
        }
    });
});

// Маршрут для обработки рейсов
app.get('/api/flights', (req, res) => {
    const sql = `
        SELECT 
            f.flightID,
            f.departureDate,
            f.arrivalDate,
            f.departureFrom,
            f.destinationTo,
            f.availableSeats,
            f.price,
            f.flightNumber,
            t.name AS tariffName
        FROM flight f
        JOIN tariff t ON f.tariffID = t.tariffID
    `;

    db.query(sql, (err, results) => {
        if (err) {
            console.error('Ошибка при получении данных о рейсах:', err);
            return res.status(500).json({ error: 'Ошибка сервера' });
        }
        res.json(results);
    });
});

// Маршрут для получения всех пользователей, кроме администратора
app.get('/users', (req, res) => {
    const query = "SELECT * FROM USERS WHERE roleID != 2";  // 2 — это ID роли администратора, предположительно
    db.query(query, (err, results) => {
        if (err) {
            console.error('Ошибка выполнения запроса:', err);
            res.status(500).send('Ошибка сервера');
            return;
        }
        res.json(results);  // Отправляем данные на клиент
    });
});

app.get('/users', (req, res) => {
    const query = `
        SELECT users.userID, users.login, users.password, users.personalName, 
               users.totalMiles, users.balancePoints, roles.roleName
        FROM users
        LEFT JOIN roles ON users.roleID = roles.roleID;
    `;

    connection.query(query, (err, results) => {
        if (err) {
            console.error('Ошибка при выполнении запроса:', err);
            return res.status(500).json({ error: 'Ошибка при получении данных' });
        }

        console.log('Результаты запроса:', results);  // Логируем результаты запроса
        res.json(results);  // Отправляем данные в формате JSON
    });
});

// Обработчик для удаления пользователя
app.delete('/users/:personalName', (req, res) => {
    const personalName = req.params.personalName;

    const query = 'DELETE FROM users WHERE personalName = ?';

    db.query(query, [personalName], (err, result) => {
        if (err) {
            console.error('Ошибка при удалении пользователя:', err);
            return res.status(500).json({ message: 'Не удалось удалить пользователя' });
        }

        if (result.affectedRows > 0) {
            return res.status(200).json({ message: 'Пользователь успешно удален' });
        } else {
            return res.status(404).json({ message: 'Пользователь не найден' });
        }
    });
});

// Маршрут для статических файлов (изображения)
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// Запуск сервера
app.listen(PORT, () => {
    console.log(`Сервер запущен на http://localhost:${PORT}`);
});