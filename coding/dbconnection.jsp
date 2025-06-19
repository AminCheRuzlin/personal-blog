<%@ page import="java.sql.*" %>

<%! 
    // Method to establish a connection to the database
    public Connection getConnection() throws Exception {
        String dbURL = "jdbc:mysql://localhost/sql_aminruzlin";
        String dbUser = "sql_aminruzlin";
        String dbPass = "3xGtKK7bia7j8XNh";
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(dbURL, dbUser, dbPass);
    }

    // Method to test the database connection
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

<%
    // Uncomment the following line to test the connection when this JSP file is included
    // testConnection();
%>
