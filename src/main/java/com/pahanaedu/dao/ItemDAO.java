package com.pahanaedu.dao;

import com.pahanaedu.db.DBConnection;
import com.pahanaedu.model.Item;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO {

    // Get all items
    public static List<Item> getAllItems() {
        List<Item> items = new ArrayList<>();
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            String sql = "SELECT * FROM products ORDER BY product_id";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Item item = new Item(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("category"),
                        rs.getString("brand"),
                        rs.getString("size"),
                        rs.getInt("pages"),
                        rs.getString("color"),
                        rs.getString("material"),
                        rs.getString("unit_type"),
                        rs.getString("barcode"),
                        rs.getString("sku"),
                        rs.getInt("quantity_in_stock"),
                        rs.getInt("reorder_level"),
                        rs.getBigDecimal("cost_price"),
                        rs.getBigDecimal("selling_price"),
                        rs.getBigDecimal("discount_percent"),
                        rs.getTimestamp("added_date") != null ? rs.getTimestamp("added_date").toLocalDateTime() : null,
                        rs.getTimestamp("updated_at") != null ? rs.getTimestamp("updated_at").toLocalDateTime() : null,
                        rs.getString("status")
                );
                items.add(item);
            }
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.err.println("Failed to fetch items: " + e.getMessage());
        }
        return items;
    }

    // Get item by ID
    public static Item getItemById(int productId) {
        Item item = null;
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            String sql = "SELECT * FROM products WHERE product_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                item = new Item(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("category"),
                        rs.getString("brand"),
                        rs.getString("size"),
                        rs.getInt("pages"),
                        rs.getString("color"),
                        rs.getString("material"),
                        rs.getString("unit_type"),
                        rs.getString("barcode"),
                        rs.getString("sku"),
                        rs.getInt("quantity_in_stock"),
                        rs.getInt("reorder_level"),
                        rs.getBigDecimal("cost_price"),
                        rs.getBigDecimal("selling_price"),
                        rs.getBigDecimal("discount_percent"),
                        rs.getTimestamp("added_date") != null ? rs.getTimestamp("added_date").toLocalDateTime() : null,
                        rs.getTimestamp("updated_at") != null ? rs.getTimestamp("updated_at").toLocalDateTime() : null,
                        rs.getString("status")
                );
            }
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.err.println("Failed to fetch item: " + e.getMessage());
        }
        return item;
    }

    // Create new item
    public static boolean createItem(Item item) {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            String sql = "INSERT INTO products (name, description, category, brand, size, pages, color, material, " +
                    "unit_type, barcode, sku, quantity_in_stock, reorder_level, cost_price, selling_price, " +
                    "discount_percent, added_date, updated_at, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, item.getName());
            stmt.setString(2, item.getDescription());
            stmt.setString(3, item.getCategory());
            stmt.setString(4, item.getBrand());
            stmt.setString(5, item.getSize());
            stmt.setInt(6, item.getPages());
            stmt.setString(7, item.getColor());
            stmt.setString(8, item.getMaterial());
            stmt.setString(9, item.getUnitType());
            stmt.setString(10, item.getBarcode());
            stmt.setString(11, item.getSku());
            stmt.setInt(12, item.getQuantityInStock());
            stmt.setInt(13, item.getReorderLevel());
            stmt.setBigDecimal(14, item.getCostPrice());
            stmt.setBigDecimal(15, item.getSellingPrice());
            stmt.setBigDecimal(16, item.getDiscountPercent());
            stmt.setTimestamp(17, item.getAddedDate() != null ? Timestamp.valueOf(item.getAddedDate()) : Timestamp.valueOf(LocalDateTime.now()));
            stmt.setTimestamp(18, item.getUpdatedAt() != null ? Timestamp.valueOf(item.getUpdatedAt()) : Timestamp.valueOf(LocalDateTime.now()));
            stmt.setString(19, item.getStatus() != null ? item.getStatus() : "active");

            int rows = stmt.executeUpdate();
            stmt.close();
            return rows > 0;
        } catch (Exception e) {
            System.err.println("Failed to create item: " + e.getMessage());
            return false;
        }
    }

    // Update item
    public static boolean updateItem(Item item) {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            String sql = "UPDATE products SET name=?, description=?, category=?, brand=?, size=?, pages=?, color=?, " +
                    "material=?, unit_type=?, barcode=?, sku=?, quantity_in_stock=?, reorder_level=?, " +
                    "cost_price=?, selling_price=?, discount_percent=?, updated_at=?, status=? WHERE product_id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, item.getName());
            stmt.setString(2, item.getDescription());
            stmt.setString(3, item.getCategory());
            stmt.setString(4, item.getBrand());
            stmt.setString(5, item.getSize());
            stmt.setInt(6, item.getPages());
            stmt.setString(7, item.getColor());
            stmt.setString(8, item.getMaterial());
            stmt.setString(9, item.getUnitType());
            stmt.setString(10, item.getBarcode());
            stmt.setString(11, item.getSku());
            stmt.setInt(12, item.getQuantityInStock());
            stmt.setInt(13, item.getReorderLevel());
            stmt.setBigDecimal(14, item.getCostPrice());
            stmt.setBigDecimal(15, item.getSellingPrice());
            stmt.setBigDecimal(16, item.getDiscountPercent());
            stmt.setTimestamp(17, Timestamp.valueOf(LocalDateTime.now()));
            stmt.setString(18, item.getStatus());
            stmt.setInt(19, item.getProductId());

            int rows = stmt.executeUpdate();
            stmt.close();
            return rows > 0;
        } catch (Exception e) {
            System.err.println("Failed to update item: " + e.getMessage());
            return false;
        }
    }

    // Delete item
    public static boolean deleteItem(int productId) {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            String sql = "DELETE FROM products WHERE product_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, productId);
            int rows = stmt.executeUpdate();
            stmt.close();
            return rows > 0;
        } catch (Exception e) {
            System.err.println("Failed to delete item: " + e.getMessage());
            return false;
        }
    }

    // Search items by name
    public static List<Item> searchItemsByName(String searchTerm) {
        List<Item> items = new ArrayList<>();
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            String sql = "SELECT * FROM products WHERE LOWER(name) LIKE LOWER(?) ORDER BY product_id";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + searchTerm + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Item item = new Item(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("category"),
                        rs.getString("brand"),
                        rs.getString("size"),
                        rs.getInt("pages"),
                        rs.getString("color"),
                        rs.getString("material"),
                        rs.getString("unit_type"),
                        rs.getString("barcode"),
                        rs.getString("sku"),
                        rs.getInt("quantity_in_stock"),
                        rs.getInt("reorder_level"),
                        rs.getBigDecimal("cost_price"),
                        rs.getBigDecimal("selling_price"),
                        rs.getBigDecimal("discount_percent"),
                        rs.getTimestamp("added_date") != null ? rs.getTimestamp("added_date").toLocalDateTime() : null,
                        rs.getTimestamp("updated_at") != null ? rs.getTimestamp("updated_at").toLocalDateTime() : null,
                        rs.getString("status")
                );
                items.add(item);
            }
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.err.println("Failed to search items: " + e.getMessage());
        }
        return items;
    }
} 