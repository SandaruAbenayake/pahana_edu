package com.pahanaedu.servlet.user;

import com.pahanaedu.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


@WebServlet("/deleteUser")
public class DeleteUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String msg;
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                boolean success = UserDAO.deleteUser(id);
                if (success) {
                    msg = "User deleted successfully.";
                } else {
                    msg = "Failed to delete user.";
                }
            } catch (NumberFormatException e) {
                msg = "Invalid user ID.";
            }
        } else {
            msg = "User ID not provided.";
        }
        request.getSession().setAttribute("success", msg);
        response.sendRedirect("userPage.jsp");
    }
} 