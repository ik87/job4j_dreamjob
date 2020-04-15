#  Список пользователей
[![Build Status](https://travis-ci.org/ik87/job4j_dreamjob.svg?branch=master)](https://travis-ci.org/ik87/job4j_dreamjob) ![Heroku](https://heroku-badge.herokuapp.com/?app=test-table-app-users&style=flat&svg=1)

REST пет-проект "Список ползьователей"
 * демонстрация:  https://test-table-app-users.herokuapp.com

### Использованные средства:

* [Bootstrap](getbootstrap.com) - для реализации UI
* [Bing Maps JavaScript API](https://docs.microsoft.com/en-us/bingmaps/v8-web-control) - поиск города
* [J2EE](https://www.oracle.com/technetwork/java/javaee/) - JPA, Servlet
* [Apache Tomcat](http://tomcat.apache.org/) - контейнер сервлетов
* [POSTGRESQL](https://www.postgresql.org/) - база данных
* [Junit](https://junit.org/), [powermock](https://www.postgresql.org/) - тестирование
* [GSON](https://github.com/google/gson) - сериализация и десериализация Java объектов в JSON

### REST API

для всех пользователей:

| команда              | запрос                                                                           | ответ                                              
|----------------------|----------------------------------------------------------------------------------|-------------------------|
| авторизвация         | POST ```https://sitename/login```  Body: ```{login: "John" , password: "123"}``` | Код состояния:```200``` |
| покинуть авторизацию | GET ```https://sitename/signout```                                               | Код состояния:```302``` |

для авторизированного пользователя как Admin:

| команда                            | запрос                                                           | ответ                                                                                                                                     |
|------------------------------------|------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------|
| получить список всех пользователей | GET ```https://sitename/admin```                                       | Код состояния: ```200``` Header: ```"Content-Type: application/json;charset=UTF-8"```  Body: ```{sesstonUser:"[user_session]", all:"[user_1, user_2...]"}``` |
| получить конкретного пользователя  | GET ```https://sitename/admin?id=1```                                  | Код состояния: ```200``` Header: ```"Content-Type: application/json;charset=UTF-8"```  Body: ```{user}```                                            |
| добавить пользователя              | POST ```https://sitename/admin```   Body: ```{user, action: "add"}```        | Код состояния: ```201``` Header: ```"Location: /admin?id=39"``` Body: ```{}```                                                                              |
| изменить пользователя              | POST ```https://sitename/admin```   Body: ```{user, action: "update"}```     | Код состояния: ```200``` Header: ```"Location: /admin?id=39"``` Body: ```{}```                                                                              |
| удалить пользователя               | POST ```https://sitename/admin```   Body: ```{id: "39", action: "remove"}``` | Код состояния: ```200```                                                                                                                        |

для авторизированного пользователя как User:

| команда                                 | запрос                                                                | ответ                                              |
|-----------------------------------------|-----------------------------------------------------------------------|----------------------------------------------------|
| получить авторизированного пользователя | GET ```https://sitename/user```                                       | Код состояния:```200``` Header: ```"Content-Type: application/json;charset=UTF-8"```  Body: ```{user_session}``` |
| изменить пользователя                   | POST ```https://sitename/user``` Body: ```{user, action: "update"}``` | Код состояния: ```200```                           |
