package ru.job4j.webservice.service;

import ru.job4j.webservice.models.Role;
import ru.job4j.webservice.models.User;

import java.util.List;

public class ValidateStub implements Validate{
    @Override
    public boolean add(User user) {
        return false;
    }

    @Override
    public boolean update(User user) {
        return false;
    }

    @Override
    public boolean update(User oldUser, User newUser) {
        return false;
    }

    @Override
    public boolean delete(User user) {
        return false;
    }

    @Override
    public List<User> findAll() {
        return null;
    }

    @Override
    public User findById(User user) {
        return null;
    }

    @Override
    public User findByLogin(User user) {
        return null;
    }

    @Override
    public List<Role> getRoles() {
        return null;
    }

    @Override
    public User findByLoginAndPassword(User user) {
        return null;
    }
}
