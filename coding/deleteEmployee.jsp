<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
     <link rel="stylesheet" href="home.css">
    <title>Delete Employee</title>
    <script>
        function confirmDelete() {
            if (confirm("Are you sure you want to delete this employee?")) {
                document.getElementById("deleteForm").submit();
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Delete Employee</h1>
        <form method="get" action="deleteEmployee.jsp">
            <label for="name">Search by Employee Name:</label>
            <input type="text" id="name" name="name" required>
            <button type="submit">Search</button>
        </form>

        <%
            String name = request.getParameter("name");
            if (name != null && !name.isEmpty()) {
                Connection connection = null;
                PreparedStatement searchStmt = null;
                ResultSet resultSet = null;

                try {
                    // Connect to the database
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                    String url = "jdbc:mysql://localhost/sql_aminruzlin";
                    String username = "sql_aminruzlin";
                    String passwordMySQL = "3xGtKK7bia7j8XNh";

                    connection = DriverManager.getConnection(url, username, passwordMySQL);
                    String searchQuery = "SELECT * FROM Employee WHERE employee_Name LIKE ?";
                    searchStmt = connection.prepareStatement(searchQuery);
                    searchStmt.setString(1, "%" + name + "%");
                    resultSet = searchStmt.executeQuery();

                    if (resultSet.next()) {
                        String userId = resultSet.getString("employee_loginID");
                        String empName = resultSet.getString("employee_Name");
                        String ic = resultSet.getString("employee_IC");
                        String gender = resultSet.getString("employee_Gender");
                        String phone = resultSet.getString("employee_PhoneNumber");
                        String dob = resultSet.getString("employee_DateOfBirth");
                        String address = resultSet.getString("employee_Address");
                        String position = resultSet.getString("employee_position");

                        out.println("<form id='deleteForm' method='post' action='deleteEmployeeAction.jsp'>");
                        out.println("<input type='hidden' name='userId' value='" + userId + "'>");
                        out.println("<p>ID: <input type='text' name='userIdDisplay' value='" + userId + "' readonly></p>");
                        out.println("<p>Name: <input type='text' name='empName' value='" + empName + "' readonly></p>");
                        out.println("<p>IC: <input type='text' name='ic' value='" + ic + "' readonly></p>");
                        out.println("<p>Gender: <input type='text' name='gender' value='" + gender + "' readonly></p>");
                        out.println("<p>Phone: <input type='text' name='phone' value='" + phone + "' readonly></p>");
                        out.println("<p>Date of Birth: <input type='text' name='dob' value='" + dob + "' readonly></p>");
                        out.println("<p>Address: <input type='text' name='address' value='" + address + "' readonly></p>");
                        out.println("<p>Position: <input type='text' name='position' value='" + position + "' readonly></p>");
                        out.println("<button type='button' onclick='confirmDelete()'>Delete</button>");
                        out.println("</form>");
                    } else {
                        out.println("<p>No employee found with the name: " + name + "</p>");
                    }
                } catch (SQLException e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } catch (ClassNotFoundException e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } finally {
                    if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
                    if (searchStmt != null) try { searchStmt.close(); } catch (SQLException ignore) {}
                    if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
                }
            }
        %>
        <div class="back-button">
            <a href="clerk.jsp" class="logout">Back</a>
        </div>
    </div>
</body>
</html>
