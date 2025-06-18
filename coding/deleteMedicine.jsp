<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Medicine</title>
    <link rel="stylesheet" href="home.css">
    
</head>
<body>
    <div class="container">
        <h1>Delete Medicine</h1>
        <p class="note">Please do not delete medicine that has available stock.</p>
        <form method="get" action="deleteMedicine.jsp">
            <div class="form-group">
                <label for="medication_Category">Search by Medication Category</label>
                <select id="medication_Category" name="medication_Category" required>
                    <option value="">Select Category</option>
                    <option value="D">Fever (D)</option>
                    <option value="A">Antibiotic (A)</option>
                    <option value="S">Cold (S)</option>
                    <option value="SF">Nervous (SF)</option>
                    <option value="TS">Pain Relief (TS)</option>
                </select>
            </div>
            <button type="submit" class="btn-submit">Search</button>
        </form>

        <%
            String medicationCategory = request.getParameter("medication_Category");
            if (medicationCategory != null && !medicationCategory.isEmpty()) {
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

                    String query = "SELECT * FROM Medication WHERE medication_Category = ?";
                    stmt = connection.prepareStatement(query);
                    stmt.setString(1, medicationCategory);
                    resultSet = stmt.executeQuery();

                    if (resultSet.next()) {
                        String medicationCode = resultSet.getString("medication_Code");
                        String medicationName = resultSet.getString("medication_Name");
                        int medicationQuantity = resultSet.getInt("medication_Quantity");

                        out.println("<form action='deleteMedicineProcess.jsp' method='post'>");
                        out.println("<div class='form-group'>");
                        out.println("<label for='medication_Code'>Medication Code</label>");
                        out.println("<input type='text' id='medication_Code' name='medication_Code' value='" + medicationCode + "' readonly>");
                        out.println("</div>");
                        out.println("<div class='form-group'>");
                        out.println("<label for='medication_Name'>Medication Name</label>");
                        out.println("<input type='text' id='medication_Name' name='medication_Name' value='" + medicationName + "' readonly>");
                        out.println("</div>");
                        out.println("<div class='form-group'>");
                        out.println("<label for='medication_Category'>Medication Category</label>");
                        out.println("<input type='text' id='medication_Category' name='medication_Category' value='" + medicationCategory + "' readonly>");
                        out.println("</div>");
                        out.println("<div class='form-group'>");
                        out.println("<label for='medication_Quantity'>Medication Quantity</label>");
                        out.println("<input type='number' id='medication_Quantity' name='medication_Quantity' value='" + medicationQuantity + "' readonly>");
                        out.println("</div>");
                        out.println("<button type='submit' class='btn-delete'>Delete</button>");
                        out.println("</form>");
                    } else {
                        out.println("<p>No medication found for the selected category.</p>");
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
