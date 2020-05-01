package ru.job4j.webservice.controllers.user;

import com.google.gson.Gson;
import ru.job4j.webservice.dto.UserDto;
import ru.job4j.webservice.mapers.UserMapper;
import ru.job4j.webservice.mapers.UserMapperImpl;
import ru.job4j.webservice.models.User;
import ru.job4j.webservice.controllers.Utils;
import ru.job4j.webservice.service.Validate;
import ru.job4j.webservice.service.ValidateService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.BiConsumer;

public class MainServlet extends HttpServlet {
    private final UserMapper userMapper = UserMapperImpl.getInstance();
    private final Validate validate = ValidateService.getInstance();
    private final Map<String, BiConsumer<HttpServletRequest, HttpServletResponse>>
            actions = new ConcurrentHashMap<>();

    @Override
    public void init() throws ServletException {
        actions.put("update", this::update);
        actions.put("deleteImg", this::deleteImg);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //if  !XMLHttpRequst -> open list.jsp and put all users to attribute
        //if  XMLHttpRequst -> (json) session user
        //if  XMLHttpRequst & id -> (json) user by id

        boolean ajax = "XMLHttpRequest".equals(req.getHeader("X-Requested-With"));

        if (ajax) {
            User authUser = Utils.getObjectFromSession(req, "user");
            UserDto userDto = userMapper.toDto(authUser);
            String json = new Gson().toJson(userDto);
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.setStatus(HttpServletResponse.SC_OK);
            resp.getWriter().write(json);
        } else {
            req.getRequestDispatcher("/WEB-INF/view/profile.jsp").forward(req, resp);
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String action = req.getParameter("action");
        actions.get(action).accept(req, resp);
    }

    void update(HttpServletRequest req, HttpServletResponse resp) {
        User changed = Utils.propertiesToUser(req);
        User user = Utils.getObjectFromSession(req, "user");
        changed.setRole(null);
        boolean result = validate.update(user, changed);
        resp.setCharacterEncoding("UTF-8");
        if (result) {
            String url = req.getRequestURI();
            resp.setStatus(HttpServletResponse.SC_OK);
            resp.setHeader("Location", url);
        } else {
            resp.setStatus(HttpServletResponse.SC_CONFLICT);
        }
    }

    void deleteImg(HttpServletRequest req, HttpServletResponse resp) {
        User user = Utils.getObjectFromSession(req, "user");
        user.setPhoto(null);
        validate.update(user);
        resp.setStatus(HttpServletResponse.SC_OK);
    }

}
