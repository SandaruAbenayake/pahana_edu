package com.pahanaedu.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

public class Bill {
    private int billId;
    private int customerId;
    private String customerName;
    private BigDecimal totalAmount;
    private BigDecimal discountAmount;
    private BigDecimal finalAmount;
    private LocalDateTime billDate;
    private String status; // pending, completed, cancelled
    private String paymentMethod;
    private String notes;
    private List<BillItem> billItems;
    private BigDecimal amountPaid;
    private BigDecimal balanceReturned;
    private int createdBy;

    // Default constructor
    public Bill() {
    }

    // Constructor with basic fields
    public Bill(int billId, int customerId, String customerName, BigDecimal totalAmount,
                BigDecimal discountAmount, BigDecimal finalAmount, BigDecimal amountPaid,
                BigDecimal balanceReturned, LocalDateTime billDate, String status, int createdBy) {
        this.billId = billId;
        this.customerId = customerId;
        this.customerName = customerName;
        this.totalAmount = totalAmount;
        this.discountAmount = discountAmount;
        this.finalAmount = finalAmount;
        this.amountPaid = amountPaid;
        this.balanceReturned = balanceReturned;
        this.billDate = billDate;
        this.status = status;
        this.createdBy = createdBy;
    }


    // Getters and Setters
    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public BigDecimal getFinalAmount() {
        return finalAmount;
    }

    public void setFinalAmount(BigDecimal finalAmount) {
        this.finalAmount = finalAmount;
    }

    public LocalDateTime getBillDate() {
        return billDate;
    }

    public void setBillDate(LocalDateTime billDate) {
        this.billDate = billDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public List<BillItem> getBillItems() {
        return billItems;
    }

    public void setBillItems(List<BillItem> billItems) {
        this.billItems = billItems;
    }

    public BigDecimal getAmountPaid() {
        return amountPaid;
    }

    public void setBalanceReturned(BigDecimal balanceReturned) {
        this.balanceReturned = balanceReturned;
    }

    public void setAmountPaid(BigDecimal amountPaid) {
        this.amountPaid = amountPaid;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public BigDecimal getBalanceReturned() {
        return balanceReturned;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }
} 