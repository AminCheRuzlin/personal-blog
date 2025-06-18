<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medicine Stock Report</title>
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
        <h1>Medicine Stock Report</h1>
        <%
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

                // Query to retrieve all stock data and join with Medication table to get medicine names
                String query = "SELECT StockMedication.stockMedication_id, Medication.medication_Code, Medication.medication_Name, StockMedication.stockMedication_Quantity FROM StockMedication JOIN Medication ON StockMedication.stockMedication_medicationCode = Medication.medication_Code";
                stmt = connection.prepareStatement(query);
                resultSet = stmt.executeQuery();

                // Display the stock data in a table
                out.println("<table>");
                out.println("<tr><th>Stock ID</th><th>Medication Code</th><th>Medication Name</th><th>Stock Quantity</th></tr>");
                while (resultSet.next()) {
                    int stockId = resultSet.getInt("stockMedication_id");
                    String medicationCode = resultSet.getString("medication_Code");
                    String medicationName = resultSet.getString("medication_Name");
                    int stockQuantity = resultSet.getInt("stockMedication_Quantity");

                    out.println("<tr>");
                    out.println("<td>" + stockId + "</td>");
                    out.println("<td>" + medicationCode + "</td>");
                    out.println("<td>" + medicationName + "</td>");
                    out.println("<td>" + stockQuantity + "</td>");
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
        %>
        <div class="back-button">
            <a href="pham.jsp" class="btn-back">Back to Home</a>
        </div>
    </div>
</body>
</html>
