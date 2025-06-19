<%@ page import="java.sql.*, java.util.*, java.text.SimpleDateFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Treatments by Date</title>
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
    </style>
</head>
<body>
    <div class="container">
        <h1>Search Treatments by Date</h1>
        <form method="get" action="ltt.jsp">
            <div class="form-group">
                <label for="treatmentDate">Enter Treatment Date</label>
                <input type="date" id="treatmentDate" name="treatmentDate" required>
            </div>
            <button type="submit" class="btn-submit">Search</button>
        </form>

        <%
            String treatmentDate = request.getParameter("treatmentDate");
            if (treatmentDate != null && !treatmentDate.isEmpty()) {
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

                    // Query to retrieve treatments for the specified date
                    String query = "SELECT * FROM Treatment WHERE treatment_Date = ?";
                    stmt = connection.prepareStatement(query);
                    stmt.setString(1, treatmentDate);
                    resultSet = stmt.executeQuery();

                    if (!resultSet.isBeforeFirst()) {    
                        out.println("<p>No treatments found for the selected date.</p>");
                    } else {
                        // Display the treatments
                        out.println("<table>");
                        out.println("<tr><th>Treatment ID</th><th>Patient IC</th><th>Date</th><th>Time</th><th>Illness</th><th>Employee IC</th></tr>");
                        while (resultSet.next()) {
                            int treatmentId = resultSet.getInt("treatment_IdTreatment");
                            String patientIC = resultSet.getString("treatment_PatientIC");
                            String date = resultSet.getString("treatment_Date");
                            String time = resultSet.getString("treatment_Time");
                            String illness = resultSet.getString("treatment_Illness");
                            String employeeIC = resultSet.getString("treatment_EmployeeIC");

                            out.println("<tr>");
                            out.println("<td>" + treatmentId + "</td>");
                            out.println("<td>" + patientIC + "</td>");
                            out.println("<td>" + date + "</td>");
                            out.println("<td>" + time + "</td>");
                            out.println("<td>" + illness + "</td>");
                            out.println("<td>" + employeeIC + "</td>");
                            out.println("</tr>");
                        }
                        out.println("</table>");
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
