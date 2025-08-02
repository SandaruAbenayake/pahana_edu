<%@ page import="com.pahanaedu.model.User" %>
<%@ page session="true" %>
<%
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
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(-45deg, #74ebd5, #ACB6E5, #dfe9f3, #eecda3);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            margin: 0;
            padding: 0;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .dashboard-container {
            max-width: 850px;
            margin: 60px auto;
            padding: 40px;
            background-color: #ffffffdd;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
            border-radius: 16px;
            text-align: center;
        }

        h2 {
            color: #333;
            margin-bottom: 10px;
        }

        p {
            color: #666;
            font-size: 16px;
            margin-bottom: 30px;
        }

        .menu h3 {
            color: #005cbf;
            margin-top: 40px;
            margin-bottom: 20px;
        }

        .btn-custom {
            display: inline-block;
            padding: 12px 24px;
            margin: 10px;
            background-color: #007bff;
            color: #fff !important;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(0, 123, 255, 0.2);
        }

        .btn-custom:hover {
            background-color: #0056b3;
            transform: translateY(-3px) scale(1.03);
            box-shadow: 0 6px 20px rgba(0, 86, 179, 0.3);
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
        <a href="customerPage.jsp" class="btn-custom">Customer Management</a>

        <!-- Item Section -->
        <h3>Item Section</h3>
        <a href="itemPage.jsp" class="btn-custom">Item Management</a>

        <!-- Report Section -->
        <h3>Report Section</h3>
        <a href="billingPanel.jsp" class="btn-custom">Calculate Bill</a>

        <!-- Others -->
        <h3>Others</h3>
        <a href="help.jsp" class="btn-custom">Help</a>
        <a href="login.jsp" class="btn-custom">Logout</a>
    </div>
</div>

</body>
</html>
