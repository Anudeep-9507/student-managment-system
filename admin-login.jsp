<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - VCE College</title>
    <style>
        /* Page styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .auth-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
        }

        .auth-card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            padding: 20px;
            text-align: center;
        }

        .auth-header {
            margin-bottom: 20px;
        }

        .auth-logo {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 15px;
        }

        .auth-header h2 {
            font-size: 1.5em;
            margin: 0;
            color: #333;
        }

        .auth-header p {
            color: #777;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        label {
            display: block;
            font-size: 1em;
            margin-bottom: 5px;
            color: #333;
        }

        input[type="text"], input[type="password"] {
            width: 93%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1em;
            margin-top: 5px;
        }

        .auth-button {
            width: 100%;
            padding: 10px;
            background-color: #6f4f29;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 1em;
            cursor: pointer;
        }

        .auth-footer {
            margin-top: 15px;
        }

        .auth-footer a {
            font-size: 0.9em;
            color: #6f4f29;
            text-decoration: none;
            display: block;
        }

        .auth-footer a:hover {
            text-decoration: underline;
        }

        /* Toast notification styles */
        .toast {
            visibility: hidden;
            max-width: 300px;
            margin: 0 auto;
            background-color: #f44336;
            color: #fff;
            text-align: center;
            border-radius: 4px;
            padding: 10px;
            position: fixed;
            z-index: 1000;
            left: 50%;
            bottom: 30px;
            font-size: 1em;
            transform: translateX(-50%);
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }

        .toast.show {
            visibility: visible;
            animation: fadeInOut 3s ease-in-out;
        }

        @keyframes fadeInOut {
            0%, 100% {
                opacity: 0;
                transform: translateX(-50%) translateY(30px);
            }
            10%, 90% {
                opacity: 1;
                transform: translateX(-50%) translateY(0);
            }
        }
    </style>
</head>
<body>
    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <img src="https://images.unsplash.com/photo-1535982330050-f1c2fb79ff78?w=80&h=80&fit=crop" alt="College Logo" class="auth-logo">
                <h2>Admin Login</h2>
                <p>Access the administrative dashboard</p>
            </div>

            <!-- Admin Login Form -->
            <form id="adminLoginForm" class="auth-form" method="post">
                <div class="form-group">
                    <label for="adminUsername">Username</label>
                    <input type="text" id="adminUsername" name="adminUsername" required>
                </div>
                <div class="form-group">
                    <label for="adminPassword">Password</label>
                    <input type="password" id="adminPassword" name="adminPassword" required>
                </div>
                <button type="submit" class="auth-button">Login</button>
            </form>

            <div class="auth-footer">
                <a href="<%= request.getContextPath() %>/reset-password.jsp" class="forgot-password">Forgot Password?</a>
                <a href="<%= request.getContextPath() %>/index.jsp" class="back-home">Back to Home</a>
            </div>
        </div>
    </div>

    <!-- Toast Notification -->
    <div id="toast" class="toast"></div>

    <script>
        // Function to show toast notification
        function showToast(message) {
            const toast = document.getElementById('toast');
            toast.textContent = message;
            toast.classList.add('show');

            setTimeout(() => {
                toast.classList.remove('show');
            }, 3000); // Show for 3 seconds
        }
    </script>

    <% 
        // Server-side logic for login validation
        String dbUrl = "jdbc:mysql://localhost:3306/college_db"; // Change to your DB details
        String dbUser = "root"; // Your DB username
        String dbPassword = ""; // Your DB password

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String adminUsername = request.getParameter("adminUsername");
            String adminPassword = request.getParameter("adminPassword");

            if (adminUsername != null && adminPassword != null) {
                Connection connection = null;
                PreparedStatement pst = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

                    String query = "SELECT * FROM admin WHERE username = ? AND password = ?";
                    pst = connection.prepareStatement(query);
                    pst.setString(1, adminUsername);
                    pst.setString(2, adminPassword);
                    rs = pst.executeQuery();

                    if (rs.next()) {
                        response.sendRedirect("admin.jsp");
                    } else {
                        request.setAttribute("errorMessage", "Invalid username or password. Please try again.");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("errorMessage", "An error occurred. Please try again later.");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (pst != null) pst.close();
                        if (connection != null) connection.close();
                    } catch (SQLException se) {
                        se.printStackTrace();
                    }
                }
            }
        }

        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) { 
    %>
        <script>
            showToast("<%= errorMessage %>");
        </script>
    <% } %>
</body>
</html>
