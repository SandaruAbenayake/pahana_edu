<%@ page import="com.pahanaedu.model.User" %>
<%@ page session="true" %>
<%
  User user = (User) session.getAttribute("user");
  if (user == null) {
    response.sendRedirect("login.jsp");
    return;
  }
%>

<!DOCTYPE html>
<html>
<head>
  <title>Pahana Edu - Dashboard</title>
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f4f6f8;
      margin: 0;
      padding: 0;
    }

    .dashboard-container {
      max-width: 500px;
      margin: 80px auto;
      padding: 30px;
      background-color: #ffffff;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
      border-radius: 12px;
      text-align: center;
    }

    h2 {
      color: #333333;
      margin-bottom: 10px;
    }

    p {
      color: #777;
      font-size: 16px;
      margin-bottom: 30px;
    }

    .menu h3 {
      color: #005cbf;
      margin-bottom: 20px;
    }

    .menu a {
      display: block;
      padding: 12px 20px;
      margin: 10px 0;
      background-color: #005cbf;
      color: white;
      text-decoration: none;
      border-radius: 8px;
      font-size: 16px;
      transition: background-color 0.3s ease, transform 0.2s ease;
    }

    .menu a:hover {
      background-color: #004799;
      transform: translateY(-2px);
    }
  </style>
</head>
<body>

<div class="dashboard-container">
  <h2>Welcome, <%= user.getUsername() %>!</h2>
  <p>Role: <%= user.getRole() %></p>

  <div class="menu">
    <h3>Navigation</h3>
    <a href="addCustomer.jsp">➕ Add Customer</a>
    <a href="viewCustomers.jsp">📄 View All Customers</a>
    <a href="calculateBill.jsp">💰 Calculate Bill</a>
    <a href="manageItems.jsp">📚 Manage Items</a>
    <a href="help.jsp">❓ Help</a>
    <a href="logout.jsp">🚪 Logout</a>
  </div>
</div>

</body>
</html>
