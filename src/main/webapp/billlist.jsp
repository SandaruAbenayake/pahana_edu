<%@ page
        import="java.util.List,com.pahanaedu.dao.BillDAO,com.pahanaedu.model.Bill,com.pahanaedu.model.BillItem,com.pahanaedu.model.Customer" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bill List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f9fafb;
            padding: 20px;
        }

        .container {
            max-width: 1000px;
            margin: auto;
        }

        .search-bar {
            margin-bottom: 30px;
        }

        .table th, .table td {
            vertical-align: middle;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Bill List</h2>
    <div class="search-bar row g-2">
        <div class="col-md-3">
            <select id="searchType" class="form-select">
                <option value="customerId">Customer ID</option>
                <option value="billId">Bill ID</option>
            </select>
        </div>
        <div class="col-md-5">
            <input type="text" id="searchInput" class="form-control" placeholder="Enter Customer ID or Bill ID">
        </div>
        <div class="col-md-2">
            <button class="btn btn-primary w-100" onclick="searchBills()">Search</button>
        </div>
    </div>
    <div id="billResults">
        <!-- Bill results will be loaded here -->
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

    // Optionally, load all bills on page load
    window.onload = function () {
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
</script>
</body>
</html>

