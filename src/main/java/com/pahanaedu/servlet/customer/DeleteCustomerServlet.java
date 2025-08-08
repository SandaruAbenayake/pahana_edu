package com.pahanaedu.servlet.customer;

import com.pahanaedu.dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/deleteCustomer")
public class DeleteCustomerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerIdStr = request.getParameter("customerId");
        String msg;

        if (customerIdStr != null) {
            try {
                int customerId = Integer.parseInt(customerIdStr);
                boolean success = CustomerDAO.deleteCustomer(customerId);
                if (success) {
                    msg = "Customer deleted successfully.";
                } else {
                    msg = "Failed to delete customer.";
                }
            } catch (NumberFormatException e) {
                msg = "Invalid customer ID.";
            }
        } else {
            msg = "Customer ID not provided.";
        }

        request.getSession().setAttribute("success", msg);
        response.sendRedirect("customerPage.jsp");
    }
} 