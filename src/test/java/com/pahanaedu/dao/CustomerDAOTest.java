package com.pahanaedu.dao;

import com.pahanaedu.db.DBConnection;
import com.pahanaedu.model.Customer;
import org.junit.jupiter.api.*;

import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class CustomerDAOTest {

    private static int createdCustomerId;

    @BeforeEach
    void setUp() {
        // Optional: initialize anything needed before each test
    }

    @BeforeAll
    static void setUpBeforeAll()  throws SQLException  {
        try (Connection conn = DBConnection.getInstance().getConnection()) {
            conn.createStatement().execute("DELETE FROM customers");
        }
    }


    @Test
    @Order(1)
    void createCustomer() {
        Customer customer = new Customer();
        customer.setFullName("Test User");
        customer.setEmail("testuser@gmail.com");
        customer.setPhone("0712345678");
        customer.setNic("123456789V");
        customer.setAddress("Test Address");
        customer.setGender("Male");
        customer.setDob(LocalDate.of(1990, 1, 1));
        customer.setRegisteredDate(LocalDateTime.now());
        customer.setStatus("active");

        boolean created = CustomerDAO.createCustomer(customer);
        assertTrue(created, "Customer should be created");
    }

    @Test
    @Order(2)
    void getAllCustomers() {
        List<Customer> customers = CustomerDAO.getAllCustomers();
        assertNotNull(customers);
        assertFalse(customers.isEmpty(), "Customer list should not be empty");
    }

    @Test
    @Order(3)
    void getCustomerById() {
        // You should replace 1 with a valid existing customer ID or get from previous test
        // For example, pick the first customer from getAllCustomers
        List<Customer> customers = CustomerDAO.getAllCustomers();
        assertFalse(customers.isEmpty());
        Customer first = customers.get(0);

        Customer customer = CustomerDAO.getCustomerById(first.getCustomerId());
        assertNotNull(customer, "Customer should be found");
        assertEquals(first.getCustomerId(), customer.getCustomerId());
    }

    @Test
    @Order(5)
    void searchCustomersByName() {
        List<Customer> results = CustomerDAO.searchCustomersByName("Test");
        assertNotNull(results);
        assertFalse(results.isEmpty(), "Should find at least one customer with 'Test' in name");

        for (Customer c : results) {
            assertTrue(c.getFullName().toLowerCase().contains("test"));
        }
    }

    @Test
    @Order(6)
    void updateCustomer() {
        List<Customer> customers = CustomerDAO.getAllCustomers();
        assertFalse(customers.isEmpty());
        Customer customer = customers.get(0);

        customer.setFullName("Updated Name");
        boolean updated = CustomerDAO.updateCustomer(customer);
        assertTrue(updated, "Customer should be updated");

        Customer updatedCustomer = CustomerDAO.getCustomerById(customer.getCustomerId());
        assertEquals("Updated Name", updatedCustomer.getFullName());
    }



    @Test
    @Order(6)
    void searchCustomersByNIC() {
        List<Customer> results = CustomerDAO.searchCustomersByNIC("123456789V");
        assertNotNull(results);
        assertFalse(results.isEmpty(), "Should find at least one customer with given NIC");

        for (Customer c : results) {
            assertTrue(c.getNic().toLowerCase().contains("123456789v"));
        }
    }

    @Test
    @Order(7)
    void deleteCustomer() {
        // Create a customer to delete
        Customer customer = new Customer();
        customer.setFullName("Delete Me");
        customer.setEmail("deleteme@example.com");
        customer.setPhone("0723456789");
        customer.setNic("999999999V");
        customer.setAddress("Delete Address");
        customer.setGender("Female");
        customer.setDob(LocalDate.of(1980, 1, 1));
        customer.setRegisteredDate(LocalDateTime.now());
        customer.setStatus("active");

        boolean created = CustomerDAO.createCustomer(customer);
        assertTrue(created);

        // Get created customer ID by searching by NIC
        List<Customer> found = CustomerDAO.searchCustomersByNIC("999999999V");
        assertFalse(found.isEmpty());
        Customer toDelete = found.get(0);

        boolean deleted = CustomerDAO.deleteCustomer(toDelete.getCustomerId());
        assertTrue(deleted, "Customer should be deleted");

        Customer deletedCustomer = CustomerDAO.getCustomerById(toDelete.getCustomerId());
        assertNull(deletedCustomer, "Deleted customer should not be found");
    }
}
