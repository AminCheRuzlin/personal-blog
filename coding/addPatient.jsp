<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Add Patient</title>
    
   <link rel="stylesheet" href="home.css">
    <script>
        function showAlert(message, redirectUrl) {
            alert(message);
            window.location.href = redirectUrl;
        }

        
    </script>
</head>
<body>
    <div class="container">
        <h1>Add Patient</h1>
        <form method="post" action="addPatientAction.jsp" >
            <label for="patient_IC">Identification Number:</label>
            <input type="text" id="patient_IC" name="IC" required maxlength="12"><br>
            
            <label for="patient_Name">Name:</label>
            <input type="text" id="patient_Name" name="Name" required maxlength="25"><br>
            
            <label for="patient_Gender">Gender:</label>
            <select id="patient_Gender" name="Gender" required>
                <option value="">Select Gender</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
            </select><br><br>
            
            <label for="patient_PhoneNumber">Phone Number:</label>
            <input type="text" id="patient_PhoneNumber" name="PhoneNumber" required maxlength="10"><br>
            
            <label for="patient_DateOfBirth">Date of Birth:</label>
            <input type="date" id="patient_DateOfBirth" name="DateOfBirth" required><br>
            
            <label for="patient_RegistrationDate">Registration Date:</label>
            <input type="date" id="patient_RegistrationDate" name="RegistrationDate" required><br>
            
             <label for="patient_timereg">Registration Time:</label>
            <input type="time" id="patient_RegistrationTime" name="RegistrationTime"><br><br>
            
            <label for="patient_Address">Address:</label>
            <input type="text" id="patient_Address" name="Address" required maxlength="100"><br>
            
            <label for="patient_Allergy">Allergy to Medication:</label>
            <input type="text" id="patient_Allergy" name="Allergy" required maxlength="30"><br>
            
            <center><button type="submit">Add Patient</button></center>
        </form>

        <div class="back-button">
            <a href="clerk.jsp" class="logout">Back</a>
        </div>
    </div>
</body>
</html>
