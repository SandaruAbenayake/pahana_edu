<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Help & Support</title>
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

    .hero-section {
      background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
      padding: 40px;
      border-radius: 10px;
      margin-bottom: 30px;
      text-align: center;
    }

    .hero-title {
      color: white;
      font-size: 2.5rem;
      font-weight: 700;
      margin-bottom: 15px;
    }

    .hero-subtitle {
      color: rgba(255, 255, 255, 0.9);
      font-size: 1.2rem;
      font-weight: 400;
    }

    .faq-section {
      background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
      padding: 25px;
      border-radius: 10px;
      margin-bottom: 20px;
    }

    .section-title {
      color: white;
      font-size: 1.8rem;
      font-weight: 600;
      margin-bottom: 15px;
      text-align: center;
    }

    .faq-card {
      background: #fff;
      border-radius: 10px;
      margin-bottom: 15px;
      border: none;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }

    .faq-header {
      background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
      padding: 20px;
      border-radius: 10px 10px 0 0;
      border-bottom: 1px solid #dee2e6;
    }

    .faq-question {
      color: #005cbf;
      font-size: 1.3rem;
      font-weight: 600;
      margin: 0;
      display: flex;
      align-items: center;
    }

    .faq-body {
      padding: 25px;
    }

    .faq-answer {
      color: #495057;
      line-height: 1.6;
      margin: 0;
    }

    .step-list {
      list-style: none;
      padding: 0;
      margin: 15px 0;
    }

    .step-list li {
      background: #f8f9fa;
      padding: 12px 18px;
      margin: 8px 0;
      border-radius: 8px;
      border-left: 4px solid #0d6efd;
      position: relative;
    }

    .step-number {
      background: #0d6efd;
      color: white;
      width: 25px;
      height: 25px;
      border-radius: 50%;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      font-size: 0.9rem;
      font-weight: 600;
      margin-right: 12px;
    }

    .contact-section {
      background: linear-gradient(135deg, #198754 0%, #157347 100%);
      padding: 25px;
      border-radius: 10px;
      margin-bottom: 20px;
    }

    .contact-title {
      color: white;
      font-size: 1.8rem;
      font-weight: 600;
      margin-bottom: 15px;
      text-align: center;
    }

    .contact-card {
      background: #fff;
      border-radius: 10px;
      padding: 25px;
      text-align: center;
    }

    .contact-info {
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 15px;
      padding: 15px;
      background: #f8f9fa;
      border-radius: 8px;
    }

    .contact-icon {
      font-size: 1.5rem;
      color: #0d6efd;
      margin-right: 15px;
    }

    .contact-text {
      font-size: 1.1rem;
      font-weight: 500;
      color: #495057;
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

    .btn-success {
      background: #198754;
      border: none;
    }

    .btn-success:hover {
      background: #157347;
    }

    .highlight-text {
      background: linear-gradient(135deg, #fff3cd 0%, #ffeeba 100%);
      padding: 3px 8px;
      border-radius: 4px;
      font-weight: 600;
      color: #856404;
    }

    .icon-large {
      font-size: 1.2rem;
      margin-right: 8px;
    }

    .quick-links {
      background: #fff;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }

    .quick-links h5 {
      color: #005cbf;
      margin-bottom: 15px;
      font-weight: 600;
    }

    .quick-link-item {
      display: flex;
      align-items: center;
      padding: 10px;
      margin-bottom: 8px;
      background: #f8f9fa;
      border-radius: 6px;
      text-decoration: none;
      color: #495057;
      transition: all 0.3s ease;
    }

    .quick-link-item:hover {
      background: #e9ecef;
      color: #0d6efd;
      transform: translateX(5px);
    }

    .system-info {
      background: linear-gradient(135deg, #6f42c1 0%, #5a2d91 100%);
      color: white;
      padding: 20px;
      border-radius: 10px;
      text-align: center;
      margin-bottom: 20px;
    }

    .system-info h5 {
      margin-bottom: 10px;
      font-weight: 600;
    }

    .version-badge {
      background: rgba(255, 255, 255, 0.2);
      padding: 5px 12px;
      border-radius: 15px;
      font-size: 0.9rem;
    }
  </style>
</head>
<body>

<div class="header">
  <div class="container d-flex justify-content-between align-items-center">
    <h2><i class="bi bi-question-circle"></i> Help & Support</h2>
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
  <!-- Hero Section -->
  <div class="hero-section">
    <h1 class="hero-title">
      <i class="bi bi-lightbulb"></i> System Help Center
    </h1>
    <p class="hero-subtitle">
      Find answers to common questions and get the most out of your management system
    </p>
  </div>

  <div class="row">
    <!-- FAQ Section -->
    <div class="col-lg-8">
      <div class="faq-section">
        <h3 class="section-title">
          <i class="bi bi-chat-square-quote"></i> Frequently Asked Questions
        </h3>

        <!-- FAQ Cards Container -->
        <div class="faq-container">
          <!-- FAQ 1: How to Create Customer -->
          <div class="faq-card">
            <div class="faq-header">
              <h4 class="faq-question">
                <i class="bi bi-person-plus icon-large"></i>
                How to Create a New Customer?
              </h4>
            </div>
            <div class="faq-body">
              <p class="faq-answer">
                Creating a new customer is simple and straightforward. Follow these steps:
              </p>
              <ol class="step-list">
                <li>
                  <span class="step-number">1</span>
                  Navigate to the <span class="highlight-text">Customer Management</span> page from your dashboard
                </li>
                <li>
                  <span class="step-number">2</span>
                  Fill in the customer details in the <span class="highlight-text">"Create New Customer"</span> form
                </li>
                <li>
                  <span class="step-number">3</span>
                  Required fields include: <span class="highlight-text">Full Name, Email, and Phone Number</span>
                </li>
                <li>
                  <span class="step-number">4</span>
                  Optional fields: NIC, Gender, Date of Birth, Address, and Status
                </li>
                <li>
                  <span class="step-number">5</span>
                  Click <span class="highlight-text">"Create Customer"</span> to save the new customer
                </li>
              </ol>
              <p class="faq-answer">
                <i class="bi bi-info-circle text-primary"></i>
                <strong>Tip:</strong> All customers are set to "Active" status by default.
              </p>
            </div>
          </div>

          <!-- FAQ 2: How to Create and Update Items -->
          <div class="faq-card">
            <div class="faq-header">
              <h4 class="faq-question">
                <i class="bi bi-box-seam icon-large"></i>
                How to Create and Update Items?
              </h4>
            </div>
            <div class="faq-body">
              <p class="faq-answer">
                Managing inventory items is essential for your business operations:
              </p>
              <h6 class="text-primary mt-3 mb-2">
                <i class="bi bi-plus-circle"></i> Creating New Items:
              </h6>
              <ol class="step-list">
                <li>
                  <span class="step-number">1</span>
                  Go to <span class="highlight-text">Item Management</span> from the main menu
                </li>
                <li>
                  <span class="step-number">2</span>
                  Enter item details: Name, Category, Price, and Description
                </li>
                <li>
                  <span class="step-number">3</span>
                  Set initial stock quantity and minimum stock level
                </li>
                <li>
                  <span class="step-number">4</span>
                  Choose the appropriate status and save
                </li>
              </ol>

              <h6 class="text-success mt-3 mb-2">
                <i class="bi bi-pencil-square"></i> Updating Existing Items:
              </h6>
              <ol class="step-list">
                <li>
                  <span class="step-number">1</span>
                  Find the item in the item list and click the <span class="highlight-text">Edit button</span>
                </li>
                <li>
                  <span class="step-number">2</span>
                  Modify the necessary fields (price, stock, description, etc.)
                </li>
                <li>
                  <span class="step-number">3</span>
                  Click <span class="highlight-text">"Update Item"</span> to save changes
                </li>
              </ol>
            </div>
          </div>

          <!-- FAQ 3: How to Process Sales -->
          <div class="faq-card">
            <div class="faq-header">
              <h4 class="faq-question">
                <i class="bi bi-cash-coin icon-large"></i>
                How to Process Sales and Generate Receipts?
              </h4>
            </div>
            <div class="faq-body">
              <p class="faq-answer">
                Process sales transactions quickly using the billing system:
              </p>
              <ol class="step-list">
                <li>
                  <span class="step-number">1</span>
                  Access the <span class="highlight-text">Cashier Billing</span> module from dashboard
                </li>
                <li>
                  <span class="step-number">2</span>
                  Select or create a customer for the transaction
                </li>
                <li>
                  <span class="step-number">3</span>
                  Search and add items to the cart using barcode or item search
                </li>
                <li>
                  <span class="step-number">4</span>
                  Adjust quantities and review the total amount
                </li>
                <li>
                  <span class="step-number">5</span>
                  Process payment and print the receipt
                </li>
              </ol>
              <p class="faq-answer">
                <i class="bi bi-printer text-success"></i>
                <strong>Note:</strong> Receipts are automatically generated and can be printed or emailed to customers.
              </p>
            </div>
          </div>

          <!-- FAQ 4: How to Manage User Accounts -->
          <div class="faq-card">
            <div class="faq-header">
              <h4 class="faq-question">
                <i class="bi bi-people icon-large"></i>
                How to Manage User Accounts and Permissions?
              </h4>
            </div>
            <div class="faq-body">
              <p class="faq-answer">
                <span class="highlight-text">Admin users</span> can manage system users and their access levels:
              </p>
              <ol class="step-list">
                <li>
                  <span class="step-number">1</span>
                  Navigate to <span class="highlight-text">User Management</span> (Admin only)
                </li>
                <li>
                  <span class="step-number">2</span>
                  Create new users by providing username, email, and role
                </li>
                <li>
                  <span class="step-number">3</span>
                  Assign appropriate roles: <span class="highlight-text">Admin</span> or <span class="highlight-text">User</span>
                </li>
                <li>
                  <span class="step-number">4</span>
                  Set initial passwords and account status
                </li>
                <li>
                  <span class="step-number">5</span>
                  Users can update their profiles and change passwords after login
                </li>
              </ol>
              <p class="faq-answer">
                <i class="bi bi-shield-check text-warning"></i>
                <strong>Important:</strong> Only Admin users can create, edit, or delete other user accounts.
              </p>
            </div>
          </div>

        </div>
      </div>
    </div>

    <!-- Sidebar -->
    <div class="col-lg-4">
      <!-- Quick Links -->
      <div class="quick-links">
        <h5><i class="bi bi-link-45deg"></i> Quick Links</h5>
        <a href="customerPage.jsp" class="quick-link-item">
          <i class="bi bi-people me-2"></i>
          Customer Management
        </a>
        <a href="itemPage.jsp" class="quick-link-item">
          <i class="bi bi-box-seam me-2"></i>
          Item Management
        </a>
        <a href="billingPanel.jsp" class="quick-link-item">
          <i class="bi bi-cash-coin me-2"></i>
          Cashier Billing
        </a>
        <% if ("admin".equalsIgnoreCase(role)) { %>
        <a href="userPage.jsp" class="quick-link-item">
          <i class="bi bi-person-gear me-2"></i>
          User Management
        </a>
        <% } %>
      </div>

      <!-- System Information -->
      <div class="system-info">
        <h5><i class="bi bi-info-circle"></i> System Information</h5>
        <p class="mb-2">Management System</p>
        <span class="version-badge">Version 1.0.0</span>
      </div>
    </div>
  </div>

  <!-- Contact Section -->
  <div class="contact-section">
    <h3 class="contact-title">
      <i class="bi bi-headset"></i> Need Additional Help?
    </h3>
    <div class="contact-card">
      <h5 class="text-center mb-4" style="color: #005cbf;">
        <i class="bi bi-person-badge"></i> Contact System Administrator
      </h5>

      <div class="row">
        <div class="col-md-6">
          <div class="contact-info">
            <i class="bi bi-telephone-fill contact-icon"></i>
            <div>
              <div class="contact-text">Phone Support</div>
              <div class="fw-bold text-primary">+94 77 123 4567</div>
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="contact-info">
            <i class="bi bi-envelope-fill contact-icon"></i>
            <div>
              <div class="contact-text">Email Support</div>
              <div class="fw-bold text-primary">admin@company.lk</div>
            </div>
          </div>
        </div>
      </div>

      <div class="row mt-3">
        <div class="col-md-6">
          <div class="contact-info">
            <i class="bi bi-clock-fill contact-icon"></i>
            <div>
              <div class="contact-text">Support Hours</div>
              <div class="fw-bold text-success">Mon-Fri: 9:00 AM - 6:00 PM</div>
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="contact-info">
            <i class="bi bi-geo-alt-fill contact-icon"></i>
            <div>
              <div class="contact-text">Office Location</div>
              <div class="fw-bold text-info">Colombo, Sri Lanka</div>
            </div>
          </div>
        </div>
      </div>

      <div class="text-center mt-4">
        <a href="mailto:admin@company.lk" class="btn btn-primary me-2">
          <i class="bi bi-envelope"></i> Send Email
        </a>
        <a href="tel:+94771234567" class="btn btn-success">
          <i class="bi bi-telephone"></i> Call Now
        </a>
      </div>
    </div>
  </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
  // Smooth scrolling for quick links
  document.querySelectorAll('.quick-link-item').forEach(link => {
    link.addEventListener('click', function(e) {
      // Add a small animation effect
      this.style.transform = 'translateX(10px)';
      setTimeout(() => {
        this.style.transform = 'translateX(5px)';
      }, 150);
    });
  });

  // Add some interactivity to FAQ cards
  document.querySelectorAll('.faq-card').forEach(card => {
    card.addEventListener('mouseenter', function() {
      this.style.transform = 'translateY(-2px)';
      this.style.boxShadow = '0 6px 16px rgba(0, 0, 0, 0.15)';
    });

    card.addEventListener('mouseleave', function() {
      this.style.transform = 'translateY(0)';
      this.style.boxShadow = '0 2px 8px rgba(0, 0, 0, 0.1)';
    });
  });

  // Print page functionality
  function printHelp() {
    window.print();
  }
</script>

</body>
</html>