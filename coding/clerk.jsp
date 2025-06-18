<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clerk Home Menu</title>
     <link rel="stylesheet" href="home.css">
    
</head>
<body>
    <center>
        <div class="container">
            <%
                String username = (String) session.getAttribute("user");
                if (username == null || username.isEmpty()) {
                    response.sendRedirect("login.jsp"); // Redirect to login page if user is not logged in
                }
            %>
            <h1>Welcome Clerk, <%= username %></h1><br>
            <ul>
                <li class="menu-item"><b>Profile</b></li>
                <li class="menu-item"><a href="updateProfile.jsp">Update Clerk Profile</a></li>
                <li class="menu-item"><a href="changePassword.jsp">Change Password</a></li></br>
                <li class="menu-item"><b>Employee Menu</b></li>
                    <ul class="nested-list">
                        <li class="menu-item"><a href="addEmployee.jsp">Add Employee</a></li>
                        <li class="menu-item"><a href="deleteEmployee.jsp">Delete Employee</a></li>
                    </ul>
                </li></br>
                <li class="menu-item"><b>Patient Menu</b></li>
                    <ul class="nested-list">
                        <li class="menu-item"><a href="addPatient.jsp">Add New Patient</a></li>
                        <li class="menu-item"><a href="updatePatient.jsp">Update Patient</a></li>
                        <li class="menu-item"><a href="deletePatient.jsp">Delete Patient</a></li>
                    </ul>
                </li></br>
                <li class="menu-item"><b>Treatment Menu</b></li>
                    <ul class="nested-list">
                        <li class="menu-item"><a href="registerTreatment.jsp">Register Patient Treatment</a></li>
                    </ul>
                </li></br>
                <li class="menu-item"><b>Report Menu</b></li>
                    <ul class="nested-list">
                        <li class="menu-item"><a href="reportAllPatients.jsp">Report of all Patients</a></li>
                        <li class="menu-item"><a href="reportRegistrationsByDate.jsp">Report of Patient Registrations by Date</a></li>
                    </ul>
                </li>
            </ul>
            <a href="logout.jsp" class="logout">Logout</a>
        </div>
    </center>
</body>
</html>
