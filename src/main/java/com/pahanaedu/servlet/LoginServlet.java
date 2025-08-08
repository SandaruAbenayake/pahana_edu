package com.pahanaedu.servlet;

import com.pahanaedu.dao.UserDAO;
import com.pahanaedu.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
@MultipartConfig
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { //HTTP POST requests
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = UserDAO.validateLogin(username, password);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("userId", user.getId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());
            session.setAttribute("user", user);

            // Set absolute paths for redirection
            String redirectUrl = "admin".equalsIgnoreCase(user.getRole()) ?
                    "dashboard.jsp" : "userDashboard.jsp";

            String jsonResponse = String.format(
                    "{\"success\":true,\"user\":{\"id\":%d,\"username\":\"%s\",\"role\":\"%s\"},\"redirect\":\"%s\"}",
                    user.getId(),
                    escapeJson(user.getUsername()),
                    escapeJson(user.getRole()),
                    escapeJson(redirectUrl)
            );

            response.getWriter().write(jsonResponse);
        } else {
            response.getWriter().write("{\"success\":false,\"message\":\"Invalid username or password\"}");
        }
    }

    // Helper method to escape JSON string values
    private String escapeJson(String input) {
        if (input == null) return "";
        return input.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}
