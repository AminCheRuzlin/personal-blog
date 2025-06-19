<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Profile</title>     <link rel="stylesheet" href="home.css">

    
</head>
<body>
    <%
        String username = (String) session.getAttribute("user");
        if (username == null || username.isEmpty()) {
            response.sendRedirect("login.jsp"); // Redirect to login page if user is not logged in
        } else {
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            String ic = "", name = "", gender = "", phoneNumber = "", address = "", position = "", dateOfBirth = "";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost/sql_aminruzlin", "sql_aminruzlin", "3xGtKK7bia7j8XNh");
                ps = conn.prepareStatement("SELECT * FROM Employee WHERE employee_loginID = ?");
                ps.setString(1, username);
                rs = ps.executeQuery();

                if (rs.next()) {
                    ic = rs.getString("employee_IC");
                    name = rs.getString("employee_Name");
                    gender = rs.getString("employee_Gender");
                    phoneNumber = rs.getString("employee_PhoneNumber");
                    address = rs.getString("employee_Address");
                    position = rs.getString("employee_Position");
                    dateOfBirth = rs.getString("employee_DateOfBirth");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            }
        
    %>
    <div class="container">
        <h1>Update Profile</h1>
        <form action="updateProfileActionpham.jsp" method="post">
            <label for="ic"><b>IC Number :</b></label><br>
            <input type="text" id="ic" name="ic" value="<%= ic %>" readonly><br>
            <label for="name"><b>Name :</b></label><br>
            <input type="text" id="name" name="name" value="<%= name %>" readonly><br>
            <label for="gender"><b>Gender :</b></label><br>
            <input type="text" id="gender" name="gender" value="<%= gender %>" readonly><br>
            <label for="dateOfBirth"><b>Birth Date :</b></label><br>
            <input type="date" id="dateOfBirth" name="dateOfBirth" value="<%= dateOfBirth %>" readonly><br>
            <label for="position"><b>Position :</b></label><br>
            <input type="text" id="position" name="position" value="<%= position %>" readonly><br>
            <label for="phoneNumber"><b>Num. Tel :</b></label><br>
            <input type="text" id="phoneNumber" name="phoneNumber" value="<%= phoneNumber %>" required><br>
            <label for="address"><b>Address :</b></label><br>
            <input type="text" id="address" name="address" value="<%= address %>" required><br>
            <button type="submit">Update</button>
        </form>
        <div class="back-button">
            <a href="pham.jsp">Back</a>
        </div>
    </div>
            <%}%>
</body>
</html>
