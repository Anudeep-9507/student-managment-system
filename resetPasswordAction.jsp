<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, javax.servlet.*, javax.servlet.http.*" %>
<%
    String username = request.getParameter("username");
    String resetKey = request.getParameter("resetKey");
    String newPassword = request.getParameter("newPassword");
    String confirmPassword = request.getParameter("confirmPassword");

    if ("vardhamanrs".equals(resetKey)) {
        if (newPassword.equals(confirmPassword)) {
            // Store the new password (In a real application, you'd save this to a database)
            session.setAttribute(username, newPassword);
            out.println("<script>alert('Password has been successfully reset for " + username + "'); window.location.href='login.jsp';</script>");
        } else {
            out.println("<script>alert('Passwords do not match. Please try again.'); window.location.href='reset-password.jsp';</script>");
        }
    } else {
        out.println("<script>alert('Incorrect reset key. Please check and try again.'); window.location.href='reset-password.jsp';</script>");
    }
%>
