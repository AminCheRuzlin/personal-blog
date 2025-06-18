<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Register Treatment</title>
   
      <link rel="stylesheet" href="home.css">
</head>
<body>
    <div class="container">
        <h1>Register Treatment</h1>
        <form method="post" action="registerTreatmentAction.jsp">
            <label for="patient_IC">Patient Name:</label>
            <select id="patient_IC" name="patient_IC" required><br>
                <option value="">Select Patient</option>
                <%
                    Connection connection = null;
                    PreparedStatement patientStmt = null;
                    ResultSet patientResultSet = null;
                    try {
                        // Connect to the database
                        Class.forName("com.mysql.jdbc.Driver").newInstance();
                        String url = "jdbc:mysql://localhost/sql_aminruzlin";
                        String username = "sql_aminruzlin";
                        String passwordMySQL = "3xGtKK7bia7j8XNh";
                        
                        connection = DriverManager.getConnection(url, username, passwordMySQL);
                        String patientQuery = "SELECT patient_IC, patient_Name FROM Patient";
                        patientStmt = connection.prepareStatement(patientQuery);
                        patientResultSet = patientStmt.executeQuery();
                        
                        while (patientResultSet.next()) {
                            String patientIC = patientResultSet.getString("patient_IC");
                            String patientName = patientResultSet.getString("patient_Name");
                            out.println("<option value='" + patientIC + "'>" + patientName + "</option>");
                        }
                    } catch (SQLException e) {
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    } catch (ClassNotFoundException e) {
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    } catch (Exception e) {
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    } finally {
                        if (patientResultSet != null) try { patientResultSet.close(); } catch (SQLException ignore) {}
                        if (patientStmt != null) try { patientStmt.close(); } catch (SQLException ignore) {}
                        if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
                    }
                %>
            </select><br><br>

            <label for="employee_IC">Doctor:</label>
            <select id="employee_IC" name="employee_IC" required>
                <option value="">Select Doctor</option>
                <%
                    Connection connection2 = null;
                    PreparedStatement doctorStmt = null;
                    ResultSet doctorResultSet = null;
                    try {
                        // Connect to the database
                        Class.forName("com.mysql.jdbc.Driver").newInstance();
                        String url = "jdbc:mysql://localhost/sql_aminruzlin";
                        String username = "sql_aminruzlin";
                        String passwordMySQL = "3xGtKK7bia7j8XNh";
                        
                        connection2 = DriverManager.getConnection(url, username, passwordMySQL);
                        String doctorQuery = "SELECT employee_IC, employee_Name FROM Employee WHERE employee_position = 'D'";
                        doctorStmt = connection2.prepareStatement(doctorQuery);
                        doctorResultSet = doctorStmt.executeQuery();
                        
                        while (doctorResultSet.next()) {
                            String doctorIC = doctorResultSet.getString("employee_IC");
                            String doctorName = doctorResultSet.getString("employee_Name");
                            out.println("<option value='" + doctorIC + "'>" + doctorName + "</option>");
                        }
                    } catch (SQLException e) {
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    } catch (ClassNotFoundException e) {
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    } catch (Exception e) {
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    } finally {
                        if (doctorResultSet != null) try { doctorResultSet.close(); } catch (SQLException ignore) {}
                        if (doctorStmt != null) try { doctorStmt.close(); } catch (SQLException ignore) {}
                        if (connection2 != null) try { connection2.close(); } catch (SQLException ignore) {}
                    }
                %>
            </select><br><br>

            <label for="treatment_Date">Date:</label>
            <input type="date" id="treatment_Date" name="treatment_Date" required><br>
            
            <label for="treatment_Time">Time:</label>
            <input type="time" id="treatment_Time" name="treatment_Time" required><br>
            
            </br><label for="treatment_Illness">Illness:</label>
            <input type="text" id="treatment_Illness" name="treatment_Illness" required maxlength="50"><br>
            
            <button type="submit">Register Treatment</button>
        </form>

        <div class="back-button">
            <a href="clerk.jsp" class="logout">Back</a>
        </div>
    </div>
</body>
</html>
