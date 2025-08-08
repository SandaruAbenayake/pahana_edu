package com.pahanaedu.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Item {
    private int productId;
    private String name;
    private String description;
    private String category;
    private String brand;
    private String size;
    private int pages;
    private String color;
    private String material;
    private String unitType;
    private String barcode;
    private String sku;
    private int quantityInStock;
    private int reorderLevel;
    private BigDecimal costPrice;
    private BigDecimal sellingPrice;
    private BigDecimal discountPercent;
    private LocalDateTime addedDate;
    private LocalDateTime updatedAt;
    private String status;

    // Default constructor
    public Item() {
    }

    // Constructor with all fields
    public Item(int productId, String name, String description, String category, String brand,
                String size, int pages, String color, String material, String unitType,
                String barcode, String sku, int quantityInStock, int reorderLevel,
                BigDecimal costPrice, BigDecimal sellingPrice, BigDecimal discountPercent,
                LocalDateTime addedDate, LocalDateTime updatedAt, String status) {
        this.productId = productId;
        this.name = name;
        this.description = description;
        this.category = category;
        this.brand = brand;
        this.size = size;
        this.pages = pages;
        this.color = color;
        this.material = material;
        this.unitType = unitType;
        this.barcode = barcode;
        this.sku = sku;
        this.quantityInStock = quantityInStock;
        this.reorderLevel = reorderLevel;
        this.costPrice = costPrice;
        this.sellingPrice = sellingPrice;
        this.discountPercent = discountPercent;
        this.addedDate = addedDate;
        this.updatedAt = updatedAt;
        this.status = status;
    }

    // Getters and Setters
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public int getPages() {
        return pages;
    }

    public void setPages(int pages) {
        this.pages = pages;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public String getUnitType() {
        return unitType;
    }

    public void setUnitType(String unitType) {
        this.unitType = unitType;
    }

    public String getBarcode() {
        return barcode;
    }

    public void setBarcode(String barcode) {
        this.barcode = barcode;
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public int getQuantityInStock() {
        return quantityInStock;
    }

    public void setQuantityInStock(int quantityInStock) {
        this.quantityInStock = quantityInStock;
    }

    public int getReorderLevel() {
        return reorderLevel;
    }

    public void setReorderLevel(int reorderLevel) {
        this.reorderLevel = reorderLevel;
    }

    public BigDecimal getCostPrice() {
        return costPrice;
    }

    public void setCostPrice(BigDecimal costPrice) {
        this.costPrice = costPrice;
    }

    public BigDecimal getSellingPrice() {
        return sellingPrice;
    }

    public void setSellingPrice(BigDecimal sellingPrice) {
        this.sellingPrice = sellingPrice;
    }

    public BigDecimal getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(BigDecimal discountPercent) {
        this.discountPercent = discountPercent;
    }

    public LocalDateTime getAddedDate() {
        return addedDate;
    }

    public void setAddedDate(LocalDateTime addedDate) {
        this.addedDate = addedDate;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
} 