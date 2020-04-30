package ru.job4j.webservice.filters;

import ru.job4j.webservice.models.User;
import ru.job4j.webservice.controllers.Utils;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Filter. Roles secure routing:
 * <p>
 * If  request.getRequestURI() contains:
 * [/css] or [/js] or [/tester] or [/signout] use this:allAllowed
 * [/] use this:root
 * [/login] use this:onlyLoginPath
 * [/admin] use this:onlyAdminPath
 * [/user] use this:onlyUserPath
 * <p>
 * if other user this:notFoundPage
 *
 * @author Kosolapov Ilya (d_dexter@mail.ru)
 * @since 1.0
 */
public class SecureFilter implements Filter {
    private Map<String, DoFilter> filter;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        filter = new LinkedHashMap<>();
        filter.put("/admin", this::onlyAdminPath);
        filter.put("/user", this::onlyUserPath);
        filter.put("/css", this::allAllowed);
        filter.put("/js", this::allAllowed);
        filter.put("/login", this::onlyLoginPath);
        filter.put("/tester", this::allAllowed);
        filter.put("/signout", this::allAllowed);
        filter.put("/", this::root);
    }


    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        String requestURI = request.getRequestURI().substring(request.getContextPath().length());
        var operation = contention(requestURI, filter);
        operation.doFilter(request, response, chain);

    }

    DoFilter contention(String requestURI, Map<String, DoFilter> filter) {
        DoFilter value = this::notFoundPage;
        for (var f : filter.entrySet()) {
            if (requestURI.contains(f.getKey())) {
                value = f.getValue();
                break;
            }
        }
        return value;
    }

    private void onlyLoginPath(HttpServletRequest req, HttpServletResponse resp, FilterChain chain) throws IOException, ServletException {
        User user = Utils.getObjectFromSession(req, "user");
        if (user != null) {
            String role = user.getRole().getRole();
            resp.sendRedirect(role);
        } else {
            chain.doFilter(req, resp);
        }
    }

    //gate
    void onlyUserPath(HttpServletRequest req, HttpServletResponse resp, FilterChain chain) throws IOException, ServletException {
        userFilter("user", req, resp, chain);
    }

    void onlyAdminPath(HttpServletRequest req, HttpServletResponse resp, FilterChain chain) throws IOException, ServletException {
        userFilter("admin", req, resp, chain);
    }

    void allAllowed(HttpServletRequest req, HttpServletResponse resp, FilterChain chain) throws IOException, ServletException {
        chain.doFilter(req, resp);
    }

    void userFilter(String role, HttpServletRequest req, HttpServletResponse resp, FilterChain chain) throws IOException, ServletException {
        User user = Utils.getObjectFromSession(req, "user");
        if (user != null) {
            if (role.equals(user.getRole().getRole())) {
                chain.doFilter(req, resp);
            } else {
                resp.sendRedirect(user.getRole().getRole());
            }
        } else {
            resp.sendRedirect("login");
        }
    }

    void notFoundPage(HttpServletRequest req, HttpServletResponse resp, FilterChain chain) throws IOException, ServletException {

        resp.sendError(HttpServletResponse.SC_NOT_FOUND);
    }

    void root(HttpServletRequest req, HttpServletResponse resp, FilterChain chain) throws IOException, ServletException {
        resp.sendRedirect("login");
    }

    @FunctionalInterface
    interface DoFilter {
        void doFilter(HttpServletRequest request,
                      HttpServletResponse response, FilterChain chain) throws IOException, ServletException;

    }

    @Override
    public void destroy() {

    }
}
