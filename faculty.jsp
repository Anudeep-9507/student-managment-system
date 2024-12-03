<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.jsp.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Dashboard</title>
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

        /* Navbar */
        nav {
            background-color: #333;
            overflow: hidden;
        }

        nav a {
            float: left;
            display: block;
            color: #fff;
            padding: 14px 20px;
            text-align: center;
            text-decoration: none;
        }

        nav a:hover {
            background-color: #ddd;
            color: black;
        }

        /* Section styling */
        .section {
            margin-top: 30px;
            padding: 30px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: none; /* Hide all sections by default */
        }

        .section.active {
            display: block; /* Show only the active section */
        }

        .section h2, .section h3 {
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

        .button {
            background-color: #6f4f29;
            color: white;
            padding: 14px 20px;
            border: none;
            border-radius: 5px;
            font-size: 1.1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
            width: 100%;
        }

        .button:hover {
            background-color: #8b5e3c;
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

        .delete-btn {
            background-color: #e74c3c;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .delete-btn:hover {
            background-color: #c0392b;
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

        .hidden {
            display: none;
        }
    </style>
</head>
<body>

<header>
    <h1>Faculty Dashboard</h1>
    <div>
        <button class="logout-btn" onclick="logout()">Logout</button>
    </div>
</header>

<nav>
    <a href="#" onclick="showSection('myDetails')">My Details</a>
    <a href="#" onclick="showSection('postMarks')">Post Marks</a>
    <a href="#" onclick="showSection('postAttendance')">Post Attendance</a>
    <a href="#" onclick="showSection('attendanceDetails')">Attendance Details</a>
    <a href="#" onclick="showSection('marksDetails')">Marks Details</a>
</nav>

<div class="container">

    <!-- My Details Section -->
    <div class="section" id="myDetails">
        <h2>My Details</h2>
        <div class="form-group">
            <label for="facultyID">Faculty ID:</label>
            <input type="text" id="facultyID" name="facultyID" value="<%= request.getAttribute("facultyID") != null ? request.getAttribute("facultyID") : "" %>" disabled>
        </div>
        <div class="form-group">
            <label for="facultyName">Faculty Name:</label>
            <input type="text" id="facultyName" name="facultyName" value="<%= request.getAttribute("facultyName") != null ? request.getAttribute("facultyName") : "" %>" disabled>
        </div>
        <div class="form-group">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>" disabled>
        </div>
        <div class="form-group">
            <label for="qualification">Qualification:</label>
            <input type="text" id="qualification" name="qualification" value="<%= request.getAttribute("qualification") != null ? request.getAttribute("qualification") : "" %>" disabled>
        </div>
        <div class="form-group">
            <label for="experience">Experience (years):</label>
            <input type="number" id="experience" name="experience" value="<%= request.getAttribute("experience") != null ? request.getAttribute("experience") : "" %>" disabled>
        </div>
    </div>

    <!-- Post Attendance Section -->
    <div class="section" id="postAttendance">
        <h3>Post Attendance</h3>
        <form id="attendanceForm" action="postAttendance.jsp" method="post">
            <div class="form-group">
                <label for="attendanceName">Student Name:</label>
                <input type="text" id="attendanceName" name="attendanceName" required>
            </div>
            <div class="form-group">
                <label for="attendanceRollNo">Roll Number:</label>
                <input type="text" id="attendanceRollNo" name="attendanceRollNo" required>
            </div>
            <div class="form-group">
                <label for="attendanceYear">Year:</label>
                <input type="text" id="attendanceYear" name="attendanceYear" required>
            </div>
            <div class="form-group">
                <label for="attendanceBranch">Branch:</label>
                <input type="text" id="attendanceBranch" name="attendanceBranch" required>
            </div>
            <div class="form-group">
                <label>Attendance for the Day:</label>
                <select id="attendanceStatus" name="attendanceStatus">
                    <option value="present">Present</option>
                    <option value="absent">Absent</option>
                </select>
            </div>
            <button type="submit" class="button">Submit Attendance</button>
        </form>
    </div>

    <!-- Post Marks Section -->
    <div class="section" id="postMarks">
        <h3>Post Marks</h3>
        <form id="marksForm" action="postMarks.jsp" method="post">
            <div class="form-group">
                <label for="marksName">Student Name:</label>
                <input type="text" id="marksName" name="marksName" required>
            </div>
            <div class="form-group">
                <label for="marksRollNo">Roll Number:</label>
                <input type="text" id="marksRollNo" name="marksRollNo" required>
            </div>
            <div class="form-group">
                <label for="marksYear">Year:</label>
                <input type="text" id="marksYear" name="marksYear" required>
            </div>
            <div class="form-group">
                <label for="marksBranch">Branch:</label>
                <input type="text" id="marksBranch" name="marksBranch" required>
            </div>
            <div class="form-group">
                <label for="marksSubject">Subject:</label>
                <input type="text" id="marksSubject" name="marksSubject" required>
            </div>
            <div class="form-group">
                <label for="marks">Marks:</label>
                <input type="number" id="marks" name="marks" min="0" max="100" required>
            </div>
            <button type="submit" class="button">Submit Marks</button>
        </form>
    </div>

    <!-- Attendance Details Section -->
    <div class="section" id="attendanceDetails">
        <h3>Attendance Details</h3>
        <table>
            <thead>
                <tr>
                    <th>Student Name</th>
                    <th>Roll Number</th>
                    <th>Year</th>
                    <th>Branch</th>
                    <th>Attendance Status</th>
                </tr>
            </thead>
            <tbody>
                <%-- Attendance data should be dynamically generated here from the backend --%>
            </tbody>
        </table>
    </div>

    <!-- Marks Details Section -->
    <div class="section" id="marksDetails">
        <h3>Marks Details</h3>
        <table>
            <thead>
                <tr>
                    <th>Student Name</th>
                    <th>Roll Number</th>
                    <th>Year</th>
                    <th>Branch</th>
                    <th>Subject</th>
                    <th>Marks</th>
                </tr>
            </thead>
            <tbody>
                <%-- Marks data should be dynamically generated here from the backend --%>
            </tbody>
        </table>
    </div>
</div>

<!-- Toast Message for Success -->
<div id="toast"></div>

<script>
    // Function to display the active section
    function showSection(sectionId) {
        // Hide all sections
        var sections = document.querySelectorAll('.section');
        sections.forEach(function(section) {
            section.classList.remove('active');
        });

        // Show the selected section
        document.getElementById(sectionId).classList.add('active');
    }

    // Function to show a success toast message
    function showToast(message) {
        var toast = document.getElementById('toast');
        toast.textContent = message;
        toast.classList.add('visible');
        setTimeout(function() {
            toast.classList.remove('visible');
        }, 4000);
    }

    // Call this function to show a success message when form is submitted
    function showSuccess() {
        showToast("Form Submitted Successfully!");
    }
</script>

</body>
</html>