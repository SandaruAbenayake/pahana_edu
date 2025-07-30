package com.pahanaedu.servlet.items;

import com.pahanaedu.dao.ItemDAO;
import com.pahanaedu.model.Item;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/searchItem")
public class SearchItemServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");
        
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            // Search for items
            List<Item> searchResults = ItemDAO.searchItemsByName(searchTerm.trim());
            request.setAttribute("searchResults", searchResults);
            request.setAttribute("searchTerm", searchTerm);
        } else {
            // If no search term, show all items
            List<Item> allItems = ItemDAO.getAllItems();
            request.setAttribute("searchResults", allItems);
        }
        
        // Forward to itemPage.jsp
        request.getRequestDispatcher("itemPage.jsp").forward(request, response);
    }
} 