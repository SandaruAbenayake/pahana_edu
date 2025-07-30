package com.pahanaedu.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class Customer {
    private int customerId;
    private String fullName;
    private String email;
    private String phone;
    private String nic;
    private String address;
    private String gender;
    private LocalDate dob;
    private LocalDateTime registeredDate;
    private String status;

    // Default constructor
    public Customer() {}

    // Constructor with all fields
    public Customer(int customerId, String fullName, String email, String phone, String nic, 
                   String address, String gender, LocalDate dob, LocalDateTime registeredDate, String status) {
        this.customerId = customerId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.nic = nic;
        this.address = address;
        this.gender = gender;
        this.dob = dob;
        this.registeredDate = registeredDate;
        this.status = status;
    }

    // Getters and Setters
    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public LocalDate getDob() { return dob; }
    public void setDob(LocalDate dob) { this.dob = dob; }

    public LocalDateTime getRegisteredDate() { return registeredDate; }
    public void setRegisteredDate(LocalDateTime registeredDate) { this.registeredDate = registeredDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
} 