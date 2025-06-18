<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
  
</head>
<body>
    <%
        
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String username = (String) session.getAttribute("user");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            out.println("<div class='container'><h1>Passwords do not match.</h1><div class='back-button'><a href='changePassword.jsp'>Try Again</a></div></div>");
            return;
        }

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_aminruzlin", "sql_aminruzlin", "3xGtKK7bia7j8XNh");

            ps = conn.prepareStatement("SELECT login_password FROM Login WHERE login_loginID = ?");
            ps.setString(1, username);
            rs = ps.executeQuery();

            if (rs.next()) {
                String currentPassword = rs.getString("login_password");
                if (!currentPassword.equals(oldPassword)) {
                    out.println("<div class='container'><h1>Old password is incorrect.</h1><div class='back-button'><a href='changePassword.jsp'>Try Again</a></div></div>");
                    return;
                }

                ps = conn.prepareStatement("UPDATE Login SET login_password = ? WHERE login_loginID = ?");
                ps.setString(1, newPassword);
                ps.setString(2, username);
                int rowsUpdated = ps.executeUpdate();

                if (rowsUpdated > 0) {
                    out.println("<div class='container'><h1>Password updated successfully!</h1><div class='back-button'><a href='clerk.jsp'>Back to Home</a></div></div>");
                } else {
                    out.println("<div class='container'><h1>Failed to update password.</h1><div class='back-button'><a href='changePassword.jsp'>Try Again</a></div></div>");
                }
            } else {
                out.println("<div class='container'><h1>User not found.</h1><div class='back-button'><a href='changePassword.jsp'>Try Again</a></div></div>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<div class='container'><h1>An error occurred. Please try again.</h1><div class='back-button'><a href='changePassword.jsp'>Try Again</a></div></div>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
</body>
</html>
