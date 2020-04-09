package ru.job4j.webservice.controllers.admin;


import com.google.gson.Gson;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
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
import java.util.List;

public class UploadServlet extends HttpServlet {
    private final Validate validate = ValidateService.getInstance();
    private final UserMapper userMapper = UserMapperImpl.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<FileItem> fileItems = null;
        try {
            fileItems = Utils.upload(req);
        } catch (FileUploadException e) {
            e.printStackTrace();
        }

        byte[] bytes = fileItems.get(0).get();
        if (bytes.length != 0) {
            User user = new User();
            Integer id = Integer.valueOf(fileItems.get(1).getString());
            user.setId(id);
            user = validate.findById(user);
            user.setPhoto(bytes);
            validate.update(user);

            UserDto userDto = userMapper.toDto(user);
            String json = new Gson().toJson(userDto);
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(json);
        }
    }

}

