package com.pahanaedu.servlet.items;

import com.pahanaedu.dao.ItemDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/deleteItem")
public class DeleteItemServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productIdStr = request.getParameter("productId");
        String msg;

        if (productIdStr != null) {
            try {
                int productId = Integer.parseInt(productIdStr);
                boolean success = ItemDAO.deleteItem(productId);
                if (success) {
                    msg = "Item deleted successfully.";
                } else {
                    msg = "Failed to delete item.";
                }
            } catch (NumberFormatException e) {
                msg = "Invalid product ID.";
            }
        } else {
            msg = "Product ID not provided.";
        }

        request.getSession().setAttribute("success", msg);
        response.sendRedirect("itemPage.jsp");
    }
} 