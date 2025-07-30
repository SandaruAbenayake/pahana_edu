package com.pahanaedu.dao;

import com.pahanaedu.db.DBConnection;
import com.pahanaedu.model.Customer;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {

    // Get all customers
    public static List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            String sql = "SELECT * FROM customers ORDER BY customer_id";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Customer customer = new Customer(
                    rs.getInt("customer_id"),
                    rs.getString("full_name"),
                    rs.getString("email"),
                    rs.getString("phone"),
                    rs.getString("nic"),
                    rs.getString("address"),
                    rs.getString("gender"),
                    rs.getDate("dob") != null ? rs.getDate("dob").toLocalDate() : null,
                    rs.getTimestamp("registered_date") != null ? rs.getTimestamp("registered_date").toLocalDateTime() : null,
                    rs.getString("status")
                );
                customers.add(customer);
            }
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.err.println("Failed to fetch customers: " + e.getMessage());
        }
        return customers;
    }

    // Get customer by ID
    public static Customer getCustomerById(int customerId) {
        Customer customer = null;
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            String sql = "SELECT * FROM customers WHERE customer_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                customer = new Customer(
                    rs.getInt("customer_id"),
                    rs.getString("full_name"),
                    rs.getString("email"),
                    rs.getString("phone"),
                    rs.getString("nic"),
                    rs.getString("address"),
                    rs.getString("gender"),
                    rs.getDate("dob") != null ? rs.getDate("dob").toLocalDate() : null,
                    rs.getTimestamp("registered_date") != null ? rs.getTimestamp("registered_date").toLocalDateTime() : null,
                    rs.getString("status")
                );
            }
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.err.println("Failed to fetch customer: " + e.getMessage());
        }
        return customer;
    }

    // Create new customer
    public static boolean createCustomer(Customer customer) {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            String sql = "INSERT INTO customers (full_name, email, phone, nic, address, gender, dob, registered_date, status) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, customer.getFullName());
            stmt.setString(2, customer.getEmail());
            stmt.setString(3, customer.getPhone());
            stmt.setString(4, customer.getNic());
            stmt.setString(5, customer.getAddress());
            stmt.setString(6, customer.getGender());
            stmt.setDate(7, customer.getDob() != null ? Date.valueOf(customer.getDob()) : null);
            stmt.setTimestamp(8, customer.getRegisteredDate() != null ? Timestamp.valueOf(customer.getRegisteredDate()) : Timestamp.valueOf(LocalDateTime.now()));
            stmt.setString(9, customer.getStatus() != null ? customer.getStatus() : "active");
            
            int rows = stmt.executeUpdate();
            stmt.close();
            return rows > 0;
        } catch (Exception e) {
            System.err.println("Failed to create customer: " + e.getMessage());
            return false;
        }
    }

    // Update customer
    public static boolean updateCustomer(Customer customer) {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            String sql = "UPDATE customers SET full_name=?, email=?, phone=?, nic=?, address=?, " +
                        "gender=?, dob=?, status=? WHERE customer_id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, customer.getFullName());
            stmt.setString(2, customer.getEmail());
            stmt.setString(3, customer.getPhone());
            stmt.setString(4, customer.getNic());
            stmt.setString(5, customer.getAddress());
            stmt.setString(6, customer.getGender());
            stmt.setDate(7, customer.getDob() != null ? Date.valueOf(customer.getDob()) : null);
            stmt.setString(8, customer.getStatus());
            stmt.setInt(9, customer.getCustomerId());
            
            int rows = stmt.executeUpdate();
            stmt.close();
            return rows > 0;
        } catch (Exception e) {
            System.err.println("Failed to update customer: " + e.getMessage());
            return false;
        }
    }

    // Delete customer
    public static boolean deleteCustomer(int customerId) {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            String sql = "DELETE FROM customers WHERE customer_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, customerId);
            int rows = stmt.executeUpdate();
            stmt.close();
            return rows > 0;
        } catch (Exception e) {
            System.err.println("Failed to delete customer: " + e.getMessage());
            return false;
        }
    }

    // Search customers by name
    public static List<Customer> searchCustomersByName(String searchTerm) {
        List<Customer> customers = new ArrayList<>();
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            String sql = "SELECT * FROM customers WHERE LOWER(full_name) LIKE LOWER(?) ORDER BY customer_id";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + searchTerm + "%");
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Customer customer = new Customer(
                    rs.getInt("customer_id"),
                    rs.getString("full_name"),
                    rs.getString("email"),
                    rs.getString("phone"),
                    rs.getString("nic"),
                    rs.getString("address"),
                    rs.getString("gender"),
                    rs.getDate("dob") != null ? rs.getDate("dob").toLocalDate() : null,
                    rs.getTimestamp("registered_date") != null ? rs.getTimestamp("registered_date").toLocalDateTime() : null,
                    rs.getString("status")
                );
                customers.add(customer);
            }
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.err.println("Failed to search customers: " + e.getMessage());
        }
        return customers;
    }
} 