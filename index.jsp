<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VCE College - Home</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <!-- Header -->
    <header class="header">
        <nav class="navbar">
            <div class="logo">
                <img src="https://images.unsplash.com/photo-1535982330050-f1c2fb79ff78?w=120&h=120&fit=crop" alt="College Logo">
                <h1>VCE College</h1>
            </div>
            <div class="nav-links" id="navLinks">
                <ul>
                    <li><a href="#home">Home</a></li>
                    <li><a href="#academics">Academics</a></li>
                    <li><a href="#facilities">Facilities</a></li>
                    <li><a href="#placements">Placements</a></li>
                    <li class="dropdown">
                        <a href="#" class="dropbtn">Login <i class="fas fa-chevron-down"></i></a>
                        <div class="dropdown-content">
                            <a href="./student-login.jsp">Student Login</a>
                            <a href="<%= request.getContextPath() %>/faculty-login.jsp">Faculty Login</a>
                            <a href="./admin-login.jsp">Admin Login</a>
                        </div>
                    </li>
                </ul>
            </div>
            <i class="fas fa-bars" onclick="showMenu()"></i>
        </nav>
    </header>
    
    <!-- Hero Section -->
    <section class="hero" id="home" style="background: linear-gradient(
        url('https://images.unsplash.com/photo-1562774053-701939374585?w=1600&h=900&fit=crop') no-repeat center center/cover;">
        <div class="hero-content">
            <h1>Welcome to Excellence</h1>
            <p>Shaping futures through quality education and innovation</p>
            <a href="#academics" class="hero-btn">Explore More</a>
        </div>
    </section>

    <!-- Academics Section -->
    <section class="section" id="academics">
        <h2 class="section-title">Academic Excellence</h2>
        <div class="cards-container">
            <div class="card">
                <img src="https://images.unsplash.com/photo-1593642634367-d91a135587b5?w=500&h=300&fit=crop" alt="Computer Science">
                <h3>Computer Science</h3>
                <p>World-class education in cutting-edge technology</p>
            </div>
            <div class="card">
                <img src="https://images.pexels.com/photos/1216589/pexels-photo-1216589.jpeg?auto=compress&cs=tinysrgb&w=600" alt="Civil Engineering">
                <h3>Civil Engineering</h3>
                <p>Equipping students for infrastructure excellence</p>
            </div>
            <div class="card">
                <img src="https://images.pexels.com/photos/8005397/pexels-photo-8005397.jpeg?auto=compress&cs=tinysrgb&w=600" alt="Electrical Engineering">
                <h3>Electrical Engineering</h3>
                <p>Powering up the future of energy systems</p>
            </div>
            <div class="card">
                <img src="https://images.pexels.com/photos/2136243/pexels-photo-2136243.jpeg?auto=compress&cs=tinysrgb&w=600" alt="Electronics Engineering">
                <h3>Electronics Engineering</h3>
                <p>Developing advanced electronic systems for tomorrow</p>
            </div>
            <div class="card">
                <img src="https://images.pexels.com/photos/7688336/pexels-photo-7688336.jpeg?auto=compress&cs=tinysrgb&w=600" alt="Information Technology">
                <h3>Information Technology</h3>
                <p>Innovative IT solutions for global challenges</p>
            </div>
        </div>
    </section>

    <!-- Facilities Section -->
    <!-- (Similar structure for Facilities, Companies Visited, and Footer sections.) -->

    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h3>Contact Us</h3>
                <p>Email: info@vce.edu</p>
                <p>Phone: +91 123 456 7890</p>
                <p>Address: Vardhaman College of Engineering, Hyderabad</p>
            </div>
            <div class="footer-section">
                <h3>Follow Us</h3>
                <a href="#"><i class="fab fa-facebook"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
                <a href="#"><i class="fab fa-linkedin"></i></a>
            </div>
        </div>
    </footer>

    <script>
        function showMenu() {
            var navLinks = document.getElementById("navLinks");
            if (navLinks.style.display === "none") {
                navLinks.style.display = "block";
            } else {
                navLinks.style.display = "none";
            }
        }
    </script>
</body>
</html>
