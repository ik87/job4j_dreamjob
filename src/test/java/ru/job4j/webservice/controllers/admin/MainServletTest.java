package ru.job4j.webservice.controllers.admin;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
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

public class MainServletTest {
    //получаем статический валидатор
    private Validate validate = ValidateService.getInstance();

    //получаем хранение в памяти
    private Store store = MemoryStore.getInstance();


    private MainServlet mainServlet = new MainServlet();

    private User user;
    private Role role;

    @Before
    public void before() {

        //заменяем поле с именем store на наш store и устанавливаем внутри validate
        Whitebox.setInternalState(validate, "store", store);

        //заменяем поле с именем validate на наш validate и устанавливаем внутри signupServlet
        Whitebox.setInternalState(mainServlet, "validate", validate);

        //инициализация user
        user = new User();
        role = new Role();
        role.setId(2);
        role.setRole("user");
        user.setLogin("John");
        user.setEmail("john@gmail.com");
        user.setPassword("123");
        user.setPhoto(new byte[]{1, 111, 123, 23, 31});
        user.setRole(role);

        store.add(user);

    }

    @After
    public void after() {
        //очистка содержимого если не пустой
        if (!store.findAll().isEmpty()) {
            Integer id = store.findAll().get(0).getId();
            User user = new User();
            user.setId(id);
            store.delete(user);
        }
    }

    @Test
    public void whenAdminUpdateUserThenUpdated() throws ServletException, IOException {

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);


        String id = store.findAll().get(0).getId().toString();

        when(req.getParameter("action")).thenReturn("update");
        when(req.getParameter("id")).thenReturn(id);
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

    @Test
    public void whenAdminRemoveUserThenRemoved() throws ServletException, IOException {

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        String id = store.findAll().get(0).getId().toString();

        when(req.getParameter("action")).thenReturn("remove");
        when(req.getParameter("id")).thenReturn(id);
        when(req.getSession()).thenReturn(session);
        when(req.getSession().getAttribute("user")).thenReturn(user);

        mainServlet.init();
        mainServlet.doPost(req, resp);

        assertTrue(store.findAll().isEmpty());
    }

    @Test
    public void whenDeleteImageThenDeleted() throws ServletException, IOException {

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        String id = store.findAll().get(0).getId().toString();

        when(req.getParameter("action")).thenReturn("deleteImg");
        when(req.getParameter("id")).thenReturn(id);
        when(req.getSession()).thenReturn(session);
        when(req.getSession().getAttribute("user")).thenReturn(user);

        mainServlet.init();
        mainServlet.doPost(req, resp);

        User result = store.findAll().get(0);

        assertThat(result.getLogin(), is("John"));
        assertNull(result.getPhoto());
    }

}