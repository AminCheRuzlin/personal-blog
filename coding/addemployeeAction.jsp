<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Registration</title>
</head>
<body>
    <%
        Connection connection = null;
        PreparedStatement loginStmt = null;
        PreparedStatement employeeStmt = null;
        ResultSet generatedKeys = null;
        String message = "";
        try {
            // Declaration and connection to MySQL database
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            String url = "jdbc:mysql://localhost/sql_aminruzlin";
            String username = "sql_aminruzlin";
            String passwordMySQL = "3xGtKK7bia7j8XNh";
            connection = DriverManager.getConnection(url, username, passwordMySQL);
            out.println("Database connection established successfully.<br>");

            // Get parameters from the request
            String user = request.getParameter("user");
            String pass = request.getParameter("pass");
            String ic = request.getParameter("ic");
            String name = request.getParameter("name");
            String gender = request.getParameter("gender");
            String phone = request.getParameter("phone");
            String dob = request.getParameter("Dob");
            String address = request.getParameter("add");
            String position = request.getParameter("pos"); 

            // Validate parameters
            List<String> missingParams = new ArrayList<>();
            Map<String, String> params = new HashMap<>();
            params.put("user", user);
            params.put("pass", pass);
            params.put("ic", ic);
            params.put("name", name);
            params.put("gender", gender);
            params.put("phone", phone);
            params.put("Dob", dob);
            params.put("add", address);
            params.put("pos", position);

            for (Map.Entry<String, String> entry : params.entrySet()) {
                if (entry.getValue() == null || entry.getValue().isEmpty()) {
                    missingParams.add(entry.getKey());
                }
            }

            if (!missingParams.isEmpty()) {
                // Set error message for missing parameters
                String errorMessage = "Missing parameters: " + String.join(", ", missingParams);
                message = "Error: " + java.net.URLEncoder.encode(errorMessage, "UTF-8");
            } else {
                // Insert into login table
                String loginQuery = "INSERT INTO Login (login_loginID, login_password) VALUES (?, ?)";
                loginStmt = connection.prepareStatement(loginQuery, Statement.RETURN_GENERATED_KEYS);
                loginStmt.setString(1, user);
                loginStmt.setString(2, pass);
                int rowsInserted = loginStmt.executeUpdate();

                if (rowsInserted > 0) {
                    generatedKeys = loginStmt.getGeneratedKeys();
                    int loginID = 0;
                    if (generatedKeys.next()) {
                        loginID = generatedKeys.getInt(1);
                    }

                    // Insert into employee table using the generated loginID
                    String employeeQuery = "INSERT INTO Employee (employee_loginID, employee_IC, employee_Name, employee_Gender, employee_PhoneNumber, employee_DateOfBirth, employee_Address, employee_position) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                    employeeStmt = connection.prepareStatement(employeeQuery);
                    employeeStmt.setString(1, user);  // Use loginID here
                    employeeStmt.setString(2, ic);
                    employeeStmt.setString(3, name);
                    employeeStmt.setString(4, gender);
                    employeeStmt.setString(5, phone);
                    employeeStmt.setString(6, dob);
                    employeeStmt.setString(7, address);
                    employeeStmt.setString(8, position);
                    employeeStmt.executeUpdate();

                    // Set success message
                    message = "Success: Registration completed successfully.";
                } else {
                    // Set error message for failed insertion into login table
                    message = "Error: Failed to insert into login table.";
                }
            }
        } catch (SQLException e) {
            message = "Error: SQL Error: " + java.net.URLEncoder.encode(e.getMessage(), "UTF-8");
        } catch (ClassNotFoundException e) {
            message = "Error: JDBC Driver not found: " + java.net.URLEncoder.encode(e.getMessage(), "UTF-8");
        } catch (Exception e) {
            message = "Error: " + java.net.URLEncoder.encode(e.getMessage(), "UTF-8");
        } finally {
            // Close resources
            if (generatedKeys != null) try { generatedKeys.close(); } catch (SQLException ignore) {}
            if (loginStmt != null) try { loginStmt.close(); } catch (SQLException ignore) {}
            if (employeeStmt != null) try { employeeStmt.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
        }
    %>
    <script type="text/javascript">
        var message = "<%= message %>";
        if (message.startsWith("Success")) {
            alert(message);
            window.location.href = "addEmployee.jsp";
        } else if (message.startsWith("Error")) {
            alert(message);
            window.location.href = "addEmployee.jsp";
        }
    </script>
</body>
</html>
