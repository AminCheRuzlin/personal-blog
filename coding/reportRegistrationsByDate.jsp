<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Registrations by Date Report</title>
  <link rel="stylesheet" href="table.css">
</head>
<body>
    <div class="container">
        <h1>Registrations by Date Report</h1>
        <form method="get" action="reportRegistrationsByDate.jsp" class="form-group">
            <label for="registrationDate">Search by Registration Date:</label>
            <input type="date" id="registrationDate" name="registrationDate" required>
            <button type="submit">Search</button>
        </form>

        <table>
            <tr>
                <th>IC</th>
                <th>Name</th>
                <th>Gender</th>
                <th>Phone</th>
                <th>Date of Birth</th>
                <th>Registration Date</th>
                <th>Registration Time</th>
                <th>Address</th>
                <th>Allergy</th>
            </tr>
            <%
                String registrationDate = request.getParameter("registrationDate");
                Connection connection = null;
                PreparedStatement stmt = null;
                ResultSet resultSet = null;

                if (registrationDate != null && !registrationDate.isEmpty()) {
                    try {
                        // Connect to the database
                        Class.forName("com.mysql.jdbc.Driver").newInstance();
                        String url = "jdbc:mysql://localhost/sql_aminruzlin";
                        String username = "sql_aminruzlin";
                        String passwordMySQL = "3xGtKK7bia7j8XNh";

                        connection = DriverManager.getConnection(url, username, passwordMySQL);
                        String query = "SELECT * FROM Patient WHERE patient_RegistrationDate = ?";

                        stmt = connection.prepareStatement(query);
                        stmt.setDate(1, java.sql.Date.valueOf(registrationDate));

                        resultSet = stmt.executeQuery();

                        while (resultSet.next()) {
                            String patientIC = resultSet.getString("patient_IC");
                            String patientName = resultSet.getString("patient_Name");
                            String patientGender = resultSet.getString("patient_Gender");
                            String patientPhoneNumber = resultSet.getString("patient_PhoneNumber");
                            String patientDateOfBirth = resultSet.getString("patient_DateOfBirth");
                            String patientRegistrationDate = resultSet.getString("patient_RegistrationDate");
                            String patientRegistrationTime = resultSet.getString("patient_RegistrationTime");
                            String patientAddress = resultSet.getString("patient_Address");
                            String patientAllergy = resultSet.getString("patient_Allergy");

                            out.println("<tr>");
                            out.println("<td>" + patientIC + "</td>");
                            out.println("<td>" + patientName + "</td>");
                            out.println("<td>" + patientGender + "</td>");
                            out.println("<td>" + patientPhoneNumber + "</td>");
                            out.println("<td>" + patientDateOfBirth + "</td>");
                            out.println("<td>" + patientRegistrationDate + "</td>");
                            out.println("<td>" + patientRegistrationTime + "</td>");
                            out.println("<td>" + patientAddress + "</td>");
                            out.println("<td>" + patientAllergy + "</td>");
                            out.println("</tr>");
                        }
                    } catch (SQLException e) {
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    } catch (ClassNotFoundException e) {
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    } catch (Exception e) {
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    } finally {
                        if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
                        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                        if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
                    }
                }
            %>
        </table>

        <div class="back-button">
            <a href="clerk.jsp" class="logout">Back</a>
        </div>
    </div>
</body>
</html>
