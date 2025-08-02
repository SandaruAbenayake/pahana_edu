<%@ page import="com.pahanaedu.dao.UserDAO" %>
<%@ page import="com.pahanaedu.model.User" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Fetch all users for the table
    List<User> userList = UserDAO.getAllUsers();
%>
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <title>User Management</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f8;
            margin: 0;
            padding: 0;
        }

        .container {
            display: flex;
            max-width: 1000px;
            margin: 40px auto;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }

        .left, .right {
            padding: 40px 30px;
        }

        .left {
            flex: 1;
            border-right: 1px solid #e0e0e0;
        }

        .right {
            flex: 2;
        }

        h2 {
            color: #005cbf;
            margin-bottom: 24px;
        }

        form label {
            display: block;
            margin-bottom: 8px;
            color: #333;
        }

        form input, form select {
            width: 100%;
            padding: 10px;
            margin-bottom: 18px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
        }

        form button {
            background: #007bff;
            color: #fff;
            border: none;
            padding: 12px 24px;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.2s;
        }

        form button:hover {
            background: #0056b3;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th, td {
            padding: 12px 10px;
            border-bottom: 1px solid #e0e0e0;
            text-align: left;
        }

        th {
            background: #f0f4fa;
            color: #333;
        }

        tr:last-child td {
            border-bottom: none;
        }

        .msg {
            margin-bottom: 18px;
            color: #d9534f;
        }

        .icon {
            cursor: pointer;
            font-size: 18px;
            margin-right: 10px;
            transition: color 0.2s;
        }

        .icon.edit:hover {
            color: #007bff;
        }

        .icon.delete:hover {
            color: #d9534f;
        }
    </style>
<script>
    // Ensure functions are available globally
    window.editUser = function(id, username, password, role) {
        document.getElementById('username').value = username;
        document.getElementById('password').value = password;
        document.getElementById('role').value = role;
        document.getElementById('userId').value = id;
        document.getElementById('formTitle').innerText = 'Edit User';
        document.getElementById('submitBtn').innerText = 'Update User';
        document.getElementById('cancelBtn').style.display = 'inline-block';
        document.getElementById('userForm').action = 'updateUser';
    };

    window.editUserFromAttr = function(el) {
        window.editUser(
            el.getAttribute('data-id'),
            el.getAttribute('data-username'),
            el.getAttribute('data-password'),
            el.getAttribute('data-role')
        );
    };

    window.cancelEdit = function() {
        document.getElementById('username').value = '';
        document.getElementById('password').value = '';
        document.getElementById('role').value = 'user';
        document.getElementById('userId').value = '';
        document.getElementById('formTitle').innerText = 'Create User';
        document.getElementById('submitBtn').innerText = 'Create User';
        document.getElementById('cancelBtn').style.display = 'none';
        document.getElementById('userForm').action = 'createUser';
    };

    window.deleteUser = function(id) {
        if (confirm('Are you sure you want to delete this user?')) {
            window.location.href = 'deleteUser?id=' + id;
        }
    };
</script>
</head>
<body>
<div class="container">
    <div class="left">
        <h2 id="formTitle">Create User</h2>
        <form action="createUser" method="post" id="userForm">
            <input type="hidden" name="id" id="userId"/>
            <label for="username">Username</label>
            <input type="text" id="username" name="username" required/>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" required/>

            <label for="role">Role</label>
            <select id="role" name="role" required>
                <option value="user">User</option>
                <option value="admin">Admin</option>
            </select>

            <button type="submit" id="submitBtn">Create User</button>
            <button type="button" id="cancelBtn" style="display:none; margin-left:10px; background:#6c757d;"
                    onclick="cancelEdit()">Cancel
            </button>
        </form>
        <%-- Show success message from session if present --%>
        <%
            String successMsg = null;
            if (session.getAttribute("success") != null) {
                successMsg = (String) session.getAttribute("success");
                session.removeAttribute("success");
            }
        %>
        <% if (successMsg != null) { %>
        <div class="msg" style="color:#28a745;"><%= successMsg %>
        </div>
        <% } %>
        <%-- Placeholder for error/success messages --%>
        <div class="msg">
            <% if (request.getAttribute("error") != null) { %>
            <%= request.getAttribute("error") %>
            <% } %>
        </div>
    </div>
    <div class="right">
        <h2>User List</h2>
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Role</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <% if (userList != null && !userList.isEmpty()) {
                for (User u : userList) {
                    // Escape values for HTML attributes
                    String escUsername = u.getUsername() == null ? "" : u.getUsername().replace("&", "&amp;").replace("\"", "&quot;").replace("'", "&#39;").replace("<", "&lt;").replace(">", "&gt;");
                    String escPassword = u.getPassword() == null ? "" : u.getPassword().replace("&", "&amp;").replace("\"", "&quot;").replace("'", "&#39;").replace("<", "&lt;").replace(">", "&gt;");
                    String escRole = u.getRole() == null ? "" : u.getRole().replace("&", "&amp;").replace("\"", "&quot;").replace("'", "&#39;").replace("<", "&lt;").replace(">", "&gt;");
            %>
            <tr>
                <td><%= u.getId() %>
                </td>
                <td><%= escUsername %>
                </td>
                <td><%= escRole %>
                </td>
                <td>
            <span class="icon edit" title="Edit"
                  data-id="<%= u.getId() %>"
                  data-username="<%= escUsername %>"
                  data-password="<%= escPassword %>"
                  data-role="<%= escRole %>"
                  onclick="editUserFromAttr(this)">✏️</span>
                    <span class="icon delete" title="Delete" onclick="deleteUser(<%= u.getId() %>)">🗑️</span>
                </td>
            </tr>
            <% }
            } else { %>
            <tr>
                <td colspan="4">No users found.</td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <!-- Back to Home Button -->
        <div style="margin-top: 20px;">
            <a href="dashboard.jsp" class="btn btn-secondary">← Back to Home</a>
        </div>

    </div>
</div>
</body>
</html>