<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Login - VCE College</title>
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
            width: 100%;
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


    </style>
</head>
<body class="auth-page">
    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <img src="https://images.unsplash.com/photo-1535982330050-f1c2fb79ff78?w=80&h=80&fit=crop" alt="College Logo" class="auth-logo">
                <h2>Student Login</h2>
                <p>Access your academic portal</p>
            </div>

            <!-- JSP Form -->
            <form id="studentLoginForm" class="auth-form" action="loginServlet" method="post">
                <div class="form-group">
                    <label for="rollNo">Roll Number</label>
                    <div class="input-group">
                        <i class="fas fa-id-card"></i>
                        <input type="text" id="rollNo" name="rollNo" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-group">
                        <i class="fas fa-lock"></i>
                        <input type="password" id="password" name="password" required>
                        <i class="fas fa-eye-slash toggle-password"></i>
                    </div>
                </div>

                <div class="form-group">
                    <label class="checkbox-container">
                        <input type="checkbox" id="remember">
                        <span class="checkmark"></span>
                        Remember me
                    </label>
                </div>

                <button type="submit" class="auth-button">
                    <span>Login</span>
                    <i class="fas fa-arrow-right"></i>
                </button>
            </form>

            <div class="auth-footer">
                <a href="./reset-password.jsp" class="forgot-password">Forgot Password?</a>
                <a href="./index.jsp" class="back-home">Back to Home</a>
            </div>
        </div>
    </div>

    <script>
        // Toggle password visibility
        document.querySelector('.toggle-password').addEventListener('click', function() {
            const passwordField = document.getElementById('password');
            const passwordType = passwordField.getAttribute('type');
            passwordField.setAttribute('type', passwordType === 'password' ? 'text' : 'password');
            this.classList.toggle('fa-eye');
            this.classList.toggle('fa-eye-slash');
        });

        // Handle form submission and navigate to student page after validating username and password
        document.getElementById('studentLoginForm').addEventListener('submit', function(event) {
            event.preventDefault();  // Prevent default form submission
    
            // Get username (rollNo) and password input values
            const rollNo = document.getElementById('rollNo').value;
            const password = document.getElementById('password').value;
    
            // Retrieve the stored new password from sessionStorage (if set)
            const newPassword = sessionStorage.getItem('newPassword');
    
            // Check credentials: Use newPassword if it exists
            if ((rollNo === 'student' && password === (newPassword || 'vcestudent')) ||
                (rollNo === 'student1' && password === (newPassword || 'vcestudent1'))) {
                // If valid, navigate to student.jsp (student dashboard or portal page)
                window.location.href = 'student.jsp';
            } else {
                // If invalid, show an error message
                alert('Invalid Roll Number or Password. Please try again.');
            }
        });
    </script>

</body>
</html>
