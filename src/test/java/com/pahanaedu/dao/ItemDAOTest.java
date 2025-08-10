package com.pahanaedu.dao;

import com.pahanaedu.model.Item;
import org.junit.jupiter.api.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class ItemDAOTest {

    private static int createdItemId;

    @BeforeEach
    void setUp() {
        // Optional setup before each test if needed
    }

    @Test
    @Order(1)
    void createItem() {
        Item item = new Item();
        item.setName("Test Item");
        item.setDescription("This is a test item");
        item.setCategory("Stationery");
        item.setBrand("TestBrand");
        item.setSize("A4");
        item.setPages(100);
        item.setColor("White");
        item.setMaterial("Paper");
        item.setUnitType("Piece");
        item.setBarcode("1234567890123");
        item.setSku("SKU123");
        item.setQuantityInStock(50);
        item.setReorderLevel(10);
        item.setCostPrice(new BigDecimal("10.50"));
        item.setSellingPrice(new BigDecimal("15.00"));
        item.setDiscountPercent(new BigDecimal("5"));
        item.setAddedDate(LocalDateTime.now());
        item.setUpdatedAt(LocalDateTime.now());
        item.setStatus("available");

        boolean created = ItemDAO.createItem(item);
        assertTrue(created, "Item should be created");

        // If your DAO returns the generated ID, store it here. Otherwise,
        // you might need to retrieve it by searching the SKU or barcode.
        // Here we assume you can search by SKU:
        List<Item> items = ItemDAO.searchItemsByName("Test Item");
        assertFalse(items.isEmpty());
        createdItemId = items.get(0).getProductId();
        assertTrue(createdItemId > 0);
    }

    @Test
    @Order(2)
    void getAllItems() {
        List<Item> items = ItemDAO.getAllItems();
        assertNotNull(items, "Item list should not be null");
        assertFalse(items.isEmpty(), "Item list should not be empty");
    }

    @Test
    @Order(3)
    void getItemById() {
        assertTrue(createdItemId > 0, "createdItemId must be set by createItem test");
        Item item = ItemDAO.getItemById(createdItemId);
        assertNotNull(item, "Item should be found by ID");
        assertEquals(createdItemId, item.getProductId());
    }

    @Test
    @Order(4)
    void updateItem() {
        Item item = ItemDAO.getItemById(createdItemId);
        assertNotNull(item);

        item.setName("Updated Test Item");
        item.setSellingPrice(new BigDecimal("17.00"));
        item.setUpdatedAt(LocalDateTime.now());

        boolean updated = ItemDAO.updateItem(item);
        assertTrue(updated, "Item should be updated");

        Item updatedItem = ItemDAO.getItemById(createdItemId);
        assertEquals("Updated Test Item", updatedItem.getName());
        assertEquals(new BigDecimal("17.00"), updatedItem.getSellingPrice());
    }

    @Test
    @Order(5)
    void searchItemsByName() {
        List<Item> items = ItemDAO.searchItemsByName("Updated");
        assertNotNull(items);
        assertFalse(items.isEmpty(), "Should find items by partial name match");
        for (Item item : items) {
            assertTrue(item.getName().toLowerCase().contains("updated"));
        }
    }

    @Test
    @Order(6)
    void deleteItem() {
        boolean deleted = ItemDAO.deleteItem(createdItemId);
        assertTrue(deleted, "Item should be deleted");

        Item deletedItem = ItemDAO.getItemById(createdItemId);
        assertNull(deletedItem, "Deleted item should not be found");
    }
}
