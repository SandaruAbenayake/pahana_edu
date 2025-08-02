package com.pahanaedu.servlet.billing;

import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.model.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/billing/searchCustomer")
public class SearchCustomerServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");
        String searchType = request.getParameter("searchType"); // "name" or "nic"
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            List<Customer> customers;
            
            if ("nic".equals(searchType)) {
                // Search by NIC
                customers = CustomerDAO.searchCustomersByNIC(searchTerm.trim());
            } else {
                // Search by name (default)
                customers = searchCustomersByName(searchTerm.trim());
            }
            
            // Return JSON response
            StringBuilder json = new StringBuilder();
            json.append("[");
            for (int i = 0; i < customers.size(); i++) {
                Customer customer = customers.get(i);
                json.append("{");
                json.append("\"customerId\":").append(customer.getCustomerId()).append(",");
                json.append("\"fullName\":\"").append(escapeJson(customer.getFullName())).append("\",");
                json.append("\"email\":\"").append(escapeJson(customer.getEmail())).append("\",");
                json.append("\"phone\":\"").append(escapeJson(customer.getPhone())).append("\",");
                json.append("\"nic\":\"").append(escapeJson(customer.getNic())).append("\",");
                json.append("\"address\":\"").append(escapeJson(customer.getAddress())).append("\",");
                json.append("\"gender\":\"").append(escapeJson(customer.getGender())).append("\",");
                json.append("\"status\":\"").append(escapeJson(customer.getStatus())).append("\"");
                json.append("}");
                if (i < customers.size() - 1) {
                    json.append(",");
                }
            }
            json.append("]");
            
            response.getWriter().write(json.toString());
        } else {
            response.getWriter().write("[]");
        }
    }
    
    private List<Customer> searchCustomersByName(String searchTerm) {
        return CustomerDAO.searchCustomersByName(searchTerm);
    }
    
    private String escapeJson(String value) {
        if (value == null) return "";
        return value.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }
} 