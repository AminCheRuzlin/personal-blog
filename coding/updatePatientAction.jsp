<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Processing Patient Update</title>
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
        PreparedStatement updateStmt = null;
        try {
            // Get parameters from the request
            String patientIC = request.getParameter("patient_IC");
            String patientPhoneNumber = request.getParameter("patient_PhoneNumber");
            String patientAddress = request.getParameter("patient_Address");
            String patientAllergy = request.getParameter("patient_Allergy");

            // Connect to the database
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            String url = "jdbc:mysql://localhost/sql_aminruzlin";
            String username = "sql_aminruzlin";
            String passwordMySQL = "3xGtKK7bia7j8XNh";
            
            connection = DriverManager.getConnection(url, username, passwordMySQL);
            String updateQuery = "UPDATE Patient SET patient_PhoneNumber = ?, patient_Address = ?, patient_Allergy = ? WHERE patient_IC = ?";
            updateStmt = connection.prepareStatement(updateQuery);
            
            // Set parameters
            updateStmt.setString(1, patientPhoneNumber);
            updateStmt.setString(2, patientAddress);
            updateStmt.setString(3, patientAllergy);
            updateStmt.setString(4, patientIC);
            
            int rowsUpdated = updateStmt.executeUpdate();
            
            if (rowsUpdated > 0) {
                out.println("<script type='text/javascript'>");
                out.println("showAlert('Patient updated successfully!', 'updatePatient.jsp');");
                out.println("</script>");
            } else {
                out.println("<script type='text/javascript'>");
                out.println("showAlert('Error updating patient.', 'updatePatient.jsp');");
                out.println("</script>");
            }
        } catch (SQLException e) {
            String errorMsg = e.getMessage() != null ? e.getMessage().replace("'", "\\'") : "SQL error occurred.";
            out.println("<script type='text/javascript'>");
            out.println("showAlert('Error: " + errorMsg + "', 'updatePatient.jsp');");
            out.println("</script>");
        } catch (ClassNotFoundException e) {
            String errorMsg = e.getMessage() != null ? e.getMessage().replace("'", "\\'") : "Class not found.";
            out.println("<script type='text/javascript'>");
            out.println("showAlert('Error: " + errorMsg + "', 'updatePatient.jsp');");
            out.println("</script>");
        } catch (Exception e) {
            String errorMsg = e.getMessage() != null ? e.getMessage().replace("'", "\\'") : "An unexpected error occurred.";
            out.println("<script type='text/javascript'>");
            out.println("showAlert('Error: " + errorMsg + "', 'updatePatient.jsp');");
            out.println("</script>");
        } finally {
            if (updateStmt != null) try { updateStmt.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
        }
    %>
</body>
</html>