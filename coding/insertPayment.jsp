<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Processing Insert Payment</title>
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
        PreparedStatement insertStmt = null;
        try {
            // Get parameters from the request
            int treatmentId = Integer.parseInt(request.getParameter("treatmentId"));
            String paymentDate = request.getParameter("paymentDate");
            String paymentTime = request.getParameter("paymentTime");
            String paymentStatus = request.getParameter("paymentStatus");
            double totalPayment = Double.parseDouble(request.getParameter("totalPayment"));

            // Connect to the database
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            String url = "jdbc:mysql://localhost/sql_aminruzlin";
            String username = "sql_aminruzlin";
            String passwordMySQL = "3xGtKK7bia7j8XNh";
            connection = DriverManager.getConnection(url, username, passwordMySQL);

            // Insert payment details
            String insertQuery = "INSERT INTO Payment (payment_IdTreatment, payment_Date, payment_Time, payment_Status, payment_TotalPayment) VALUES (?, ?, ?, ?, ?)";
            insertStmt = connection.prepareStatement(insertQuery);
            insertStmt.setInt(1, treatmentId);
            insertStmt.setString(2, paymentDate);
            insertStmt.setString(3, paymentTime);
            insertStmt.setString(4, paymentStatus);
            insertStmt.setDouble(5, totalPayment);

            int rowsInserted = insertStmt.executeUpdate();

            if (rowsInserted > 0) {
                out.println("<script type='text/javascript'>");
                out.println("showAlert('Payment details inserted successfully!', 'display.jsp');");
                out.println("</script>");
            } else {
                out.println("<script type='text/javascript'>");
                out.println("showAlert('Error inserting payment details.', 'display.jsp');");
                out.println("</script>");
            }
        } catch (SQLException e) {
            String errorMsg = e.getMessage() != null ? e.getMessage().replace("'", "\\'") : "SQL error occurred.";
            out.println("<script type='text/javascript'>");
            out.println("showAlert('Error: " + errorMsg + "', 'display.jsp');");
            out.println("</script>");
        } catch (ClassNotFoundException e) {
            String errorMsg = e.getMessage() != null ? e.getMessage().replace("'", "\\'") : "Class not found.";
            out.println("<script type='text/javascript'>");
            out.println("showAlert('Error: " + errorMsg + "', 'display.jsp');");
            out.println("</script>");
        } catch (Exception e) {
            String errorMsg = e.getMessage() != null ? e.getMessage().replace("'", "\\'") : "An unexpected error occurred.";
            out.println("<script type='text/javascript'>");
            out.println("showAlert('Error: " + errorMsg + "', 'display.jsp');");
            out.println("</script>");
        } finally {
            if (insertStmt != null) try { insertStmt.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
        }
    %>
</body>
</html>
