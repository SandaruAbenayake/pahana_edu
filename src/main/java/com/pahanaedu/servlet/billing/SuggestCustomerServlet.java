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

@WebServlet("/billing/suggestCustomer")
public class SuggestCustomerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String term = req.getParameter("term");
        String type = req.getParameter("type"); // "name" or "nic"

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        if (term != null && !term.trim().isEmpty()) {
            List<Customer> suggestions;

            if ("nic".equalsIgnoreCase(type)) {
                suggestions = CustomerDAO.searchCustomersByNIC(term.trim());
            } else {
                suggestions = CustomerDAO.searchCustomersByName(term.trim());
            }

            StringBuilder json = new StringBuilder();
            json.append("[");
            for (int i = 0; i < suggestions.size(); i++) {
                Customer customer = suggestions.get(i);
                json.append("{");
                json.append("\"fullName\":\"").append(escapeJson(customer.getFullName())).append("\",");
                json.append("\"nic\":\"").append(escapeJson(customer.getNic())).append("\"");
                json.append("}");
                if (i < suggestions.size() - 1) {
                    json.append(",");
                }
            }
            json.append("]");
            resp.getWriter().write(json.toString());
        } else {
            resp.getWriter().write("[]");
        }
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
