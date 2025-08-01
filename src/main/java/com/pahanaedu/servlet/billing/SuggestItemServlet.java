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

@WebServlet("/billing/suggestItem")
public class SuggestItemServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String term = request.getParameter("term");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (term != null && !term.trim().isEmpty()) {
            List<Item> items = ItemDAO.searchItemsByName(term.trim());

            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < items.size(); i++) {
                Item item = items.get(i);
                json.append("{")
                        .append("\"itemCode\":\"").append(item.getProductId()).append("\",")
                        .append("\"itemName\":\"").append(escapeJson(item.getName())).append("\",")
                        .append("\"unitPrice\":").append(item.getSellingPrice()).append(",")
                        .append("\"stockQty\":").append(item.getQuantityInStock())

                        .append("}");

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
                .replace("\r", "\\r");
    }
}
