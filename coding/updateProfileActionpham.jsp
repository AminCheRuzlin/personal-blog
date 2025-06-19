<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Profile Update</title>
 
   
    <script type="text/javascript">
        function redirectToHome() {
            window.location.replace("pham.jsp");
        }
    </script>
</head>
<body>
    <%
        String username = (String) session.getAttribute("user");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String ic = "", name = "", gender = "", position = "", dateOfBirth = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:/sql_aminruzlin", "sql_aminruzlin", "3xGtKK7bia7j8XNh");
            ps = conn.prepareStatement("UPDATE Employee SET employee_PhoneNumber = ?, employee_Address = ? WHERE employee_loginID = ?");
            ps.setString(1, phoneNumber);
            ps.setString(2, address);
            ps.setString(3, username);

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                %>
                <script type="text/javascript">
                    alert('Profile updated successfully!');
                    redirectToHome();
                </script>
                <%
            } else {
                out.println("<h2>Failed to update profile.</h2>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    %>
    <div class="back-button">
        <a href="pham.jsp">Back to Home</a>
    </div>
</body>
</html>
