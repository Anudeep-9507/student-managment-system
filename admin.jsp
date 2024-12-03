<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel - Manage Students/Faculty</title>
    <style>
            /* General Styles */
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}

h1 {
    color: #333;
    text-align: center;
    padding: 20px;
}

/* Navbar Styles */
nav {
    background-color: #6f4f29; /* Primary color */
    overflow: hidden;
    position: relative;
    padding: 10px 20px;
    box-sizing: border-box; /* Ensure padding does not affect layout */
}

nav a {
    color: white;
    text-align: center;
    padding: 14px 20px;
    display: inline-block;
    text-decoration: none;
}

nav a:hover {
    background-color: #8b5a2b; /* Secondary color */
    color: black;
}

/* Logout Button Styles */
.logout-btn {
    position: absolute;
    right: 20px;
    top: 50%; /* Vertically center the button */
    transform: translateY(-50%); /* Ensure it is perfectly centered vertically */
    background-color: #d9534f;
    color: white;
    padding: 12px 25px; /* Make button larger for better visibility */
    font-size: 16px; /* Ensure text is legible */
    border-radius: 5px;
    text-decoration: none;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Add a slight shadow for better visibility */
    transition: background-color 0.3s, transform 0.3s; /* Smooth transition on hover */
}

.logout-btn:hover {
    background-color: #c9302c;
    transform: translateY(-50%) scale(1.05); /* Slight scale-up effect on hover */
}

/* Form Styles */
form {
    background: #fff;
    padding: 30px;
    margin: 50px auto;
    border-radius: 8px;
    max-width: 500px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

label {
    display: block;
    margin-top: 15px;
    font-weight: bold;
    text-align: left;
}

input {
    width: 100%;
    padding: 12px;
    margin-top: 8px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 16px;
    box-sizing: border-box;
}

input:focus {
    border-color: #8b5a2b; /* Highlight border color on focus */
    outline: none;
}

button {
    width: 100%;
    padding: 12px;
    margin-top: 20px;
    background-color: #6f4f29; /* Primary color */
    color: white;
    font-size: 16px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

button:hover {
    background-color: #8b5a2b; /* Secondary color */
}

button:focus {
    outline: none;
}

/* Styling the "Student Information" and "Faculty Information" sections */
#viewStudentInfo h2, #viewFacultyInfo h2 {
    text-align: center;
    color: #6f4f29; /* Primary color */
    font-size: 24px;
    margin-bottom: 15px;
    padding: 2px;
}

/* Style for Student and Faculty Information Tables */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    padding:5px;
    margin: 2px
}

th, td {
    padding: 12px;
    text-align: left;
    border-bottom: 1px solid #ddd;
    padding:5px;
    margin: 2px
}

th {
    background-color: #6f4f29; /* Primary color */
    color: white;
}

td {
    background-color: #f9f9f9;
}

/* Container Styles */
.container {
    margin: 20px auto;
}

.message {
    color: green;
}

/* Hide all forms initially */
.form-container {
    display: none;
    margin: 20px;
    padding:20px;
}

    </style>
</head>
<body>
    <h1>Admin Panel</h1>

    <!-- Navbar -->
    <nav>
        <a href="javascript:void(0);" onclick="showForm('addStudentForm')">Add Student</a>
        <a href="javascript:void(0);" onclick="showForm('addFacultyForm')">Add Faculty</a>
        <a href="javascript:void(0);" onclick="showForm('viewStudentInfo')">Student Info</a>
        <a href="javascript:void(0);" onclick="showForm('viewFacultyInfo')">Faculty Info</a>
         <a href="index.jsp" class="logout-btn">Logout</a>
    </nav>

    <!-- Add Student Form -->
    <div id="addStudentForm" class="form-container">
        <h2>Add Student</h2>
        <form method="post">
            <label>Roll Number:</label>
            <input type="text" name="rollno" required><br>
            <label>Name:</label>
            <input type="text" name="name" required><br>
            <label>Username:</label>
            <input type="text" name="username" required><br>
            <label>Password:</label>
            <input type="password" name="password" required><br>
            <label>Department:</label>
            <input type="text" name="department" required><br>
            <label>Year:</label>
            <input type="number" name="year" required><br>
            <button type="submit" name="action" value="addStudent">Add Student</button>
        </form>
    </div>

    <!-- Add Faculty Form -->
    <div id="addFacultyForm" class="form-container">
        <h2>Add Faculty</h2>
        <form method="post">
            <label>Faculty Name:</label>
            <input type="text" name="facultyName" required><br>
            <label>Username:</label>
            <input type="text" name="username" required><br>
            <label>Password:</label>
            <input type="password" name="password" required><br>
            <label>Qualification:</label>
            <input type="text" name="qualification" required><br>
            <label>Experience (Years):</label>
            <input type="number" name="experience" required><br>
            <button type="submit" name="action" value="addFaculty">Add Faculty</button>
        </form>
    </div>

   <!-- View Student Info -->
