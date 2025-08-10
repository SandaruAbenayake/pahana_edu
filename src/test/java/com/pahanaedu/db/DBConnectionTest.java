package com.pahanaedu.db;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.*;

class DBConnectionTest {

    private DBConnection dbConnection;
    private Connection connection;

    @BeforeEach
    void setUp() throws SQLException {
        dbConnection = DBConnection.getInstance();
        connection = dbConnection.getConnection();
    }

    @Test
    void testGetInstanceNotNull() {
        assertNotNull(dbConnection, "DBConnection instance should not be null");
    }

    @Test
    void testGetConnectionNotNullAndValid() throws SQLException {
        assertNotNull(connection, "Connection should not be null");
        assertFalse(connection.isClosed(), "Connection should be open");
    }

    @Test
    void testSingletonBehavior() throws SQLException {
        DBConnection secondInstance = DBConnection.getInstance();
        assertSame(dbConnection, secondInstance, "Instances should be the same (singleton)");
    }

    @Test
    void testCloseConnection() throws SQLException {
        DBConnection.closeConnection();
        assertTrue(connection.isClosed(), "Connection should be closed");
    }
}
