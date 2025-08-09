package com.pahanaedu.servlet.billing;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/billing/createBill")
public class CreateBillServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try {
            ObjectMapper mapper = new ObjectMapper();
            JsonNode json = mapper.readTree(request.getInputStream());
            String customerName = json.path("customer").asText("");
            int customerId = json.path("customerId").asInt(0);
            String paymentMethod = json.path("paymentMethod").asText("");
            String notes = json.path("notes").asText("");
            BigDecimal totalAmount = new BigDecimal(json.path("total").asText("0"));
            BigDecimal givenAmount = new BigDecimal(json.path("givenAmount").asText("0"));
            BigDecimal balance = givenAmount.subtract(totalAmount);
            List<BillItem> billItems = new ArrayList<>();
            for (JsonNode itemNode : json.path("items")) {
                BillItem item = new BillItem();
                item.setProductCode(itemNode.path("code").asText(""));
                item.setProductName(itemNode.path("name").asText(""));
                item.setQuantity(itemNode.path("qty").asInt(0));
                item.setUnitPrice(new BigDecimal(itemNode.path("price").asText("0")));
                item.setTotalPrice(new BigDecimal(itemNode.path("total").asText("0")));
                // Set productId if available, else 0
                item.setProductId(itemNode.has("productId") ? itemNode.path("productId").asInt(0) : 0);
                // Set discountPercent and discountAmount (default to zero)
                item.setDiscountPercent(itemNode.has("discountPercent") ? new BigDecimal(itemNode.path("discountPercent").asText("0")) : BigDecimal.ZERO);
                item.setDiscountAmount(itemNode.has("discountAmount") ? new BigDecimal(itemNode.path("discountAmount").asText("0")) : BigDecimal.ZERO);
                // Calculate final price
                item.setFinalPrice(item.getTotalPrice().subtract(item.getDiscountAmount() != null ? item.getDiscountAmount() : BigDecimal.ZERO));
                billItems.add(item);
            }
            Bill bill = new Bill();
            bill.setCustomerId(customerId);
            bill.setCustomerName(customerName);
            bill.setPaymentMethod(paymentMethod);
            bill.setNotes(notes);
//            bill.setBillDate(LocalDateTime.now().toString());
            bill.setAmountPaid(givenAmount);
            bill.setBalanceReturned(balance);
            // Get userId from session
            Integer userId = (Integer) request.getSession().getAttribute("userId");
            com.pahanaedu.model.User user = (com.pahanaedu.model.User) request.getSession().getAttribute("user");
            if (userId == null && user != null) {
                userId = user.getId();
            }
            if (userId == null) {
                response.getWriter().write("{\"success\":false,\"message\":\"User not logged in\"}");
                return;
            }
            bill.setCreatedBy(userId);
            bill.setStatus("completed");
            bill.setBillItems(billItems);
            bill.setTotalAmount(totalAmount);
            bill.setDiscountAmount(BigDecimal.ZERO);
            bill.setFinalAmount(totalAmount);
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