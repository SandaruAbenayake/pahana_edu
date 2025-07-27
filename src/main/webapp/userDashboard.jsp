<%@ page import="com.pahanaedu.model.User" %>
<%@ page session="true" %>
<%
    // Session validation and role check
    User user = (User) session.getAttribute("user");
    if (user == null || !"user".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Pahana Edu - Cashier Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #eef2f3;
            margin: 0;
            padding: 0;
        }

        .dashboard-container {
            max-width: 700px;
            margin: 50px auto;
            padding: 30px;
            background-color: #ffffff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            border-radius: 12px;
            text-align: center;
        }

        h2 {
            color: #333333;
        }

        .menu h3 {
            color: #005cbf;
            margin: 30px 0 15px;
        }

        .menu a {
            display: inline-block;
            padding: 12px 20px;
            margin: 10px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .menu a:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>

<div class="dashboard-container">
    <h2>Welcome Cashier, <%= user.getUsername() %>!</h2>
    <p>Role: <%= user.getRole() %></p>

    <div class="menu">
        <!-- Customer Section -->
        <h3>Customer Section</h3>
        <a href="addCustomer.jsp">➕ Add Customer</a>
        <a href="viewCustomers.jsp"> View All Customers</a>
        <a href="removeCustomer.jsp">Remove Customer</a>
        <a href="updateCustomer.jsp">Upgrade Customer</a>

        <!-- Item Section -->
        <h3>Item Section</h3>
        <a href="addItem.jsp">➕ Add Item</a>
        <a href="removeItem.jsp"> Remove Item</a>
        <a href="updateItem.jsp">Upgrade Item</a>
        <a href="viewItems.jsp">View All Items</a>

        <!-- Report Section -->
        <h3>Report Section</h3>
        <a href="calculateBill.jsp">Calculate Bill</a>
        <a href="printBill.jsp"> Print Bill</a>
        <a href="viewPurchases.jsp">View All Purchase Details</a>

        <!-- Others -->
        <h3>Others</h3>
        <a href="help.jsp">Help</a>
        <a href="logout.jsp">Logout</a>
    </div>
</div>

</body>
</html>
