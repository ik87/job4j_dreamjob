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
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.BiConsumer;

public class ProfileServlet extends HttpServlet {
    private final UserMapper userMapper = UserMapperImpl.getInstance();
    private final Validate validate = ValidateService.getInstance();


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        User user = new User();
        if (id == null) {
            user = Utils.getObjectFromSession(req, "user");
        } else {
            user.setId(Integer.valueOf(id));
            user = validate.findById(user);
        }

        boolean ajax = "XMLHttpRequest".equals(req.getHeader("X-Requested-With"));
        UserDto userDto = userMapper.toDto(user);

        if(ajax) {
            String json = new Gson().toJson(userDto);
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(json);
        } else {
            req.setAttribute("userDto", userDto);
            req.getRequestDispatcher("/WEB-INF/view/profile.jsp").forward(req, resp);
        }

    }
}
