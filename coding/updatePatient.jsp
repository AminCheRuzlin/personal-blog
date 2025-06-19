<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Update Patient</title>
    <link rel="stylesheet" href="home.css">
</head>
<body>
    <div class="container">
        <h1>Update Patient</h1>
        <form method="get" action="updatePatient.jsp">
            <label for="searchName">Search by Name:</label>
            <input type="text" id="searchName" name="searchName" required>
            <button type="submit">Search</button>
        </form>

        <%
            String searchName = request.getParameter("searchName");
            if (searchName != null && !searchName.isEmpty()) {
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
                    String searchQuery = "SELECT * FROM Patient WHERE patient_Name LIKE ?";
                    searchStmt = connection.prepareStatement(searchQuery);
                    searchStmt.setString(1, "%" + searchName + "%");
                    resultSet = searchStmt.executeQuery();

                    if (resultSet.next()) {
                        String patientIC = resultSet.getString("patient_IC");
                        String patientNameResult = resultSet.getString("patient_Name");
                        String patientGender = resultSet.getString("patient_Gender");
                        String patientPhoneNumber = resultSet.getString("patient_PhoneNumber");
                        String patientDateOfBirth = resultSet.getString("patient_DateOfBirth");
                        String patientRegistrationDate = resultSet.getString("patient_RegistrationDate");
                        String patientRegistrationTime = resultSet.getString("patient_RegistrationTime");
                        String patientAddress = resultSet.getString("patient_Address");
                        String patientAllergy = resultSet.getString("patient_Allergy");

                        out.println("<form method='post' action='updatePatientAction.jsp'>");
                        out.println("<input type='hidden' name='patient_IC' value='" + patientIC + "'>");
                        out.println("<p>IC: <input type='text' name='patient_IC_Display' value='" + patientIC + "' readonly></p>");
                        out.println("<p>Name: <input type='text' name='patient_Name' value='" + patientNameResult + "' readonly></p>");
                        out.println("<p>Gender: <input type='text' name='patient_Gender' value='" + patientGender + "' readonly></p>");
                        out.println("<p>Phone: <input type='text' name='patient_PhoneNumber' value='" + patientPhoneNumber + "'></p>");
                        out.println("<p>Date of Birth: <input type='text' name='patient_DateOfBirth' value='" + patientDateOfBirth + "' readonly></p>");
                        out.println("<p>Registration Date: <input type='text' name='patient_RegistrationDate' value='" + patientRegistrationDate + "' readonly></p>");
                        out.println("<p>Registration Time: <input type='text' name='patient_RegistrationTime' value='" + patientRegistrationTime + "' readonly></p>");
                        out.println("<p>Address: <input type='text' name='patient_Address' value='" + patientAddress + "'></p>");
                        out.println("<p>Allergy: <input type='text' name='patient_Allergy' value='" + patientAllergy + "'></p>");
                        out.println("<button type='submit'>Update</button>");
                        out.println("</form>");
                    } else {
                        out.println("<p>No patient found with the name: " + searchName + "</p>");
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
