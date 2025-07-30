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
<html>
<head>
    <title>Item Management</title>
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
        <h1>Item Management System</h1>
        <a href="userDashboard.jsp" class="back-btn">Back to Home</a>
    </div>

    <div class="container">
        <div class="form-section">
            <h2 id="formTitle">Create Item</h2>
            
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

            <form action="createItem" method="post" id="itemForm">
                <input type="hidden" name="productId" id="productId" />
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="name">Name *</label>
                        <input type="text" id="name" name="name" required />
                    </div>
                    <div class="form-group">
                        <label for="category">Category *</label>
                        <input type="text" id="category" name="category" required />
                    </div>
                    <div class="form-group">
                        <label for="brand">Brand</label>
                        <input type="text" id="brand" name="brand" />
                    </div>
                </div>

                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description"></textarea>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="size">Size</label>
                        <input type="text" id="size" name="size" />
                    </div>
                    <div class="form-group">
                        <label for="pages">Pages</label>
                        <input type="number" id="pages" name="pages" value="0" min="0" />
                    </div>
                    <div class="form-group">
                        <label for="color">Color</label>
                        <input type="text" id="color" name="color" />
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="material">Material</label>
                        <input type="text" id="material" name="material" />
                    </div>
                    <div class="form-group">
                        <label for="unitType">Unit Type</label>
                        <input type="text" id="unitType" name="unitType" />
                    </div>
                    <div class="form-group">
                        <label for="barcode">Barcode</label>
                        <input type="text" id="barcode" name="barcode" />
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="sku">SKU</label>
                        <input type="text" id="sku" name="sku" />
                    </div>
                    <div class="form-group">
                        <label for="quantityInStock">Quantity in Stock</label>
                        <input type="number" id="quantityInStock" name="quantityInStock" value="0" min="0" />
                    </div>
                    <div class="form-group">
                        <label for="reorderLevel">Reorder Level</label>
                        <input type="number" id="reorderLevel" name="reorderLevel" value="0" min="0" />
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="costPrice">Cost Price</label>
                        <input type="number" id="costPrice" name="costPrice" value="0.00" min="0" step="0.01" />
                    </div>
                    <div class="form-group">
                        <label for="sellingPrice">Selling Price</label>
                        <input type="number" id="sellingPrice" name="sellingPrice" value="0.00" min="0" step="0.01" />
                    </div>
                    <div class="form-group">
                        <label for="discountPercent">Discount %</label>
                        <input type="number" id="discountPercent" name="discountPercent" value="0.00" min="0" max="100" step="0.01" />
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="status">Status</label>
                        <select id="status" name="status">
                            <option value="available">Available</option>
                            <option value="out_of_stock">Out of Stock</option>
                            <option value="discontinued">Discontinued</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn" id="submitBtn">Create Item</button>
                        <button type="button" class="btn btn-secondary" id="cancelBtn" style="display:none;" onclick="cancelEdit()">Cancel</button>
                    </div>
                </div>
            </form>
        </div>

        <div class="search-section">
            <div class="search-content">
                <div class="search-title">🔍 Search Items</div>
                <div class="search-subtitle">Find items quickly by name, category, or brand</div>
                
                <form action="searchItem" method="post" id="searchForm" class="search-form">
                    <input type="text" name="searchTerm" id="searchInput" class="search-input" 
                           placeholder="Type to search items..." 
                           value="<%= searchTerm != null ? searchTerm : "" %>" />
                    <button type="submit" class="search-btn">Search</button>
                </form>
                
                <% if (searchTerm != null && !searchTerm.isEmpty()) { %>
                    <button type="button" class="clear-btn" onclick="clearSearch()">Clear Search</button>
                <% } %>
                
                <% if (searchTerm != null && !searchTerm.isEmpty()) { %>
                    <div class="search-results-info">
                        Found <strong><%= itemList.size() %></strong> item(s) for <strong><%= searchTerm %></strong>
                    </div>
                <% } %>
            </div>
        </div>

        <div class="table-section">
            <h2>Item List - Full Details</h2>
            <table class="compact-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Category</th>
                        <th>Brand</th>
                        <th>Size</th>
                        <th>Pages</th>
                        <th>Color</th>
                        <th>Material</th>
                        <th>Unit Type</th>
                        <th>Barcode</th>
                        <th>SKU</th>
                        <th>Stock</th>
                        <th>Reorder</th>
                        <th>Cost</th>
                        <th>Price</th>
                        <th>Discount</th>
                        <th>Status</th>
                        <th>Added Date</th>
                        <th>Updated</th>
                        <th>Action</th>
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
                    <tr>
                        <td><%= item.getProductId() %></td>
                        <td><%= displayName %></td>
                        <td><%= escDescription %></td>
                        <td><%= escCategory %></td>
                        <td><%= escBrand %></td>
                        <td><%= escSize %></td>
                        <td><%= item.getPages() %></td>
                        <td><%= escColor %></td>
                        <td><%= escMaterial %></td>
                        <td><%= escUnitType %></td>
                        <td><%= escBarcode %></td>
                        <td><%= escSku %></td>
                        <td><%= item.getQuantityInStock() %></td>
                        <td><%= item.getReorderLevel() %></td>
                        <td><%= item.getCostPrice() != null ? item.getCostPrice() : "0.00" %></td>
                        <td><%= item.getSellingPrice() != null ? item.getSellingPrice() : "0.00" %></td>
                        <td><%= item.getDiscountPercent() != null ? item.getDiscountPercent() : "0.00" %></td>
                        <td><%= escStatus %></td>
                        <td><%= item.getAddedDate() != null ? item.getAddedDate().toString().substring(0, 16) : "" %></td>
                        <td><%= item.getUpdatedAt() != null ? item.getUpdatedAt().toString().substring(0, 16) : "" %></td>
                        <td>
                            <span class="icon edit" title="Edit"
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
                                onclick="editItemFromAttr(this)">✏️</span>
                            <span class="icon delete" title="Delete" onclick="deleteItem(<%= item.getProductId() %>)">🗑️</span>
                        </td>
                    </tr>
                <%   }
                   } else { %>
                    <tr><td colspan="21">No items found.</td></tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>

<script>
    // Ensure functions are available globally
    window.editItem = function(id, name, description, category, brand, size, pages, color, material, unitType, barcode, sku, quantity, reorder, cost, selling, discount, status) {
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
        document.getElementById('formTitle').innerText = 'Edit Item';
        document.getElementById('submitBtn').innerText = 'Update Item';
        document.getElementById('cancelBtn').style.display = 'inline-block';
        document.getElementById('itemForm').action = 'updateItem';
    };

    window.editItemFromAttr = function(el) {
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

    window.cancelEdit = function() {
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
        document.getElementById('formTitle').innerText = 'Create Item';
        document.getElementById('submitBtn').innerText = 'Create Item';
        document.getElementById('cancelBtn').style.display = 'none';
        document.getElementById('itemForm').action = 'createItem';
    };

    window.deleteItem = function(productId) {
        if (confirm('Are you sure you want to delete this item?')) {
            window.location.href = 'deleteItem?productId=' + productId;
        }
    };

    window.clearSearch = function() {
        window.location.href = 'itemPage.jsp';
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