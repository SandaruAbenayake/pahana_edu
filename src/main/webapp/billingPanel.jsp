<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Cashier Billing Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .card {
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .autocomplete-results {
            position: absolute;
            z-index: 1000;
            background: white;
            border: 1px solid #ced4da;
            width: 100%;
            max-height: 200px;
            overflow-y: auto;
        }

        .autocomplete-item {
            padding: 10px;
            cursor: pointer;
        }

        .autocomplete-item:hover {
            background-color: #f1f1f1;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="card mb-4 p-3">
        <div class="d-flex justify-content-between align-items-center">
            <h2>Cashier Billing Panel</h2>
            <%
                String role = (String) session.getAttribute("role");
                String homePage = "login.jsp"; // default fallback

                if ("admin".equalsIgnoreCase(role)) {
                    homePage = "dashboard.jsp";
                } else if ("user".equalsIgnoreCase(role)) {
                    homePage = "userDashboard.jsp";
                }
            %>
            <a href="<%= homePage %>" class="btn btn-secondary">Back</a>
        </div>

    </div>

    <!-- Customer Section -->
    <div class="card mb-4 p-4">
        <h4>Customer Info</h4>
        <div class="row g-2 mb-3">
            <div class="col-md-6">
                <input type="text" class="form-control" id="customerSearch" placeholder="Search by name or NIC">
            </div>
            <div class="col-md-2">
                <select class="form-select" id="searchType">
                    <option value="name">Name</option>
                    <option value="nic">NIC</option>
                </select>
            </div>
            <div class="col-md-2">
                <button class="btn btn-primary w-100" onclick="searchCustomer()">Search</button>
            </div>
            <div class="col-md-2">
                <a href="customerPage.jsp" class="btn btn-success w-100">Create Customer</a>
            </div>
        </div>

        <div id="customerDetails" style="display: none;">
            <h5>Customer Details</h5>
            <ul class="list-group">
                <li class="list-group-item">Name: <span id="customerName"></span></li>
                <li class="list-group-item">Email: <span id="customerEmail"></span></li>
                <li class="list-group-item">Phone: <span id="customerPhone"></span></li>
                <li class="list-group-item">NIC: <span id="customerNIC"></span></li>
                <li class="list-group-item">Address: <span id="customerAddress"></span></li>
                <li class="list-group-item">Status: <span id="customerStatus"></span></li>
            </ul>
        </div>
    </div>

    <div class="row">
        <!-- Item Entry -->
        <div class="col-md-6 mb-4">
            <div class="card p-4">
                <h4>Add Item</h4>
                <div class="mb-3 position-relative">
                    <label>Search Item</label>
                    <input type="text" class="form-control" id="itemSearch">
                    <div class="autocomplete-results" id="autocompleteResults" style="display: none;"></div>
                </div>

                <div id="itemDetails" style="display: none;">
                    <p><strong>Code:</strong> <span id="itemCode"></span></p>
                    <p><strong>Name:</strong> <span id="itemName"></span></p>
                    <p><strong>Price:</strong> $<span id="itemPrice"></span></p>
                    <p><strong>Stock:</strong> <span id="itemStock"></span></p>

                    <div class="mb-3">
                        <label>Quantity</label>
                        <input type="number" class="form-control" id="itemQuantity" min="1" value="1"
                               onchange="calculateItemTotal()">
                    </div>

                    <div class="mb-3">
                        <label>Total</label>
                        <input type="text" class="form-control" id="itemTotal" readonly>
                    </div>

                    <button class="btn btn-success w-100" id="addToBillBtn" onclick="addToBill()" disabled>Add to Bill
                    </button>
                </div>
            </div>
        </div>

        <!-- Bill Summary -->
        <div class="col-md-6 mb-4">
            <div class="card p-4">
                <h4>Current Bill</h4>
                <table class="table table-bordered">
                    <thead class="table-light">
                    <tr>
                        <th>Code</th>
                        <th>Item</th>
                        <th>Qty</th>
                        <th>Price</th>
                        <th>Total</th>
                        <th>Remove</th>
                    </tr>
                    </thead>
                    <tbody id="billItems"></tbody>
                </table>

                <div class="mb-3">
                    <p>Subtotal: <strong id="subtotal">$0.00</strong></p>
                    <p>Discount: <strong id="discount">$0.00</strong></p>
                    <p>Total: <strong id="total">$0.00</strong></p>
                </div>

                <div class="mb-3">
                    <label>Payment Method</label>
                    <select class="form-select" id="paymentMethod">
                        <option value="cash">Cash</option>
                        <option value="card">Card</option>
                        <option value="bank_transfer">Bank Transfer</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label>Notes</label>
                    <input type="text" class="form-control" id="notes" placeholder="Optional notes...">
                </div>

                <div class="d-grid gap-2">
                    <button class="btn btn-primary" onclick="confirmBill()">Confirm Bill</button>
                    <button class="btn btn-danger" onclick="resetBill()">Reset</button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS and script placeholders -->
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
    }

    function displayItemDetails(item) {
        document.getElementById('itemCode').textContent = item.sku;
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

    function addToBill() {
        const code = document.getElementById('itemCode').textContent;
        const name = document.getElementById('itemName').textContent;
        const price = parseFloat(document.getElementById('itemPrice').textContent) || 0;
        const qty = parseInt(document.getElementById('itemQuantity').value) || 0;
        const stock = parseInt(document.getElementById('itemStock').textContent) || 0;
        if (qty < 1 || qty > stock) {
            alert('Invalid quantity!');
            return;
        }
        console.log(code, name, price, qty);
        const total = price * qty;
        const billItems = document.getElementById('billItems');
        let row = document.createElement('tr');
        const tdCode = document.createElement('td');
        tdCode.textContent = code;
        row.appendChild(tdCode);

        const tdName = document.createElement('td');
        tdName.textContent = name;
        row.appendChild(tdName);

        const tdQty = document.createElement('td');
        tdQty.textContent = qty;
        row.appendChild(tdQty);

        const tdPrice = document.createElement('td');
        tdPrice.textContent = price.toFixed(2);
        row.appendChild(tdPrice);

        const tdTotal = document.createElement('td');
        tdTotal.textContent = total.toFixed(2);
        row.appendChild(tdTotal);

        const tdBtn = document.createElement('td');
        const btn = document.createElement('button');
        btn.className = 'btn btn-danger btn-sm';
        btn.textContent = 'Remove';
        btn.onclick = function () {
            this.closest('tr').remove();
            updateBillTotals();
        };
        tdBtn.appendChild(btn);
        row.appendChild(tdBtn);
        console.log(row)
        billItems.appendChild(row);
        updateBillTotals();
        document.getElementById('itemDetails').style.display = 'none';
        document.getElementById('addToBillBtn').disabled = true;
        document.getElementById('itemSearch').value = '';
    }

    function updateBillTotals() {
        let subtotal = 0;
        // Only count rows that are direct children of #billItems
        document.querySelectorAll('#billItems > tr').forEach(row => {
            if (row.children.length >= 5) {
                const totalCell = row.children[4];
                const value = parseFloat(totalCell.textContent);
                if (!isNaN(value)) subtotal += value;
            }
        });
        document.getElementById('subtotal').textContent = 'Rs' + subtotal.toFixed(2);
        document.getElementById('discount').textContent = 'Rs0.00';
        document.getElementById('total').textContent = 'Rs' + subtotal.toFixed(2);

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
        if (confirm('Are you sure you want to confirm this bill?')) {
            // Show purchase summary table
            showPurchaseSummary();
        }
    }

    function showPurchaseSummary() {
        // Remove old summary if exists
        let oldSummary = document.getElementById('purchaseSummary');
        if (oldSummary) oldSummary.remove();

        // Create summary table
        const summaryDiv = document.createElement('div');
        summaryDiv.id = 'purchaseSummary';
        summaryDiv.className = 'card p-4 mt-4';
        summaryDiv.innerHTML = `<h4>Purchase Summary</h4>
            <p><strong>Customer:</strong> ${document.getElementById('customerName').textContent}</p>
            <table class="table table-bordered">
                <thead><tr><th>Item Code</th><th>Item Name</th><th>Price</th><th>Qty</th><th>Total</th></tr></thead>
                <tbody id="purchaseSummaryBody"></tbody>
            </table>
            <p><strong>Bill Total:</strong> <span id="purchaseSummaryTotal"></span></p>
            <button class="btn btn-success" onclick="finalizeBill()">Yes, Purchase</button>
            <button class="btn btn-secondary ms-2" onclick="this.closest('#purchaseSummary').remove()">Cancel</button>`;
        document.querySelector('.container').appendChild(summaryDiv);

        // Fill table rows
        let sum = 0;
        document.querySelectorAll('#billItems > tr').forEach(row => {
            const code = row.children[0].textContent;
            const name = row.children[1].textContent;
            const qty = row.children[2].textContent;
            const price = row.children[3].textContent;
            const total = row.children[4].textContent;
            sum += parseFloat(total) || 0;
            const tr = document.createElement('tr');
            tr.innerHTML = `<td>${code}</td><td>${name}</td><td>${price}</td><td>${qty}</td><td>${total}</td>`;
            document.getElementById('purchaseSummaryBody').appendChild(tr);
        });
        document.getElementById('purchaseSummaryTotal').textContent = 'Rs' + sum.toFixed(2);
    }

    function finalizeBill() {
        alert('Bill confirmed and purchase completed!');
        // Optionally, send data to server here
        document.getElementById('purchaseSummary').remove();
        // Reset bill table and totals
        document.getElementById('billItems').innerHTML = '';
        updateBillTotals();
    }

</script>
</body>
</html>
