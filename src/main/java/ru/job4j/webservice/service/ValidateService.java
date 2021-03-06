package ru.job4j.webservice.service;

import ru.job4j.webservice.models.Role;
import ru.job4j.webservice.models.User;
import ru.job4j.webservice.persistent.DbStore;
import ru.job4j.webservice.persistent.Store;

import java.util.List;

public class ValidateService implements Validate {
    private final Store store = DbStore.getInstance();

    private static final ValidateService INSTANCE = new ValidateService();

    private ValidateService() {
    }

    public static ValidateService getInstance() {
        return INSTANCE;
    }

    @Override
    public User add(User user) {
        User result = null;
        if (hasEmptyString(user)) {
           result = store.add(user);
        }
        return result;
    }

    @Override
    public boolean update(User user) {
        boolean result = false;
        if (store.ifExist(user) && hasEmptyString(user)) {
            result = store.update(user);
        }
        return result;
    }

    @Override
    public boolean update(User oldUser, User newUser) {

        if (!isEmpty(newUser.getPassword())) {
            oldUser.setPassword(newUser.getPassword());
        }

        if (!isEmpty(newUser.getLogin())) {
            oldUser.setLogin(newUser.getLogin());
        }

        if (!isEmpty(newUser.getEmail())) {
            oldUser.setEmail(newUser.getEmail());
        }

        if (newUser.getPhoto() != null) {
            oldUser.setPhoto(newUser.getPhoto());
        }

        if (newUser.getCountry() != null) {
            oldUser.setCountry(newUser.getCountry());
        }

        if (newUser.getCity() != null) {
            oldUser.setCity(newUser.getCity());
        }

        if (newUser.getRole() != null && newUser.getRole().getId() != null) {
            oldUser.setRole(newUser.getRole());
        }

        return update(oldUser);
    }

    @Override
    public boolean delete(User user) {
        boolean result = false;
        if (store.findById(user) != null) {
            store.delete(user);
            result = true;
        }
        return result;
    }

    @Override
    public List<User> findAll() {
        return store.findAll();
    }

    @Override
    public User findById(User user) {
        return store.findById(user);
    }

    private boolean hasEmptyString(User user) {
        return !user.getLogin().isEmpty()
                && !user.getEmail().isEmpty()
                && !user.getPassword().isEmpty();
    }

    @Override
    public User findByLogin(User user) {
        return store.findByLogin(user);
    }

    @Override
    public User findByLoginAndPassword(User user) {
        return store.findByLoginAndPassword(user);
    }

    @Override
    public List<Role> getRoles() {
        return store.getRoles();
    }

    /**
     * check string on null and empty
     *
     * @param str checked string
     * @return true if empty
     */
    private boolean isEmpty(String str) {
        return str == null || str.isEmpty();
    }
}
