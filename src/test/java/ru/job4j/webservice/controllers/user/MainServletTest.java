package ru.job4j.webservice.controllers.user;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.powermock.modules.junit4.PowerMockRunner;
import org.powermock.reflect.Whitebox;
import ru.job4j.webservice.models.Role;
import ru.job4j.webservice.models.User;
import ru.job4j.webservice.persistent.MemoryStore;
import ru.job4j.webservice.persistent.Store;
import ru.job4j.webservice.service.Validate;
import ru.job4j.webservice.service.ValidateService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

import static org.hamcrest.core.Is.is;
import static org.junit.Assert.*;
import static org.powermock.api.mockito.PowerMockito.mock;
import static org.powermock.api.mockito.PowerMockito.when;

@RunWith(PowerMockRunner.class)
public class MainServletTest {

    @Test
    public void whenUserChangeHimselfThenChanged() throws ServletException, IOException {
        //получаем статический валидатор
        Validate validate = ValidateService.getInstance();

        //получаем хранение в памяти
        Store store = MemoryStore.getInstance();

        //заменяем поле с именем store на наш store и устанавливаем внутри validate
        Whitebox.setInternalState(validate, "store", store);

        //создаем экземпляр сервлета
        MainServlet mainServlet = new MainServlet();

        //заменяем поле с именем validate на наш validate и устанавливаем внутри signupServlet
        Whitebox.setInternalState(mainServlet, "validate", validate);

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        //инициализация user
        User user = new User();
        Role role = new Role();
        role.setId(2);
        role.setRole("user");
        user.setLogin("John");
        user.setEmail("john@gmail.com");
        user.setPassword("123");
        user.setRole(role);

        store.add(user);

        when(req.getParameter("action")).thenReturn("update");
        when(req.getParameter("email")).thenReturn("joooohn@gmail.com");
        when(req.getSession()).thenReturn(session);
        when(req.getSession().getAttribute("user")).thenReturn(user);

        mainServlet.init();
        mainServlet.doPost(req, resp);

        User result = store.findAll().get(0);

        assertThat(result.getLogin(), is("John"));
        assertThat(result.getEmail(), is("joooohn@gmail.com"));
        assertThat(result.getPassword(), is("123"));
    }

}