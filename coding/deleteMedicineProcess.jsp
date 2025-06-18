<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Processing Delete Medicine</title>
    <script>
        function showAlert(message, redirectUrl) {
            alert(message);
            window.location.href = redirectUrl;
        }
    </script>
</head>
<body>
    <%
        Connection connection = null;
        PreparedStatement deleteStmt = null;
        try {
            // Get parameters from the request
            String medicationCode = request.getParameter("medication_Code");

            // Connect to the database
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            String url = "jdbc:mysql://localhost/sql_aminruzlin";
            String username = "sql_aminruzlin";
            String passwordMySQL = "3xGtKK7bia7j8XNh";
            connection = DriverManager.getConnection(url, username, passwordMySQL);

            // Delete the medication
            String deleteQuery = "DELETE FROM Medication WHERE medication_Code = ?";
            deleteStmt = connection.prepareStatement(deleteQuery);
            deleteStmt.setString(1, medicationCode);

            int rowsDeleted = deleteStmt.executeUpdate();

            if (rowsDeleted > 0) {
                out.println("<script type='text/javascript'>");
                out.println("showAlert('Medicine deleted successfully!', 'deleteMedicine.jsp');");
                out.println("</script>");
            } else {
                out.println("<script type='text/javascript'>");
                out.println("showAlert('Error deleting medicine.', 'deleteMedicine.jsp');");
                out.println("</script>");
            }
        } catch (SQLException e) {
            String errorMsg = e.getMessage() != null ? e.getMessage().replace("'", "\\'") : "SQL error occurred.";
            out.println("<script type='text/javascript'>");
            out.println("showAlert('Error: " + errorMsg + "', 'deleteMedicine.jsp');");
            out.println("</script>");
        } catch (ClassNotFoundException e) {
            String errorMsg = e.getMessage() != null ? e.getMessage().replace("'", "\\'") : "Class not found.";
            out.println("<script type='text/javascript'>");
            out.println("showAlert('Error: " + errorMsg + "', 'deleteMedicine.jsp');");
            out.println("</script>");
        } catch (Exception e) {
            String errorMsg = e.getMessage() != null ? e.getMessage().replace("'", "\\'") : "An unexpected error occurred.";
            out.println("<script type='text/javascript'>");
            out.println("showAlert('Error: " + errorMsg + "', 'deleteMedicine.jsp');");
            out.println("</script>");
        } finally {
            if (deleteStmt != null) try { deleteStmt.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
        }
    %>
</body>
</html>
