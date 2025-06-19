<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Report by Date</title>
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

        .form-group input {
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
        <h1>Payment Report by Date</h1>
        <form method="get" action="reportdate.jsp">
            <div class="form-group">
                <label for="start_date">Start Date</label>
                <input type="date" id="start_date" name="start_date" required>
            </div>
            <div class="form-group">
                <label for="end_date">End Date</label>
                <input type="date" id="end_date" name="end_date" required>
            </div>
            <button type="submit" class="btn-submit">Search</button>
        </form>

        <%
            String startDate = request.getParameter("start_date");
            String endDate = request.getParameter("end_date");
            if (startDate != null && endDate != null && !startDate.isEmpty() && !endDate.isEmpty()) {
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

                    // Query to retrieve payment details within the date range
                    String query = "SELECT * FROM Payment WHERE payment_Date BETWEEN ? AND ?";
                    stmt = connection.prepareStatement(query);
                    stmt.setString(1, startDate);
                    stmt.setString(2, endDate);
                    resultSet = stmt.executeQuery();

                    // Display the payment details in a table
                    out.println("<table>");
                    out.println("<tr><th>Payment ID</th><th>Treatment ID</th><th>Payment Date</th><th>Payment Time</th><th>Payment Status</th><th>Total Payment</th></tr>");
                    while (resultSet.next()) {
                        int paymentId = resultSet.getInt("payment_IdPayment");
                        int treatmentId = resultSet.getInt("payment_IdTreatment");
                        String paymentDate = resultSet.getString("payment_Date");
                        String paymentTime = resultSet.getString("payment_Time");
                        String paymentStatus = resultSet.getString("payment_Status");
                        double totalPayment = resultSet.getDouble("payment_TotalPayment");

                        out.println("<tr>");
                        out.println("<td>" + paymentId + "</td>");
                        out.println("<td>" + treatmentId + "</td>");
                        out.println("<td>" + paymentDate + "</td>");
                        out.println("<td>" + paymentTime + "</td>");
                        out.println("<td>" + paymentStatus + "</td>");
                        out.println("<td>" + totalPayment + "</td>");
                        out.println("</tr>");
                    }
                    out.println("</table>");
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
            <a href="pham.jsp" class="btn-back">Back to Home</a>
        </div>
    </div>
</body>
</html>
