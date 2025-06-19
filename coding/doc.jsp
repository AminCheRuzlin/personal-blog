<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Home</title>
    <link rel="stylesheet" href="home.css">
   
</head>
<body>
    <div class="container">
        <%
            String username = (String) session.getAttribute("user");
            if (username == null || username.isEmpty()) {
                response.sendRedirect("login.jsp"); // Redirect to login page if user is not logged in
            }
        %>
        <h1>Welcome Dr. <%= username %></h1>
        </br>
        <ul>
            <li class="menu-item"><b>Profile</b></li>
            <li class="menu-item"><a href="updateProfiledoc.jsp">Update Doctor Profile</a></li>
            <li class="menu-item"><a href="changePassworddoc.jsp">Change Password</a></li></br>
            <li class="menu-item"><b>Treatment and Prescription Menu</b></li>
                <ul class="nested-list">
                    <li class="menu-item"><a href="treatmentAndDispensingMedicine.jsp">Treatment and Dispensing Medicine</a></li>
                </ul>
            </li></br>
            <li class="menu-item"><b>Report Menu</b></li>
                <ul class="nested-list">
                    <li class="menu-item"><a href="treatmentReportByPatient.jsp">Treatment Report by Patient</a></li>
                    <li class="menu-item"><a href="medicineDispensingReportByPatient.jsp">Medicine Dispensing Report by Patient</a></li>
                </ul>
            </li>
        </ul>
        <a href="logout.jsp" class="logout">Logout</a>
    </div>
</body>
</html>
