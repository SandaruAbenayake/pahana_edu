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

        .bill-card {
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .bill-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
        }

        .bill-header {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
        }

        .bill-id {
            color: #0d6efd;
            font-weight: 600;
            font-size: 1.1rem;
        }

        .customer-name {
            color: #495057;
            font-weight: 500;
        }

        .bill-date {
            color: #6c757d;
            font-size: 0.9rem;
        }

        .summary-section {
            background: #f8f9fa;
            padding: 1rem;
            border-radius: 8px;
            margin-top: 1rem;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
        }

        .summary-item:last-child {
            margin-bottom: 0;
            font-weight: 600;
            color: #0d6efd;
            border-top: 1px solid #dee2e6;
            padding-top: 0.5rem;
        }

        .no-bills {
            text-align: center;
            padding: 3rem 1rem;
            color: #6c757d;
        }

        .no-bills i {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: #dee2e6;
        }

        .loading-spinner {
            text-align: center;
            padding: 2rem;
        }

        .alert {
            border: none;
            border-radius: 8px;
        }

        .modal-content {
            border-radius: 10px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
        }
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
