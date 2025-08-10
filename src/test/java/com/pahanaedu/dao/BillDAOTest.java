package com.pahanaedu.dao;

import com.pahanaedu.db.DBConnection;
import com.pahanaedu.model.Bill;
import com.pahanaedu.model.BillItem;
import org.junit.jupiter.api.*;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class BillDAOTest {

    private BillDAO billDAO;
    private static int createdBillId;
    private Connection connection;

    @BeforeEach
    void setUp() throws SQLException {
        billDAO = new BillDAO();
        connection = DBConnection.getInstance().getConnection();
        System.out.println("Database connection established for BillDAO tests.");
    }

    @BeforeAll
    static void cleanDatabase() throws SQLException {
        try (Connection conn = DBConnection.getInstance().getConnection()) {
            conn.createStatement().execute("DELETE FROM bill_items");
            conn.createStatement().execute("DELETE FROM bills");
        }
    }

    @Test
    @Order(1)
    void createBill() {
        Bill bill = new Bill();
        bill.setCustomerId(1);
        bill.setCustomerName("Test Customer");
        bill.setTotalAmount(BigDecimal.valueOf(100.00));
        bill.setDiscountAmount(BigDecimal.valueOf(10.00));
        bill.setFinalAmount(BigDecimal.valueOf(90.00));
        bill.setAmountPaid(BigDecimal.valueOf(90.00));
        bill.setBalanceReturned(BigDecimal.ZERO);
        bill.setBillDate("2025-08-10");
        bill.setStatus("pending");
        bill.setPaymentMethod("cash"); // Assuming cash is a valid payment method
        bill.setCreatedBy(4); // Assuming user ID 4 is a valid user

        createdBillId = billDAO.createBill(bill);
        System.out.println(createdBillId);
        assertTrue(createdBillId > 0, "Bill ID should be generated");
    }

    @Test
    @Order(2)
    void createBillItemTest() {
        // Create a new DB connection here
        try (Connection connection = DBConnection.getInstance().getConnection()) {
            BillItem item = new BillItem();
            item.setBillId(createdBillId);  // make sure createdBillId is set before this test runs
            item.setProductId(2);
            item.setProductName("Test Product");
            item.setProductCode("P001");
            item.setQuantity(2);
            item.setUnitPrice(BigDecimal.valueOf(50.00));
            item.calculateTotalPrice();
            item.setDiscountPercent(BigDecimal.ZERO);
            item.calculateFinalPrice();

            boolean isCreated = billDAO.createBillItem(item, connection);
            assertTrue(isCreated, "Bill item should be created successfully");

        } catch (SQLException e) {
            e.printStackTrace();
            // Optionally fail the test explicitly if connection couldn't be established
            assertTrue(false, "Failed to establish DB connection");
        }
    }

    @Test
    @Order(3)
    void getBillById() {
        Bill bill = billDAO.getBillById(createdBillId);
        assertNotNull(bill, "Bill should be found");
        assertEquals(createdBillId, bill.getBillId(), "Bill ID should match");
    }

    @Test
    @Order(4)
    void getBillItemsByBillId() {
        List<BillItem> items = billDAO.getBillItemsByBillId(createdBillId);
        assertFalse(items.isEmpty(), "Bill should have items");
    }

    @Test
    @Order(5)
    void getAllBills() {
        List<Bill> bills = billDAO.getAllBills();
        assertFalse(bills.isEmpty(), "Bills list should not be empty");
    }


//    @Test
//    @Order(6)
//    void getBillsByCustomerId() {
//        List<Bill> bills = billDAO.getBillsByCustomerId(1);
//        assertFalse(bills.isEmpty(), "Customer should have bills");
//    }

    @Test
    @Order(6)
    void deleteBill() {
        boolean deleted = billDAO.deleteBill(createdBillId);
        assertTrue(deleted, "Bill should be deleted");

        Bill bill = billDAO.getBillById(createdBillId);
        assertNull(bill, "Deleted bill should not be found");
    }
}
