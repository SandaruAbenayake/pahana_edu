<%@ page import="com.pahanaedu.dao.CustomerDAO" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Get customers - either search results or all customers
    List<Customer> customerList = (List<Customer>) request.getAttribute("searchResults");
    if (customerList == null) {
        customerList = CustomerDAO.getAllCustomers();
    }
    String searchTerm = (String) request.getAttribute("searchTerm");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f8;
            margin: 0;
            padding: 0;
        }

        .header {
            background: #fff;
            padding: 15px 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .header h2 {
            color: #005cbf;
            margin: 0;
        }

        .container {
            max-width: 1400px;
            margin: 20px auto;
        }

        .card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
            border: none;
            margin-bottom: 20px;
        }

        .search-section {
            background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .search-title {
            color: white;
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .form-control, .form-select {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 0.75rem 1rem;
        }

        .form-control:focus, .form-select:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
        }

        .btn-primary {
            background: #0d6efd;
            border: none;
        }

        .btn-primary:hover {
            background: #0b5ed7;
        }

        .btn-outline-primary {
            border-color: #0d6efd;
            color: #0d6efd;
        }

        .btn-outline-primary:hover {
            background: #0d6efd;
            color: #fff;
        }

        .btn-success {
            background: #198754;
            border: none;
        }

        .btn-success:hover {
            background: #157347;
        }

        .btn-warning {
            background: #ffc107;
            border: none;
            color: #000;
        }

        .btn-warning:hover {
            background: #ffca2c;
            color: #000;
        }

        .btn-danger {
            background: #dc3545;
            border: none;
        }

        .btn-danger:hover {
            background: #bb2d3b;
        }

        .table {
            margin: 0;
        }

        .table th {
            background: #f8f9fa;
            border-bottom: 2px solid #dee2e6;
            color: #495057;
            font-weight: 600;
        }

        .table td {
            vertical-align: middle;
        }

        .customer-form-card {
            background: #fff;
            border-radius: 10px;
            padding: 1.5rem;
        }

        .alert {
            border: none;
            border-radius: 8px;
        }

        .alert-success {
            background-color: #d1edff;
            color: #0c5460;
            border-left: 4px solid #0dcaf0;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border-left: 4px solid #dc3545;
        }

        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }

        .btn-sm {
            padding: 0.4rem 0.8rem;
            font-size: 0.875rem;
        }

        .stats-card {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 8px;
            padding: 1rem;
            text-align: center;
            margin-bottom: 1rem;
        }

        .stats-number {
            font-size: 2rem;
            font-weight: 600;
            color: #0d6efd;
        }

        .stats-label {
            color: #6c757d;
            font-size: 0.9rem;
        }

        .highlight {
            background-color: #fff3cd;
            padding: 0.2rem 0.4rem;
            border-radius: 4px;
            font-weight: 600;
        }

        .status-badge {
            font-size: 0.8rem;
        }

        .customer-row:hover {
            background-color: #f8f9fa;
        }

        .form-section {
            background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .form-title {
            color: white;
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

<div class="header">
    <div class="container d-flex justify-content-between align-items-center">
        <h2><i class="bi bi-people"></i> Customer Management</h2>
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
    <!-- Customer Form Section -->
    <div class="form-section">
        <div class="form-title" id="formTitle">
            <i class="bi bi-person-plus"></i> Create New Customer
        </div>
        <div class="customer-form-card">
            <%-- Show success/error messages --%>
            <%
                String successMsg = null;
                String errorMsg = null;
                if (session.getAttribute("success") != null) {
                    successMsg = (String) session.getAttribute("success");
                    session.removeAttribute("success");
                }
                if (session.getAttribute("error") != null) {
                    errorMsg = (String) session.getAttribute("error");
                    session.removeAttribute("error");
                }
            %>
            <% if (successMsg != null) { %>
            <div class="alert alert-success d-flex align-items-center mb-3" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i>
                <%= successMsg %>
            </div>
            <% } %>
            <% if (errorMsg != null) { %>
            <div class="alert alert-danger d-flex align-items-center mb-3" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                <%= errorMsg %>
            </div>
            <% } %>

            <form action="createCustomer" method="post" id="customerForm">
                <input type="hidden" name="customerId" id="customerId"/>

                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="fullName" class="form-label">
                            <i class="bi bi-person"></i> Full Name *
                        </label>
                        <input type="text" class="form-control" id="fullName" name="fullName" required
                               placeholder="Enter full name">
                    </div>
                    <div class="col-md-4">
                        <label for="email" class="form-label">
                            <i class="bi bi-envelope"></i> Email *
                        </label>
                        <input type="email" class="form-control" id="email" name="email" required
                               placeholder="Enter email address">
                    </div>
                    <div class="col-md-4">
                        <label for="phone" class="form-label">
                            <i class="bi bi-telephone"></i> Phone *
                        </label>
                        <input type="tel" class="form-control" id="phone" name="phone" required
                               placeholder="Enter phone number">
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="nic" class="form-label">
                            <i class="bi bi-card-text"></i> NIC
                        </label>
                        <input type="text" class="form-control" id="nic" name="nic"
                               placeholder="Enter NIC number">
                    </div>
                    <div class="col-md-4">
                        <label for="gender" class="form-label">
                            <i class="bi bi-gender-ambiguous"></i> Gender
                        </label>
                        <select class="form-select" id="gender" name="gender">
                            <option value="">Select Gender</option>
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="dob" class="form-label">
                            <i class="bi bi-calendar"></i> Date of Birth
                        </label>
                        <input type="date" class="form-control" id="dob" name="dob">
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-8">
                        <label for="address" class="form-label">
                            <i class="bi bi-geo-alt"></i> Address
                        </label>
                        <textarea class="form-control" id="address" name="address" rows="2"
                                  placeholder="Enter address"></textarea>
                    </div>
                    <div class="col-md-4">
                        <label for="status" class="form-label">
                            <i class="bi bi-shield-check"></i> Status
                        </label>
                        <select class="form-select" id="status" name="status">
                            <option value="active">Active</option>
                            <option value="inactive">Inactive</option>
                            <option value="blocked">Blocked</option>
                        </select>
                    </div>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary flex-grow-1" id="submitBtn">
                        <i class="bi bi-plus-circle"></i> Create Customer
                    </button>
                    <button type="button" class="btn btn-secondary" id="cancelBtn"
                            style="display:none;" onclick="cancelEdit()">
                        <i class="bi bi-x-circle"></i> Cancel
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Search Section -->
    <div class="search-section">
        <div class="search-title">
            <i class="bi bi-search"></i> Search Customers
        </div>
        <div class="row g-3">
            <div class="col-md-8">
                <form action="searchCustomer" method="post" id="searchForm" class="d-flex">
                    <input type="text" name="searchTerm" id="searchInput" class="form-control form-control-lg me-2"
                           placeholder="Search by name, email, or phone..."
                           value="<%= searchTerm != null ? searchTerm : "" %>"/>
                    <button type="submit" class="btn btn-light btn-lg">
                        <i class="bi bi-search"></i> Search
                    </button>
                </form>
            </div>
            <div class="col-md-4">
                <% if (searchTerm != null && !searchTerm.isEmpty()) { %>
                <button type="button" class="btn btn-light btn-lg w-100" onclick="clearSearch()">
                    <i class="bi bi-x-circle"></i> Clear Search
                </button>
                <div class="text-white mt-2 text-center">
                    Found <strong><%= customerList.size() %></strong> customer(s) for "<%= searchTerm %>"
                </div>
                <% } %>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- Statistics Section -->
        <div class="col-md-3">
            <div class="card">
                <div class="card-body">
                    <h6 class="card-title mb-3">
                        <i class="bi bi-graph-up"></i> Customer Statistics
                    </h6>
                    <div class="stats-card">
                        <div class="stats-number"><%= customerList != null ? customerList.size() : 0 %></div>
                        <div class="stats-label">Total Customers</div>
                    </div>
                    <%
                        int activeCount = 0;
                        int inactiveCount = 0;
                        if (customerList != null) {
                            for (Customer c : customerList) {
                                if ("active".equals(c.getStatus())) activeCount++;
                                else inactiveCount++;
                            }
                        }
                    %>
                    <div class="row">
                        <div class="col-6">
                            <div class="stats-card">
                                <div class="stats-number text-success"><%= activeCount %></div>
                                <div class="stats-label">Active</div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="stats-card">
                                <div class="stats-number text-warning"><%= inactiveCount %></div>
                                <div class="stats-label">Inactive</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Customer List Section -->
        <div class="col-md-9">
            <div class="card">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h5 class="card-title mb-0">
                            <i class="bi bi-list-check"></i> Customer List
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
                                <th><i class="bi bi-person"></i> Name</th>
                                <th><i class="bi bi-envelope"></i> Email</th>
                                <th><i class="bi bi-telephone"></i> Phone</th>
                                <th><i class="bi bi-card-text"></i> NIC</th>
                                <th><i class="bi bi-gender-ambiguous"></i> Gender</th>
                                <th><i class="bi bi-calendar"></i> DOB</th>
                                <th><i class="bi bi-shield-check"></i> Status</th>
                                <th><i class="bi bi-gear"></i> Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <% if (customerList != null && !customerList.isEmpty()) {
                                for (Customer customer : customerList) {
                                    // Escape values for HTML attributes
                                    String escFullName = customer.getFullName() == null ? "" : customer.getFullName().replace("&", "&amp;").replace("\"", "&quot;").replace("'", "&#39;").replace("<", "&lt;").replace(">", "&gt;");
                                    String escEmail = customer.getEmail() == null ? "" : customer.getEmail().replace("&", "&amp;").replace("\"", "&quot;").replace("'", "&#39;").replace("<", "&lt;").replace(">", "&gt;");
                                    String escPhone = customer.getPhone() == null ? "" : customer.getPhone().replace("&", "&amp;").replace("\"", "&quot;").replace("'", "&#39;").replace("<", "&lt;").replace(">", "&gt;");
                                    String escNic = customer.getNic() == null ? "" : customer.getNic().replace("&", "&amp;").replace("\"", "&quot;").replace("'", "&#39;").replace("<", "&lt;").replace(">", "&gt;");
                                    String escAddress = customer.getAddress() == null ? "" : customer.getAddress().replace("&", "&amp;").replace("\"", "&quot;").replace("'", "&#39;").replace("<", "&lt;").replace(">", "&gt;");
                                    String escGender = customer.getGender() == null ? "" : customer.getGender().replace("&", "&amp;").replace("\"", "&quot;").replace("'", "&#39;").replace("<", "&lt;").replace(">", "&gt;");
                                    String escStatus = customer.getStatus() == null ? "" : customer.getStatus().replace("&", "&amp;").replace("\"", "&quot;").replace("'", "&#39;").replace("<", "&lt;").replace(">", "&gt;");

                                    // Highlight search term in name if searching
                                    String displayName = escFullName;
                                    if (searchTerm != null && !searchTerm.isEmpty() && escFullName.toLowerCase().contains(searchTerm.toLowerCase())) {
                                        displayName = escFullName.replaceAll("(?i)(" + searchTerm + ")", "<span class='highlight'>$1</span>");
                                    }
                            %>
                            <tr class="customer-row">
                                <td><span class="badge bg-secondary">#<%= customer.getCustomerId() %></span></td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <i class="bi bi-person-circle me-2 text-primary"></i>
                                        <%= displayName %>
                                    </div>
                                </td>
                                <td><%= escEmail %></td>
                                <td><%= escPhone %></td>
                                <td><%= escNic %></td>
                                <td><%= escGender %></td>
                                <td><%= customer.getDob() != null ? customer.getDob() : "-" %></td>
                                <td>
                                    <% if ("active".equals(escStatus)) { %>
                                    <span class="badge bg-success status-badge">
                                            <i class="bi bi-check-circle"></i> Active
                                        </span>
                                    <% } else if ("inactive".equals(escStatus)) { %>
                                    <span class="badge bg-warning status-badge">
                                            <i class="bi bi-pause-circle"></i> Inactive
                                        </span>
                                    <% } else { %>
                                    <span class="badge bg-danger status-badge">
                                            <i class="bi bi-x-circle"></i> Blocked
                                        </span>
                                    <% } %>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn btn-warning btn-sm" title="Edit Customer"
                                                data-id="<%= customer.getCustomerId() %>"
                                                data-fullname="<%= escFullName %>"
                                                data-email="<%= escEmail %>"
                                                data-phone="<%= escPhone %>"
                                                data-nic="<%= escNic %>"
                                                data-address="<%= escAddress %>"
                                                data-gender="<%= escGender %>"
                                                data-dob="<%= customer.getDob() != null ? customer.getDob() : "" %>"
                                                data-status="<%= escStatus %>"
                                                onclick="editCustomerFromAttr(this)">
                                            <i class="bi bi-pencil-square"></i>
                                        </button>
                                        <button class="btn btn-danger btn-sm" title="Delete Customer"
                                                onclick="deleteCustomer(<%= customer.getCustomerId() %>)">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <% }
                            } else { %>
                            <tr>
                                <td colspan="9" class="text-center text-muted py-4">
                                    <i class="bi bi-people fs-1 d-block mb-2"></i>
                                    No customers found.
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

<script>
    // Ensure functions are available globally
    window.editCustomer = function (id, fullName, email, phone, nic, address, gender, dob, status) {
        document.getElementById('customerId').value = id;
        document.getElementById('fullName').value = fullName;
        document.getElementById('email').value = email;
        document.getElementById('phone').value = phone;
        document.getElementById('nic').value = nic;
        document.getElementById('address').value = address;
        document.getElementById('gender').value = gender;
        document.getElementById('dob').value = dob;
        document.getElementById('status').value = status;
        document.getElementById('formTitle').innerHTML = '<i class="bi bi-pencil-square"></i> Edit Customer';
        document.getElementById('submitBtn').innerHTML = '<i class="bi bi-check-circle"></i> Update Customer';
        document.getElementById('submitBtn').className = 'btn btn-success flex-grow-1';
        document.getElementById('cancelBtn').style.display = 'inline-block';
        document.getElementById('customerForm').action = 'updateCustomer';

        // Scroll to form
        document.querySelector('.form-section').scrollIntoView({ behavior: 'smooth' });
    };

    window.editCustomerFromAttr = function (el) {
        window.editCustomer(
            el.getAttribute('data-id'),
            el.getAttribute('data-fullname'),
            el.getAttribute('data-email'),
            el.getAttribute('data-phone'),
            el.getAttribute('data-nic'),
            el.getAttribute('data-address'),
            el.getAttribute('data-gender'),
            el.getAttribute('data-dob'),
            el.getAttribute('data-status')
        );
    };

    window.cancelEdit = function () {
        document.getElementById('customerId').value = '';
        document.getElementById('fullName').value = '';
        document.getElementById('email').value = '';
        document.getElementById('phone').value = '';
        document.getElementById('nic').value = '';
        document.getElementById('address').value = '';
        document.getElementById('gender').value = '';
        document.getElementById('dob').value = '';
        document.getElementById('status').value = 'active';
        document.getElementById('formTitle').innerHTML = '<i class="bi bi-person-plus"></i> Create New Customer';
        document.getElementById('submitBtn').innerHTML = '<i class="bi bi-plus-circle"></i> Create Customer';
        document.getElementById('submitBtn').className = 'btn btn-primary flex-grow-1';
        document.getElementById('cancelBtn').style.display = 'none';
        document.getElementById('customerForm').action = 'createCustomer';
    };

    window.deleteCustomer = function (customerId) {
        if (confirm('Are you sure you want to delete this customer? This action cannot be undone.')) {
            window.location.href = 'deleteCustomer?customerId=' + customerId;
        }
    };

    window.clearSearch = function () {
        window.location.href = 'customerPage.jsp';
    };

    // Auto-submit search on Enter key
    document.getElementById('searchInput').addEventListener('keypress', function (e) {
        if (e.key === 'Enter') {
            e.preventDefault();
            document.getElementById('searchForm').submit();
        }
    });
</script>

</body>
</html>