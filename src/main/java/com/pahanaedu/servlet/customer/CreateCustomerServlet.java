package com.pahanaedu.servlet.customer;

import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.model.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;

@WebServlet("/createCustomer")
public class CreateCustomerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get form parameters
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String nic = request.getParameter("nic");
            String address = request.getParameter("address");
            String gender = request.getParameter("gender");
            String dobStr = request.getParameter("dob");
            String status = request.getParameter("status");

            // Create Customer object
            Customer customer = new Customer();
            customer.setFullName(fullName);
            customer.setEmail(email);
            customer.setPhone(phone);
            customer.setNic(nic);
            customer.setAddress(address);
            customer.setGender(gender);
            customer.setRegisteredDate(LocalDateTime.now());
            customer.setStatus(status != null ? status : "active");

            // Parse date of birth if provided
            if (dobStr != null && !dobStr.trim().isEmpty()) {
                try {
                    LocalDate dob = LocalDate.parse(dobStr);
                    customer.setDob(dob);
                } catch (Exception e) {
                    // If date parsing fails, leave it null
                    System.err.println("Invalid date format: " + dobStr);
                }
            }

            // Save to database
            boolean success = CustomerDAO.createCustomer(customer);
            String msg;
            if (success) {
                msg = "Customer created successfully.";
            } else {
                msg = "Failed to create customer.";
            }
            request.getSession().setAttribute("success", msg);
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Error creating customer: " + e.getMessage());
        }

        response.sendRedirect("customerPage.jsp");
    }
} 