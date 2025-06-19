<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%! 
    // Function to escape HTML to prevent XSS
    public String escapeHtml(String s) {
        if (s == null) {
            return null;
        }
        return s.replaceAll("&", "&amp;")
                .replaceAll("<", "&lt;")
                .replaceAll(">", "&gt;")
                .replaceAll("\"", "&quot;")
                .replaceAll("'", "&#x27;")
                .replaceAll("/", "&#x2F;");
    }

    public Connection getConnection() throws Exception {
        String dbURL = "jdbc:mysql://localhost/sql_aminruzlin";
        String dbUser = "sql_aminruzlin";
        String dbPass = "3xGtKK7bia7j8XNh";
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(dbURL, dbUser, dbPass);
    }

    public void testConnection() {
        Connection conn = null;
        try {
            conn = getConnection();
            if (conn != null) {
                System.out.println("Database connection successful.");
            }
        } catch (Exception e) {
            System.out.println("Failed to connect to the database: " + e.getMessage());
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Registration</title>
    <script type="text/javascript">
        function showError(message) {
            alert(message);
            window.location.replace("signup.html");
        }
        function showSuccess() {
            alert("Registration successful!");
            window.location.replace("login.jsp");
        }
    </script>
</head>
<body>
    <%
        Connection connection = null;
        PreparedStatement loginStmt = null;
        PreparedStatement employeeStmt = null;
        ResultSet generatedKeys = null;
        try {
            connection = getConnection();
            out.println("Database connection established successfully.<br>");

            // Get parameters from the request
            String user = escapeHtml(request.getParameter("user"));
            String pass = escapeHtml(request.getParameter("pass"));
            String ic = escapeHtml(request.getParameter("ic"));
            String name = escapeHtml(request.getParameter("name"));
            String gender = escapeHtml(request.getParameter("gender"));
            String phone = escapeHtml(request.getParameter("phone"));
            String dob = escapeHtml(request.getParameter("Dob"));
            String address = escapeHtml(request.getParameter("add"));
            String position = escapeHtml(request.getParameter("pos")); // Clerk, Doctor, Pharmacy

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
                // Redirect to signup.html with error message
                String errorMessage = "Missing parameters: " + String.join(", ", missingParams);
                response.sendRedirect("signup.html?error=" + java.net.URLEncoder.encode(errorMessage, "UTF-8"));
            } else {
                connection.setAutoCommit(false); // Start transaction

                try {
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

                        connection.commit(); // Commit transaction

                        // Display success message and redirect to login.jsp
                        out.println("<script>showSuccess();</script>");
                    } else {
                        throw new SQLException("Failed to insert into login table.");
                    }
                } catch (SQLException e) {
                    connection.rollback(); // Rollback transaction
                    out.println("<script>showError('SQL Error: " + escapeHtml(e.getMessage()) + "');</script>");
                }
            }
        } catch (SQLException e) {
            out.println("<script>showError('SQL Error: " + escapeHtml(e.getMessage()) + "');</script>");
        } catch (ClassNotFoundException e) {
            out.println("<script>showError('JDBC Driver not found: " + escapeHtml(e.getMessage()) + "');</script>");
        } catch (Exception e) {
            out.println("<script>showError('Error: " + escapeHtml(e.getMessage()) + "');</script>");
        } finally {
            // Close resources
            if (generatedKeys != null) try { generatedKeys.close(); } catch (SQLException ignore) {}
            if (loginStmt != null) try { loginStmt.close(); } catch (SQLException ignore) {}
            if (employeeStmt != null) try { employeeStmt.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
        }
    %>
</body>
</html>
