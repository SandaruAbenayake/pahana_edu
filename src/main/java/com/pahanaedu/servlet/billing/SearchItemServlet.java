package com.pahanaedu.servlet.billing;

import com.pahanaedu.dao.ItemDAO;
import com.pahanaedu.model.Item;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/billing/searchItem")
public class SearchItemServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            List<Item> items = ItemDAO.searchItemsByName(searchTerm.trim());
            
            // Return JSON response
            StringBuilder json = new StringBuilder();
            json.append("[");
            for (int i = 0; i < items.size(); i++) {
                Item item = items.get(i);
                json.append("{");
                json.append("\"productId\":").append(item.getProductId()).append(",");
                json.append("\"name\":\"").append(escapeJson(item.getName())).append("\",");
                json.append("\"sku\":\"").append(escapeJson(item.getSku())).append("\",");
                json.append("\"sellingPrice\":").append(item.getSellingPrice() != null ? item.getSellingPrice() : "0.00").append(",");
                json.append("\"quantityInStock\":").append(item.getQuantityInStock()).append(",");
                json.append("\"status\":\"").append(escapeJson(item.getStatus())).append("\"");
                json.append("}");
                if (i < items.size() - 1) {
                    json.append(",");
                }
            }
            json.append("]");
            
            response.getWriter().write(json.toString());
        } else {
            response.getWriter().write("[]");
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