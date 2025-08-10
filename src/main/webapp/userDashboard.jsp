<%@ page import="com.pahanaedu.model.User" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"user".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cashier Dashboard - Pahana Edu Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel = "stylesheet" href="<%= request.getContextPath() %>/css/user-dashboard.css">
    <style>

    </style>
</head>
<body>
<!-- Header -->
<div class="header">
    <div class="header-content">
        <div class="logo-section">
            <div class="logo-icon">
                <i class="bi bi-cash-stack"></i>
            </div>
            <div class="logo-text">
                <h2>Cashier Terminal</h2>
            </div>
        </div>
        <div class="user-info">
            <div class="user-avatar">
                <i class="bi bi-person-check"></i>
            </div>
            <div class="user-details">
                <h6><%= user.getUsername() %></h6>
                <small><i class="bi bi-cash-coin"></i> CASHIER</small>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <!-- Welcome Section -->
    <div class="welcome-section">
        <div class="welcome-content">
            <h1 class="welcome-title">
                <i class="bi bi-person-workspace"></i> Cashier Dashboard
            </h1>
            <p class="welcome-subtitle">
                Hello <%= user.getUsername() %>! Ready to serve customers efficiently
            </p>
            <div class="cashier-badge">
                <i class="bi bi-shield-check"></i> Active Cashier Session
            </div>
        </div>
    </div>



    <!-- Dashboard Menu Grid -->
    <div class="dashboard-grid">
        <!-- Customer Management -->
        <div class="menu-section">
            <div class="menu-header">
                <div class="menu-icon customer">
                    <i class="bi bi-people"></i>
                </div>
                <h3 class="menu-title customer">Customer Section</h3>
            </div>
            <div class="menu-buttons">
                <a href="customerPage.jsp" class="btn-menu customer">
                    <i class="bi bi-person-plus-fill"></i>
                    Manage Customers
                </a>
            </div>
        </div>

        <!-- Item Management -->
        <div class="menu-section">
            <div class="menu-header">
                <div class="menu-icon inventory">
                    <i class="bi bi-box-seam"></i>
                </div>
                <h3 class="menu-title inventory">Inventory Section</h3>
            </div>
            <div class="menu-buttons">
                <a href="itemPage.jsp" class="btn-menu inventory">
                    <i class="bi bi-boxes"></i>
                    Check Stock & Items
                </a>
            </div>
        </div>

        <!-- Billing Section -->
        <div class="menu-section">
            <div class="menu-header">
                <div class="menu-icon billing">
                    <i class="bi bi-calculator"></i>
                </div>
                <h3 class="menu-title billing">Order Section</h3>
            </div>
            <div class="menu-buttons">
                <a href="billingPanel.jsp" class="btn-menu billing pulse">
                    <i class="bi bi-cart-plus"></i>
                    Create New Bill
                </a>
            </div>
        </div>

        <!-- System Tools -->
        <div class="menu-section">
            <div class="menu-header">
                <div class="menu-icon tools">
                    <i class="bi bi-tools"></i>
                </div>
                <h3 class="menu-title tools">Support Tools</h3>
            </div>
            <div class="menu-buttons">
                <a href="helpPage.jsp" class="btn-menu help">
                    <i class="bi bi-question-circle-fill"></i>
                    Get Help & Support
                </a>
                <a href="login.jsp" class="btn-menu btn-logout" onclick="return confirmLogout()">
                    <i class="bi bi-box-arrow-right"></i>
                    End Cashier Session
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
        return confirm('Are you sure you want to end your cashier session?');
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
        const billsProcessed = document.querySelector('.stat-card:nth-child(1) .stat-number');
        const totalSales = document.querySelector('.stat-card:nth-child(2) .stat-number');
        const customersServed = document.querySelector('.stat-card:nth-child(3) .stat-number');

        // Simulate real-time updates
        let currentBills = parseInt(billsProcessed.textContent);
        let currentSales = parseInt(totalSales.textContent.replace('₹', '').replace(',', ''));
        let currentCustomers = parseInt(customersServed.textContent);

        // Random updates
        if (Math.random() > 0.7) {
            billsProcessed.textContent = currentBills + 1;
            totalSales.textContent = '₹' + (currentSales + Math.floor(Math.random() * 500) + 100).toLocaleString();
            customersServed.textContent = currentCustomers + 1;

            // Flash effect for updated stats
            [billsProcessed, totalSales, customersServed].forEach(el => {
                el.style.color = '#20c997';
                el.style.transform = 'scale(1.1)';
                setTimeout(() => {
                    el.style.color = '#198754';
                    el.style.transform = 'scale(1)';
                }, 500);
            });
        }
    }

    // Update stats every 15 seconds (for demo purposes)
    setInterval(updateStats, 15000);

    // Time tracking
    function updateActiveTime() {
        const timeElement = document.querySelector('.stat-card:nth-child(4) .stat-number');
        let currentTime = parseFloat(timeElement.textContent.replace('h', ''));
        currentTime += 0.1; // Add 6 minutes every minute
        timeElement.textContent = currentTime.toFixed(1) + 'h';
    }

    // Update time every minute
    setInterval(updateActiveTime, 60000);

    // Add notification for billing button
    const billingBtn = document.querySelector('.btn-menu.billing');
    billingBtn.addEventListener('mouseenter', function() {
        this.innerHTML = '<i class="bi bi-cart-check"></i> Start New Transaction';
    });

    billingBtn.addEventListener('mouseleave', function() {
        this.innerHTML = '<i class="bi bi-cart-plus"></i> Create New Bill';
    });
</script>
</body>
</html>