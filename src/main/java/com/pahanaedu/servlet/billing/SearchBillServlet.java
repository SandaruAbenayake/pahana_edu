package com.pahanaedu.servlet.billing;

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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/billing/searchBill")
public class SearchBillServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type = req.getParameter("type");
        String value = req.getParameter("value");
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        List<Bill> bills = new ArrayList<>();
        try {
            if ("customerId".equalsIgnoreCase(type) && value != null && !value.isEmpty()) {
                int customerId = Integer.parseInt(value);
                bills = BillDAO.getBillsByCustomerId(customerId);
            } else if ("billId".equalsIgnoreCase(type) && value != null && !value.isEmpty()) {
                int billId = Integer.parseInt(value);
                Bill bill = BillDAO.getBillById(billId);
                if (bill != null) bills.add(bill);
            } else if ("all".equalsIgnoreCase(type)) {
                bills = BillDAO.getAllBills();
            }
            List<Map<String, Object>> result = new ArrayList<>();
            for (Bill bill : bills) {
                Map<String, Object> billMap = new HashMap<>();
                billMap.put("billId", bill.getBillId());
                billMap.put("customerName", bill.getCustomerName());
                billMap.put("billDate", bill.getBillDate());
                billMap.put("totalAmount", bill.getTotalAmount());
                billMap.put("amountPaid", bill.getAmountPaid());
                billMap.put("balanceReturned", bill.getBalanceReturned());
                List<Map<String, Object>> items = new ArrayList<>();
                if (bill.getBillItems() != null) {
                    for (BillItem item : bill.getBillItems()) {
                        Map<String, Object> itemMap = new HashMap<>();
                        itemMap.put("name", item.getProductName());
                        itemMap.put("quantity", item.getQuantity());
                        itemMap.put("price", item.getUnitPrice());
                        itemMap.put("total", item.getTotalPrice());
                        items.add(itemMap);
                    }
                }
                billMap.put("items", items);
                result.add(billMap);
            }
            ObjectMapper mapper = new ObjectMapper();
            resp.getWriter().write(mapper.writeValueAsString(result));
        } catch (Exception e) {
            System.out.println("error => " + e.getMessage());
        }
    }
}

