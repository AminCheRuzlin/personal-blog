<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Processing Patient Deletion</title>
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
            // Get the patient IC from the request
            String patientIC = request.getParameter("patient_IC");

            // Connect to the database
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            String url = "jdbc:mysql://localhost/sql_aminruzlin";
            String username = "sql_aminruzlin";
            String passwordMySQL = "3xGtKK7bia7j8XNh";
            
            connection = DriverManager.getConnection(url, username, passwordMySQL);
            String deleteQuery = "DELETE FROM Patient WHERE patient_IC = ?";
            deleteStmt = connection.prepareStatement(deleteQuery);
            
            // Set parameters
            deleteStmt.setString(1, patientIC);
            
            int rowsDeleted = deleteStmt.executeUpdate();
            
            if (rowsDeleted > 0) {
                out.println("<script type='text/javascript'>");
                out.println("showAlert('Patient deleted successfully!', 'deletePatient.jsp');");
                out.println("</script>");
            } else {
                out.println("<script type='text/javascript'>");
                out.println("showAlert('Error deleting patient.', 'deletePatient.jsp');");
                out.println("</script>");
            }
        } catch (SQLException e) {
            String errorMsg = e.getMessage() != null ? e.getMessage().replace("'", "\\'") : "SQL error occurred.";
            out.println("<script type='text/javascript'>");
            out.println("showAlert('Error: " + errorMsg + "', 'deletePatient.jsp');");
            out.println("</script>");
        } catch (ClassNotFoundException e) {
            String errorMsg = e.getMessage() != null ? e.getMessage().replace("'", "\\'") : "Class not found.";
            out.println("<script type='text/javascript'>");
            out.println("showAlert('Error: " + errorMsg + "', 'deletePatient.jsp');");
            out.println("</script>");
        } catch (Exception e) {
            String errorMsg = e.getMessage() != null ? e.getMessage().replace("'", "\\'") : "An unexpected error occurred.";
            out.println("<script type='text/javascript'>");
            out.println("showAlert('Error: " + errorMsg + "', 'deletePatient.jsp');");
            out.println("</script>");
        } finally {
            if (deleteStmt != null) try { deleteStmt.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
        }
    %>
</body>
</html>
