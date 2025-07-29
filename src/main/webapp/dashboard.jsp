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
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f4f6f8;
      margin: 0;
      padding: 0;
    }

    .dashboard-container {
      max-width: 700px;
      margin: 50px auto;
      padding: 40px;
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
      color: black;
      margin: 30px 0 10px;
    }

    .menu a {
      display: inline-block;
      padding: 12px 20px;
      margin: 8px;
      background-color: #005cbf;
      color: white;
      text-decoration: none;
      border-radius: 8px;
      font-size: 15px;
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
  <h2>Welcome Admin, <%= user.getUsername() %>!</h2>
  <p>Role: <%= user.getRole() %></p>

  <div class="menu">
    <h3>Customer Management</h3>
    <a href="addCustomer.jsp"> Add Customer</a>
    <a href="viewCustomers.jsp"> View All Customers</a>
    <a href="removeCustomer.jsp"> Remove Customer</a>
    <a href="updateCustomer.jsp">Upgrade Customer</a>

    <h3> Item Management</h3>
    <a href="addItem.jsp"> Add Item</a>
    <a href="removeItem.jsp"> Remove Item</a>
    <a href="updateItem.jsp"> Upgrade Item</a>
    <a href="viewItems.jsp"> View All Items</a>

    <h3> Billing & Purchase</h3>
    <a href="calculateBill.jsp"> Calculate Bill</a>
    <a href="printBill.jsp"> Print Bill</a>
    <a href="viewPurchases.jsp">View All Purchase Detail</a>

    <h3>User Management</h3>
    <a href="createUser.jsp">Create User</a>
    <a href="editUser.jsp">Edit User</a>
    <a href="removeUser.jsp">Remove User</a>
    <a href="viewUsers.jsp">View All Users</a>

    <h3>Others</h3>
    <a href="help.jsp"> Help</a>
    <a href="logout.jsp"> Logout</a>
  </div>
</div>

</body>
</html>
