package ru.job4j.webservice.persistent;

import org.apache.commons.dbcp2.BasicDataSource;
import ru.job4j.webservice.models.Role;
import ru.job4j.webservice.models.User;

import java.net.URI;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DbStore implements Store {
    private final static BasicDataSource SOURCE = new BasicDataSource();
    private final static DbStore INSTANCE = new DbStore();

    @Override
    public boolean ifExist(User user) {
        String sql = "WHERE user_id = ?";
        return !findBy(sql, x -> x.setInt(1, user.getId())).isEmpty();
    }

    private DbStore() {
        try {
            URI dbUri = new URI(System.getenv("DATABASE_URL"));
            String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + dbUri.getPath() + "?sslmode=require";

            if (dbUri.getUserInfo() != null) {
                SOURCE.setUsername(dbUri.getUserInfo().split(":")[0]);
                SOURCE.setPassword(dbUri.getUserInfo().split(":")[1]);
            }
            SOURCE.setDriverClassName("org.postgresql.Driver");
            SOURCE.setUrl(dbUrl);
            SOURCE.setInitialSize(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static DbStore getInstance() {
        return INSTANCE;
    }

    @Override
    public User add(User user) {
        User result = null;
        String sql = "INSERT INTO Users(role_id, login, email, password, created, country, city) VALUES (?, ?, ?, ?, NOW(), ?, ?)";
        try (Connection connection = SOURCE.getConnection();
             PreparedStatement pstm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pstm.setInt(1, user.getRole().getId());
            pstm.setString(2, user.getLogin());
            pstm.setString(3, user.getEmail());
            pstm.setString(4, user.getPassword());
            pstm.setString(5, user.getCountry());
            pstm.setString(6, user.getCity());
            pstm.executeUpdate();
            try (ResultSet generatedKeys = pstm.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    user.setId(generatedKeys.getInt(1));
                }
            }
            result = user;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }


    @Override
    public boolean update(User user) {
        boolean result = true;
        String sql = "UPDATE users SET role_id = ?, "
                + "login = ?, email = ?, password = ?, photo = ?, country = ?, city = ? WHERE user_id = ?";
        try (Connection connection = SOURCE.getConnection();
             PreparedStatement pstm = connection.prepareStatement(sql)) {
            pstm.setInt(1, user.getRole().getId());
            pstm.setString(2, user.getLogin());
            pstm.setString(3, user.getEmail());
            pstm.setString(4, user.getPassword());
            pstm.setBytes(5, user.getPhoto());
            pstm.setString(6, user.getCountry());
            pstm.setString(7, user.getCity());
            pstm.setInt(8, user.getId());

            pstm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            result = false;
        }
        return result;
    }

    @Override
    public void delete(User user) {
        String sql = "DELETE FROM users WHERE user_id = ?";
        try (Connection connection = SOURCE.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, user.getId());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<User> findAll() {
        return findBy("", null);
    }

    @Override
    public User findById(User user) {
        String sql = "WHERE user_id = ?";
        List<User> result = findBy(sql, x -> x.setInt(1, user.getId()));
        return result.isEmpty() ? null : result.get(0);
    }

    @Override
    public User findByLogin(User user) {
        String sql = "WHERE login = ?";
        List<User> result = findBy(sql, x -> x.setString(1, user.getLogin()));
        return result.isEmpty() ? null : result.get(0);
    }

    @Override
    public User findByLoginAndPassword(User user) {
        String sql = "WHERE login = ? AND password = ?";
        List<User> result = findBy(sql, x -> {
            x.setString(1, user.getLogin());
            x.setString(2, user.getPassword());
        });
        return result.isEmpty() ? null : result.get(0);
    }

    /**
     * General-purpose cities method
     *
     * @param where any sql WHERE cities
     * @param ps    functionality interface the same Consumer but can throws SQLException or NULL
     * @return array items
     */
    private List<User> findBy(String where, ConsumerX<PreparedStatement> ps) {
        String sql = "SELECT user_id, u.role_id, role, login, email, password, created, photo, u.city, u.country"
                + " FROM users u JOIN roles r ON r.role_id = u.role_id " + where;
        List<User> users = new ArrayList<>();
        try (Connection connection = SOURCE.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql)) {
            if (ps != null) {
                ps.accept(pstmt);
            }
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                User user = new User();
                Role role = new Role();

                role.setId(rs.getInt("role_id"));
                role.setRole(rs.getString("role"));

                user.setId(rs.getInt("user_id"));
                user.setLogin(rs.getString("login"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setCreated((rs.getTimestamp("created").getTime()));
                user.setPhoto(rs.getBytes("photo"));

                user.setCountry(rs.getString("country"));
                user.setCity(rs.getString("city"));

                user.setRole(role);

                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    /**
     * The same Consumer but can throws SQLException
     *
     * @param <T> for example  PreparedStatement
     */
    interface ConsumerX<T> {
        void accept(T obj) throws SQLException;
    }

    @Override
    public List<Role> getRoles() {
        return null;
    }
}
