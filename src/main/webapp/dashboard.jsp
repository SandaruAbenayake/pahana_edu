<%@ page import="com.pahanaedu.model.User" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Pahana Edu - Admin Dashboard</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(-45deg, #f3ec78, #af4261, #1e90ff, #00c9a7);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            margin: 0;
            padding: 0;
        }

        @keyframes gradientBG {
            0% {
                background-position: 0% 50%;
            }
            50% {
                background-position: 100% 50%;
            }
            100% {
                background-position: 0% 50%;
            }
        }

        .dashboard-container {
            max-width: 800px;
            margin: 60px auto;
            padding: 40px;
            background-color: #ffffffdd;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
            border-radius: 16px;
            text-align: center;
        }

        h2 {
            color: #333333;
            margin-bottom: 10px;
        }

        p {
            color: #555;
            font-size: 16px;
            margin-bottom: 30px;
        }

        .menu h3 {
            color: #222;
            margin-top: 30px;
            margin-bottom: 15px;
        }

        .menu a.btn {
            display: inline-block;
            margin: 8px;
            padding: 12px 20px;
            background: #005cbf;
            color: white;
            text-decoration: none;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            position: relative;
            overflow: hidden;
            transition: all 0.4s ease;
        }


        .menu a.btn:hover {
            color: lightblue;
            background: transparent;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2);
        }


    </style>
</head>
<body>

<div class="dashboard-container">
    <h2>Welcome Admin, <%= user.getUsername() %>!</h2>
    <p>Role: <%= user.getRole() %>
    </p>

    <div class="menu">
        <h3>Customer Management</h3>
        <a href="customerPage.jsp" class="btn"><span>Customer Management</span></a>

        <h3>Item Management</h3>
        <a href="itemPage.jsp" class="btn"><span>Item Management</span></a>

        <h3>Billing & Purchase</h3>
        <a href="billingPanel.jsp" class="btn"><span>Calculate Bill</span></a>
        <a href="billlist.jsp" class="btn"><span>View All Purchase Details</span></a>

        <h3>User Management</h3>
        <a href="userPage.jsp" class="btn"><span>User Management</span></a>

        <h3>Others</h3>
        <a href="help.jsp" class="btn"><span>Help</span></a>
        <a href="login.jsp" class="btn"><span>Logout</span></a>
    </div>
</div>

</body>
</html>
