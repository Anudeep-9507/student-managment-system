<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Login - VCE College</title>
    <style>
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

        .input-group {
            display: flex;
            align-items: center;
            position: relative;
        }

        input[type="text"], input[type="password"] {
            width: 93%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1em;
            margin-top: 5px;
        }

        .input-group i {
            position: absolute;
            left: 10px;
            color: #888;
        }

        .toggle-password {
            position: absolute;
            right: 10px;
            cursor: pointer;
            color: #888;
        }

        .checkbox-container {
            display: flex;
            align-items: center;
            font-size: 1em;
            color: #333;
        }

        .checkbox-container input {
            margin-right: 10px;
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

        .auth-button i {
            margin-left: 10px;
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

        .auth-footer .back-home {
            margin-top: 10px;
        }

        /* Toast styles */
        .toast {
            visibility: hidden;
            max-width: 300px;
            margin: 0 auto;
            position: fixed;
            left: 50%;
            bottom: 30px;
            transform: translateX(-50%);
            background-color: #f44336;
            color: white;
            text-align: center;
            border-radius: 5px;
            padding: 10px 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
            font-size: 1em;
            z-index: 1000;
            animation: fadeInOut 4s;
        }

        @keyframes fadeInOut {
            0%, 100% {
                opacity: 0;
                transform: translateX(-50%) translateY(20px);
            }
            10%, 90% {
                opacity: 1;
                transform: translateX(-50%) translateY(0);
            }
        }

        .show-toast {
            visibility: visible;
        }

    </style>
</head>
<body class="auth-page">
    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <img src="https://images.unsplash.com/photo-1535982330050-f1c2fb79ff78?w=80&h=80&fit=crop" alt="College Logo" class="auth-logo">
                <h2>Faculty Login</h2>
                <p>Access your teaching portal</p>
            </div>

            <!-- Display error message if login fails -->
            <%
                String message = "";
                String facultyId = request.getParameter("facultyId");
                String password = request.getParameter("password");

                if (facultyId != null && password != null) {
                    // Database connection details
                    String dbURL = "jdbc:mysql://localhost:3306/college_db";
                    String dbUsername = "root";  // Use your actual username
                    String dbPassword = "";  // Use your actual password

                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;

                    try {
                        // Establish the database connection
                        conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

                        // SQL query to check if the faculty exists
                        String sql = "SELECT * FROM faculty WHERE username = ? AND password = ?";

                        stmt = conn.prepareStatement(sql);
                        stmt.setString(1, facultyId);
                        stmt.setString(2, password);

                        // Execute the query
                        rs = stmt.executeQuery();

                        if (rs.next()) {
                            // Login successful, redirect to the faculty dashboard
                            response.sendRedirect("faculty.jsp");
                        } else {
                            // Login failed
                            message = "Invalid Faculty ID or Password";
                        }

                    } catch (SQLException e) {
                        e.printStackTrace();
                        message = "An error occurred. Please try again.";
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            %>

            <!-- Form -->
            <form id="facultyLoginForm" method="POST" class="auth-form">
                <div class="form-group">
                    <label for="facultyId">Faculty ID</label>
                    <input type="text" id="facultyId" name="facultyId" required>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                </div>

                <button type="submit" class="auth-button">
                    Login
                </button>
            </form>

            <div class="auth-footer">
                <a href="./reset-password.jsp" class="forgot-password">Forgot Password?</a>
                <a href="./index.jsp" class="back-home">Back to Home</a>
            </div>
        </div>
    </div>

    <!-- Toast message -->
    <div id="toast" class="toast"><%= message %></div>

    <script>
        // Show toast if the message is not empty
        const message = "<%= message %>";
        if (message.trim() !== "") {
            const toast = document.getElementById("toast");
            toast.classList.add("show-toast");

            // Hide toast after 4 seconds
            setTimeout(() => {
                toast.classList.remove("show-toast");
            }, 4000);
        }
    </script>
</body>
</html>