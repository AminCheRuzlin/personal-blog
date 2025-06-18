<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Processing Add Medicine</title>
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
        PreparedStatement insertMedicationStmt = null;
        PreparedStatement updateStockStmt = null;
        try {
            // Get parameters from the request
            String medicationCode = request.getParameter("medication_Code");
            String medicationName = request.getParameter("medication_Name");
            String medicationCategory = request.getParameter("medication_Category");
            int medicationQuantity = Integer.parseInt(request.getParameter("medication_Quantity"));

            // Connect to the database
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            String url = "jdbc:mysql://localhost/sql_aminruzlin";
            String username = "sql_aminruzlin";
            String passwordMySQL = "3xGtKK7bia7j8XNh";
            connection = DriverManager.getConnection(url, username, passwordMySQL);

            // Insert the new medicine into Medication table
            String insertMedicationQuery = "INSERT INTO Medication (medication_Code, medication_Name, medication_Category, medication_Quantity) VALUES (?, ?, ?, ?)";
            insertMedicationStmt = connection.prepareStatement(insertMedicationQuery);
            insertMedicationStmt.setString(1, medicationCode);
            insertMedicationStmt.setString(2, medicationName);
            insertMedicationStmt.setString(3, medicationCategory);
            insertMedicationStmt.setInt(4, medicationQuantity);

            int rowsInserted = insertMedicationStmt.executeUpdate();

            if (rowsInserted > 0) {
                // Update the stock in StockMedication table
                String updateStockQuery = "INSERT INTO StockMedication (stockMedication_medicationCode, stockMedication_Quantity) VALUES (?, ?) ON DUPLICATE KEY UPDATE stockMedication_Quantity = stockMedication_Quantity + VALUES(stockMedication_Quantity)";
                updateStockStmt = connection.prepareStatement(updateStockQuery);
                updateStockStmt.setString(1, medicationCode);
                updateStockStmt.setInt(2, medicationQuantity);

                int rowsUpdated = updateStockStmt.executeUpdate();

                if (rowsUpdated > 0) {
                    out.println("<script type='text/javascript'>");
                    out.println("showAlert('Medicine added successfully and stock updated!', 'addMedicine.jsp');");
                    out.println("</script>");
                } else {
                    out.println("<script type='text/javascript'>");
                    out.println("showAlert('Error updating stock.', 'addMedicine.jsp');");
                    out.println("</script>");
                }
            } else {
                out.println("<script type='text/javascript'>");
                out.println("showAlert('Error adding medicine.', 'addMedicine.jsp');");
                out.println("</script>");
            }
        } catch (SQLException e) {
            String errorMsg = e.getMessage() != null ? e.getMessage().replace("'", "\\'") : "SQL error occurred.";
            out.println("<script type='text/javascript'>");
            out.println("showAlert('Error: " + errorMsg + "', 'addMedicine.jsp');");
            out.println("</script>");
        } catch (ClassNotFoundException e) {
            String errorMsg = e.getMessage() != null ? e.getMessage().replace("'", "\\'") : "Class not found.";
            out.println("<script type='text/javascript'>");
            out.println("showAlert('Error: " + errorMsg + "', 'addMedicine.jsp');");
            out.println("</script>");
        } catch (Exception e) {
            String errorMsg = e.getMessage() != null ? e.getMessage().replace("'", "\\'") : "An unexpected error occurred.";
            out.println("<script type='text/javascript'>");
            out.println("showAlert('Error: " + errorMsg + "', 'addMedicine.jsp');");
            out.println("</script>");
        } finally {
            if (insertMedicationStmt != null) try { insertMedicationStmt.close(); } catch (SQLException ignore) {}
            if (updateStockStmt != null) try { updateStockStmt.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
        }
    %>
</body>
</html>
