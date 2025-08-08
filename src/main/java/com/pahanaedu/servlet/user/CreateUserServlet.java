package com.pahanaedu.servlet.user;

import com.pahanaedu.dao.UserDAO;
import com.pahanaedu.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/createUser")
public class CreateUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String msg;
        if (username != null && password != null && role != null) {
            User user = new User();
            user.setUsername(username);
            user.setPassword(password);
            user.setRole(role);
            boolean success = UserDAO.createUser(user);
            if (success) {
                msg = "User created successfully.";
            } else {
                msg = "Failed to create user.";
            }
        } else {
            msg = "Missing user data.";
        }
        request.getSession().setAttribute("success", msg);
        response.sendRedirect("userPage.jsp");
    }
} 