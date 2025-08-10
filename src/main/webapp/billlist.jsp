<%@ page
        import="java.util.List,com.pahanaedu.dao.BillDAO,com.pahanaedu.model.Bill,com.pahanaedu.model.BillItem,com.pahanaedu.model.Customer" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bill List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/bill-list.css">
    <style>

    </style>
</head>
<body>
<div class="header">
    <div class="container d-flex justify-content-between align-items-center">
        <h2><i class="bi bi-receipt"></i> Bill Management</h2>
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
    <!-- Search Section -->
    <div class="search-section">
        <div class="search-title">
            <i class="bi bi-search"></i> Search Bills
        </div>
        <div class="row g-3">
            <div class="col-md-3">
                <select id="searchType" class="form-select form-select-lg">
                    <option value="customerId">Customer ID</option>
                    <option value="billId">Bill ID</option>
                    <option value="all">All Bills</option>
                </select>
            </div>
            <div class="col-md-6">
                <input type="text" id="searchInput" class="form-control form-control-lg"
                       placeholder="Enter Customer ID or Bill ID">
            </div>
            <div class="col-md-3">
                <button class="btn btn-light btn-lg w-100" onclick="searchBills()">
                    <i class="bi bi-search"></i> Search Bills
                </button>
            </div>
        </div>
    </div>

    <!-- Results Section -->
    <div class="card">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h5 class="card-title mb-0">
                    <i class="bi bi-list-check"></i> Bill Results
                </h5>
                <button class="btn btn-outline-primary btn-sm" onclick="refreshBills()">
                    <i class="bi bi-arrow-clockwise"></i> Refresh
                </button>
            </div>

            <div id="billResults">
                <div class="loading-spinner">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p class="mt-2 text-muted">Loading bills...</p>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function searchBills() {
        var type = document.getElementById('searchType').value;
        var value = document.getElementById('searchInput').value.trim();
        if (!value) {
            alert('Please enter a value to search.');
            return;
        }
        fetch('billing/searchBill?type=' + encodeURIComponent(type) + '&value=' + encodeURIComponent(value))
            .then(res => res.json())
            .then(data => {
                var html = '';
                if (data.length === 0) {
                    html = '<div class="alert alert-warning">No bills found.</div>';
                } else {
                    data.forEach(bill => {
                        html += '<div class="card mb-3"><div class="card-body">';
                        html += '<h5>Bill ID: ' + bill.billId + ' | Customer: ' + bill.customerName + '</h5>';
                        html += '<p>Date: ' + bill.billDate + '</p>';
                        html += '<table class="table table-bordered"><thead><tr><th>Item</th><th>Qty</th><th>Price</th><th>Total</th></tr></thead><tbody>';
                        bill.items.forEach(item => {
                            html += '<tr>' +
                                '<td>' + item.name + '</td>' +
                                '<td>' + item.quantity + '</td>' +
                                '<td>' + item.price + '</td>' +
                                '<td>' + item.total + '</td>' +
                                '</tr>';
                        });
                        html += '</tbody></table>';
                        html += '<p><strong>Subtotal:</strong> ' + bill.totalAmount + ' | <strong>Paid:</strong> ' + bill.amountPaid + ' | <strong>Balance:</strong> ' + bill.balanceReturned + '</p>';
                        html += '</div></div>';
                    });
                }
                document.getElementById('billResults').innerHTML = html;
            })
            .catch(err => {
                document.getElementById('billResults').innerHTML = '<div class="alert alert-danger">Error loading bills.</div>';
            });
    }

    function showLoading() {
        document.getElementById('billResults').innerHTML = `
            <div class="loading-spinner">
                <div class="spinner-border text-primary" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
                <p class="mt-2 text-muted">Loading bills...</p>
            </div>
        `;
    }

    function showAlert(message, type) {
        document.getElementById('billResults').innerHTML = `
            <div class="alert alert-${type} d-flex align-items-center" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                ${message}
            </div>
        `;
    }

    function refreshBills() {
        document.getElementById('searchInput').value = '';
        document.getElementById('searchType').value = 'all';
        loadAllBills();
    }

    function loadAllBills() {
        fetch('billing/searchBill?type=all')
            .then(res => res.json())
            .then(data => {
                var html = '';
                if (data.length === 0) {
                    html = '<div class="alert alert-warning">No bills found.</div>';
                } else {
                    data.forEach(bill => {
                        html += '<div class="card mb-3"><div class="card-body">';
                        html += '<h5>Bill ID: ' + bill.billId + ' | Customer: ' + bill.customerName + '</h5>';
                        html += '<p>Date: ' + bill.billDate + '</p>';
                        html += '<table class="table table-bordered"><thead><tr><th>Item</th><th>Qty</th><th>Price</th><th>Total</th></tr></thead><tbody>';
                        bill.items.forEach(item => {
                            html += '<tr>' +
                                '<td>' + item.name + '</td>' +
                                '<td>' + item.quantity + '</td>' +
                                '<td>' + item.price + '</td>' +
                                '<td>' + item.total + '</td>' +
                                '</tr>';
                        });
                        html += '</tbody></table>';
                        html += '<p><strong>Subtotal:</strong> ' + bill.totalAmount + ' | <strong>Paid:</strong> ' + bill.amountPaid + ' | <strong>Balance:</strong> ' + bill.balanceReturned + '</p>';
                        html += '</div></div>';
                    });
                }
                document.getElementById('billResults').innerHTML = html;
            })
            .catch(err => {
                document.getElementById('billResults').innerHTML = '<div class="alert alert-danger">Error loading bills.</div>';
            });
    }

    window.addEventListener('load', function () {
        console.log('Window loaded — calling loadAllBills');
        loadAllBills();
    });


</script>
</body>
</html>
