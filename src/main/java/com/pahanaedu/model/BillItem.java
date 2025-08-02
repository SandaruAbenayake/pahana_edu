package com.pahanaedu.model;

import java.math.BigDecimal;

public class BillItem {
    private int billItemId;
    private int billId;
    private int productId;
    private String productName;
    private String productCode;
    private int quantity;
    private BigDecimal unitPrice;
    private BigDecimal totalPrice;
    private BigDecimal discountPercent;
    private BigDecimal discountAmount;
    private BigDecimal finalPrice;

    // Default constructor
    public BillItem() {}

    // Constructor with basic fields
    public BillItem(int billItemId, int billId, int productId, String productName, String productCode,
                   int quantity, BigDecimal unitPrice, BigDecimal totalPrice) {
        this.billItemId = billItemId;
        this.billId = billId;
        this.productId = productId;
        this.productName = productName;
        this.productCode = productCode;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.totalPrice = totalPrice;
    }

    // Constructor with all fields
    public BillItem(int billItemId, int billId, int productId, String productName, String productCode,
                   int quantity, BigDecimal unitPrice, BigDecimal totalPrice, 
                   BigDecimal discountPercent, BigDecimal discountAmount, BigDecimal finalPrice) {
        this.billItemId = billItemId;
        this.billId = billId;
        this.productId = productId;
        this.productName = productName;
        this.productCode = productCode;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.totalPrice = totalPrice;
        this.discountPercent = discountPercent;
        this.discountAmount = discountAmount;
        this.finalPrice = finalPrice;
    }

    // Getters and Setters
    public int getBillItemId() { return billItemId; }
    public void setBillItemId(int billItemId) { this.billItemId = billItemId; }

    public int getBillId() { return billId; }
    public void setBillId(int billId) { this.billId = billId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getProductCode() { return productCode; }
    public void setProductCode(String productCode) { this.productCode = productCode; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public BigDecimal getUnitPrice() { return unitPrice; }
    public void setUnitPrice(BigDecimal unitPrice) { this.unitPrice = unitPrice; }

    public BigDecimal getTotalPrice() { return totalPrice; }
    public void setTotalPrice(BigDecimal totalPrice) { this.totalPrice = totalPrice; }

    public BigDecimal getDiscountPercent() { return discountPercent; }
    public void setDiscountPercent(BigDecimal discountPercent) { this.discountPercent = discountPercent; }

    public BigDecimal getDiscountAmount() { return discountAmount; }
    public void setDiscountAmount(BigDecimal discountAmount) { this.discountAmount = discountAmount; }

    public BigDecimal getFinalPrice() { return finalPrice; }
    public void setFinalPrice(BigDecimal finalPrice) { this.finalPrice = finalPrice; }

    // Helper method to calculate total price
    public void calculateTotalPrice() {
        if (unitPrice != null && quantity > 0) {
            this.totalPrice = unitPrice.multiply(BigDecimal.valueOf(quantity));
        }
    }

    // Helper method to calculate final price with discount
    public void calculateFinalPrice() {
        if (totalPrice != null) {
            if (discountPercent != null && discountPercent.compareTo(BigDecimal.ZERO) > 0) {
                this.discountAmount = totalPrice.multiply(discountPercent).divide(BigDecimal.valueOf(100));
                this.finalPrice = totalPrice.subtract(discountAmount);
            } else {
                this.discountAmount = BigDecimal.ZERO;
                this.finalPrice = totalPrice;
            }
        }
    }
} 