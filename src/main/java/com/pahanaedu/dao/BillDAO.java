package com.pahanaedu.dao;

import com.pahanaedu.db.DBConnection;
import com.pahanaedu.model.Bill;
import com.pahanaedu.model.BillItem;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class BillDAO {

    // Create new bill
    public static int createBill(Bill bill) {
        System.out.println(bill);
        int billId = -1;
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            conn.setAutoCommit(false);

            // Insert bill
            String sql = "INSERT INTO bills (customer_id, total_amount, discount_amount, final_amount, amount_paid, balance_returned, payment_method, notes, status, bill_date, created_by) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            System.out.println(bill);
            stmt.setInt(1, bill.getCustomerId());
            stmt.setBigDecimal(2, bill.getTotalAmount());
            stmt.setBigDecimal(3, bill.getDiscountAmount() != null ? bill.getDiscountAmount() : BigDecimal.ZERO);
            stmt.setBigDecimal(4, bill.getFinalAmount());
            stmt.setBigDecimal(5, bill.getAmountPaid());
            stmt.setBigDecimal(6, bill.getBalanceReturned());
            stmt.setString(7, bill.getPaymentMethod());
            stmt.setString(8, bill.getNotes());
            stmt.setString(9, bill.getStatus() != null ? bill.getStatus() : "pending");
            stmt.setTimestamp(10, Timestamp.valueOf(LocalDateTime.now()));
            stmt.setInt(11, bill.getCreatedBy());


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

                            // Adjust stock quantity in the item/product table
                            String updateStockSql = "UPDATE products SET quantity_in_stock = quantity_in_stock - ? WHERE product_id = ?";
                            try (PreparedStatement updateStockStmt = conn.prepareStatement(updateStockSql)) {
                                updateStockStmt.setInt(1, item.getQuantity());  // quantity sold
                                updateStockStmt.setInt(2, item.getProductId()); // product/item id
                                int updatedRows = updateStockStmt.executeUpdate();
                                if (updatedRows == 0) {
                                    throw new SQLException("Failed to update stock for item_id: " + item.getProductId());
                                }
                            }
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
                bill = new Bill();
                bill.setBillId(rs.getInt("bill_id"));
                bill.setCustomerId(rs.getInt("customer_id"));
                bill.setCustomerName(rs.getString("customer_name"));
                bill.setTotalAmount(rs.getBigDecimal("total_amount"));
                bill.setDiscountAmount(rs.getBigDecimal("discount_amount"));
                bill.setFinalAmount(rs.getBigDecimal("final_amount"));
                bill.setAmountPaid(rs.getBigDecimal("amount_paid"));
                bill.setBalanceReturned(rs.getBigDecimal("balance_returned"));
                bill.setBillDate(rs.getString("bill_date") != null ? rs.getString("bill_date") : null);
                bill.setStatus(rs.getString("status"));
                bill.setPaymentMethod(rs.getString("payment_method"));
                bill.setNotes(rs.getString("notes"));
                bill.setCreatedBy(rs.getInt("created_by"));


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
            String sql = "SELECT \n" +
                    "    B.bill_id,\n" +
                    "    B.bill_date,\n" +
                    "    B.final_amount,\n" +
                    "    B.discount_amount,\n" +
                    "    B.payment_method,\n" +
                    "    B.balance_returned,\n" +
                    "    B.amount_paid,\n" +
                    "    B.bill_date,\n" +
                    "    C.full_name AS customer_name,\n" +
                    "    C.customer_id,\n" +
                    "    U.username AS cashiers,\n" +
                    "    JSON_ARRAYAGG(\n" +
                    "        JSON_OBJECT(\n" +
                    "            'billItemId', BI.bill_item_id,\n" +
                    "            'productId', BI.product_id,\n" +
                    "            'productCode', BI.product_code,\n" +
                    "            'productName', BI.product_name,\n" +
                    "            'quantity', BI.quantity,\n" +
                    "            'unitPrice', BI.unit_price,\n" +
                    "            'totalPrice', BI.total_price,\n" +
                    "            'discountPercent', BI.discount_percent,\n" +
                    "            'discountAmount', BI.discount_amount,\n" +
                    "            'finalPrice', BI.final_price\n" +
                    "        )\n" +
                    "    ) AS bill_items\n" +
                    "FROM bills B\n" +
                    "JOIN customers C ON B.customer_id = C.customer_id\n" +
                    "JOIN users U ON B.created_by = U.id\n" +
                    "LEFT JOIN bill_items BI ON B.bill_id = BI.bill_id\n" +
                    "GROUP BY B.bill_id, B.bill_date, B.final_amount, B.discount_amount, B.payment_method,\n" +
                    "         B.balance_returned, B.amount_paid, C.full_name, C.customer_id;\n";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
            while (rs.next()) {
                Bill bill = new Bill();
                bill.setBillId(rs.getInt("bill_id"));
                bill.setTotalAmount(rs.getBigDecimal("final_amount"));
                bill.setCustomerName(rs.getString("customer_name"));
                bill.setDiscountAmount(rs.getBigDecimal("discount_amount"));
                bill.setFinalAmount(rs.getBigDecimal("final_amount"));
                bill.setAmountPaid(rs.getBigDecimal("amount_paid"));
                bill.setBalanceReturned(rs.getBigDecimal("balance_returned"));
                bill.setPaymentMethod(rs.getString("payment_method"));
                bill.setBillDate(rs.getString("bill_date") != null ? rs.getString("bill_date") : null);
                // Parse bill_items JSON string
                String billItemsJson = rs.getString("bill_items");
                List<BillItem> billItems = new ArrayList<>();
                if (billItemsJson != null && !billItemsJson.equals("[null]")) {
                    try {
                        billItems = Arrays.asList(mapper.readValue(billItemsJson, BillItem[].class));
                    } catch (Exception e) {
                        System.err.println("Failed to parse bill items JSON: " + e.getMessage());
                    }
                }
                bill.setBillItems(billItems);
                bills.add(bill);
            }
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.err.println("Failed to fetch bills: " + e.getMessage());
        }
        return bills;
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

    public static List<Bill> getBillsByCustomerId(int customerId) {
        return null;
    }


}