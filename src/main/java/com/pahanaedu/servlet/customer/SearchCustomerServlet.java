package com.pahanaedu.servlet.customer;

import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.model.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/searchCustomer")
public class SearchCustomerServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");
        
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            // Search for customers
            List<Customer> searchResults = CustomerDAO.searchCustomersByName(searchTerm.trim());
            request.setAttribute("searchResults", searchResults);
            request.setAttribute("searchTerm", searchTerm);
        } else {
            // If no search term, show all customers
            List<Customer> allCustomers = CustomerDAO.getAllCustomers();
            request.setAttribute("searchResults", allCustomers);
        }
        
        // Forward to customerPage.jsp
        request.getRequestDispatcher("customerPage.jsp").forward(request, response);
    }
} 