package com.pahanaedu.servlet;

import com.pahanaedu.dao.UserDAO;
import com.pahanaedu.model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class LoginServlet extends HttpServlet {

    // Handles POST requests for login
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get login credentials from the form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate credentials using DAO
        User user = UserDAO.validateLogin(username, password);

        if (user != null) {
            // If credentials are correct, start a session and store user object
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Redirect based on user role
            if ("admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("adminDashboard.jsp");
            } else if ("user".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("userDashboard.jsp");
            } else {
                // Unknown role, show error
                request.setAttribute("error", "Unknown role");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } else {
            // If login fails, return to login page with error message
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
