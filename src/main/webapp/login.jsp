<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Pahana Edu</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .logo {
            display: block;
            max-width: 120px;
            margin: 0 auto 20px;
        }
    </style>
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow">
                <div class="card-body">


                    <h3 class="card-title text-center mb-4">Login to Pahana Edu</h3>

                    <form id="loginForm" action="login" method="post">
                        <div class="mb-3">
                            <label class="form-label">Username:</label>
                            <input type="text" name="username" class="form-control" required />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Password:</label>
                            <input type="password" name="password" class="form-control" required />
                        </div>
                        <div class="d-grid">
                            <input type="submit" value="Login" class="btn btn-primary" />
                        </div>
                    </form>

                    <% String error = (String) request.getAttribute("error"); %>
                    <% if (error != null) { %>
                    <div class="alert alert-danger mt-3" role="alert">
                        <%= error %>
                    </div>
                    <% } %>
                    <div class="alert alert-danger mt-3" role="alert" id="errorMessage" style="display: none;">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <marquee behavior="scroll" direction="left" class="mt-4 text-primary fs-5 fw-semibold">
        Welcome to Pahana EDU!
    </marquee>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById('loginForm').onsubmit = function(e) {
        e.preventDefault();

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
                // Store user data in localStorage
                // localStorage.setItem('userData', JSON.stringify(data.user)); // Removed, now using session
                console.log('Redirecting to:', data.redirect);

                // Force a hard redirect
                window.location.href = data.redirect;
            } else {
                const errorDiv = document.getElementById('errorMessage');
                errorDiv.textContent = data.message || 'Login failed';
                errorDiv.style.display = 'block';
            }
        })
        .catch(error => {
            console.error('Login error:', error);
            const errorDiv = document.getElementById('errorMessage');
            errorDiv.textContent = 'An error occurred during login';
            errorDiv.style.display = 'block';
        });

        return false;
    };
</script>
</body>
</html>
