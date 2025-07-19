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
                user = new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("role")
                );
            }

            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.err.println("Login failed: " + e.getMessage());
        }

        return user;
    }

}
