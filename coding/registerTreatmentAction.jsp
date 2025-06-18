<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Processing Treatment Registration</title>
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
        PreparedStatement insertStmt = null;
        PreparedStatement checkStmt = null;
        ResultSet resultSet = null;
        try {
            // Get parameters from the request
            String patientIC = request.getParameter("patient_IC");
            String employeeIC = request.getParameter("employee_IC");
            String treatmentDate = request.getParameter("treatment_Date");
            String treatmentTime = request.getParameter("treatment_Time");
            String treatmentIllness = request.getParameter("treatment_Illness");

            // Connect to the database
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            String url = "jdbc:mysql://localhost/sql_aminruzlin";
            String username = "sql_aminruzlin";
            String passwordMySQL = "3xGtKK7bia7j8XNh";
            
            connection = DriverManager.getConnection(url, username, passwordMySQL);

            // Generate unique treatment_IdTreatment
            int treatmentIdTreatment;
            Random random = new Random();
            boolean isUnique = false;

            do {
                treatmentIdTreatment = random.nextInt(10); // Random number between 0 and 99999
                String checkQuery = "SELECT COUNT(*) FROM Treatment WHERE treatment_IdTreatment = ?";
                checkStmt = connection.prepareStatement(checkQuery);
                checkStmt.setInt(1, treatmentIdTreatment);
                resultSet = checkStmt.executeQuery();
                if (resultSet.next() && resultSet.getInt(1) == 0) {
                    isUnique = true;
                }
            } while (!isUnique);

            // Insert treatment record
            String insertQuery = "INSERT INTO Treatment (treatment_IdTreatment, treatment_PatientIC, treatment_EmployeeIC, treatment_Date, treatment_Time, treatment_Illness) VALUES (?, ?, ?, ?, ?, ?)";
            insertStmt = connection.prepareStatement(insertQuery);
            
            // Set parameters
            insertStmt.setInt(1, treatmentIdTreatment);
            insertStmt.setString(2, patientIC);
            insertStmt.setString(3, employeeIC);
            insertStmt.setDate(4, java.sql.Date.valueOf(treatmentDate));
            insertStmt.setString(5, treatmentTime);
            insertStmt.setString(6, treatmentIllness);
            
            int rowsInserted = insertStmt.executeUpdate();
            
            if (rowsInserted > 0) {
                out.println("<script type='text/javascript'>");
                out.println("showAlert('Treatment registered successfully!', 'registerTreatment.jsp');");
                out.println("</script>");
            } else {
                out.println("<script type='text/javascript'>");
                out.println("showAlert('Error registering treatment.', 'registerTreatment.jsp');");
                out.println("</script>");
            }
        } catch (SQLException e) {
            String errorMsg = e.getMessage() != null ? e.getMessage().replace("'", "\\'") : "SQL error occurred.";
            out.println("<script type='text/javascript'>");
            out.println("showAlert('Error: " + errorMsg + "', 'registerTreatment.jsp');");
            out.println("</script>");
        } catch (ClassNotFoundException e) {
            String errorMsg = e.getMessage() != null ? e.getMessage().replace("'", "\\'") : "Class not found.";
            out.println("<script type='text/javascript'>");
            out.println("showAlert('Error: " + errorMsg + "', 'registerTreatment.jsp');");
            out.println("</script>");
        } catch (Exception e) {
            String errorMsg = e.getMessage() != null ? e.getMessage().replace("'", "\\'") : "An unexpected error occurred.";
            out.println("<script type='text/javascript'>");
            out.println("showAlert('Error: " + errorMsg + "', 'registerTreatment.jsp');");
            out.println("</script>");
        } finally {
            if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
            if (checkStmt != null) try { checkStmt.close(); } catch (SQLException ignore) {}
            if (insertStmt != null) try { insertStmt.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
        }
    %>
</body>
</html>
