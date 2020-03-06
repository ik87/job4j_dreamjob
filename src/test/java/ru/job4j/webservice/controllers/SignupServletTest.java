package ru.job4j.webservice.controllers;

import org.junit.Test;
import org.powermock.reflect.Whitebox;
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
import static org.junit.Assert.assertThat;
import static org.mockito.Mockito.*;


public class SignupServletTest {

    @Test
    public void whenAddUserThenStoreIt() throws ServletException, IOException {
        //получаем статический валидатор
        Validate validate = ValidateService.getInstance();

        //получаем хранение в памяти
        Store store = MemoryStore.getInstance();

        //заменяем поле с именем store на наш store и устанавливаем внутри validate
        Whitebox.setInternalState(validate, "store", store);

        //создаем экземпляр сервлета
        SignupServlet signupServlet = new SignupServlet();

        //заменяем поле с именем validate на наш validate и устанавливаем внутри signupServlet
        Whitebox.setInternalState(signupServlet, "validate", validate);

        HttpServletRequest req = mock(HttpServletRequest.class);
        HttpServletResponse resp = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        when(req.getParameter("login")).thenReturn("John");
        when(req.getParameter("email")).thenReturn("john@gmail.com");
        when(req.getParameter("password")).thenReturn("123");
        when(req.getSession()).thenReturn(session);

        signupServlet.doPost(req, resp);

        User user = store.findAll().get(0);

        assertThat(user.getLogin(), is("John"));
        assertThat(user.getEmail(), is("john@gmail.com"));
        assertThat(user.getPassword(), is("123"));
    }


}