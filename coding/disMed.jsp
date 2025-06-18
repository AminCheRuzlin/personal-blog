<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dispense Medicine</title>
    <link rel="stylesheet" href="home.css">
    <style>
        /* Your CSS styling here */
    </style>
</head>
<body>
    <div class="container">
        <h1>Dispense Medicine</h1>
        <%
            String patientIC = request.getParameter("patient_IC");
            if (patientIC != null && !patientIC.isEmpty()) {
                Connection connection = null;
                PreparedStatement stmt = null;
                ResultSet resultSet = null;
                List<Map<String, String>> medicationsList = new ArrayList<>();
                String url = "jdbc:mysql://localhost/sql_aminruzlin";
                String username = "sql_aminruzlin";
                String passwordMySQL = "3xGtKK7bia7j8XNh";

                try {
                    // Connect to the database to retrieve medications
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                    connection = DriverManager.getConnection(url, username, passwordMySQL);

                    String query = "SELECT * FROM Medication";
                    stmt = connection.prepareStatement(query);
                    resultSet = stmt.executeQuery();
                    while (resultSet.next()) {
                        Map<String, String> medication = new HashMap<>();
                        medication.put("code", resultSet.getString("medication_Code"));
                        medication.put("name", resultSet.getString("medication_Name"));
                        medicationsList.add(medication);
                    }
                    resultSet.close();
                    stmt.close();

                    // Retrieve patient and treatment details
                    query = "SELECT t.treatment_Date, t.treatment_Time, t.treatment_IdTreatment, t.treatment_EmployeeIC FROM Treatment t WHERE t.treatment_PatientIC = ?";
                    stmt = connection.prepareStatement(query);
                    stmt.setString(1, patientIC);
                    resultSet = stmt.executeQuery();

                    if (resultSet.next()) {
                        String treatmentDate = resultSet.getString("treatment_Date");
                        String treatmentTime = resultSet.getString("treatment_Time");
                        int treatmentId = resultSet.getInt("treatment_IdTreatment");
                        String doctorIC = resultSet.getString("treatment_EmployeeIC");

                        out.println("<div class='details-section'>");
                        out.println("<h2>Patient and Treatment Details</h2>");
                        out.println("<p>IC Pesakit: " + patientIC + "</p>");
                        out.println("<p>Tarikh Rawatan: " + treatmentDate + "</p>");
                        out.println("<p>Masa Rawatan: " + treatmentTime + "</p>");
                        out.println("<p>ID Rawatan: " + treatmentId + "</p>");
                        out.println("<p>IC Doktor: " + doctorIC + "</p>");
                        out.println("</div>");

                        // Retrieve and display existing medications for the treatment
                        out.println("<h2>Current Medications</h2>");
                        out.println("<table>");
                        out.println("<tr><th>Medication Name</th><th>Quantity</th><th>Usage Method</th><th>Total Price</th></tr>");

                        query = "SELECT m.medication_Name, dm.dispenseMedication_Quantity, dm.dispenseMedication_UsageMethod, dm.dispenseMedication_TotalPrice " +
                                "FROM dispenseMedication dm " +
                                "JOIN Medication m ON dm.dispenseMedication_medicationCode = m.medication_Code " +
                                "WHERE dm.dispenseMedication_IdTreatment = ?";
                        stmt = connection.prepareStatement(query);
                        stmt.setInt(1, treatmentId);
                        resultSet = stmt.executeQuery();

                        boolean hasMedications = false;
                        while (resultSet.next()) {
                            hasMedications = true;
                            String medicationName = resultSet.getString("medication_Name");
                            int quantity = resultSet.getInt("dispenseMedication_Quantity");
                            String usageMethod = resultSet.getString("dispenseMedication_UsageMethod");
                            double totalPrice = resultSet.getDouble("dispenseMedication_TotalPrice");

                            out.println("<tr>");
                            out.println("<td>" + medicationName + "</td>");
                            out.println("<td>" + quantity + "</td>");
                            out.println("<td>" + usageMethod + "</td>");
                            out.println("<td>" + totalPrice + "</td>");
                            out.println("</tr>");
                        }
                        out.println("</table>");

                        if (!hasMedications) {
                            out.println("<p>No medications have been dispensed for this treatment yet.</p>");
                        }

                        out.println("<h2>Add Medication</h2>");
                        out.println("<form action='dispenseMedicineProcess.jsp' method='post'>");
                        out.println("<input type='hidden' id='patient_IC' name='patient_IC' value='" + patientIC + "' readonly>");
                        out.println("<input type='hidden' id='treatment_IdTreatment' name='treatment_IdTreatment' value='" + treatmentId + "' readonly>");
                        out.println("<div class='form-group'>");
                        out.println("<label for='medication_Code'>Select Medicine</label>");
                        out.println("<select id='medication_Code' name='medication_Code' required>");
                        out.println("<option value=''>Select Medicine</option>");
                        for (Map<String, String> medication : medicationsList) {
                            String code = medication.get("code");
                            String name = medication.get("name");
                            out.println("<option value='" + code + "'>" + name + " (" + code + ")</option>");
                        }
                        out.println("</select>");
                        out.println("</div>");
                        out.println("<div class='form-group'>");
                        out.println("<label for='medication_Quantity'>Quantity</label>");
                        out.println("<input type='number' id='medication_Quantity' name='medication_Quantity' min='1' required>");
                        out.println("</div>");
                        out.println("<div class='form-group'>");
                        out.println("<label for='usage_Method'>Usage Method</label>");
                        out.println("<input type='text' id='usage_Method' name='usage_Method' required>");
                        out.println("</div>");
                        out.println("<div class='form-group'>");
                        out.println("<label for='total_Price'>Total Price</label>");
                        out.println("<input type='number' id='total_Price' name='total_Price' step='0.01' required>");
                        out.println("</div>");
                        out.println("<button type='submit' class='btn-submit'>Add Medication</button>");
                        out.println("</form>");
                    } else {
                        out.println("<p>No treatment details found for the provided patient IC.</p>");
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
            } else {
                out.println("<p>Please provide a valid patient IC to proceed.</p>");
            }
        %>
        <div class="back-button">
            <a href="doc.jsp" class="btn-back">Back to Home</a>
        </div>
    </div>
</body>
</html>
