package ru.job4j.webservice.controllers.admin;

import com.google.gson.Gson;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import ru.job4j.webservice.dto.UserDto;
import ru.job4j.webservice.mapers.UserMapper;
import ru.job4j.webservice.mapers.UserMapperImpl;
import ru.job4j.webservice.models.User;
import ru.job4j.webservice.controllers.Utils;
import ru.job4j.webservice.service.Validate;
import ru.job4j.webservice.service.ValidateService;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class UploadServlet extends HttpServlet {
    private final Validate validate = ValidateService.getInstance();
    private final UserMapper userMapper = UserMapperImpl.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
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
            //id and photo

            UserDto userDto = userMapper.toDto(user);

            Map<String, String> photo = new LinkedHashMap<>();

            photo.put("id", String.valueOf(userDto.getUserId()));
            photo.put("photo", userDto.getPhoto());
            String json = new Gson().toJson(photo);

            resp.setContentType("application/json");

            resp.setCharacterEncoding("UTF-8");
            resp.setStatus(HttpServletResponse.SC_CREATED);
            resp.getWriter().write(json);
        }
    }

}

