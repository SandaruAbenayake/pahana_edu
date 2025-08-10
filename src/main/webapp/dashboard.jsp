<%@ page import="com.pahanaedu.model.User" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Pahana Edu Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel = "stylesheet" href="css/dashboard.css">
</head>
<body>
<!-- Header -->
<div class="header">
    <div class="header-content">
        <div class="logo-section">
            <div class="logo-icon">
                <i class="bi bi-mortarboard"></i>
            </div>
            <div class="logo-text">
                <h2>Pahana Edu Management</h2>
            </div>
        </div>
        <div class="user-info">
            <div class="user-avatar">
                <i class="bi bi-person-circle"></i>
            </div>
            <div class="user-details">
                <h6><%= user.getUsername() %></h6>
                <small><i class="bi bi-shield-check"></i> <%= user.getRole().toUpperCase() %></small>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <!-- Welcome Section -->
    <div class="welcome-section">
        <div class="welcome-content">
            <h1 class="welcome-title">
                <i class="bi bi-speedometer2"></i> Admin Dashboard
            </h1>
            <p class="welcome-subtitle">
                Welcome back, <%= user.getUsername() %>! Manage your educational system efficiently
            </p>
        </div>
    </div>

    <!-- Dashboard Menu Grid -->
    <div class="dashboard-grid">
        <!-- Customer Management -->
        <div class="menu-section">
            <div class="menu-header">
                <div class="menu-icon">
                    <i class="bi bi-people"></i>
                </div>
                <h3 class="menu-title">Customer Management</h3>
            </div>
            <div class="menu-buttons">
                <a href="customerPage.jsp" class="btn-menu">
                    <i class="bi bi-person-plus"></i>
                    Manage Customers
                </a>
            </div>
        </div>

        <!-- Item Management -->
        <div class="menu-section">
            <div class="menu-header">
                <div class="menu-icon">
                    <i class="bi bi-box-seam"></i>
                </div>
                <h3 class="menu-title">Inventory Management</h3>
            </div>
            <div class="menu-buttons">
                <a href="itemPage.jsp" class="btn-menu">
                    <i class="bi bi-boxes"></i>
                    Manage Items & Stock
                </a>
            </div>
        </div>

        <!-- Billing & Purchase -->
        <div class="menu-section">
            <div class="menu-header">
                <div class="menu-icon">
                    <i class="bi bi-cash-coin"></i>
                </div>
                <h3 class="menu-title">Billing & Sales</h3>
            </div>
            <div class="menu-buttons">
                <a href="billingPanel.jsp" class="btn-menu">
                    <i class="bi bi-calculator"></i>
                    Create New Bill
                </a>
                <a href="billlist.jsp" class="btn-menu">
                    <i class="bi bi-receipt"></i>
                    View All Purchases
                </a>
            </div>
        </div>

        <!-- User Management -->
        <div class="menu-section">
            <div class="menu-header">
                <div class="menu-icon">
                    <i class="bi bi-person-gear"></i>
                </div>
                <h3 class="menu-title">User Administration</h3>
            </div>
            <div class="menu-buttons">
                <a href="userPage.jsp" class="btn-menu">
                    <i class="bi bi-people-fill"></i>
                    Manage System Users
                </a>
            </div>
        </div>

        <!-- System Tools -->
        <div class="menu-section">
            <div class="menu-header">
                <div class="menu-icon">
                    <i class="bi bi-tools"></i>
                </div>
                <h3 class="menu-title">System Tools</h3>
            </div>
            <div class="menu-buttons">
                <a href="helpPage.jsp" class="btn-menu btn-help">
                    <i class="bi bi-question-circle"></i>
                    Help & Support
                </a>
                <a href="login.jsp" class="btn-menu btn-logout" onclick="return confirmLogout()">
                    <i class="bi bi-box-arrow-right"></i>
                    Logout
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Quick Actions -->
<div class="quick-actions">
    <a href="billingPanel.jsp" class="quick-action-btn" title="Quick Billing">
        <i class="bi bi-plus-lg"></i>
    </a>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Confirm logout
    function confirmLogout() {
        return confirm('Are you sure you want to logout?');
    }

    // Add hover effects for menu sections
    document.querySelectorAll('.menu-section').forEach(section => {
        section.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-8px)';
            this.style.boxShadow = '0 12px 30px rgba(0, 0, 0, 0.15)';
        });

        section.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(-5px)';
            this.style.boxShadow = '0 8px 25px rgba(0, 0, 0, 0.12)';
        });
    });

    // Add click effect for buttons
    document.querySelectorAll('.btn-menu').forEach(btn => {
        btn.addEventListener('click', function(e) {
            // Create ripple effect
            const ripple = document.createElement('span');
            const rect = this.getBoundingClientRect();
            const size = Math.max(rect.height, rect.width);
            const x = e.clientX - rect.left - size / 2;
            const y = e.clientY - rect.top - size / 2;

            ripple.style.width = ripple.style.height = size + 'px';
            ripple.style.left = x + 'px';
            ripple.style.top = y + 'px';
            ripple.classList.add('ripple');

            this.appendChild(ripple);

            setTimeout(() => {
                ripple.remove();
            }, 600);
        });
    });

    // Add ripple effect styles
    const style = document.createElement('style');
    style.textContent = `
            .btn-menu {
                position: relative;
                overflow: hidden;
            }

            .ripple {
                position: absolute;
                border-radius: 50%;
                background: rgba(255, 255, 255, 0.4);
                transform: scale(0);
                animation: ripple 0.6s linear;
                pointer-events: none;
            }

            @keyframes ripple {
                to {
                    transform: scale(4);
                    opacity: 0;
                }
            }
        `;
    document.head.appendChild(style);

    // Auto-update stats (simulated)
    function updateStats() {
        const statNumbers = document.querySelectorAll('.stat-number');
        statNumbers.forEach(stat => {
            if (stat.textContent.includes('₹')) return; // Skip currency
            const currentValue = parseInt(stat.textContent);
            const change = Math.random() > 0.5 ? 1 : -1;
            const newValue = Math.max(0, currentValue + change);
            stat.textContent = newValue;
        });
    }

    // Update stats every 30 seconds (for demo purposes)
    setInterval(updateStats, 30000);
</script>
</body>
</html>