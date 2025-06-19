<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dispense Medicine Process</title>
    <style>
        .container {
            padding: 30px;
            width: 100%;
            max-width: 800px;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        .btn-back, .btn-add-more {
            padding: 15px 30px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1.1em;
            margin: 10px;
        }

        .btn-back:hover, .btn-add-more:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Dispense Medicine Process</h1>
        <%
            String patientIC = request.getParameter("patient_IC");
            int treatmentId = Integer.parseInt(request.getParameter("treatment_IdTreatment"));
            String medicationCode = request.getParameter("medication_Code");
            String usageMethod = request.getParameter("usage_Method");
            int quantity = Integer.parseInt(request.getParameter("medication_Quantity"));
            double totalPrice = Double.parseDouble(request.getParameter("total_Price"));

            if (patientIC != null && !patientIC.isEmpty() && medicationCode != null && !medicationCode.isEmpty() && quantity > 0) {
                Connection connection = null;
                PreparedStatement insertStmt = null;
                PreparedStatement updateStockStmt = null;
                PreparedStatement updateMedicationStmt = null;
                String url = "jdbc:mysql://localhost/sql_aminruzlin";
                String username = "sql_aminruzlin";
                String passwordMySQL = "3xGtKK7bia7j8XNh";
                try {
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                    connection = DriverManager.getConnection(url, username, passwordMySQL);

                    // Insert dispensed medication records
                    String insertQuery = "INSERT INTO dispenseMedication (dispenseMedication_IdTreatment, dispenseMedication_medicationCode, dispenseMedication_UsageMethod, dispenseMedication_Quantity, dispenseMedication_TotalPrice) VALUES (?, ?, ?, ?, ?)";
                    insertStmt = connection.prepareStatement(insertQuery);
                    insertStmt.setInt(1, treatmentId);
                    insertStmt.setString(2, medicationCode);
                    insertStmt.setString(3, usageMethod);
                    insertStmt.setInt(4, quantity);
                    insertStmt.setDouble(5, totalPrice);
                    insertStmt.executeUpdate();

                    // Update stock and medication quantities
                    String updateStockQuery = "UPDATE StockMedication SET stockMedication_Quantity = stockMedication_Quantity - ? WHERE stockMedication_medicationCode = ?";
                    updateStockStmt = connection.prepareStatement(updateStockQuery);
                    updateStockStmt.setInt(1, quantity);
                    updateStockStmt.setString(2, medicationCode);
                    updateStockStmt.executeUpdate();

                    String updateMedicationQuery = "UPDATE Medication SET medication_Quantity = medication_Quantity - ? WHERE medication_Code = ?";
                    updateMedicationStmt = connection.prepareStatement(updateMedicationQuery);
                    updateMedicationStmt.setInt(1, quantity);
                    updateMedicationStmt.setString(2, medicationCode);
                    updateMedicationStmt.executeUpdate();

                    out.println("<p>Medications dispensed successfully!</p>");
                    out.println("<p>Would you like to add more medication or finish?</p>");
                    out.println("<form action='disMed.jsp' method='get'>");
                    out.println("<input type='hidden' name='patient_IC' value='" + patientIC + "'>");
                    out.println("<button type='submit' class='btn-add-more'>Add More Medication</button>");
                    out.println("</form>");
                    out.println("<form action='doc.jsp' method='get'>");
                    out.println("<button type='submit' class='btn-back'>Finish</button>");
                    out.println("</form>");
                } catch (SQLException e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } catch (ClassNotFoundException e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } finally {
                    if (insertStmt != null) try { insertStmt.close(); } catch (SQLException ignore) {}
                    if (updateStockStmt != null) try { updateStockStmt.close(); } catch (SQLException ignore) {}
                    if (updateMedicationStmt != null) try { updateMedicationStmt.close(); } catch (SQLException ignore) {}
                    if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
                }
            } else {
                out.println("<p>Please provide valid data to proceed.</p>");
            }
        %>
    </div>
</body>
</html>
