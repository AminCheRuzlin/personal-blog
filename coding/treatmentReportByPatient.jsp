<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Treatment Report by Patient</title>
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
        <h1>Treatment Report</h1>
        <form method="get" action="treatmentReportByPatient.jsp" class="search-form">
            <div class="form-group">
                <label for="treatment_IdTreatment">Enter Treatment ID:</label>
                <input type="text" id="treatment_IdTreatment" name="treatment_IdTreatment">
            </div>
            <button type="submit" class="btn-submit">Search</button>
        </form>
        <%
            String treatmentIdParam = request.getParameter("treatment_IdTreatment");
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

                String query;
                if (treatmentIdParam != null && !treatmentIdParam.isEmpty()) {
                    query = "SELECT t.treatment_Date, t.treatment_Time, t.treatment_IdTreatment, t.treatment_EmployeeIC, t.treatment_Illness, t.treatment_PatientIC " +
                            "FROM Treatment t WHERE t.treatment_IdTreatment = ?";
                    stmt = connection.prepareStatement(query);
                    stmt.setString(1, treatmentIdParam);
                } else {
                    query = "SELECT t.treatment_Date, t.treatment_Time, t.treatment_IdTreatment, t.treatment_EmployeeIC, t.treatment_Illness, t.treatment_PatientIC " +
                            "FROM Treatment t";
                    stmt = connection.prepareStatement(query);
                }

                resultSet = stmt.executeQuery();

                if (resultSet.next()) {
                    out.println("<div class='result-table'>");
                    out.println("<h2>Treatment Details</h2>");
                    out.println("<table>");
                    out.println("<tr><th>Treatment Date</th><th>Treatment Time</th><th>Treatment ID</th><th>Doctor IC</th><th>Illness</th><th>Patient IC</th></tr>");
                    do {
                        String treatmentDate = resultSet.getString("t.treatment_Date");
                        String treatmentTime = resultSet.getString("t.treatment_Time");
                        int treatmentId = resultSet.getInt("t.treatment_IdTreatment");
                        String doctorIC = resultSet.getString("t.treatment_EmployeeIC");
                        String illness = resultSet.getString("t.treatment_Illness");
                        String patientIC = resultSet.getString("t.treatment_PatientIC");

                        out.println("<tr>");
                        out.println("<td>" + treatmentDate + "</td>");
                        out.println("<td>" + treatmentTime + "</td>");
                        out.println("<td>" + treatmentId + "</td>");
                        out.println("<td>" + doctorIC + "</td>");
                        out.println("<td>" + illness + "</td>");
                        out.println("<td>" + patientIC + "</td>");
                        out.println("</tr>");
                    } while (resultSet.next());
                    out.println("</table>");
                    out.println("</div>");
                } else {
                    out.println("<p>No treatments found.</p>");
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
        %>
        <div class="back-button">
            <a href="doc.jsp" class="btn-back">Back to Home</a>
        </div>
    </div>
</body>
</html>
