<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Treatment and Dispense Medicine</title>
    <link rel="stylesheet" href="home.css">
    
</head>
<body>
    <div class="container">
        <h1>Update Treatment and Dispense Medicine</h1>
        <%
            Connection connection = null;
            PreparedStatement updateStmt = null;
            PreparedStatement insertStmt = null;
            try {
                // Get parameters from the request
                String patientIC = request.getParameter("patient_IC");
                int treatmentID = Integer.parseInt(request.getParameter("treatment_IdTreatment"));
                String treatmentIllness = request.getParameter("treatment_Illness");

                // Connect to the database
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                String url = "jdbc:mysql://localhost/sql_aminruzlin";
                String username = "sql_aminruzlin";
                String passwordMySQL = "3xGtKK7bia7j8XNh";
                connection = DriverManager.getConnection(url, username, passwordMySQL);

                // Update the treatment details
                String updateQuery = "UPDATE Treatment SET treatment_Illness = ? WHERE treatment_IdTreatment = ?";
                updateStmt = connection.prepareStatement(updateQuery);
                updateStmt.setString(1, treatmentIllness);
                updateStmt.setInt(2, treatmentID);

                int rowsUpdated = updateStmt.executeUpdate();

                if (rowsUpdated > 0) {
                    out.println("<p>Treatment updated successfully!</p>");
                    out.println("<form action='disMed.jsp' method='post'>");
                    out.println("<input type='hidden' id='patient_IC' name='patient_IC' value='" + patientIC + "'>");
                    out.println("<button type='submit' class='btn-submit'>Proceed to Dispense Medicine</button>");
                    out.println("</form>");
                } else {
                    out.println("<p>Error updating treatment details.</p>");
                }
            } catch (SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } catch (ClassNotFoundException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                if (updateStmt != null) try { updateStmt.close(); } catch (SQLException ignore) {}
                if (insertStmt != null) try { insertStmt.close(); } catch (SQLException ignore) {}
                if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
            }
        %>
        <div class="back-button">
            <a href="doc.jsp" class="btn-back">Back to Home</a>
        </div>
    </div>
</body>
</html>
