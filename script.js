function toggleProject(id) {
  const section = document.getElementById(id);
  const button = section.previousElementSibling.querySelector("button");

  if (section.style.display === "block") {
    section.style.display = "none";
    button.textContent = "View";
  } else {
    section.style.display = "block";
    button.textContent = "Hide";
  }
}
function toggleDarkMode() {
  const body = document.body;
  const button = document.getElementById("toggle-dark");

  body.classList.toggle("dark-mode");

  if (body.classList.contains("dark-mode")) {
    button.textContent = "☀️ Light Mode";
  } else {
    button.textContent = "🌙 Dark Mode";
  }
}

