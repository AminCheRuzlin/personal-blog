<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Delete Employee</title>
</head>
<body>
    <%
        Connection connection = null;
        PreparedStatement deleteEmployeeStmt = null;
        PreparedStatement deleteLoginStmt = null;
        try {
            // Connect to the database
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            String url = "jdbc:mysql://localhost/sql_aminruzlin";
            String username = "sql_aminruzlin";
            String passwordMySQL = "3xGtKK7bia7j8XNh";

            connection = DriverManager.getConnection(url, username, passwordMySQL);
            String userId = request.getParameter("userId");

            if (userId == null || userId.isEmpty()) {
                // Redirect to delete.jsp with error message
                String errorMessage = "Missing parameter: userId";
                response.sendRedirect("deleteEmployee.jsp?error=" + java.net.URLEncoder.encode(errorMessage, "UTF-8"));
            } else {
                // Delete from employee table first to avoid foreign key constraint violation
                String deleteEmployeeQuery = "DELETE FROM Employee WHERE employee_loginID = ?";
                deleteEmployeeStmt = connection.prepareStatement(deleteEmployeeQuery);
                deleteEmployeeStmt.setString(1, userId);
                int employeeRowsDeleted = deleteEmployeeStmt.executeUpdate();

                if (employeeRowsDeleted > 0) {
                    // Delete from login table
                    String deleteLoginQuery = "DELETE FROM Login WHERE login_loginID = ?";
                    deleteLoginStmt = connection.prepareStatement(deleteLoginQuery);
                    deleteLoginStmt.setString(1, userId);
                    int loginRowsDeleted = deleteLoginStmt.executeUpdate();

                    if (loginRowsDeleted > 0) {
                        // Set success message
                        out.println("<script type='text/javascript'>");
                        out.println("alert('Success: Employee and login records deleted successfully.');");
                        out.println("window.location.href = 'deleteEmployee.jsp';");
                        out.println("</script>");
                    } else {
                        // Set error message for failed deletion in login table
                        out.println("<script type='text/javascript'>");
                        out.println("alert('Error: Failed to delete from login table.');");
                        out.println("window.location.href = 'deleteEmployee.jsp';");
                        out.println("</script>");
                    }
                } else {
                    // Set error message for failed deletion in employee table
                    out.println("<script type='text/javascript'>");
                    out.println("alert('Error: Failed to delete from employee table.');");
                    out.println("window.location.href = 'deleteEmployee.jsp';");
                    out.println("</script>");
                }
            }
        } catch (SQLException e) {
            out.println("<script type='text/javascript'>");
            out.println("alert('Error: SQL Error: " + java.net.URLEncoder.encode(e.getMessage(), "UTF-8") + "');");
            out.println("window.location.href = 'deleteEmployee.jsp';");
            out.println("</script>");
        } catch (ClassNotFoundException e) {
            out.println("<script type='text/javascript'>");
            out.println("alert('Error: JDBC Driver not found: " + java.net.URLEncoder.encode(e.getMessage(), "UTF-8") + "');");
            out.println("window.location.href = 'deleteEmployee.jsp';");
            out.println("</script>");
        } catch (Exception e) {
            out.println("<script type='text/javascript'>");
            out.println("alert('Error: " + java.net.URLEncoder.encode(e.getMessage(), "UTF-8") + "');");
            out.println("window.location.href = 'deleteEmployee.jsp';");
            out.println("</script>");
        } finally {
            if (deleteEmployeeStmt != null) try { deleteEmployeeStmt.close(); } catch (SQLException ignore) {}
            if (deleteLoginStmt != null) try { deleteLoginStmt.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
        }
    %>
</body>
</html>
