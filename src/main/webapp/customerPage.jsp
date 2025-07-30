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
<html>
<head>
    <title>Customer Management</title>
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
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header h1 {
            color: #005cbf;
            margin: 0;
        }
        .back-btn {
            background: #6c757d;
            color: #fff;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
            transition: background 0.2s;
        }
        .back-btn:hover {
            background: #545b62;
            color: #fff;
        }
        .container {
            max-width: 1400px;
            margin: 20px auto;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.08);
            overflow: hidden;
        }
        .form-section {
            padding: 20px;
            border-bottom: 1px solid #e0e0e0;
        }
        .search-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 25px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        .search-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="white" opacity="0.1"/><circle cx="75" cy="75" r="1" fill="white" opacity="0.1"/><circle cx="50" cy="10" r="0.5" fill="white" opacity="0.1"/><circle cx="10" cy="60" r="0.5" fill="white" opacity="0.1"/><circle cx="90" cy="40" r="0.5" fill="white" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            pointer-events: none;
        }
        .search-content {
            position: relative;
            z-index: 1;
        }
        .search-title {
            color: white;
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 15px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
        }
        .search-subtitle {
            color: rgba(255,255,255,0.9);
            font-size: 14px;
            margin-bottom: 25px;
        }
        .search-form {
            display: flex;
            max-width: 600px;
            margin: 0 auto;
            background: white;
            border-radius: 50px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
            overflow: hidden;
            position: relative;
        }
        .search-input {
            flex: 1;
            padding: 15px 25px;
            border: none;
            outline: none;
            font-size: 16px;
            background: transparent;
        }
        .search-input::placeholder {
            color: #999;
            font-style: italic;
        }
        .search-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 15px 30px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        .search-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }
        .search-btn:hover::before {
            left: 100%;
        }
        .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        .clear-btn {
            background: #6c757d;
            color: white;
            border: none;
            padding: 15px 25px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            margin-left: 10px;
            border-radius: 50px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .clear-btn:hover {
            background: #545b62;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
        }
        .search-results-info {
            margin-top: 20px;
            color: white;
            font-size: 16px;
            font-weight: 500;
            text-shadow: 0 1px 2px rgba(0,0,0,0.3);
        }
        .search-results-info strong {
            background: rgba(255,255,255,0.2);
            padding: 4px 8px;
            border-radius: 20px;
            margin: 0 5px;
        }
        .table-section {
            padding: 20px;
        }
        h2 {
            color: #005cbf;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #333;
            font-weight: 500;
        }
        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }
        .form-group textarea {
            height: 60px;
            resize: vertical;
        }
        .form-row {
            display: flex;
            gap: 15px;
            margin-bottom: 15px;
        }
        .form-row .form-group {
            flex: 1;
            margin-bottom: 0;
        }
        .btn {
            background: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
            transition: background 0.2s;
            margin-right: 10px;
        }
        .btn:hover {
            background: #0056b3;
        }
        .btn-secondary {
            background: #6c757d;
        }
        .btn-secondary:hover {
            background: #545b62;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            font-size: 12px;
        }
        th, td {
            padding: 8px;
            border-bottom: 1px solid #e0e0e0;
            text-align: left;
        }
        th {
            background: #f0f4fa;
            color: #333;
            font-weight: 600;
        }
        tr:last-child td {
            border-bottom: none;
        }
        .icon {
            cursor: pointer;
            font-size: 16px;
            margin-right: 8px;
            transition: color 0.2s;
        }
        .icon.edit:hover {
            color: #007bff;
        }
        .icon.delete:hover {
            color: #d9534f;
        }
        .msg {
            margin-bottom: 15px;
            padding: 10px;
            border-radius: 4px;
        }
        .msg.success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .msg.error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .compact-table td {
            padding: 6px 8px;
            font-size: 11px;
        }
        .compact-table th {
            padding: 8px;
            font-size: 11px;
        }
        .highlight {
            background-color: #fff3cd;
            font-weight: bold;
        }
        @media (max-width: 768px) {
            .search-form {
                flex-direction: column;
                border-radius: 20px;
            }
            .search-input {
                border-radius: 20px 20px 0 0;
            }
            .search-btn {
                border-radius: 0 0 20px 20px;
            }
            .clear-btn {
                margin-left: 0;
                margin-top: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Customer Management System</h1>
        <a href="userDashboard.jsp" class="back-btn">Back to Home</a>
    </div>

    <div class="container">
        <div class="form-section">
            <h2 id="formTitle">Create Customer</h2>
            
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
                <div class="msg success"><%= successMsg %></div>
            <% } %>
            <% if (errorMsg != null) { %>
                <div class="msg error"><%= errorMsg %></div>
            <% } %>

            <form action="createCustomer" method="post" id="customerForm">
                <input type="hidden" name="customerId" id="customerId" />
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="fullName">Full Name *</label>
                        <input type="text" id="fullName" name="fullName" required />
                    </div>
                    <div class="form-group">
                        <label for="email">Email *</label>
                        <input type="email" id="email" name="email" required />
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone *</label>
                        <input type="tel" id="phone" name="phone" required />
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="nic">NIC</label>
                        <input type="text" id="nic" name="nic" />
                    </div>
                    <div class="form-group">
                        <label for="gender">Gender</label>
                        <select id="gender" name="gender">
                            <option value="">Select Gender</option>
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="dob">Date of Birth</label>
                        <input type="date" id="dob" name="dob" />
                    </div>
                </div>

                <div class="form-group">
                    <label for="address">Address</label>
                    <textarea id="address" name="address"></textarea>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="status">Status</label>
                        <select id="status" name="status">
                            <option value="active">Active</option>
                            <option value="inactive">Inactive</option>
                            <option value="blocked">Blocked</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn" id="submitBtn">Create Customer</button>
                        <button type="button" class="btn btn-secondary" id="cancelBtn" style="display:none;" onclick="cancelEdit()">Cancel</button>
                    </div>
                </div>
            </form>
        </div>

        <div class="search-section">
            <div class="search-content">
                <div class="search-title">🔍 Search Customers</div>
                <div class="search-subtitle">Find customers quickly by name, email, or phone</div>
                
                <form action="searchCustomer" method="post" id="searchForm" class="search-form">
                    <input type="text" name="searchTerm" id="searchInput" class="search-input" 
                           placeholder="Type to search customers..." 
                           value="<%= searchTerm != null ? searchTerm : "" %>" />
                    <button type="submit" class="search-btn">Search</button>
                </form>
                
                <% if (searchTerm != null && !searchTerm.isEmpty()) { %>
                    <button type="button" class="clear-btn" onclick="clearSearch()">Clear Search</button>
                <% } %>
                
                <% if (searchTerm != null && !searchTerm.isEmpty()) { %>
                    <div class="search-results-info">
                        Found <strong><%= customerList.size() %></strong> customer(s) for <strong><%= searchTerm %></strong>
                    </div>
                <% } %>
            </div>
        </div>

        <div class="table-section">
            <h2>Customer List - Full Details</h2>
            <table class="compact-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>NIC</th>
                        <th>Gender</th>
                        <th>DOB</th>
                        <th>Address</th>
                        <th>Status</th>
                        <th>Registered Date</th>
                        <th>Action</th>
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
                    <tr>
                        <td><%= customer.getCustomerId() %></td>
                        <td><%= displayName %></td>
                        <td><%= escEmail %></td>
                        <td><%= escPhone %></td>
                        <td><%= escNic %></td>
                        <td><%= escGender %></td>
                        <td><%= customer.getDob() != null ? customer.getDob() : "" %></td>
                        <td><%= escAddress %></td>
                        <td><%= escStatus %></td>
                        <td><%= customer.getRegisteredDate() != null ? customer.getRegisteredDate().toString().substring(0, 16) : "" %></td>
                        <td>
                            <span class="icon edit" title="Edit"
                                data-id="<%= customer.getCustomerId() %>"
                                data-fullname="<%= escFullName %>"
                                data-email="<%= escEmail %>"
                                data-phone="<%= escPhone %>"
                                data-nic="<%= escNic %>"
                                data-address="<%= escAddress %>"
                                data-gender="<%= escGender %>"
                                data-dob="<%= customer.getDob() != null ? customer.getDob() : "" %>"
                                data-status="<%= escStatus %>"
                                onclick="editCustomerFromAttr(this)">✏️</span>
                            <span class="icon delete" title="Delete" onclick="deleteCustomer(<%= customer.getCustomerId() %>)">🗑️</span>
                        </td>
                    </tr>
                <%   }
                   } else { %>
                    <tr><td colspan="11">No customers found.</td></tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>

<script>
    // Ensure functions are available globally
    window.editCustomer = function(id, fullName, email, phone, nic, address, gender, dob, status) {
        document.getElementById('customerId').value = id;
        document.getElementById('fullName').value = fullName;
        document.getElementById('email').value = email;
        document.getElementById('phone').value = phone;
        document.getElementById('nic').value = nic;
        document.getElementById('address').value = address;
        document.getElementById('gender').value = gender;
        document.getElementById('dob').value = dob;
        document.getElementById('status').value = status;
        document.getElementById('formTitle').innerText = 'Edit Customer';
        document.getElementById('submitBtn').innerText = 'Update Customer';
        document.getElementById('cancelBtn').style.display = 'inline-block';
        document.getElementById('customerForm').action = 'updateCustomer';
    };

    window.editCustomerFromAttr = function(el) {
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

    window.cancelEdit = function() {
        document.getElementById('customerId').value = '';
        document.getElementById('fullName').value = '';
        document.getElementById('email').value = '';
        document.getElementById('phone').value = '';
        document.getElementById('nic').value = '';
        document.getElementById('address').value = '';
        document.getElementById('gender').value = '';
        document.getElementById('dob').value = '';
        document.getElementById('status').value = 'active';
        document.getElementById('formTitle').innerText = 'Create Customer';
        document.getElementById('submitBtn').innerText = 'Create Customer';
        document.getElementById('cancelBtn').style.display = 'none';
        document.getElementById('customerForm').action = 'createCustomer';
    };

    window.deleteCustomer = function(customerId) {
        if (confirm('Are you sure you want to delete this customer?')) {
            window.location.href = 'deleteCustomer?customerId=' + customerId;
        }
    };

    window.clearSearch = function() {
        window.location.href = 'customerPage.jsp';
    };

    // Auto-submit search on Enter key
    document.getElementById('searchInput').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            e.preventDefault();
            document.getElementById('searchForm').submit();
        }
    });
</script>
</body>
</html> 