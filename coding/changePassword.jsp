<%-- 
    Document   : changePassword
    Created on : Jul 5, 2024, 11:39:29 PM
    Author     : fatta
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
      <link rel="stylesheet" href="home.css">

</head>
<body>
    <%
       
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String username = (String) session.getAttribute("user");
    %>
    <div class="container">
        <h1>Change Password</h1>
        <form action="changePasswordAction.jsp" method="post">
            <div class="form-group">
                <label for="oldPassword">Old Password:</label>
                <input type="password" id="oldPassword" name="oldPassword" required>
            </div><br>
            <div class="form-group">
                <label for="newPassword">New Password:</label>
                <input type="password" id="newPassword" name="newPassword" required><br>
            </div><br>
            <div class="form-group">
                <label for="confirmPassword">Confirm New Password:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required><br>
            </div><br>
            <div class="button-group">
                <button type="submit">Change Password</button>
            </div>
        </form>
        <div class="back-button">
            <a href="clerk.jsp">Back to Home</a>
        </div>
    </div>
</body>
</html>
