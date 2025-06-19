<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Display Treatment Details</title>
    <link rel="stylesheet" href="home.css">
    <style>
        body {
            font-family: Arial, sans-serif;
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
            max-width: 800px;
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
    </style>
</head>
<body>
    <div class="container">
        <h1>Display Treatment Details</h1>
        <form method="get" action="display.jsp">
            <div class="form-group">
                <label for="treatmentId">Enter Treatment ID</label>
                <input type="text" id="treatmentId" name="treatmentId" required>
            </div>
            <button type="submit" class="btn-submit">Search</button>
        </form>

        <%
            String treatmentId = request.getParameter("treatmentId");
            if (treatmentId != null && !treatmentId.isEmpty()) {
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

                    // Query to retrieve treatment details
                    String query = "SELECT * FROM Treatment WHERE treatment_IdTreatment = ?";
                    stmt = connection.prepareStatement(query);
                    stmt.setString(1, treatmentId);
                    resultSet = stmt.executeQuery();

                    if (resultSet.next()) {
                        int idTreatment = resultSet.getInt("treatment_IdTreatment");
                        String patientIC = resultSet.getString("treatment_PatientIC");
                        String date = resultSet.getString("treatment_Date");
                        String time = resultSet.getString("treatment_Time");
                        String illness = resultSet.getString("treatment_Illness");
                        String employeeIC = resultSet.getString("treatment_EmployeeIC");

                        out.println("<table>");
                        out.println("<tr><th>Treatment ID</th><th>Patient IC</th><th>Date</th><th>Time</th><th>Illness</th><th>Employee IC</th></tr>");
                        out.println("<tr>");
                        out.println("<td>" + idTreatment + "</td>");
                        out.println("<td>" + patientIC + "</td>");
                        out.println("<td>" + date + "</td>");
                        out.println("<td>" + time + "</td>");
                        out.println("<td>" + illness + "</td>");
                        out.println("<td>" + employeeIC + "</td>");
                        out.println("</tr>");
                        out.println("</table>");

                        // Query to retrieve payment details if exists
                        query = "SELECT * FROM Payment WHERE payment_IdTreatment = ?";
                        stmt = connection.prepareStatement(query);
                        stmt.setString(1, treatmentId);
                        resultSet = stmt.executeQuery();

                        if (resultSet.next()) {
                            int paymentId = resultSet.getInt("payment_IdPayment");
                            String paymentDate = resultSet.getString("payment_Date");
                            String paymentTime = resultSet.getString("payment_Time");
                            String paymentStatus = resultSet.getString("payment_Status");
                            double totalPayment = resultSet.getDouble("payment_TotalPayment");

                            out.println("<h2>Payment Details</h2>");
                            out.println("<form action='updatePayment.jsp' method='post'>");
                            out.println("<div class='form-group'>");
                            out.println("<label for='paymentId'>Payment ID</label>");
                            out.println("<input type='text' id='paymentId' name='paymentId' value='" + paymentId + "' readonly>");
                            out.println("</div>");
                            out.println("<div class='form-group'>");
                            out.println("<label for='paymentDate'>Payment Date</label>");
                            out.println("<input type='text' id='paymentDate' name='paymentDate' value='" + paymentDate + "' readonly>");
                            out.println("</div>");
                            out.println("<div class='form-group'>");
                            out.println("<label for='paymentTime'>Payment Time</label>");
                            out.println("<input type='text' id='paymentTime' name='paymentTime' value='" + paymentTime + "' readonly>");
                            out.println("</div>");
                            out.println("<div class='form-group'>");
                            out.println("<label for='paymentStatus'>Payment Status</label>");
                            out.println("<select id='paymentStatus' name='paymentStatus'>");
                            out.println("<option value='in progress'" + ("in progress".equals(paymentStatus) ? " selected" : "") + ">In Progress</option>");
                            out.println("<option value='completed'" + ("completed".equals(paymentStatus) ? " selected" : "") + ">Completed</option>");
                            out.println("</select>");
                            out.println("</div>");
                            out.println("<div class='form-group'>");
                            out.println("<label for='totalPayment'>Total Payment</label>");
                            out.println("<input type='text' id='totalPayment' name='totalPayment' value='" + totalPayment + "' readonly>");
                            out.println("</div>");
                            out.println("<button type='submit' class='btn-submit'>Update Payment Status</button>");
                            out.println("</form>");
                        } else {
                            out.println("<h2>No payment details found. Insert new payment details below:</h2>");
                            out.println("<form action='insertPayment.jsp' method='post'>");
                            out.println("<div class='form-group'>");
                            out.println("<label for='treatmentId'>Treatment ID</label>");
                            out.println("<input type='text' id='treatmentId' name='treatmentId' value='" + idTreatment + "' readonly>");
                            out.println("</div>");
                            out.println("<div class='form-group'>");
                            out.println("<label for='paymentDate'>Payment Date</label>");
                            out.println("<input type='date' id='paymentDate' name='paymentDate' required>");
                            out.println("</div>");
                            out.println("<div class='form-group'>");
                            out.println("<label for='paymentTime'>Payment Time</label>");
                            out.println("<input type='time' id='paymentTime' name='paymentTime' required>");
                            out.println("</div>");
                            out.println("<div class='form-group'>");
                            out.println("<label for='paymentStatus'>Payment Status</label>");
                            out.println("<select id='paymentStatus' name='paymentStatus' required>");
                            out.println("<option value='in progress'>In Progress</option>");
                            out.println("<option value='completed'>Completed</option>");
                            out.println("</select>");
                            out.println("</div>");
                            out.println("<div class='form-group'>");
                            out.println("<label for='totalPayment'>Total Payment</label>");
                            out.println("<input type='number' step='0.01' id='totalPayment' name='totalPayment' required>");
                            out.println("</div>");
                            out.println("<button type='submit' class='btn-submit'>Insert Payment Details</button>");
                            out.println("</form>");
                        }
                    } else {
                        out.println("<p>No treatment found with the provided ID.</p>");
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
        <a href="pham.jsp">Back to Home</a> </div> 
</body>
</html>
