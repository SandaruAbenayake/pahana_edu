<%@ page import="com.pahanaedu.dao.ItemDAO" %>
<%@ page import="com.pahanaedu.model.Item" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Get items - either search results or all items
    List<Item> itemList = (List<Item>) request.getAttribute("searchResults");
    if (itemList == null) {
        itemList = ItemDAO.getAllItems();
    }
    String searchTerm = (String) request.getAttribute("searchTerm");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Item Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/item-page.css">
    <style>

    </style>
</head>
<body>

<div class="header">
    <div class="container d-flex justify-content-between align-items-center">
        <h2><i class="bi bi-box-seam"></i> Item Management</h2>
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
    <!-- Item Form Section -->
    <div class="form-section">
        <div class="form-title" id="formTitle">
            <i class="bi bi-plus-circle"></i> Create New Item
        </div>
        <div class="item-form-card">
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

            <form action="createItem" method="post" id="itemForm">
                <input type="hidden" name="productId" id="productId"/>

                <!-- Basic Information -->
                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="name" class="form-label">
                            <i class="bi bi-box"></i> Item Name *
                        </label>
                        <input type="text" class="form-control" id="name" name="name" required
                               placeholder="Enter item name">
                    </div>
                    <div class="col-md-4">
                        <label for="category" class="form-label">
                            <i class="bi bi-tags"></i> Category *
                        </label>
                        <input type="text" class="form-control" id="category" name="category" required
                               placeholder="Enter category">
                    </div>
                    <div class="col-md-4">
                        <label for="brand" class="form-label">
                            <i class="bi bi-award"></i> Brand
                        </label>
                        <input type="text" class="form-control" id="brand" name="brand"
                               placeholder="Enter brand name">
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-12">
                        <label for="description" class="form-label">
                            <i class="bi bi-text-left"></i> Description
                        </label>
                        <textarea class="form-control" id="description" name="description" rows="2"
                                  placeholder="Enter item description"></textarea>
                    </div>
                </div>

                <!-- Product Details -->
                <div class="row mb-3">
                    <div class="col-md-3">
                        <label for="size" class="form-label">
                            <i class="bi bi-arrows-expand"></i> Size
                        </label>
                        <input type="text" class="form-control" id="size" name="size"
                               placeholder="Enter size">
                    </div>
                    <div class="col-md-3">
                        <label for="pages" class="form-label">
                            <i class="bi bi-file-earmark"></i> Pages
                        </label>
                        <input type="number" class="form-control" id="pages" name="pages" value="0" min="0">
                    </div>
                    <div class="col-md-3">
                        <label for="color" class="form-label">
                            <i class="bi bi-palette"></i> Color
                        </label>
                        <input type="text" class="form-control" id="color" name="color"
                               placeholder="Enter color">
                    </div>
                    <div class="col-md-3">
                        <label for="material" class="form-label">
                            <i class="bi bi-gem"></i> Material
                        </label>
                        <input type="text" class="form-control" id="material" name="material"
                               placeholder="Enter material">
                    </div>
                </div>

                <!-- Product Identification -->
                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="unitType" class="form-label">
                            <i class="bi bi-rulers"></i> Unit Type
                        </label>
                        <input type="text" class="form-control" id="unitType" name="unitType"
                               placeholder="Enter unit type">
                    </div>
                    <div class="col-md-4">
                        <label for="barcode" class="form-label">
                            <i class="bi bi-upc-scan"></i> Barcode
                        </label>
                        <input type="text" class="form-control" id="barcode" name="barcode"
                               placeholder="Enter barcode">
                    </div>
                    <div class="col-md-4">
                        <label for="sku" class="form-label">
                            <i class="bi bi-qr-code"></i> SKU
                        </label>
                        <input type="text" class="form-control" id="sku" name="sku"
                               placeholder="Enter SKU">
                    </div>
                </div>

                <!-- Inventory Management -->
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="quantityInStock" class="form-label">
                            <i class="bi bi-stack"></i> Quantity in Stock
                        </label>
                        <input type="number" class="form-control" id="quantityInStock" name="quantityInStock" value="0" min="0">
                    </div>
                    <div class="col-md-6">
                        <label for="reorderLevel" class="form-label">
                            <i class="bi bi-exclamation-triangle"></i> Reorder Level
                        </label>
                        <input type="number" class="form-control" id="reorderLevel" name="reorderLevel" value="0" min="0">
                    </div>
                </div>

                <!-- Pricing Information -->
                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="costPrice" class="form-label">
                            <i class="bi bi-currency-dollar"></i> Cost Price (Rs.)
                        </label>
                        <input type="number" class="form-control" id="costPrice" name="costPrice" value="0.00" min="0" step="0.01">
                    </div>
                    <div class="col-md-4">
                        <label for="sellingPrice" class="form-label">
                            <i class="bi bi-cash"></i> Selling Price (Rs.)
                        </label>
                        <input type="number" class="form-control" id="sellingPrice" name="sellingPrice" value="0.00" min="0" step="0.01">
                    </div>
                    <div class="col-md-4">
                        <label for="discountPercent" class="form-label">
                            <i class="bi bi-percent"></i> Discount %
                        </label>
                        <input type="number" class="form-control" id="discountPercent" name="discountPercent" value="0.00" min="0" max="100" step="0.01">
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="status" class="form-label">
                            <i class="bi bi-shield-check"></i> Status
                        </label>
                        <select class="form-select" id="status" name="status">
                            <option value="available">Available</option>
                            <option value="out_of_stock">Out of Stock</option>
                            <option value="discontinued">Discontinued</option>
                        </select>
                    </div>
                    <div class="col-md-6 d-flex align-items-end">
                        <div class="d-flex gap-2 w-100">
                            <button type="submit" class="btn btn-primary flex-grow-1" id="submitBtn">
                                <i class="bi bi-plus-circle"></i> Create Item
                            </button>
                            <button type="button" class="btn btn-secondary" id="cancelBtn"
                                    style="display:none;" onclick="cancelEdit()">
                                <i class="bi bi-x-circle"></i> Cancel
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Search Section -->
    <div class="search-section">
        <div class="search-title">
            <i class="bi bi-search"></i> Search Items
        </div>
        <div class="row g-3">
            <div class="col-md-8">
                <form action="searchItem" method="post" id="searchForm" class="d-flex">
                    <input type="text" name="searchTerm" id="searchInput" class="form-control form-control-lg me-2"
                           placeholder="Search by name, category, brand, or SKU..."
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
                    Found <strong><%= itemList.size() %></strong> item(s) for "<%= searchTerm %>"
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
                        <i class="bi bi-graph-up"></i> Item Statistics
                    </h6>
                    <div class="stats-card">
                        <div class="stats-number"><%= itemList != null ? itemList.size() : 0 %></div>
                        <div class="stats-label">Total Items</div>
                    </div>
                    <%
                        int availableCount = 0;
                        int outOfStockCount = 0;
                        int discontinuedCount = 0;
                        if (itemList != null) {
                            for (Item item : itemList) {
                                if ("available".equals(item.getStatus())) availableCount++;
                                else if ("out_of_stock".equals(item.getStatus())) outOfStockCount++;
                                else if ("discontinued".equals(item.getStatus())) discontinuedCount++;
                            }
                        }
                    %>
                    <div class="row">
                        <div class="col-4">
                            <div class="stats-card">
                                <div class="stats-number text-success"><%= availableCount %></div>
                                <div class="stats-label">Available</div>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="stats-card">
                                <div class="stats-number text-warning"><%= outOfStockCount %></div>
                                <div class="stats-label">Out of Stock</div>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="stats-card">
                                <div class="stats-number text-secondary"><%= discontinuedCount %></div>
                                <div class="stats-label">Discontinued</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Item List Section -->
        <div class="col-md-9">
            <div class="card">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h5 class="card-title mb-0">
                            <i class="bi bi-list-check"></i> Item Inventory
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
                                <th><i class="bi bi-box"></i> Name</th>
                                <th><i class="bi bi-tags"></i> Category</th>
                                <th><i class="bi bi-award"></i> Brand</th>
                                <th><i class="bi bi-stack"></i> Stock</th>
                                <th><i class="bi bi-cash"></i> Price</th>
                                <th><i class="bi bi-percent"></i> Discount</th>
                                <th><i class="bi bi-shield-check"></i> Status</th>
                                <th><i class="bi bi-gear"></i> Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <% if (itemList != null && !itemList.isEmpty()) {
                                for (Item item : itemList) {
                                    // Escape values for HTML attributes
                                    String escName = item.getName() == null ? "" : item.getName().replace("&", "&amp;").replace("\"", "&quot;").replace("'", "&#39;").replace("<", "&lt;").replace(">", "&gt;");
                                    String escDescription = item.getDescription() == null ? "" : item.getDescription().replace("&", "&amp;").replace("\"", "&quot;").replace("'", "&#39;").replace("<", "&lt;").replace(">", "&gt;");
                                    String escCategory = item.getCategory() == null ? "" : item.getCategory().replace("&", "&amp;").replace("\"", "&quot;").replace("'", "&#39;").replace("<", "&lt;").replace(">", "&gt;");
                                    String escBrand = item.getBrand() == null ? "" : item.getBrand().replace("&", "&amp;").replace("\"", "&quot;").replace("'", "&#39;").replace("<", "&lt;").replace(">", "&gt;");
                                    String escSize = item.getSize() == null ? "" : item.getSize().replace("&", "&amp;").replace("\"", "&quot;").replace("'", "&#39;").replace("<", "&lt;").replace(">", "&gt;");
                                    String escColor = item.getColor() == null ? "" : item.getColor().replace("&", "&amp;").replace("\"", "&quot;").replace("'", "&#39;").replace("<", "&lt;").replace(">", "&gt;");
                                    String escMaterial = item.getMaterial() == null ? "" : item.getMaterial().replace("&", "&amp;").replace("\"", "&quot;").replace("'", "&#39;").replace("<", "&lt;").replace(">", "&gt;");
                                    String escUnitType = item.getUnitType() == null ? "" : item.getUnitType().replace("&", "&amp;").replace("\"", "&quot;").replace("'", "&#39;").replace("<", "&lt;").replace(">", "&gt;");
                                    String escBarcode = item.getBarcode() == null ? "" : item.getBarcode().replace("&", "&amp;").replace("\"", "&quot;").replace("'", "&#39;").replace("<", "&lt;").replace(">", "&gt;");
                                    String escSku = item.getSku() == null ? "" : item.getSku().replace("&", "&amp;").replace("\"", "&quot;").replace("'", "&#39;").replace("<", "&lt;").replace(">", "&gt;");
                                    String escStatus = item.getStatus() == null ? "" : item.getStatus().replace("&", "&amp;").replace("\"", "&quot;").replace("'", "&#39;").replace("<", "&lt;").replace(">", "&gt;");

                                    // Highlight search term in name if searching
                                    String displayName = escName;
                                    if (searchTerm != null && !searchTerm.isEmpty() && escName.toLowerCase().contains(searchTerm.toLowerCase())) {
                                        displayName = escName.replaceAll("(?i)(" + searchTerm + ")", "<span class='highlight'>$1</span>");
                                    }
                            %>
                            <tr class="item-row">
                                <td><span class="badge bg-secondary">#<%= item.getProductId() %></span></td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <i class="bi bi-box me-2 text-primary"></i>
                                        <div>
                                            <div><%= displayName %></div>
                                            <% if (escDescription != null && !escDescription.isEmpty()) { %>
                                            <small class="text-muted"><%= escDescription.length() > 30 ? escDescription.substring(0, 30) + "..." : escDescription %></small>
                                            <% } %>
                                        </div>
                                    </div>
                                </td>
                                <td class="compact-cell"><%= escCategory %></td>
                                <td class="compact-cell"><%= escBrand %></td>
                                <td class="compact-cell">
                                    <% if (item.getQuantityInStock() <= item.getReorderLevel() && item.getQuantityInStock() > 0) { %>
                                    <span class="badge bg-warning"><%= item.getQuantityInStock() %></span>
                                    <% } else if (item.getQuantityInStock() == 0) { %>
                                    <span class="badge bg-danger"><%= item.getQuantityInStock() %></span>
                                    <% } else { %>
                                    <span class="badge bg-success"><%= item.getQuantityInStock() %></span>
                                    <% } %>
                                </td>
                                <td class="compact-cell">Rs. <%= item.getSellingPrice() != null ? item.getSellingPrice() : "0.00" %></td>
                                <td class="compact-cell"><%= item.getDiscountPercent() != null ? item.getDiscountPercent() : "0.00" %>%</td>
                                <td>
                                    <% if ("available".equals(escStatus)) { %>
                                    <span class="badge bg-success status-badge">
                                        <i class="bi bi-check-circle"></i> Available
                                    </span>
                                    <% } else if ("out_of_stock".equals(escStatus)) { %>
                                    <span class="badge bg-warning status-badge">
                                        <i class="bi bi-exclamation-triangle"></i> Out of Stock
                                    </span>
                                    <% } else { %>
                                    <span class="badge bg-secondary status-badge">
                                        <i class="bi bi-x-circle"></i> Discontinued
                                    </span>
                                    <% } %>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn btn-warning btn-sm" title="Edit Item"
                                                data-id="<%= item.getProductId() %>"
                                                data-name="<%= escName %>"
                                                data-description="<%= escDescription %>"
                                                data-category="<%= escCategory %>"
                                                data-brand="<%= escBrand %>"
                                                data-size="<%= escSize %>"
                                                data-pages="<%= item.getPages() %>"
                                                data-color="<%= escColor %>"
                                                data-material="<%= escMaterial %>"
                                                data-unittype="<%= escUnitType %>"
                                                data-barcode="<%= escBarcode %>"
                                                data-sku="<%= escSku %>"
                                                data-quantity="<%= item.getQuantityInStock() %>"
                                                data-reorder="<%= item.getReorderLevel() %>"
                                                data-cost="<%= item.getCostPrice() != null ? item.getCostPrice() : "0.00" %>"
                                                data-selling="<%= item.getSellingPrice() != null ? item.getSellingPrice() : "0.00" %>"
                                                data-discount="<%= item.getDiscountPercent() != null ? item.getDiscountPercent() : "0.00" %>"
                                                data-status="<%= escStatus %>"
                                                onclick="editItemFromAttr(this)">
                                            <i class="bi bi-pencil-square"></i>
                                        </button>
                                        <button class="btn btn-danger btn-sm" title="Delete Item"
                                                onclick="deleteItem(<%= item.getProductId() %>)">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <% }
                            } else { %>
                            <tr>
                                <td colspan="9" class="text-center text-muted py-4">
                                    <i class="bi bi-box fs-1 d-block mb-2"></i>
                                    No items found.
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
    window.editItem = function (id, name, description, category, brand, size, pages, color, material, unitType, barcode, sku, quantity, reorder, cost, selling, discount, status) {
        document.getElementById('productId').value = id;
        document.getElementById('name').value = name;
        document.getElementById('description').value = description;
        document.getElementById('category').value = category;
        document.getElementById('brand').value = brand;
        document.getElementById('size').value = size;
        document.getElementById('pages').value = pages;
        document.getElementById('color').value = color;
        document.getElementById('material').value = material;
        document.getElementById('unitType').value = unitType;
        document.getElementById('barcode').value = barcode;
        document.getElementById('sku').value = sku;
        document.getElementById('quantityInStock').value = quantity;
        document.getElementById('reorderLevel').value = reorder;
        document.getElementById('costPrice').value = cost;
        document.getElementById('sellingPrice').value = selling;
        document.getElementById('discountPercent').value = discount;
        document.getElementById('status').value = status;
        document.getElementById('formTitle').innerHTML = '<i class="bi bi-pencil-square"></i> Edit Item';
        document.getElementById('submitBtn').innerHTML = '<i class="bi bi-check-circle"></i> Update Item';
        document.getElementById('submitBtn').className = 'btn btn-success flex-grow-1';
        document.getElementById('cancelBtn').style.display = 'inline-block';
        document.getElementById('itemForm').action = 'updateItem';

        // Scroll to form
        document.querySelector('.form-section').scrollIntoView({ behavior: 'smooth' });
    };

    window.editItemFromAttr = function (el) {
        window.editItem(
            el.getAttribute('data-id'),
            el.getAttribute('data-name'),
            el.getAttribute('data-description'),
            el.getAttribute('data-category'),
            el.getAttribute('data-brand'),
            el.getAttribute('data-size'),
            el.getAttribute('data-pages'),
            el.getAttribute('data-color'),
            el.getAttribute('data-material'),
            el.getAttribute('data-unittype'),
            el.getAttribute('data-barcode'),
            el.getAttribute('data-sku'),
            el.getAttribute('data-quantity'),
            el.getAttribute('data-reorder'),
            el.getAttribute('data-cost'),
            el.getAttribute('data-selling'),
            el.getAttribute('data-discount'),
            el.getAttribute('data-status')
        );
    };

    window.cancelEdit = function () {
        document.getElementById('productId').value = '';
        document.getElementById('name').value = '';
        document.getElementById('description').value = '';
        document.getElementById('category').value = '';
        document.getElementById('brand').value = '';
        document.getElementById('size').value = '';
        document.getElementById('pages').value = '0';
        document.getElementById('color').value = '';
        document.getElementById('material').value = '';
        document.getElementById('unitType').value = '';
        document.getElementById('barcode').value = '';
        document.getElementById('sku').value = '';
        document.getElementById('quantityInStock').value = '0';
        document.getElementById('reorderLevel').value = '0';
        document.getElementById('costPrice').value = '0.00';
        document.getElementById('sellingPrice').value = '0.00';
        document.getElementById('discountPercent').value = '0.00';
        document.getElementById('status').value = 'available';
        document.getElementById('formTitle').innerHTML = '<i class="bi bi-plus-circle"></i> Create New Item';
        document.getElementById('submitBtn').innerHTML = '<i class="bi bi-plus-circle"></i> Create Item';
        document.getElementById('submitBtn').className = 'btn btn-primary flex-grow-1';
        document.getElementById('cancelBtn').style.display = 'none';
        document.getElementById('itemForm').action = 'createItem';
    };

    window.deleteItem = function (productId) {
        if (confirm('Are you sure you want to delete this item? This action cannot be undone.')) {
            window.location.href = 'deleteItem?productId=' + productId;
        }
    };

    window.clearSearch = function () {
        window.location.href = 'itemPage.jsp';
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