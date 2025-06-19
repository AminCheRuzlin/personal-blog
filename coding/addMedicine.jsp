<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Medicine</title>
    <link rel="stylesheet" href="home.css">
   <script>
        function validateForm() {
            const medicationCode = document.getElementById('medication_Code');
            const medicationName = document.getElementById('medication_Name');
            const medicationCategory = document.getElementById('medication_Category');
            const medicationQuantity = document.getElementById('medication_Quantity');

            if (medicationCode.value.length > 5) {
                alert('Medication Code must be 5 characters or less.');
                medicationCode.focus();
                return false;
            }

            if (medicationName.value.length > 40) {
                alert('Medication Name must be 40 characters or less.');
                medicationName.focus();
                return false;
            }

            if (medicationCategory.value.length > 2) {
                alert('Medication Category must be 2 characters or less.');
                medicationCategory.focus();
                return false;
            }

            if (medicationQuantity.value.length > 4) {
                alert('Medication Quantity must be 4 digits or less.');
                medicationQuantity.focus();
                return false;
            }

            return true;
        }
    </script>

</head>
<body>
    <div class="container">
        <h1>Add Medicine</h1>
        <div class="note">
            <strong>Note:</strong>
            <p>Please use the following categories for the medicines:</p>
            <ul>
                <li>Fever (D)</li>
                <li>Antibiotic (A)</li>
                <li>Cold (S)</li>
                <li>Nervous (SF)</li>
                <li>Pain Relief (TS)</li>
            </ul> <p><strong>Medication Code Format:</strong> The medication code should start with the category letter followed by a 3-digit number (e.g., Fever: D001, Antibiotic: A001).</p>
        </div>
        
        <form action="addMedicineProcess.jsp" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="medication_Code">Medication Code</label>
                <input type="text" id="medication_Code" name="medication_Code" maxlength="5" required>
            </div>
            <div class="form-group">
                <label for="medication_Name">Medication Name</label>
                <input type="text" id="medication_Name" name="medication_Name" maxlength="40" required>
            </div>
            <div class="form-group">
                <label for="medication_Category">Medication Category</label>
                <select id="medication_Category" name="medication_Category" required>
                    <option value="">Select Category</option>
                    <option value="D">Fever (D)</option>
                    <option value="A">Antibiotic (A)</option>
                    <option value="S">Cold (S)</option>
                    <option value="SF">Nervous (SF)</option>
                    <option value="TS">Pain Relief (TS)</option>
                </select>
            </div>
            <div class="form-group">
                <label for="medication_Quantity">Medication Quantity</label>
                <input type="number" id="medication_Quantity" name="medication_Quantity" required>
            </div>
            <button type="submit" class="btn-submit">Add Medicine</button>
        </form>
        <div class="back-button">
        <a href="pham.jsp">Back to Home</a>
    </div>
    </div>
</body>
</html>
