package com.pahanaedu.dao;

import com.pahanaedu.db.DBConnection;
import com.pahanaedu.model.Bill;
import com.pahanaedu.model.BillItem;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {

    // Create new bill
    public static int createBill(Bill bill) {
        int billId = -1;
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            conn.setAutoCommit(false);
            
            // Insert bill
            String sql = "INSERT INTO bills (customer_id, customer_name, total_amount, discount_amount, final_amount, bill_date, status, payment_method, notes) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            stmt.setInt(1, bill.getCustomerId());
            stmt.setString(2, bill.getCustomerName());
            stmt.setBigDecimal(3, bill.getTotalAmount());
            stmt.setBigDecimal(4, bill.getDiscountAmount() != null ? bill.getDiscountAmount() : BigDecimal.ZERO);
            stmt.setBigDecimal(5, bill.getFinalAmount());
            stmt.setTimestamp(6, bill.getBillDate() != null ? Timestamp.valueOf(bill.getBillDate()) : Timestamp.valueOf(LocalDateTime.now()));
            stmt.setString(7, bill.getStatus() != null ? bill.getStatus() : "pending");
            stmt.setString(8, bill.getPaymentMethod());
            stmt.setString(9, bill.getNotes());
            
            int rows = stmt.executeUpdate();
            if (rows > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    billId = rs.getInt(1);
                    
                    // Insert bill items
                    if (bill.getBillItems() != null && !bill.getBillItems().isEmpty()) {
                        for (BillItem item : bill.getBillItems()) {
                            item.setBillId(billId);
                            createBillItem(item, conn);
                        }
                    }
                }
                rs.close();
            }
            stmt.close();
            conn.commit();
            conn.setAutoCommit(true);
        } catch (Exception e) {
            System.err.println("Failed to create bill: " + e.getMessage());
        }
        return billId;
    }

    // Create bill item
    public static boolean createBillItem(BillItem item, Connection conn) {
        try {
            String sql = "INSERT INTO bill_items (bill_id, product_id, product_name, product_code, quantity, unit_price, total_price, discount_percent, discount_amount, final_price) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            
            stmt.setInt(1, item.getBillId());
            stmt.setInt(2, item.getProductId());
            stmt.setString(3, item.getProductName());
            stmt.setString(4, item.getProductCode());
            stmt.setInt(5, item.getQuantity());
            stmt.setBigDecimal(6, item.getUnitPrice());
            stmt.setBigDecimal(7, item.getTotalPrice());
            stmt.setBigDecimal(8, item.getDiscountPercent() != null ? item.getDiscountPercent() : BigDecimal.ZERO);
            stmt.setBigDecimal(9, item.getDiscountAmount() != null ? item.getDiscountAmount() : BigDecimal.ZERO);
            stmt.setBigDecimal(10, item.getFinalPrice());
            
            int rows = stmt.executeUpdate();
            stmt.close();
            return rows > 0;
        } catch (Exception e) {
            System.err.println("Failed to create bill item: " + e.getMessage());
            return false;
        }
    }

    // Get bill by ID
    public static Bill getBillById(int billId) {
        Bill bill = null;
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            String sql = "SELECT * FROM bills WHERE bill_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, billId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                bill = new Bill(
                    rs.getInt("bill_id"),
                    rs.getInt("customer_id"),
                    rs.getString("customer_name"),
                    rs.getBigDecimal("total_amount"),
                    rs.getBigDecimal("discount_amount"),
                    rs.getBigDecimal("final_amount"),
                    rs.getTimestamp("bill_date") != null ? rs.getTimestamp("bill_date").toLocalDateTime() : null,
                    rs.getString("status")
                );
                bill.setPaymentMethod(rs.getString("payment_method"));
                bill.setNotes(rs.getString("notes"));
                
                // Get bill items
                bill.setBillItems(getBillItemsByBillId(billId));
            }
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.err.println("Failed to fetch bill: " + e.getMessage());
        }
        return bill;
    }

    // Get bill items by bill ID
    public static List<BillItem> getBillItemsByBillId(int billId) {
        List<BillItem> items = new ArrayList<>();
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            String sql = "SELECT * FROM bill_items WHERE bill_id = ? ORDER BY bill_item_id";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, billId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                BillItem item = new BillItem(
                    rs.getInt("bill_item_id"),
                    rs.getInt("bill_id"),
                    rs.getInt("product_id"),
                    rs.getString("product_name"),
                    rs.getString("product_code"),
                    rs.getInt("quantity"),
                    rs.getBigDecimal("unit_price"),
                    rs.getBigDecimal("total_price"),
                    rs.getBigDecimal("discount_percent"),
                    rs.getBigDecimal("discount_amount"),
                    rs.getBigDecimal("final_price")
                );
                items.add(item);
            }
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.err.println("Failed to fetch bill items: " + e.getMessage());
        }
        return items;
    }

    // Get all bills
    public static List<Bill> getAllBills() {
        List<Bill> bills = new ArrayList<>();
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            String sql = "SELECT * FROM bills ORDER BY bill_date DESC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Bill bill = new Bill(
                    rs.getInt("bill_id"),
                    rs.getInt("customer_id"),
                    rs.getString("customer_name"),
                    rs.getBigDecimal("total_amount"),
                    rs.getBigDecimal("discount_amount"),
                    rs.getBigDecimal("final_amount"),
                    rs.getTimestamp("bill_date") != null ? rs.getTimestamp("bill_date").toLocalDateTime() : null,
                    rs.getString("status")
                );
                bill.setPaymentMethod(rs.getString("payment_method"));
                bill.setNotes(rs.getString("notes"));
                bills.add(bill);
            }
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.err.println("Failed to fetch bills: " + e.getMessage());
        }
        return bills;
    }

    // Update bill status
    public static boolean updateBillStatus(int billId, String status) {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            String sql = "UPDATE bills SET status = ? WHERE bill_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, status);
            stmt.setInt(2, billId);
            int rows = stmt.executeUpdate();
            stmt.close();
            return rows > 0;
        } catch (Exception e) {
            System.err.println("Failed to update bill status: " + e.getMessage());
            return false;
        }
    }

    // Delete bill
    public static boolean deleteBill(int billId) {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            conn.setAutoCommit(false);
            
            // Delete bill items first
            String deleteItemsSql = "DELETE FROM bill_items WHERE bill_id = ?";
            PreparedStatement stmt = conn.prepareStatement(deleteItemsSql);
            stmt.setInt(1, billId);
            stmt.executeUpdate();
            stmt.close();
            
            // Delete bill
            String deleteBillSql = "DELETE FROM bills WHERE bill_id = ?";
            stmt = conn.prepareStatement(deleteBillSql);
            stmt.setInt(1, billId);
            int rows = stmt.executeUpdate();
            stmt.close();
            
            conn.commit();
            conn.setAutoCommit(true);
            return rows > 0;
        } catch (Exception e) {
            System.err.println("Failed to delete bill: " + e.getMessage());
            return false;
        }
    }
} 