package com.pahanaedu.servlet.items;

import com.pahanaedu.dao.ItemDAO;
import com.pahanaedu.model.Item;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@WebServlet("/updateItem")
public class UpdateItemServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get form parameters
            int productId = Integer.parseInt(request.getParameter("productId"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            String brand = request.getParameter("brand");
            String size = request.getParameter("size");
            int pages = Integer.parseInt(request.getParameter("pages"));
            String color = request.getParameter("color");
            String material = request.getParameter("material");
            String unitType = request.getParameter("unitType");
            String barcode = request.getParameter("barcode");
            String sku = request.getParameter("sku");
            int quantityInStock = Integer.parseInt(request.getParameter("quantityInStock"));
            int reorderLevel = Integer.parseInt(request.getParameter("reorderLevel"));
            BigDecimal costPrice = new BigDecimal(request.getParameter("costPrice"));
            BigDecimal sellingPrice = new BigDecimal(request.getParameter("sellingPrice"));
            BigDecimal discountPercent = new BigDecimal(request.getParameter("discountPercent"));
            String status = request.getParameter("status");

            // Create Item object
            Item item = new Item();
            item.setProductId(productId);
            item.setName(name);
            item.setDescription(description);
            item.setCategory(category);
            item.setBrand(brand);
            item.setSize(size);
            item.setPages(pages);
            item.setColor(color);
            item.setMaterial(material);
            item.setUnitType(unitType);
            item.setBarcode(barcode);
            item.setSku(sku);
            item.setQuantityInStock(quantityInStock);
            item.setReorderLevel(reorderLevel);
            item.setCostPrice(costPrice);
            item.setSellingPrice(sellingPrice);
            item.setDiscountPercent(discountPercent);
            item.setUpdatedAt(LocalDateTime.now());
            item.setStatus(status != null ? status : "active");

            // Update in database
            boolean success = ItemDAO.updateItem(item);
            String msg;
            if (success) {
                msg = "Item updated successfully.";
            } else {
                msg = "Failed to update item.";
            }
            request.getSession().setAttribute("success", msg);
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Invalid numeric values provided.");
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Error updating item: " + e.getMessage());
        }
        
        response.sendRedirect("itemPage.jsp");
    }
} 