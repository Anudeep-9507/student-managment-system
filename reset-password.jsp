<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password - VCE College</title>
    <style>
        /* Global Styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .auth-page {
            background-color: #f4f4f9;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .auth-container {
            width: 100%;
            max-width: 450px;
            padding: 30px;
            background-color: #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .auth-header {
            text-align: center;
        }

        .auth-logo {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 50%;
            margin-bottom: 20px;
        }

        .auth-header h2 {
            font-size: 24px;
            margin: 0;
            color: #333;
        }

        .auth-header p {
            font-size: 16px;
            color: #666;
        }

        /* Form Styles */
        .auth-form {
            margin-top: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-size: 14px;
            color: #333;
            margin-bottom: 5px;
        }

        .input-group {
            display: flex;
            align-items: center;
            border: 1px solid #ddd;
            padding: 10px;
            border-radius: 5px;
        }

        .input-group i {
            color: #888;
            margin-right: 10px;
        }

        .input-group input {
            width: 100%;
            border: none;
            outline: none;
            padding: 8px;
            font-size: 14px;
            color: #333;
        }

        .checkbox-container {
            display: flex;
            align-items: center;
        }

        .checkbox-container input {
            margin-right: 10px;
        }

        .checkmark {
            width: 16px;
            height: 16px;
            border: 2px solid #888;
            border-radius: 3px;
            display: inline-block;
        }

        .auth-button {
            width: 100%;
            padding: 10px;
            background-color: #6f4f29;
            color: #fff;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .auth-button i {
            margin-left: 10px;
        }

        .auth-footer {
            margin-top: 20px;
            text-align: center;
        }

        .auth-footer a {
            font-size: 14px;
            color: #6f4f29;
            text-decoration: none;
        }

        .auth-footer a:hover {
            text-decoration: underline;
        }

        /* Media Queries */
        @media (max-width: 480px) {
            .auth-container {
                padding: 20px;
            }

            .auth-header h2 {
                font-size: 20px;
            }

            .auth-header p {
                font-size: 14px;
            }
        }
    </style>
</head>
<body class="auth-page">
    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <img src="https://images.unsplash.com/photo-1535982330050-f1c2fb79ff78?w=80&h=80&fit=crop" alt="College Logo" class="auth-logo">
                <h2>Reset Password</h2>
                <p>Enter your username and reset key to change your password</p>
            </div>

            <form id="resetPasswordForm" class="auth-form" method="post" action="resetPasswordAction.jsp">
                <!-- Added Username Field -->
                <div class="form-group">
                    <label for="username">Username</label>
                    <div class="input-group">
                        <i class="fas fa-user"></i>
                        <input type="text" id="username" name="username" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="resetKey">Reset Key</label>
                    <div class="input-group">
                        <i class="fas fa-key"></i>
                        <input type="text" id="resetKey" name="resetKey" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="newPassword">New Password</label>
                    <div class="input-group">
                        <i class="fas fa-lock"></i>
                        <input type="password" id="newPassword" name="newPassword" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Confirm New Password</label>
                    <div class="input-group">
                        <i class="fas fa-lock"></i>
                        <input type="password" id="confirmPassword" name="confirmPassword" required>
                    </div>
                </div>

                <button type="submit" class="auth-button">
                    <span>Reset Password</span>
                    <i class="fas fa-arrow-right"></i>
                </button>
            </form>

            <div class="auth-footer">
                <a href="faculty-login.jsp" class="back-home">Back to Login</a>
            </div>
        </div>
    </div>
</body>
</html>
