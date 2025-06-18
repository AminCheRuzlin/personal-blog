<%-- 
    Document   : logout
    Created on : Jul 5, 2024, 10:28:35 PM
    Author     : fatta
--%>

<%
session.setAttribute("user", null);
session.invalidate();
response.sendRedirect("login.jsp");
%>