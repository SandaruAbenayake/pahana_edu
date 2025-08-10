<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Pahana Edu Management System</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/login.css">
</head>
<body>

<div class="container-fluid">
    <div class="login-container">
        <div class="login-card">
            <!-- Header Section -->
            <div class="login-header">
                <div class="logo-container">
                    <div class="logo">
                        <i class="bi bi-mortarboard"></i>
                    </div>
                    <h1 class="system-title">Pahana EDU</h1>
                    <p class="system-subtitle">Management System</p>
                </div>
            </div>

            <!-- Login Form Section -->
            <div class="login-body">
                <h3 class="form-title">
                    <i class="bi bi-shield-lock"></i> Welcome Back
                </h3>

                <form id="loginForm" action="login" method="post">
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="bi bi-person-fill"></i>
                        </span>
                        <div class="form-floating">
                            <input type="text" name="username" class="form-control" id="username"
                                   placeholder="Username" required autocomplete="username"/>
                            <label for="username">Username</label>
                        </div>
                    </div>

                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="bi bi-lock-fill"></i>
                        </span>
                        <div class="form-floating">
                            <input type="password" name="password" class="form-control" id="password"
                                   placeholder="Password" required autocomplete="current-password"/>
                            <label for="password">Password</label>
                        </div>
                    </div>

                    <button type="submit" class="btn-login" id="loginBtn">
                        <div class="loading-spinner" id="loadingSpinner"></div>
                        <i class="bi bi-box-arrow-in-right" id="loginIcon"></i>
                        <span id="loginText">Sign In</span>
                    </button>
                </form>

                <!-- Error Messages -->
                <% String error = (String) request.getAttribute("error"); %>
                <% if (error != null) { %>
                <div class="alert alert-danger" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    <%= error %>
                </div>
                <% } %>
                <div class="alert alert-danger" role="alert" id="errorMessage" style="display: none;">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    <span id="errorText"></span>
                </div>

                <!-- Feature Highlights -->
                <div class="feature-highlight">
                    <h6><i class="bi bi-stars"></i> System Features</h6>
                    <div class="feature-list">
                        <div class="feature-item">
                            <i class="bi bi-people"></i>
                            <span>Customer Management</span>
                        </div>
                        <div class="feature-item">
                            <i class="bi bi-box-seam"></i>
                            <span>Inventory Control</span>
                        </div>
                        <div class="feature-item">
                            <i class="bi bi-cash-coin"></i>
                            <span>Sales Processing</span>
                        </div>
                        <div class="feature-item">
                            <i class="bi bi-graph-up"></i>
                            <span>Analytics & Reports</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Welcome Banner -->
<div class="welcome-banner">
    <div class="welcome-text">
        <i class="bi bi-star-fill me-2"></i>
        Welcome to Pahana EDU Management System - Sandaru Business Solution
        <i class="bi bi-star-fill ms-2"></i>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById('loginForm').onsubmit = function (e) {
        e.preventDefault();

        // Show loading state
        const loginBtn = document.getElementById('loginBtn');
        const loadingSpinner = document.getElementById('loadingSpinner');
        const loginIcon = document.getElementById('loginIcon');
        const loginText = document.getElementById('loginText');
        const errorMessage = document.getElementById('errorMessage');

        // Hide any existing error messages
        errorMessage.style.display = 'none';

        // Update button to loading state
        loadingSpinner.style.display = 'inline-block';
        loginIcon.style.display = 'none';
        loginText.textContent = 'Signing In...';
        loginBtn.disabled = true;

        const formData = new FormData(this);

        fetch('<%= request.getContextPath() %>/login', {
            method: 'POST',
            body: formData
        })
            .then(response => {
                console.log('Response status:', response.status);
                return response.json();
            })
            .then(data => {
                console.log('Response data:', data);
                if (data.success) {
                    // Show success state
                    loadingSpinner.style.display = 'none';
                    loginIcon.className = 'bi bi-check-circle';
                    loginIcon.style.display = 'inline';
                    loginText.textContent = 'Success! Redirecting...';
                    loginBtn.style.background = 'linear-gradient(135deg, #198754 0%, #157347 100%)';

                    console.log('Redirecting to:', data.redirect);

                    // Redirect after a short delay for better UX
                    setTimeout(() => {
                        window.location.href = data.redirect;
                    }, 1000);
                } else {
                    // Show error
                    resetLoginButton();
                    const errorText = document.getElementById('errorText');
                    errorText.textContent = data.message || 'Login failed. Please check your credentials.';
                    errorMessage.style.display = 'block';

                    // Add shake animation to form
                    const loginCard = document.querySelector('.login-card');
                    loginCard.style.animation = 'shake 0.5s ease-in-out';
                    setTimeout(() => {
                        loginCard.style.animation = 'float 6s ease-in-out infinite';
                    }, 500);
                }
            })
            .catch(error => {
                console.error('Login error:', error);
                resetLoginButton();
                const errorText = document.getElementById('errorText');
                errorText.textContent = 'Connection error. Please check your internet connection and try again.';
                errorMessage.style.display = 'block';
            });

        return false;
    };

    function resetLoginButton() {
        const loginBtn = document.getElementById('loginBtn');
        const loadingSpinner = document.getElementById('loadingSpinner');
        const loginIcon = document.getElementById('loginIcon');
        const loginText = document.getElementById('loginText');

        loadingSpinner.style.display = 'none';
        loginIcon.className = 'bi bi-box-arrow-in-right';
        loginIcon.style.display = 'inline';
        loginText.textContent = 'Sign In';
        loginBtn.disabled = false;
        loginBtn.style.background = 'linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%)';
    }

    // Add shake animation CSS
    const shakeStyle = document.createElement('style');
    shakeStyle.textContent = `
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
            20%, 40%, 60%, 80% { transform: translateX(5px); }
        }
    `;
    document.head.appendChild(shakeStyle);

    // Auto-focus username field on page load
    window.addEventListener('load', function() {
        document.getElementById('username').focus();
    });

    // Add Enter key support for better UX
    document.addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            document.getElementById('loginForm').dispatchEvent(new Event('submit'));
        }
    });
</script>

</body>
</html>