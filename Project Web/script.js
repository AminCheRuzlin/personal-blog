// Show message on blog page
function showMessage() {
  const msg = document.getElementById("message");
  if (msg) {
    msg.textContent = "Thanks for visiting my blog!";
  }
}

// Simulate login (store login state)
function loginUser() {
  const username = document.getElementById("username").value;
  const password = document.getElementById("password").value;
  const error = document.getElementById("login-error");

  const validUsername = "admin";
  const validPassword = "1234";

  if (username === validUsername && password === validPassword) {
    localStorage.setItem("loggedIn", "true");
    window.location.href = "index.html";
    return false;
  } else {
    error.textContent = "Invalid username or password.";
    return false;
  }
}

// Check login before showing blog page
function checkLogin() {
  if (localStorage.getItem("loggedIn") !== "true") {
    window.location.href = "login.html";
  }
}

// Logout and clear login
function logoutUser() {
  localStorage.removeItem("loggedIn");
  window.location.href = "login.html";
}
