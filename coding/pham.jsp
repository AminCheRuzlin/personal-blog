<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pharmacy Employee Home</title>

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
        <h1>Welcome Pharmacist, <%= username %></h1><br>
        <ul>
            <li class="menu-item"><b>Profile</b></li>
            <li class="menu-item"><a href="updateProfilepham.jsp">Update Pharmacy Profile</a></li>
            <li class="menu-item"><a href="changePasswordpham.jsp">Change Password</a></li></br>
            <li class="menu-item"><b>Medicine Menu</b></li>
                <ul class="nested-list">
                    <li class="menu-item"><a href="addMedicine.jsp">Add Medicine</a></li>
                    <li class="menu-item"><a href="updateMedicine.jsp">Update Medicine</a></li>
                    <li class="menu-item"><a href="deleteMedicine.jsp">Delete Medicine</a></li>
                </ul>
            </li></br>
            <li class="menu-item"><b>Payment Menu</b></li>
                <ul class="nested-list">
                    <li class="menu-item"><a href="ltt.jsp">List of Treatments (Today)</a></li>
                    <li class="menu-item"><a href="display.jsp">Display Detail Treatment and Payment - update</a></li>
                </ul>
            </li></br>
            <li class="menu-item"><b>Report Menu</b></li>
                <ul class="nested-list">
                    <li class="menu-item"><a href="allMedicineReport.jsp">All Medicine Report</a></li>
                    <li class="menu-item"><a href="medicineReportByCategory.jsp">Medicine Report by Medicine Category</a></li>
                    <li class="menu-item"><a href="medicineStockReport.jsp">Medicine Stock Report</a></li>
                    <li class="menu-item"><a href="reportdate.jsp">Payment Report by Date (From Date to Date)</a></li>
                </ul>
            </li>
        </ul>
        <br>
        <a href="logout.jsp" class="logout">Logout</a>
    </div>
</body>
</html>
