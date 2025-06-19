<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Delete Patient</title>
      <link rel="stylesheet" href="home.css">
</head>
<body>
    <div class="container">
        <h1>Delete Patient</h1>
        <form method="get" action="deletePatient.jsp">
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

                    while (resultSet.next()) {
                        String patientIC = resultSet.getString("patient_IC");
                        String patientNameResult = resultSet.getString("patient_Name");
                        String patientGender = resultSet.getString("patient_Gender");
                        String patientPhoneNumber = resultSet.getString("patient_PhoneNumber");
                        String patientDateOfBirth = resultSet.getString("patient_DateOfBirth");
                        String patientRegistrationDate = resultSet.getString("patient_RegistrationDate");
                        String patientAddress = resultSet.getString("patient_Address");
                        String patientAllergy = resultSet.getString("patient_Allergy");

                        out.println("<form method='post' action='deletePatientAction.jsp'>");
                        out.println("<input type='hidden' name='patient_IC' value='" + patientIC + "'>");
                        out.println("<p>IC: " + patientIC + "</p>");
                        out.println("<p>Name: " + patientNameResult + "</p>");
                        out.println("<p>Gender: " + patientGender + "</p>");
                        out.println("<p>Phone: " + patientPhoneNumber + "</p>");
                        out.println("<p>Date of Birth: " + patientDateOfBirth + "</p>");
                        out.println("<p>Registration Date: " + patientRegistrationDate + "</p>");
                        out.println("<p>Address: " + patientAddress + "</p>");
                        out.println("<p>Allergy: " + patientAllergy + "</p>");
                        out.println("<button type='submit'>Delete</button>");
                        out.println("</form>");
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
