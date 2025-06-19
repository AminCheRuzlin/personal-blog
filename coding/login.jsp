<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Klinik Aufa</title>
    <link rel="stylesheet" href="login.css">
    <style>
        .password-wrapper {
            position: relative;
        }
        .toggle-password {
            position: absolute;
            right: 25px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
        }
    </style>
    <script>
        function demo() {
            var name = document.forms["form"]["user"].value;
            var pass = document.forms["form"]["pass"].value;
            var valid = true;
            
            if (name == "") {
                document.getElementById("name-error").style.display = "block";
                valid = false;
            } else {
                document.getElementById("name-error").style.display = "none";
            }
            
            if (pass == "") {
                document.getElementById("pass-error").style.display = "block";
                valid = false;
            } else {
                document.getElementById("pass-error").style.display = "none";
            }
            
            return valid;
        }

        function togglePassword() {
            var passInput = document.getElementById("password");
            var toggleIcon = document.getElementById("toggle-password");
            if (passInput.type === "password") {
                passInput.type = "text";
                toggleIcon.textContent = "Hide";
            } else {
                passInput.type = "password";
                toggleIcon.textContent = "Show";
            }
        }
    </script>
</head>
<body>
    <div class="form-maker">
        <div class="label"><br>Login</div>
        <form action="loginprocess.jsp" class="login-form" name="form" onsubmit="return demo()">
            <div class="font"> Enter Name : </div>
            <input type="text" placeholder="Enter Name" name="user">
            <div id="name-error">Enter Username </div>
            <div class="font font2"> Enter Password : </div>
            <div class="password-wrapper">
                <input type="password" placeholder="Enter Password" name="pass" id="password">
                <span id="toggle-password" class="toggle-password" onclick="togglePassword()">Show</span>
            </div>
            <div id="pass-error">Enter your Password</div>   
            <center><input type="submit" class="sub" value="Login"></center>
            <center><a class="sub" href="index.html">Back</a></center>
        </form>
    </div>
</body>
</html>
