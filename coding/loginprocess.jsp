<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ include file="dbconnection.jsp" %>
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
%>
<%
    String username = escapeHtml(request.getParameter("user"));
    String password = escapeHtml(request.getParameter("pass"));

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        conn = getConnection();
        if (conn == null) {
            out.println("<script>");
            out.println("alert('Database connection failed. Please try again later.');");
            out.println("window.location.replace('login.jsp');");
            out.println("</script>");
            return;
        }

        String sql = "SELECT e.employee_Position, l.login_password FROM Login l JOIN Employee e ON l.login_loginID = e.employee_loginID WHERE l.login_loginID = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, username);

        rs = ps.executeQuery();

        if (rs.next()) {
            String storedPassword = rs.getString("login_password");
            String position = rs.getString("employee_Position");

            // Check if the password matches
            if (password.equals(storedPassword)) {
                // Use the implicit session object
                session.setAttribute("user", escapeHtml(username));
                
                String redirectURL = "";
                if ("C".equals(position)) {
                    redirectURL = "clerk.jsp";
                } else if ("D".equals(position)) {
                    redirectURL = "doc.jsp";
                } else if ("P".equals(position)) {
                    redirectURL = "pham.jsp";
                }

                // Generate JavaScript to redirect
                out.println("<script>");
                out.println("alert('Welcome to the Klinik AUFA');");
                out.println("window.location.replace('" + escapeHtml(redirectURL) + "?sessionid=" + escapeHtml(session.getId()) + "');");
                out.println("</script>");
            } else {
                out.println("<script>");
                out.println("alert('Invalid username or password');");
                out.println("window.location.replace('login.jsp');");
                out.println("</script>");
            }
        } else {
            out.println("<script>");
            out.println("alert('Invalid username or password');");
            out.println("window.location.replace('login.jsp');");
            out.println("</script>");
        }
    } catch (Exception e) {
        out.println("<script>");
        out.println("alert('An error occurred. Please try again.');");
        out.println("window.location.replace('login.jsp');");
        out.println("</script>");
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
