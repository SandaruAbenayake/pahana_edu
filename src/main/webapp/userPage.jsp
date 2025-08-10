<%@ page import="com.pahanaedu.dao.UserDAO" %>
<%@ page import="com.pahanaedu.model.User" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Fetch all users for the table
    List<User> userList = UserDAO.getAllUsers();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/user-page.css">
    <style>

    </style>
    <script>
        // Ensure functions are available globally
        window.editUser = function (id, username, password, role) {
            document.getElementById('username').value = username;
            document.getElementById('password').value = password;
            document.getElementById('role').value = role;
            document.getElementById('userId').value = id;
            document.getElementById('formTitle').innerHTML = '<i class="bi bi-pencil-square"></i> Edit User';
            document.getElementById('submitBtn').innerHTML = '<i class="bi bi-check-circle"></i> Update User';
            document.getElementById('submitBtn').className = 'btn btn-success';
            document.getElementById('cancelBtn').style.display = 'inline-block';
            document.getElementById('userForm').action = 'updateUser';
        };

        window.editUserFromAttr = function (el) {
            window.editUser(
                el.getAttribute('data-id'),
                el.getAttribute('data-username'),
                el.getAttribute('data-password'),
                el.getAttribute('data-role')
            );
        };

        window.cancelEdit = function () {
            document.getElementById('username').value = '';
            document.getElementById('password').value = '';
            document.getElementById('role').value = 'user';
            document.getElementById('userId').value = '';
            document.getElementById('formTitle').innerHTML = '<i class="bi bi-person-plus"></i> Create New User';
            document.getElementById('submitBtn').innerHTML = '<i class="bi bi-plus-circle"></i> Create User';
            document.getElementById('submitBtn').className = 'btn btn-primary';
            document.getElementById('cancelBtn').style.display = 'none';
            document.getElementById('userForm').action = 'createUser';
        };

        window.deleteUser = function (id) {
            if (confirm('Are you sure you want to delete this user? This action cannot be undone.')) {
                window.location.href = 'deleteUser?id=' + id;
            }
        };
    </script>
</head>
<body>

<div class="header">
    <div class="container d-flex justify-content-between align-items-center">
        <h2><i class="bi bi-people"></i> User Management</h2>
        <%
            String role = (String) session.getAttribute("role");
            String homePage = "login.jsp";
            if ("admin".equalsIgnoreCase(role)) {
                homePage = "dashboard.jsp";
            } else if ("user".equalsIgnoreCase(role)) {
                homePage = "userDashboard.jsp";
            }
        %>
        <a href="<%= homePage %>" class="btn btn-outline-primary">
            <i class="bi bi-house"></i> Back to Dashboard
        </a>
    </div>
</div>

<div class="container">
    <div class="row">
        <!-- User Form Section -->
        <div class="col-md-4">
            <div class="form-section">
                <div class="form-title" id="formTitle">
                    <i class="bi bi-person-plus"></i> Create New User
                </div>
                <div class="user-form-card">
                    <form action="createUser" method="post" id="userForm">
                        <input type="hidden" name="id" id="userId"/>

                        <div class="mb-3">
                            <label for="username" class="form-label">
                                <i class="bi bi-person"></i> Username
                            </label>
                            <input type="text" class="form-control" id="username" name="username" required
                                   placeholder="Enter username">
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">
                                <i class="bi bi-lock"></i> Password
                            </label>
                            <input type="password" class="form-control" id="password" name="password" required
                                   placeholder="Enter password">
                        </div>

                        <div class="mb-3">
                            <label for="role" class="form-label">
                                <i class="bi bi-shield-check"></i> Role
                            </label>
                            <select class="form-select" id="role" name="role" required>
                                <option value="user">User</option>
                                <option value="admin">Admin</option>
                            </select>
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary flex-grow-1" id="submitBtn">
                                <i class="bi bi-plus-circle"></i> Create User
                            </button>
                            <button type="button" class="btn btn-secondary" id="cancelBtn"
                                    style="display:none;" onclick="cancelEdit()">
                                <i class="bi bi-x-circle"></i> Cancel
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Statistics Card -->
            <div class="card">
                <div class="card-body">
                    <h6 class="card-title mb-3">
                        <i class="bi bi-graph-up"></i> User Statistics
                    </h6>
                    <div class="stats-card">
                        <div class="stats-number"><%= userList != null ? userList.size() : 0 %></div>
                        <div class="stats-label">Total Users</div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <div class="stats-card">
                                <div class="stats-number text-success">
                                    <%= userList != null ? userList.stream().mapToInt(u -> "admin".equals(u.getRole()) ? 1 : 0).sum() : 0 %>
                                </div>
                                <div class="stats-label">Admins</div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="stats-card">
                                <div class="stats-number text-info">
                                    <%= userList != null ? userList.stream().mapToInt(u -> "user".equals(u.getRole()) ? 1 : 0).sum() : 0 %>
                                </div>
                                <div class="stats-label">Users</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Messages -->
            <%-- Show success message from session if present --%>
            <%
                String successMsg = null;
                if (session.getAttribute("success") != null) {
                    successMsg = (String) session.getAttribute("success");
                    session.removeAttribute("success");
                }
            %>
            <% if (successMsg != null) { %>
            <div class="alert alert-success d-flex align-items-center" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i>
                <%= successMsg %>
            </div>
            <% } %>

            <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger d-flex align-items-center" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                <%= request.getAttribute("error") %>
            </div>
            <% } %>
        </div>

        <!-- User List Section -->
        <div class="col-md-8">
            <div class="card">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h5 class="card-title mb-0">
                            <i class="bi bi-list-check"></i> User List
                        </h5>
                        <button class="btn btn-outline-primary btn-sm" onclick="window.location.reload()">
                            <i class="bi bi-arrow-clockwise"></i> Refresh
                        </button>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th><i class="bi bi-hash"></i> ID</th>
                                <th><i class="bi bi-person"></i> Username</th>
                                <th><i class="bi bi-shield-check"></i> Role</th>
                                <th><i class="bi bi-gear"></i> Actions</th>
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
                                <td><span class="badge bg-secondary">#<%= u.getId() %></span></td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <i class="bi bi-person-circle me-2 text-primary"></i>
                                        <%= escUsername %>
                                    </div>
                                </td>
                                <td>
                                    <% if ("admin".equals(escRole)) { %>
                                    <span class="badge bg-success">
                                            <i class="bi bi-shield-check"></i> Admin
                                        </span>
                                    <% } else { %>
                                    <span class="badge bg-info">
                                            <i class="bi bi-person"></i> User
                                        </span>
                                    <% } %>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn btn-warning btn-sm" title="Edit User"
                                                data-id="<%= u.getId() %>"
                                                data-username="<%= escUsername %>"
                                                data-password="<%= escPassword %>"
                                                data-role="<%= escRole %>"
                                                onclick="editUserFromAttr(this)">
                                            <i class="bi bi-pencil-square"></i>
                                        </button>
                                        <button class="btn btn-danger btn-sm" title="Delete User"
                                                onclick="deleteUser(<%= u.getId() %>)">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <% }
                            } else { %>
                            <tr>
                                <td colspan="4" class="text-center text-muted py-4">
                                    <i class="bi bi-people fs-1 d-block mb-2"></i>
                                    No users found.
                                </td>
                            </tr>
                            <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>