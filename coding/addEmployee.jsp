<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Management</title>
    <link rel="stylesheet" href="main.css">
    <style>
        .error {
            color: red;
            font-size: 0.875em;
        }
    </style>
    <script>
        function validatePassword() {
            const password = document.getElementById('pass').value;
            const errorElement = document.getElementById('passwordError');
            const strongPasswordPattern = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).{8,}$/;

            if (!strongPasswordPattern.test(password)) {
                errorElement.textContent = "Password must be at least 8 characters long, contain at least one number, one uppercase letter, one lowercase letter, and one special character.";
                return false;
            }

            errorElement.textContent = "";
            return true;
        }
    </script>
</head>
<body><%
       
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String username = (String) session.getAttribute("user");
    %>
    <div class="form-maker">
        <br><div class="label">Add New Employee</div>
        <form action="addemployeeAction.jsp" method="post" class="signup-form sign" name="form" onsubmit="return validatePassword()">
            <div class="font">Create Username of Employee</div>
            <input type="text" placeholder="Enter Username" name="user" id="user" required></br>
<div></div>
            <br><div class="font">Create Password of Employee</div>
            <input type="password" placeholder="Enter Password" name="pass" id="pass" required></br>
            <div id="passwordError" class="error"></div>
<div></div>
            <br><div class="font">Enter Employee IC</div>
            <input type="text" placeholder="Enter IC" name="ic" id="ic" required></br>
<div></div>
            <br><div class="font">Enter Employee Name</div>
            <input type="text" placeholder="Enter Name" name="name" id="name" required></br>
<div></div>
            <br><div class="font">Enter Employee Gender</div>
            <select id="gender" name="gender" required></br>
                <option value="">Select Gender</option>
                <option value="Men">Men</option>
                <option value="Women">Women</option>
            </select></br>
<div></div>
<br><div class="font">Enter Employee Phone Number</div>
            <input type="text" placeholder="Enter Phone Number" name="phone" id="phone" required></br>
<div></div>
            <br><div class="font">Enter Employee Date Of Birth </div>
            <input type="date" placeholder="Enter Date of Birth" name="Dob" id="Dob" required></br>
<div></div>
            <br><div class="font">Enter Employee Address</div>
            <input type="text" placeholder="Enter Address" name="add" id="add" required></br>
<div></div>
            <br><div class="font">Enter Employee Position</div>
            <select id="position" name="pos" required>
                <option value="">Select Position</option>
                <option value="D">D</option>
                <option value="P">P</option>
            </select></br>

            <center><input type="submit" class="sub" value="Save"></center>
        </form>
        <center><a href="clerk.jsp" class="back-button">Back</a></center>
    </div>
</body>
</html>
