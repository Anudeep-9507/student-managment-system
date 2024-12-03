<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> --%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard</title>
    <style>
        /* Basic reset and styling */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            line-height: 1.6;
            color: #333;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        header {
            background-color: #6f4f29;
            color: #fff;
            padding: 20px 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            text-align: center;
        }

        header h1 {
            font-size: 2.5rem;
            letter-spacing: 1px;
            flex-grow: 1;
        }

        .logout-btn {
            background-color: #6f4f29;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            font-size: 1.1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .logout-btn:hover {
            background-color: #8b5e3c;
        }

        .section {
            margin-top: 30px;
            padding: 30px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .section h2 {
            font-size: 1.8rem;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            font-size: 1rem;
            color: #333;
            margin-bottom: 8px;
            display: inline-block;
        }

        input, select {
            padding: 12px;
            font-size: 1rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 100%;
            box-sizing: border-box;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
        }

        table th, table td {
            padding: 12px 15px;
            text-align: left;
            border: 1px solid #ddd;
        }

        table th {
            background-color: #f4f4f4;
        }

        /* Toast Message Styles */
        #toast {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #333;
            color: #fff;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            display: none;
        }

        #toast.visible {
            display: block;
            animation: fadeInOut 4s forwards;
        }

        @keyframes fadeInOut {
            0%, 80% {
                opacity: 1;
            }
            100% {
                opacity: 0;
            }
        }
    </style>
</head>
<body>

<header>
    <h1>Student Dashboard</h1>
    <div>
        <button class="logout-btn" onclick="logout()">Logout</button>
    </div>
</header>

<div class="container">
    
    <!-- Student Details Section -->
    <div class="section" id="studentDetails">
        <h2>My Details</h2>
        <div class="form-group">
            <label for="studentName">Student Name:</label>
            <input type="text" id="studentName" name="studentName" value="<%= session.getAttribute("studentName") %>" disabled>
        </div>
        <div class="form-group">
            <label for="studentRollNo">Roll Number:</label>
            <input type="text" id="studentRollNo" name="studentRollNo" value="<%= session.getAttribute("studentRollNo") %>" disabled>
        </div>
        <div class="form-group">
            <label for="studentDepartment">Department:</label>
            <input type="text" id="studentDepartment" name="studentDepartment" value="<%= session.getAttribute("studentDepartment") %>" disabled>
        </div>
        <div class="form-group">
            <label for="studentYear">Year:</label>
            <input type="text" id="studentYear" name="studentYear" value="<%= session.getAttribute("studentYear") %>" disabled>
        </div>
    </div>

    <!-- Attendance Section -->
    <div class="section" id="attendanceDetails">
        <h2>Attendance</h2>
        <table id="attendanceTable">
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="attendance" items="${attendanceList}">
                    <tr>
                        <td>${attendance.date}</td>
                        <td>${attendance.status}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Marks Section with CGPA Only -->
    <div class="section" id="marksDetails">
        <h2>CGPA</h2>
        <div class="form-group">
            <label for="studentCGPA">Current CGPA:</label>
            <input type="text" id="studentCGPA" name="studentCGPA" value="<%= session.getAttribute("studentCGPA") %>" disabled>
        </div>
    </div>
</div>

<div id="toast">Information Loaded!</div>

<script>
    // Logout Function (Redirect to index.html)
    function logout() {
        // You can add any logout logic you want here, like clearing session storage or cookies.
        window.location.href = 'index.jsp';  // Redirect to index.jsp page
    }

    function showToast() {
        const toast = document.getElementById('toast');
        toast.classList.add('visible');
        setTimeout(() => toast.classList.remove('visible'), 4000);
    }

    // Show toast on page load
    showToast();
</script>

</body>
</html>
