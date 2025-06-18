<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medicine Dispensing Report by Patient</title>
    <link rel="stylesheet" href="home.css">
    <style>
      body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            padding: 30px;
            width: 100%;
            max-width: 1000px;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        h1 {
            color: #007bff;
            margin-bottom: 20px;
            font-size: 2em;
        }

        form {
            width: 100%;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
        }

        .form-group input, .form-group select {
            width: calc(100% - 20px);
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .btn-submit {
            padding: 15px 30px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1.1em;
        }

        .btn-submit:hover {
            background-color: #0056b3;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .back-button {
            margin-top: 20px;
        }

        .btn-back {
            padding: 15px 30px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1.1em;
        }

        .btn-back:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Medicine Dispensing Report by Patient</h1>
        <form method="get" action="medicineDispensingReportByPatient.jsp" class="search-form">
            <div class="form-group">
                <label for="patient_IC">Enter Patient IC:</label>
                <input type="text" id="patient_IC" name="patient_IC" required>
            </div>
            <button type="submit" class="btn-submit">Search</button>
        <%
            String patientIC = request.getParameter("patient_IC");
            if (patientIC != null && !patientIC.isEmpty()) {
                Connection connection = null;
                PreparedStatement stmt = null;
                ResultSet resultSet = null;
                String url = "jdbc:mysql://localhost/sql_aminruzlin";
                String username = "sql_aminruzlin";
                String passwordMySQL = "3xGtKK7bia7j8XNh";

                try {
                    // Connect to the database
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                    connection = DriverManager.getConnection(url, username, passwordMySQL);

                    // Retrieve treatment details by patient IC
                    String query = "SELECT t.treatment_IdTreatment, t.treatment_Date, t.treatment_Time, t.treatment_EmployeeIC, t.treatment_Illness " +
                                   "FROM Treatment t WHERE t.treatment_PatientIC = ?";
                    stmt = connection.prepareStatement(query);
                    stmt.setString(1, patientIC);
                    resultSet = stmt.executeQuery();

                    if (resultSet.next()) {
                        out.println("<div class='result-table'>");
                        out.println("<h2>Treatment Details for Patient IC: " + patientIC + "</h2>");
                        out.println("<table>");
                        out.println("<tr><th>Treatment ID</th><th>Treatment Date</th><th>Treatment Time</th><th>Doctor IC</th><th>Illness</th></tr>");
                        do {
                            int treatmentId = resultSet.getInt("treatment_IdTreatment");
                            String treatmentDate = resultSet.getString("t.treatment_Date");
                            String treatmentTime = resultSet.getString("t.treatment_Time");
                            String doctorIC = resultSet.getString("t.treatment_EmployeeIC");
                            String illness = resultSet.getString("t.treatment_Illness");

                            out.println("<tr>");
                            out.println("<td>" + treatmentId + "</td>");
                            out.println("<td>" + treatmentDate + "</td>");
                            out.println("<td>" + treatmentTime + "</td>");
                            out.println("<td>" + doctorIC + "</td>");
                            out.println("<td>" + illness + "</td>");
                            out.println("</tr>");

                            // Retrieve medicine dispensing details using treatment ID
                            String medQuery = "SELECT d.dispenseMedication_IdTreatment, d.dispenseMedication_medicationCode, d.dispenseMedication_UsageMethod, " +
                                              "d.dispenseMedication_Quantity, d.dispenseMedication_TotalPrice, m.medication_Name " +
                                              "FROM dispenseMedication d JOIN Medication m ON d.dispenseMedication_medicationCode = m.medication_Code " +
                                              "WHERE d.dispenseMedication_IdTreatment = ?";
                            PreparedStatement medStmt = connection.prepareStatement(medQuery);
                            medStmt.setInt(1, treatmentId);
                            ResultSet medResultSet = medStmt.executeQuery();

                            if (medResultSet.next()) {
                                out.println("<div class='result-table'>");
                                out.println("<h2>Dispensed Medications for Treatment ID: " + treatmentId + "</h2>");
                                out.println("<table>");
                                out.println("<tr><th>Medication Code</th><th>Medication Name</th><th>Usage Method</th><th>Quantity</th><th>Total Price</th></tr>");
                                do {
                                    String medicationCode = medResultSet.getString("dispenseMedication_medicationCode");
                                    String medicationName = medResultSet.getString("medication_Name");
                                    String usageMethod = medResultSet.getString("dispenseMedication_UsageMethod");
                                    int quantity = medResultSet.getInt("dispenseMedication_Quantity");
                                    double totalPrice = medResultSet.getDouble("dispenseMedication_TotalPrice");

                                    out.println("<tr>");
                                    out.println("<td>" + medicationCode + "</td>");
                                    out.println("<td>" + medicationName + "</td>");
                                    out.println("<td>" + usageMethod + "</td>");
                                    out.println("<td>" + quantity + "</td>");
                                    out.println("<td>" + totalPrice + "</td>");
                                    out.println("</tr>");
                                } while (medResultSet.next());
                                out.println("</table>");
                                out.println("</div>");
                            } else {
                                out.println("<p>No dispensed medications found for Treatment ID: " + treatmentId + "</p>");
                            }
                            medResultSet.close();
                            medStmt.close();
                        } while (resultSet.next());
                        out.println("</table>");
                        out.println("</div>");
                    } else {
                        out.println("<p>No treatments found for the provided patient IC.</p>");
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
        <form><div class="back-button">
            <a href="doc.jsp" class="btn-back">Back to Home</a>
        </div>
    </div>
</body>
</html>
