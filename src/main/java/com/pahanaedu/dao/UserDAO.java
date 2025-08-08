package com.pahanaedu.dao;

import com.pahanaedu.db.DBConnection;
import com.pahanaedu.model.User;

import java.sql.*;

public class UserDAO {

    public static User validateLogin(String username, String password) {
        User user = null;

        try {
            System.out.println("Validating username and password");
            Connection conn = DBConnection.getInstance().getConnection();
            String sql = "SELECT * FROM users WHERE username=? AND password=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setRole(rs.getString("role"));
                // Don't set password for security
            }

            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.err.println("Login failed: " + e.getMessage());
        }

        return user;
    }

    // Add method to get all users
    public static java.util.List<User> getAllUsers() {
        java.util.List<User> users = new java.util.ArrayList<>();
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            String sql = "SELECT * FROM users";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                User user = new User(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("role")
                );
                users.add(user);
            }
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.err.println("Failed to fetch users: " + e.getMessage());
        }
        return users;
    }

    // Delete user by id
    public static boolean deleteUser(int id) {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            String sql = "DELETE FROM users WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            int rows = stmt.executeUpdate();
            stmt.close();
            return rows > 0;
        } catch (Exception e) {
            System.err.println("Failed to delete user: " + e.getMessage());
            return false;
        }
    }

    // Update user by id
    public static boolean updateUser(User user) {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            String sql = "UPDATE users SET username=?, password=?, role=? WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getRole());
            stmt.setInt(4, user.getId());
            int rows = stmt.executeUpdate();
            stmt.close();
            return rows > 0;
        } catch (Exception e) {
            System.err.println("Failed to update user: " + e.getMessage());
            return false;
        }
    }

    // Create user
    public static boolean createUser(User user) {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            String sql = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getRole());
            int rows = stmt.executeUpdate();
            stmt.close();
            return rows > 0;
        } catch (Exception e) {
            System.err.println("Failed to create user: " + e.getMessage());
            return false;
        }
    }
}
