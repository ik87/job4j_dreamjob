package ru.job4j.webservice.controllers.admin;

import com.google.gson.Gson;
import ru.job4j.webservice.dto.UserDto;
import ru.job4j.webservice.mapers.UserMapper;
import ru.job4j.webservice.mapers.UserMapperImpl;
import ru.job4j.webservice.models.User;
import ru.job4j.webservice.service.Utils;
import ru.job4j.webservice.service.Validate;
import ru.job4j.webservice.service.ValidateService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.BiConsumer;

public class MainServlet extends HttpServlet {
    private final UserMapper userMapper = UserMapperImpl.getInstance();
    private final Validate validate = ValidateService.getInstance();
    private final Map<String, BiConsumer<HttpServletRequest, HttpServletResponse>>
            actions = new ConcurrentHashMap<>();

    @Override
    public void init() throws ServletException {
        actions.put("add", this::add);
        actions.put("update", this::update);
        actions.put("remove", this::remove);
        actions.put("deleteImg", this::deleteImg);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //if  !XMLHttpRequst -> get list.jsp
        //if  XMLHttpRequst -> list users (json) and session user
        //if  XMLHttpRequst & id -> (json) user by id

        boolean ajax = "XMLHttpRequest".equals(req.getHeader("X-Requested-With"));

        if (ajax) {
            String id = req.getParameter("id");
            String json = "";
            if (id == null) {
                Map<String, Set<UserDto>> composUsers = new LinkedHashMap<>();
                Set<User> users = new LinkedHashSet<>(validate.findAll());

                User sessionUser = Utils.getObjectFromSession(req, "user");

                if (sessionUser != null) {
                    users.remove(sessionUser);
                    Set<UserDto> sesstionUserDto = Set.of(userMapper.toDto(sessionUser));
                    composUsers.put("sessionUser", sesstionUserDto);
                }

                Set<UserDto> usersDto = new LinkedHashSet<>(userMapper.toDto(users));
                composUsers.put("all", usersDto);

                json = new Gson().toJson(composUsers);

            } else {
                User user = new User();
                user.setId(Integer.valueOf(id));
                user = validate.findById(user);
                if (user != null) {
                    UserDto userDto = userMapper.toDto(user);
                    json = new Gson().toJson(userDto);
                }
            }
            if (!json.isEmpty()) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                resp.setStatus(HttpServletResponse.SC_OK);
                resp.getWriter().write(json);
            } else {
                resp.setCharacterEncoding("UTF-8");
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
        } else {
            req.getRequestDispatcher("/WEB-INF/view/list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        actions.get(action).accept(req, resp);
    }

    void update(HttpServletRequest req, HttpServletResponse resp) {
        User changed = Utils.propertiesToUser(req);
        User user = validate.findById(changed);
        boolean result = validate.update(user, changed);
        resp.setCharacterEncoding("UTF-8");
        if (result) {
            String id = "?id=" + user.getId().toString();
            String url = req.getRequestURI() + id;
            resp.setStatus(HttpServletResponse.SC_OK);
            resp.setHeader("Location", url);
        } else {
            resp.setStatus(HttpServletResponse.SC_CONFLICT);
        }
    }

    void deleteImg(HttpServletRequest req, HttpServletResponse resp) {
        User user = Utils.propertiesToUser(req);
        user = validate.findById(user);
        user.setPhoto(null);
        validate.update(user);
        resp.setStatus(HttpServletResponse.SC_OK);
    }

    void remove(HttpServletRequest req, HttpServletResponse resp) {
        User user = Utils.propertiesToUser(req);
        user = validate.findById(user);
        boolean result = validate.delete(user);
        if (result) {
            resp.setStatus(HttpServletResponse.SC_OK);
        } else {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
        }

    }

    void add(HttpServletRequest req, HttpServletResponse resp) {
        User user = Utils.propertiesToUser(req);
        user = validate.add(user);
        resp.setCharacterEncoding("UTF-8");
        if (user != null) {
            String id = "?id=" + user.getId().toString();
            String url = req.getRequestURI() + id;
            resp.setStatus(HttpServletResponse.SC_CREATED);
            resp.setHeader("Location", url);
        } else {
            resp.setStatus(HttpServletResponse.SC_CONFLICT);
        }
    }

}
