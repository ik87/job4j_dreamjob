DROP TABLE Users;
DROP TABLE Roles;
--add roles
CREATE TABLE Roles (
   role_id serial primary key,
   role varchar(10)
);

-- add users
CREATE TABLE Users (
   user_id serial primary key,
   role_id int references Roles(role_id),
   photo bytea,
   login varchar(50) UNIQUE,
   email varchar(50),
   password varchar(50),
   created timestamp,
   country varchar(50),
   city varchar(50)
);

-- set tables as unique
-- ALTER TABLE users ADD UNIQUE ("login" , "email");

INSERT INTO Roles(role) VALUES ('admin'),('user');

INSERT INTO Users(role_id, login, email, password, created, country, city)
VALUES
(1, 'Jack', 'jack@gmail.com', '123', '2019-10-10 22:50', 'Russia', 'Moscow'),
(2, 'Mark', 'mark@gmail.com', '123', '2019-10-10 22:50', 'United States', 'California'),
(2, 'John', 'john@gmail.com', '123', '2020-01-17 22:50', 'India', 'Delhi');

-- add user
-- INSERT INTO Users(roleId, login, email, password, created) VALUES (?, ?, ?, ?, ?)

-- get user
-- SELECT userId, u.roleId, role, login, email, password, created
-- FROM users u JOIN roles r ON r.roleId = u.roleId