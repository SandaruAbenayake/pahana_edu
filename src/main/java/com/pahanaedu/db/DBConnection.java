package com.pahanaedu.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    // Database config
    private static final String URL = "jdbc:mysql://localhost:3306/pahanaedu";
    private static final String USER = "root";
    private static final String PASSWORD = "sada123";

    // Singleton instance
    private static DBConnection instance;
    private Connection connection;

    // Private constructor
    private DBConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println(" Database connected successfully!");
        } catch (ClassNotFoundException e) {
            System.err.println(" JDBC Driver not found: " + e.getMessage());
            throw new SQLException(e);
        } catch (SQLException e) {
            System.err.println("Failed to connect to DB: " + e.getMessage());
            throw e;
        }
    }

    // Singleton getter
    public static synchronized DBConnection getInstance() throws SQLException {
        if (instance == null || instance.getConnection().isClosed()) {
            instance = new DBConnection();
        }
        return instance;
    }

    // Getter for connection
    public Connection getConnection() {
        return connection;
    }

    // Close the connection
    public static void closeConnection() {
        if (instance != null && instance.getConnection() != null) {
            try {
                instance.getConnection().close();
                System.out.println("Database connection closed.");
            } catch (SQLException e) {
                System.err.println("Error closing DB connection: " + e.getMessage());
            }
        }
    }
}
