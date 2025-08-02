package com.pahanaedu.servlet.billing;

import com.pahanaedu.dao.BillDAO;
import com.pahanaedu.model.Bill;
import com.pahanaedu.model.BillItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/billing/createBill")
public class CreateBillServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get bill parameters
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            String customerName = request.getParameter("customerName");
            String paymentMethod = request.getParameter("paymentMethod");
            String notes = request.getParameter("notes");
            
            // Create bill object
            Bill bill = new Bill();
            bill.setCustomerId(customerId);
            bill.setCustomerName(customerName);
            bill.setPaymentMethod(paymentMethod);
            bill.setNotes(notes);
            bill.setBillDate(LocalDateTime.now());
            bill.setStatus("completed");
            
            // Get bill items from request
            List<BillItem> billItems = new ArrayList<>();
            String[] productIds = request.getParameterValues("productId[]");
            String[] productNames = request.getParameterValues("productName[]");
            String[] productCodes = request.getParameterValues("productCode[]");
            String[] quantities = request.getParameterValues("quantity[]");
            String[] unitPrices = request.getParameterValues("unitPrice[]");
            String[] totalPrices = request.getParameterValues("totalPrice[]");
            
            BigDecimal totalAmount = BigDecimal.ZERO;
            
            if (productIds != null) {
                for (int i = 0; i < productIds.length; i++) {
                    BillItem item = new BillItem();
                    item.setProductId(Integer.parseInt(productIds[i]));
                    item.setProductName(productNames[i]);
                    item.setProductCode(productCodes[i]);
                    item.setQuantity(Integer.parseInt(quantities[i]));
                    item.setUnitPrice(new BigDecimal(unitPrices[i]));
                    item.setTotalPrice(new BigDecimal(totalPrices[i]));
                    item.setFinalPrice(new BigDecimal(totalPrices[i])); // No discount for now
                    
                    billItems.add(item);
                    totalAmount = totalAmount.add(item.getTotalPrice());
                }
            }
            
            bill.setBillItems(billItems);
            bill.setTotalAmount(totalAmount);
            bill.setDiscountAmount(BigDecimal.ZERO);
            bill.setFinalAmount(totalAmount);
            
            // Create bill in database
            int billId = BillDAO.createBill(bill);
            
            if (billId > 0) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\":true,\"billId\":" + billId + ",\"message\":\"Bill created successfully\"}");
            } else {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\":false,\"message\":\"Failed to create bill\"}");
            }
            
        } catch (Exception e) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\":false,\"message\":\"Error: " + e.getMessage() + "\"}");
        }
    }
} 