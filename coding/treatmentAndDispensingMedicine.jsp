<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Treatment and Dispensing Medicine</title>
    <link rel="stylesheet" href="home.css">
</head>
<body>
    <div class="container">
        <h1>Treatment and Dispensing Medicine</h1>
        <form method="get" action="treatmentAndDispensingMedicine.jsp">
            <div class="form-group">
                <label for="patient_IC">Enter Patient IC</label>
                <input type="text" id="patient_IC" name="patient_IC" required>
            </div>
            <button type="submit" class="btn-submit">Search</button>
        </form>

        <%
            String patientIC = request.getParameter("patient_IC");
            if (patientIC != null && !patientIC.isEmpty()) {
                Connection connection = null;
                PreparedStatement stmt = null;
                ResultSet resultSet = null;
                try {
                    // Connect to the database
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                    String url = "jdbc:mysql://localhost/sql_aminruzlin";
                    String username = "sql_aminruzlin";
                    String passwordMySQL = "3xGtKK7bia7j8XNh";
                    connection = DriverManager.getConnection(url, username, passwordMySQL);

                    // Query to retrieve patient and treatment details
                    String query = "SELECT * FROM Patient WHERE patient_IC = ?";
                    stmt = connection.prepareStatement(query);
                    stmt.setString(1, patientIC);
                    resultSet = stmt.executeQuery();

                    if (resultSet.next()) {
                        String patientName = resultSet.getString("patient_Name");
                        String patientGender = resultSet.getString("patient_Gender");
                        String patientPhoneNumber = resultSet.getString("patient_PhoneNumber");
                        String patientDOB = resultSet.getString("patient_DateOfBirth");
                        String patientAddress = resultSet.getString("patient_Address");
                        String patientAllergy = resultSet.getString("patient_Allergy");

                        out.println("<form action='updatetd.jsp' method='post'>");
                        out.println("<div class='form-group'>");
                        out.println("<label for='patient_IC'>Patient IC</label>");
                        out.println("<input type='text' id='patient_IC' name='patient_IC' value='" + patientIC + "' readonly>");
                        out.println("</div>");
                        out.println("<div class='form-group'>");
                        out.println("<label for='patient_Name'>Patient Name</label>");
                        out.println("<input type='text' id='patient_Name' name='patient_Name' value='" + patientName + "' readonly>");
                        out.println("</div>");
                        out.println("<div class='form-group'>");
                        out.println("<label for='patient_Gender'>Patient Gender</label>");
                        out.println("<input type='text' id='patient_Gender' name='patient_Gender' value='" + patientGender + "' readonly>");
                        out.println("</div>");
                        out.println("<div class='form-group'>");
                        out.println("<label for='patient_PhoneNumber'>Patient Phone Number</label>");
                        out.println("<input type='text' id='patient_PhoneNumber' name='patient_PhoneNumber' value='" + patientPhoneNumber + "' readonly>");
                        out.println("</div>");
                        out.println("<div class='form-group'>");
                        out.println("<label for='patient_DOB'>Patient Date of Birth</label>");
                        out.println("<input type='text' id='patient_DOB' name='patient_DOB' value='" + patientDOB + "' readonly>");
                        out.println("</div>");
                        out.println("<div class='form-group'>");
                        out.println("<label for='patient_Address'>Patient Address</label>");
                        out.println("<input type='text' id='patient_Address' name='patient_Address' value='" + patientAddress + "' readonly>");
                        out.println("</div>");
                        out.println("<div class='form-group'>");
                        out.println("<label for='patient_Allergy'>Patient Allergy</label>");
                        out.println("<input type='text' id='patient_Allergy' name='patient_Allergy' value='" + patientAllergy + "' readonly>");
                        out.println("</div>");

                        // Query to retrieve treatment details
                        query = "SELECT * FROM Treatment WHERE treatment_PatientIC = ?";
                        stmt = connection.prepareStatement(query);
                        stmt.setString(1, patientIC);
                        resultSet = stmt.executeQuery();

                        if (resultSet.next()) {
                            int treatmentID = resultSet.getInt("treatment_IdTreatment");
                            String treatmentIllness = resultSet.getString("treatment_Illness");

                            out.println("<div class='form-group'>");
                            out.println("<label for='treatment_Illness'>Illness</label>");
                            out.println("<input type='text' id='treatment_Illness' name='treatment_Illness' value='" + treatmentIllness + "' required>");
                            out.println("</div>");
                            out.println("<input type='hidden' id='treatment_IdTreatment' name='treatment_IdTreatment' value='" + treatmentID + "'>");
                        }

                        out.println("<button type='submit' class='btn-update'>Update Illness</button>");
                        out.println("</form>");
                        out.println("<form action='disMed.jsp' method='post' style='margin-top: 20px;'>");
                        out.println("<input type='hidden' id='patient_IC' name='patient_IC' value='" + patientIC + "'>");
                        out.println("<button type='submit' class='btn-proceed'>Proceed to Dispense Medicine</button>");
                        out.println("</form>");
                    } else {
                        out.println("<p>No patient found with the provided IC.</p>");
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
        <div class="back-button">
            <a href="doc.jsp" class="btn-back">Back to Home</a>
        </div>
    </div>
</body>
</html>
