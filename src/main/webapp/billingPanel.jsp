<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Cashier Billing Panel</title>
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
        }

        .list-group-item {
            border-color: #e0e0e0;
            padding: 1rem;
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
        <h2>Cashier Billing Panel</h2>
        <%
            String role = (String) session.getAttribute("role");
            String homePage = "login.jsp";
            if ("admin".equalsIgnoreCase(role)) {
                homePage = "dashboard.jsp";
            } else if ("user".equalsIgnoreCase(role)) {
                homePage = "userDashboard.jsp";
            }
        %>
        <a href="<%= homePage %>" class="btn btn-outline-primary">Back to Dashboard</a>
    </div>
</div>

<div class="container">
    <div class="search-section">
        <div class="row g-3">
            <div class="col-md-6">
                <input type="text" class="form-control form-control-lg" id="customerSearch" placeholder="Search customer by name or NIC">
            </div>
            <div class="col-md-2">
                <select class="form-select form-select-lg" id="searchType">
                    <option value="name">Name</option>
                    <option value="nic">NIC</option>
                </select>
            </div>
            <div class="col-md-2">
                <button class="btn btn-light btn-lg w-100" onclick="searchCustomer()">
                    <i class="bi bi-search"></i> Search
                </button>
            </div>
            <div class="col-md-2">
                <a href="customerPage.jsp" class="btn btn-light btn-lg w-100">
                    <i class="bi bi-person-plus"></i> New
                </a>
            </div>
        </div>
    </div>

    <!-- Customer Details Card -->
    <div class="card mb-4" id="customerDetails" style="display: none;">
        <div class="card-body">
            <h5 class="card-title mb-4">Customer Details</h5>
            <div class="row g-3">
                <div class="col-md-4">
                    <p class="mb-1"><strong>Name:</strong> <span id="customerName"></span></p>
                    <p class="mb-1"><strong>Email:</strong> <span id="customerEmail"></span></p>
                </div>
                <div class="col-md-4">
                    <p class="mb-1"><strong>Phone:</strong> <span id="customerPhone"></span></p>
                    <p class="mb-1"><strong>NIC:</strong> <span id="customerNIC"></span></p>
                </div>
                <div class="col-md-4">
                    <p class="mb-1"><strong>Address:</strong> <span id="customerAddress"></span></p>
                    <p class="mb-1"><strong>Status:</strong> <span id="customerStatus"></span></p>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- Item Entry -->
        <div class="col-md-5">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title mb-4">Add Item</h5>
                    <div class="mb-3 position-relative">
                        <input type="text" class="form-control form-control-lg" id="itemSearch" placeholder="Search item by name or code">
                        <div class="autocomplete-results" id="autocompleteResults" style="display: none;"></div>
                    </div>
                    <div id="itemDetails" style="display: none;">
                        <div class="row mb-3">
                            <div class="col-6">
                                <label class="form-label">Code: <span id="itemCode"></span></label>
                            </div>
                            <div class="col-6">
                                <label class="form-label">Name: <span id="itemName"></span></label>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-6">
                                <label class="form-label">Price: <span id="itemPrice"></span></label>
                            </div>
                            <div class="col-6">
                                <label class="form-label">Stock: <span id="itemStock"></span></label>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Quantity</label>
                            <input type="number" class="form-control" id="itemQuantity" min="1" value="1" onchange="calculateItemTotal()">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Total</label>
                            <input type="text" class="form-control" id="itemTotal" readonly>
                        </div>
                        <button class="btn btn-primary w-100" id="addToBillBtn" onclick="addToBill()" disabled>
                            <i class="bi bi-cart-plus"></i> Add to Bill
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bill Summary -->
        <div class="col-md-7">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title mb-4">Current Bill</h5>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Code</th>
                                    <th>Item</th>
                                    <th>Qty</th>
                                    <th>Price</th>
                                    <th>Total</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody id="billItems"></tbody>
                        </table>
                    </div>

                    <div class="row mt-4">
                        <div class="col-md-4">
                            <p class="mb-2">Subtotal: <strong id="subtotal">Rs 0.00</strong></p>
                        </div>
                        <div class="col-md-4">
                            <p class="mb-2">Discount: <strong id="discount">Rs 0.00</strong></p>
                        </div>
                        <div class="col-md-4">
                            <p class="mb-2">Total: <strong id="total">Rs 0.00</strong></p>
                        </div>
                    </div>

                    <div class="row mt-3">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Amount Given</label>
                                <input type="number" class="form-control" id="amountGiven" oninput="updateBalance()">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Balance</label>
                                <input type="text" class="form-control" id="balance" readonly>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Payment Method</label>
                                <select class="form-select" id="paymentMethod">
                                    <option value="cash">Cash</option>
                                    <option value="card">Card</option>
                                    <option value="bank_transfer">Bank Transfer</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Notes</label>
                                <input type="text" class="form-control" id="notes" placeholder="Optional notes...">
                            </div>
                        </div>
                    </div>

                    <div class="d-flex gap-2 mt-4">
                        <button class="btn btn-primary flex-grow-1" onclick="confirmBill()">
                            <i class="bi bi-check2-circle"></i> Confirm Bill
                        </button>
                        <button class="btn btn-outline-primary" onclick="resetBill()">
                            <i class="bi bi-x-circle"></i> Reset
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Reuse the logic from your previous JavaScript code
    const customerInput = document.getElementById('customerSearch');
    const itemInput = document.getElementById('itemSearch');
    const searchType = document.getElementById('searchType');
    const suggestionsBox = document.createElement("div");
    suggestionsBox.className = "autocomplete-results";
    suggestionsBox.style.display = "none";
    customerInput.parentNode.appendChild(suggestionsBox);

    const itemSuggestionsBox = document.getElementById('autocompleteResults');

    let debounce;
    let selectedCustomer = null;

    customerInput.addEventListener('input', function () {
        const value = this.value.trim();
        clearTimeout(debounce);
        if (value.length >= 2) {
            debounce = setTimeout(() => fetchCustomerSuggestions(value), 300);
        } else {
            suggestionsBox.innerHTML = '';
            suggestionsBox.style.display = 'none';
        }
    });

    itemInput.addEventListener('input', function () {
        const value = this.value.trim();
        clearTimeout(debounce);
        if (value.length >= 2) {
            debounce = setTimeout(() => searchItem(), 300);
        } else {
            itemSuggestionsBox.innerHTML = '';
            itemSuggestionsBox.style.display = 'none';
        }
    })

    document.addEventListener('click', function (e) {
        if (!e.target.closest('.position-relative')) {
            suggestionsBox.style.display = 'none';
            itemSuggestionsBox.style.display = 'none';
        }
    });

    document.getElementById('itemQuantity').addEventListener('input', calculateItemTotal);

    function fetchCustomerSuggestions(query) {
        const type = searchType.value;
        fetch("billing/suggestCustomer?term=" + encodeURIComponent(query) + "&type=" + type)
            .then(res => res.json())
            .then(data => {
                suggestionsBox.innerHTML = '';
                if (data.length > 0) {
                    data.forEach(customer => {
                        const div = document.createElement('div');
                        div.className = 'autocomplete-item';
                        div.textContent = customer.fullName + " (" + customer.nic + ")";
                        div.onclick = () => {
                            customerInput.value = type === 'name' ? customer.fullName : customer.nic;
                            suggestionsBox.innerHTML = '';
                            suggestionsBox.style.display = 'none';
                            searchCustomer(); // auto trigger after selection
                        };
                        suggestionsBox.appendChild(div);
                    });
                    suggestionsBox.style.display = 'block';
                } else {
                    suggestionsBox.style.display = 'none';
                }
            })
            .catch(err => {
                console.error("Suggestion error:", err);
                suggestionsBox.style.display = 'none';
            });
    }

    function searchCustomer() {
        const searchTerm = customerInput.value.trim();
        const type = searchType.value;
        if (searchTerm === '') {
            alert('Please enter a search term');
            return;
        }

        fetch("billing/searchCustomer?searchTerm=" + encodeURIComponent(searchTerm) + "&searchType=" + type)
            .then(res => res.json())
            .then(data => {
                if (data.length > 0) {
                    displayCustomerDetails(data[0]);
                } else {
                    alert("Customer not found.");
                }
            })
            .catch(err => {
                console.error("Search error:", err);
                alert("Error searching for customer.");
            });
    }

    function searchItem() {
        const query = itemInput.value.trim();
        if (query.length < 2) {
            itemSuggestionsBox.innerHTML = '';
            itemSuggestionsBox.style.display = 'none';
            return;
        }
        fetch('billing/searchItem?searchTerm=' + encodeURIComponent(query), {
            headers: {
                'Accept': 'application/json'
            }
        })
            .then(res => res.json())
            .then(data => {
                itemSuggestionsBox.innerHTML = '';
                if (data.length > 0) {
                    data.forEach(item => {
                        const div = document.createElement('div');
                        div.className = 'autocomplete-item';
                        div.textContent = item.name + ' (Code: ' + item.sku + ')';
                        div.onclick = () => {
                            itemInput.value = item.name;
                            itemSuggestionsBox.innerHTML = '';
                            itemSuggestionsBox.style.display = 'none';
                            displayItemDetails(item);
                        };
                        itemSuggestionsBox.appendChild(div);
                    });
                    itemSuggestionsBox.style.display = 'block';
                } else {
                    itemSuggestionsBox.style.display = 'none';
                }
            })
            .catch(err => {
                console.error('Item suggestion error:', err);
                itemSuggestionsBox.style.display = 'none';
            });
    }

    function displayCustomerDetails(customer) {
        document.getElementById("customerName").textContent = customer.fullName;
        document.getElementById("customerEmail").textContent = customer.email;
        document.getElementById("customerPhone").textContent = customer.phone;
        document.getElementById("customerNIC").textContent = customer.nic;
        document.getElementById("customerAddress").textContent = customer.address;
        document.getElementById("customerStatus").textContent = customer.status;
        document.getElementById("customerDetails").style.display = "block";
        selectedCustomer = customer; // Store full customer object
    }


    let billItemsList = [];
    let selectedItem = null

    function displayItemDetails(item) {
        selectedItem = item;
        document.getElementById('itemCode').textContent = item.sku;
        document.getElementById('itemCode').setAttribute('data-product-id', item.id); // Store product ID
        document.getElementById('itemName').textContent = item.name;
        document.getElementById('itemPrice').textContent = item.sellingPrice;
        document.getElementById('itemStock').textContent = item.quantityInStock;
        document.getElementById('itemDetails').style.display = 'block';
        document.getElementById('addToBillBtn').disabled = false;
    }

    function calculateItemTotal() {
        const price = parseFloat(document.getElementById('itemPrice').textContent) || 0;
        const qty = parseInt(document.getElementById('itemQuantity').value) || 0;
        const total = price * qty;
        document.getElementById('itemTotal').value = total.toFixed(2);
    }

    // Array to store bill items

    function addToBill() {
        const price = parseFloat(document.getElementById('itemPrice').textContent) || 0;
        const qty = parseInt(document.getElementById('itemQuantity').value) || 0;
        if (qty < 1 || qty > selectedItem.quantityInStock) {
            alert('Invalid quantity!');
            return;
        }

        const total = price * qty;

        // Create bill item object
        const billItem = {
            productId: selectedItem.productId,
            code: selectedItem.sku,
            name: selectedItem.name,
            price: price,
            quantity: qty,
            total: total
        };

        console.log(billItem);
        // Add to billItemsList array
        billItemsList.push(billItem);

        // Recreate the entire bill items table
        const billItemsTable = document.getElementById('billItems');
        billItemsTable.innerHTML = '';

        // Rebuild table from billItemsList
        billItemsList.forEach((item, idx) => {
            let row = document.createElement('tr');
            row.innerHTML =
                '<td>' + item.code + '</td>' +
                '<td>' + item.name + '</td>' +
                '<td>' + item.quantity + '</td>' +
                '<td>' + item.price.toFixed(2) + '</td>' +
                '<td>' + item.total.toFixed(2) + '</td>' +
                '<td>' +
                '<button class="btn btn-danger btn-sm" onclick="removeFromBill(' + idx + ')">Remove</button>' +
                '</td>';
            billItemsTable.appendChild(row);
        });

        updateBillTotals();

        // Reset item entry form
        document.getElementById('itemDetails').style.display = 'none';
        document.getElementById('addToBillBtn').disabled = true;
        document.getElementById('itemSearch').value = '';
    }

    function removeFromBill(index) {
        // Remove item from billItemsList array
        billItemsList.splice(index, 1);

        // Recreate the entire bill items table
        const billItemsTable = document.getElementById('billItems');
        billItemsTable.innerHTML = '';

        // Rebuild table from billItemsList
        billItemsList.forEach((item, idx) => {
            let row = document.createElement('tr');
            row.innerHTML =
                '<td>' + item.code + '</td>' +
                '<td>' + item.name + '</td>' +
                '<td>' + item.quantity + '</td>' +
                '<td>' + item.price.toFixed(2) + '</td>' +
                '<td>' + item.total.toFixed(2) + '</td>' +
                '<td>' +
                '<button class="btn btn-danger btn-sm" onclick="removeFromBill(' + idx + ')">Remove</button>' +
                '</td>';
            billItemsTable.appendChild(row);
        });

        updateBillTotals();
    }

    function updateBalance() {
        const given = parseFloat(document.getElementById('amountGiven').value) || 0;
        const total = parseFloat(document.getElementById('total').textContent.replace('Rs', '').replace('$', '')) || 0;
        const balance = given - total;
        document.getElementById('balance').value = balance.toFixed(2);
    }

    function updateBillTotals() {
        let subtotal = billItemsList.reduce((sum, item) => sum + item.total, 0);
        document.getElementById('subtotal').textContent = 'Rs' + subtotal.toFixed(2);
        document.getElementById('total').textContent = 'Rs' + subtotal.toFixed(2);
        updateBalance();
    }

    function confirmBill() {
        if (document.querySelectorAll('#billItems > tr').length === 0) {
            alert('No items in the bill!');
            return;
        }
        const customerName = document.getElementById('customerName').textContent;
        if (!customerName) {
            alert('Please select a customer!');
            return;
        }
        // Show modal popup for purchase summary
        showPurchaseSummaryModal();
    }

    function showPurchaseSummaryModal() {
        // Remove old modal if exists
        let oldModal = document.getElementById('purchaseSummaryModal');
        if (oldModal) oldModal.remove();

        // Create modal HTML
        const modalDiv = document.createElement('div');
        modalDiv.id = 'purchaseSummaryModal';
        modalDiv.className = 'modal fade show';
        modalDiv.style.display = 'block';
        modalDiv.innerHTML = `
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Purchase Summary</h5>
                    <button type="button" class="btn-close" onclick="closePurchaseSummaryModal()"></button>
                </div>
                <div class="modal-body">
                    <p><strong>Customer:</strong> ${document.getElementById('customerName').textContent}</p>
                    <table class="table table-bordered">
                        <thead><tr><th>Item Code</th><th>Item Name</th><th>Price</th><th>Qty</th><th>Total</th></tr></thead>
                        <tbody id="purchaseSummaryBody"></tbody>
                    </table>
                    <p><strong>Bill Total:</strong> <span id="purchaseSummaryTotal"></span></p>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-success" onclick="finalizeBill()">Finalize Bill</button>
                    <button class="btn btn-secondary" onclick="closePurchaseSummaryModal()">Close</button>
                </div>
            </div>
        </div>`;
        document.body.appendChild(modalDiv);
        document.body.classList.add('modal-open');
        // Fill table rows AFTER modal is in DOM
        let sum = 0;
        // Clear previous rows if any
        const summaryBody = modalDiv.querySelector('#purchaseSummaryBody');
        summaryBody.innerHTML = '';
        document.querySelectorAll('#billItems > tr').forEach(row => {
            if (row.children.length >= 5) {
                const code = row.children[0].textContent;
                const name = row.children[1].textContent;
                const qty = row.children[2].textContent;
                const price = row.children[3].textContent;
                const total = row.children[4].textContent;
                sum += parseFloat(total) || 0;
                const tr = document.createElement('tr');
                tr.innerHTML = '<td>' + code + '</td><td>' + name + '</td><td>' + price + '</td><td>' + qty + '</td><td>' + total + '</td>';
                summaryBody.appendChild(tr);
            }
        });
        modalDiv.querySelector('#purchaseSummaryTotal').textContent = 'Rs' + sum.toFixed(2);
    }

    function closePurchaseSummaryModal() {
        let modal = document.getElementById('purchaseSummaryModal');
        if (modal) modal.remove();
        document.body.classList.remove('modal-open');
    }

    function printBill() {
        let modalContent = document.querySelector('#purchaseSummaryModal .modal-content');
        let printWindow = window.open('', '', 'width=900,height=600');
        printWindow.document.write('<html><head><title>Print Bill</title>');
        printWindow.document.write('<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">');
        printWindow.document.write('</head><body>');
        printWindow.document.write(modalContent.innerHTML);
        printWindow.document.write('</body></html>');
        printWindow.document.close();
        printWindow.focus();
        setTimeout(() => {
            printWindow.print();
            printWindow.close();
        }, 500);
    }

    function resetBill() {
        document.getElementById('billItems').innerHTML = '';
        document.getElementById('subtotal').textContent = 'Rs0.00';
        document.getElementById('discount').textContent = 'Rs0.00';
        document.getElementById('total').textContent = 'Rs0.00';
        document.getElementById('amountGiven').value = '';
        document.getElementById('balance').value = '';
        document.getElementById('customerSearch').value = '';
        document.getElementById('itemSearch').value = '';
        document.getElementById('customerDetails').style.display = 'none';
        document.getElementById('itemDetails').style.display = 'none';
        document.getElementById('notes').value = '';
        document.getElementById('paymentMethod').value = 'cash';
    }

    function finalizeBill() {
        // Collect bill data
        const customerId = selectedCustomer && selectedCustomer.customerId ? selectedCustomer.customerId : null;
        const customerName = selectedCustomer && selectedCustomer.fullName ? selectedCustomer.fullName : '';
        const items = [];
        billItemsList.forEach(row => {
            // Spread operator to include all properties
            items.push({
                ...row,
                qty: row.quantity,
            });
        });
        const total = document.getElementById('total').textContent.replace('Rs', '').replace('$', '');
        const paymentMethod = document.getElementById('paymentMethod').value;
        const notes = document.getElementById('notes').value;
        const givenAmount = document.getElementById('amountGiven').value || 0;
        const billData = {
            customerId,
            customerName,
            items,
            total,
            paymentMethod,
            notes,
            givenAmount
        };
        // Send bill data to backend
        fetch('billing/createBill', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(billData)
        })
            .then(res => res.json())
            .then(data => {
                if (data.success && data.billId) {
                    // Show simple bill for print
                    showSimplePrintBill();
                    closePurchaseSummaryModal();
                    resetBill();
                } else {
                    alert('Error saving bill: ' + (data.message || 'Unknown error'));
                }
            })
            .catch(err => {
                alert('Error saving bill: ' + err);
            });
    }

    function showSimplePrintBill() {
        // Collect bill data for print
        const customerName = document.getElementById('customerName').textContent;
        const now = new Date();
        const dateStr = now.toLocaleDateString();
        const timeStr = now.toLocaleTimeString();
        const billItems = billItemsList;
        const subtotal = billItems.reduce((sum, item) => sum + item.total, 0);
        const givenAmount = document.getElementById('amountGiven').value || 0;
        const balance = (parseFloat(givenAmount) - subtotal).toFixed(2);

        // Create print window
        let printWindow = window.open('', '', 'width=900,height=600');
        printWindow.document.write('<html><head><title>Print Bill</title>');
        printWindow.document.write('<style>body{font-family:sans-serif;padding:20px;} table{width:100%;border-collapse:collapse;} th,td{border:1px solid #ccc;padding:8px;text-align:left;} th{background:#f0f0f0;} .totals{margin-top:20px;} .totals p{margin:4px 0;}</style>');
        printWindow.document.write('</head><body>');
        printWindow.document.write('<h2>Bookshop Bill</h2>');
        printWindow.document.write('<p><strong>Customer:</strong> ' + customerName + '</p>');
        printWindow.document.write('<p><strong>Date:</strong> ' + dateStr + ' <strong>Time:</strong> ' + timeStr + '</p>');
        printWindow.document.write('<table><thead><tr><th>Item</th><th>Qty</th><th>Price</th><th>Total</th></tr></thead><tbody>');
        billItems.forEach(item => {
            printWindow.document.write('<tr>' +
                '<td>' + item.name + '</td>' +
                '<td>' + item.quantity + '</td>' +
                '<td>' + item.price.toFixed(2) + '</td>' +
                '<td>' + item.total.toFixed(2) + '</td>' +
                '</tr>');
        });
        printWindow.document.write('</tbody></table>');
        printWindow.document.write('<div class="totals">');
        printWindow.document.write('<p><strong>Subtotal:</strong> ' + subtotal.toFixed(2) + '</p>');
        printWindow.document.write('<p><strong>Given Amount:</strong> ' + parseFloat(givenAmount).toFixed(2) + '</p>');
        printWindow.document.write('<p><strong>Balance:</strong> ' + balance + '</p>');
        printWindow.document.write('</div>');
        printWindow.document.write('</body></html>');
        printWindow.document.close();
        printWindow.focus();
        setTimeout(() => {
            printWindow.print();
            printWindow.close();
        }, 500);
    }


</script>
</body>
</html>
