const chai = require('chai');
const expect = chai.expect;
const request = require('supertest');
const mysql = require('mysql2');
const server = require('../server'); // Путь к вашему серверу

// Подключение к тестовой БД
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '@Hasbik1609D',
    database: 'avia_db'
});

describe('API Tests', () => {
    before((done) => {
        // Подключение к базе данных перед тестами
        db.connect((err) => {
            if (err) {
                console.error('Ошибка подключения к базе данных:', err);
                return done(err);
            }
            console.log('Подключение к базе данных успешно');
            done();
        });
    });

    after((done) => {
        // Закрытие соединения с базой данных после всех тестов
        db.end((err) => {
            if (err) {
                console.error('Ошибка закрытия базы данных:', err);
            }
            done();
        });
    });

    it('POST /api/users - Должен добавить нового пользователя', (done) => {
        request(server)
            .post('/api/users')
            .send({
                login: 'test_login',          // Логин нового пользователя
                password: 'test_password',    // Пароль нового пользователя
                personalName: 'Test User',    // Имя пользователя
                roleID: 1                     // ID роли пользователя
            })
            .end((err, res) => {
                if (err) {
                    console.error('Ошибка при выполнении POST /api/users:', err);
                    return done(err);
                }
                expect(res.status).to.equal(201);  // Ожидаем статус 201
                expect(res.body.message).to.equal('Пользователь успешно добавлен');  // Ожидаем сообщение об успешном добавлении
                console.log('Тест POST /api/users пройден успешно');
                done();
            });
    });
    
    

    it('GET /api/flights - Должен вернуть список рейсов', (done) => {
        request(server)
            .get('/api/flights')
            .end((err, res) => {
                if (err) {
                    console.error('Ошибка при выполнении GET /api/flights:', err);
                    return done(err);
                }
                expect(res.status).to.equal(200);  // Ожидаем статус 200
                expect(res.body).to.be.an('array');  // Ожидаем, что ответ будет массивом
    
                // Выводим список рейсов в консоль
                console.log('Полученные рейсы:', res.body);
    
                console.log('Тест GET /api/flights пройден успешно');
                done();
            });
    });
    

    it('POST /api/messages - Должен добавить новое сообщение', (done) => {
        request(server)
            .post('/api/messages')
            .send({ username: 'daryenaya', message: 'Я пишу новое сообщение' })
            .end((err, res) => {
                if (err) {
                    console.error('Ошибка при выполнении POST /api/messages:', err);
                    return done(err);
                }
                expect(res.status).to.equal(200);  // Ожидаем статус 200
                expect(res.body.success).to.be.true;  // Ожидаем, что ответ будет success: true
                console.log('Тест POST /api/messages пройден успешно');
                done();
            });
    });
});
