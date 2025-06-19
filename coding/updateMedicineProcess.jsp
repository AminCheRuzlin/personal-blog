<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Processing Update Medicine</title>
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
        PreparedStatement updateMedicationStmt = null;
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

            // Update the medication in Medication table
            String updateMedicationQuery = "UPDATE Medication SET medication_Name = ?, medication_Category = ?, medication_Quantity = ? WHERE medication_Code = ?";
            updateMedicationStmt = connection.prepareStatement(updateMedicationQuery);
            updateMedicationStmt.setString(1, medicationName);
            updateMedicationStmt.setString(2, medicationCategory);
            updateMedicationStmt.setInt(3, medicationQuantity);
            updateMedicationStmt.setString(4, medicationCode);

            int rowsUpdated = updateMedicationStmt.executeUpdate();

            if (rowsUpdated > 0) {
                // Update the stock in StockMedication table
                String updateStockQuery = "UPDATE StockMedication SET stockMedication_Quantity = ? WHERE stockMedication_medicationCode = ?";
                updateStockStmt = connection.prepareStatement(updateStockQuery);
                updateStockStmt.setInt(1, medicationQuantity);
                updateStockStmt.setString(2, medicationCode);

                int rowsStockUpdated = updateStockStmt.executeUpdate();

                if (rowsStockUpdated > 0) {
                    out.println("<script type='text/javascript'>");
                    out.println("showAlert('Medicine updated successfully and stock updated!', 'updateMedicine.jsp');");
                    out.println("</script>");
                } else {
                    out.println("<script type='text/javascript'>");
                    out.println("showAlert('Error updating stock.', 'updateMedicine.jsp');");
                    out.println("</script>");
                }
            } else {
                out.println("<script type='text/javascript'>");
                out.println("showAlert('Error updating medicine.', 'updateMedicine.jsp');");
                out.println("</script>");
            }
        } catch (SQLException e) {
            String errorMsg = e.getMessage() != null ? e.getMessage().replace("'", "\\'") : "SQL error occurred.";
            out.println("<script type='text/javascript'>");
            out.println("showAlert('Error: " + errorMsg + "', 'updateMedicine.jsp');");
            out.println("</script>");
        } catch (ClassNotFoundException e) {
            String errorMsg = e.getMessage() != null ? e.getMessage().replace("'", "\\'") : "Class not found.";
            out.println("<script type='text/javascript'>");
            out.println("showAlert('Error: " + errorMsg + "', 'updateMedicine.jsp');");
            out.println("</script>");
        } catch (Exception e) {
            String errorMsg = e.getMessage() != null ? e.getMessage().replace("'", "\\'") : "An unexpected error occurred.";
            out.println("<script type='text/javascript'>");
            out.println("showAlert('Error: " + errorMsg + "', 'updateMedicine.jsp');");
            out.println("</script>");
        } finally {
            if (updateMedicationStmt != null) try { updateMedicationStmt.close(); } catch (SQLException ignore) {}
            if (updateStockStmt != null) try { updateStockStmt.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
        }
    %>
</body>
</html>
