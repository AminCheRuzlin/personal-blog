<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Processing Patient Addition</title>
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
        try {
            // Get parameters from the request
            String patientIC = request.getParameter("IC");
            String patientName = request.getParameter("Name");
            String patientGender = request.getParameter("Gender");
            String patientPhoneNumber = request.getParameter("PhoneNumber");
            String patientDateOfBirth = request.getParameter("DateOfBirth");
            String patientRegistrationDate = request.getParameter("RegistrationDate");
            String patientRegistrationTime = request.getParameter("RegistrationTime");
            String patientAddress = request.getParameter("Address");
            String patientAllergy = request.getParameter("Allergy");
            
            // Debugging output
            out.println("<p>IC: " + patientIC + "</p>");
            out.println("<p>Name: " + patientName + "</p>");
            out.println("<p>Gender: " + patientGender + "</p>");
            out.println("<p>Phone: " + patientPhoneNumber + "</p>");
            out.println("<p>DOB: " + patientDateOfBirth + "</p>");
            out.println("<p>Reg Date: " + patientRegistrationDate + "</p>");
            out.println("<p>Reg Time: " + patientRegistrationTime + "</p>");
            out.println("<p>Address: " + patientAddress + "</p>");
            out.println("<p>Allergy: " + patientAllergy + "</p>");
            
            // Connect to the database
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            String url = "jdbc:mysql://localhost/sql_aminruzlin";
            String username = "sql_aminruzlin";
            String passwordMySQL = "3xGtKK7bia7j8XNh";
            
            connection = DriverManager.getConnection(url, username, passwordMySQL);
            String insertQuery = "INSERT INTO Patient (patient_IC, patient_Name, patient_Gender, patient_PhoneNumber, patient_DateOfBirth, patient_RegistrationDate, patient_RegistrationTime, patient_Address, patient_Allergy) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            insertStmt = connection.prepareStatement(insertQuery);
            
            // Set parameters
            insertStmt.setString(1, patientIC);
            insertStmt.setString(2, patientName);
            insertStmt.setString(3, patientGender);
            insertStmt.setString(4, patientPhoneNumber);
            insertStmt.setDate(5, java.sql.Date.valueOf(patientDateOfBirth));
            insertStmt.setDate(6, java.sql.Date.valueOf(patientRegistrationDate));
            insertStmt.setString(7, patientRegistrationTime);
            insertStmt.setString(8, patientAddress);
            insertStmt.setString(9, patientAllergy);
            
            int rowsInserted = insertStmt.executeUpdate();
            
            if (rowsInserted > 0) {
                out.println("<script type='text/javascript'>");
                out.println("showAlert('Patient added successfully!', 'addPatient.jsp');");
                out.println("</script>");
            } else {
                out.println("<script type='text/javascript'>");
                out.println("showAlert('Error adding patient.', 'addPatient.jsp');");
                out.println("</script>");
            }
        } catch (SQLException e) {
            String errorMsg = e.getMessage() != null ? e.getMessage().replace("'", "\\'") : "SQL error occurred.";
            out.println("<script type='text/javascript'>");
            out.println("showAlert('Error: " + errorMsg + "', 'addPatient.jsp');");
            out.println("</script>");
        } catch (ClassNotFoundException e) {
            String errorMsg = e.getMessage() != null ? e.getMessage().replace("'", "\\'") : "Class not found.";
            out.println("<script type='text/javascript'>");
            out.println("showAlert('Error: " + errorMsg + "', 'addPatient.jsp');");
            out.println("</script>");
        } catch (Exception e) {
            String errorMsg = e.getMessage() != null ? e.getMessage().replace("'", "\\'") : "An unexpected error occurred.";
            out.println("<script type='text/javascript'>");
            out.println("showAlert('Error: " + errorMsg + "', 'addPatient.jsp');");
            out.println("</script>");
        } finally {
            if (insertStmt != null) try { insertStmt.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
        }
    %>
</body>
</html>
