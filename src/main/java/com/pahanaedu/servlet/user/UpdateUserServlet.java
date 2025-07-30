package com.pahanaedu.servlet.user;

import com.pahanaedu.dao.UserDAO;
import com.pahanaedu.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/updateUser")
public class UpdateUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String msg;
        if (idStr != null && username != null && password != null && role != null) {
            try {
                int id = Integer.parseInt(idStr);
                User user = new User(id, username, password, role);
                boolean success = UserDAO.updateUser(user);
                if (success) {
                    msg = "User updated successfully.";
                } else {
                    msg = "Failed to update user.";
                }
            } catch (NumberFormatException e) {
                msg = "Invalid user ID.";
            }
        } else {
            msg = "Missing user data.";
        }
        request.getSession().setAttribute("success", msg);
        response.sendRedirect("userPage.jsp");
    }
} 