<div id="viewStudentInfo" class="form-container">
    <h2>Student Information</h2>
    <table border="1" width=5px height=5px>
        <tr>
            <th>Roll No</th>
            <th>Name</th>
            <th>Department</th>
            <th>Year</th>
            <th>Action</th>
        </tr>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/college_db", "root", "");
                stmt = conn.createStatement();
                rs = stmt.executeQuery("SELECT * FROM students");

                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getString("rollno") + "</td>");
                    out.println("<td>" + rs.getString("name") + "</td>");
                    out.println("<td>" + rs.getString("department") + "</td>");
                    out.println("<td>" + rs.getInt("year") + "</td>");
                    out.println("<td>");
                    out.println("<form method='post'>");
                    out.println("<input type='hidden' name='action' value='deleteStudent'>");
                    out.println("<input type='hidden' name='rollno' value='" + rs.getString("rollno") + "'>");
                    out.println("<button type='submit'>Delete</button>");
                    out.println("</form>");
                    out.println("</td>");
                    out.println("</tr>");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
            }
        %>
    </table>
</div>

<!-- View Faculty Info -->
<div id="viewFacultyInfo" class="form-container">
    <h2>Faculty Information</h2>
    <table border="1">
        <tr>
            <th>Name</th>
            <th>Qualification</th>
            <th>Experience</th>
            <th>Action</th>
        </tr>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/college_db", "root", "");
                stmt = conn.createStatement();
                rs = stmt.executeQuery("SELECT * FROM faculty");

                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getString("name") + "</td>");
                    out.println("<td>" + rs.getString("qualification") + "</td>");
                    out.println("<td>" + rs.getInt("experience") + " years</td>");
                    out.println("<td>");
                    out.println("<form method='post'>");
                    out.println("<input type='hidden' name='action' value='deleteFaculty'>");
                    out.println("<input type='hidden' name='facultyId' value='" + rs.getInt("id") + "'>");
                    out.println("<button type='submit'>Delete</button>");
                    out.println("</form>");
                    out.println("</td>");
                    out.println("</tr>");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
            }
        %>
    </table>
</div>

    </div>

    <script>
        // Function to show/hide forms based on clicked navbar item
        function showForm(formId) {
            var forms = document.querySelectorAll('.form-container');
            forms.forEach(function(form) {
                form.style.display = 'none';  // Hide all forms
            });

            var formToShow = document.getElementById(formId);
            if (formToShow) {
                formToShow.style.display = 'block';  // Show the clicked form
            }
        }
    </script>

    <%
        // Database connection and form handling for adding students/faculty
        String action = request.getParameter("action");
        if (action != null) {
            PreparedStatement ps = null;
            try {
                // Reuse the same connection and statement objects
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/college_db", "root", "");

                if ("addStudent".equals(action)) {
                    String rollno = request.getParameter("rollno");
                    String name = request.getParameter("name");
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");
                    String department = request.getParameter("department");
                    int year = Integer.parseInt(request.getParameter("year"));

                    String sql = "INSERT INTO students (rollno, name, username, password, department, year) VALUES (?, ?, ?, ?, ?, ?)";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, rollno);
                    ps.setString(2, name);
                    ps.setString(3, username);
                    ps.setString(4, password);
                    ps.setString(5, department);
                    ps.setInt(6, year);

                    int rowsInserted = ps.executeUpdate();
                    if (rowsInserted > 0) {
                        out.println("<div class='message'>Student added successfully!</div>");
                    }
                } else if ("addFaculty".equals(action)) {
                    String facultyName = request.getParameter("facultyName");
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");
                    String qualification = request.getParameter("qualification");
                    int experience = Integer.parseInt(request.getParameter("experience"));

                    String sql = "INSERT INTO faculty (name, username, password, qualification, experience) VALUES (?, ?, ?, ?, ?)";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, facultyName);
                    ps.setString(2, username);
                    ps.setString(3, password);
                    ps.setString(4, qualification);
                    ps.setInt(5, experience);

                    int rowsInserted = ps.executeUpdate();
                    if (rowsInserted > 0) {
                        out.println("<div class='message'>Faculty added successfully!</div>");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
            }
        }
    %>
    <%
    if ("deleteStudent".equals(action)) {
        String rollnoToDelete = request.getParameter("rollno");
        PreparedStatement ps = null;
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/college_db", "root", "");
            String sql = "DELETE FROM students WHERE rollno = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, rollnoToDelete);
            int rowsDeleted = ps.executeUpdate();
            if (rowsDeleted > 0) {
                out.println("<div class='message'>Student deleted successfully!</div>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
        }
    } else if ("deleteFaculty".equals(action)) {
        String facultyIdToDelete = request.getParameter("facultyId");
        PreparedStatement ps = null;
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/college_db", "root", "");
            String sql = "DELETE FROM faculty WHERE id = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(facultyIdToDelete));
            int rowsDeleted = ps.executeUpdate();
            if (rowsDeleted > 0) {
                out.println("<div class='message'>Faculty deleted successfully!</div>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
        }
    }
%>

</body>
</html>
