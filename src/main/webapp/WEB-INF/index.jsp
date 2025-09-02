<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Survey</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/survey.css">
</head>
<body>
  <div class="container">

    <!-- HERO header đỏ -->
    <div class="hero">
      <img src="${pageContext.request.contextPath}/images/murachlogo.jpg" alt="Murach Logo">
      <div>
        <h1>Survey</h1>
        <p>If you have a moment, we'd appreciate it if you would fill out this survey.</p>
      </div>
    </div>

    <!-- Card chứa form -->
    <div class="card">
      <form action="${pageContext.request.contextPath}/survey" method="post">
        <!-- Your information -->
        <div class="section">
          <h2>Your information:</h2>
          <div class="form-grid">
            <label for="fn">First Name</label>
            <input id="fn" class="input" type="text" name="firstName" required>

            <label for="ln">Last Name</label>
            <input id="ln" class="input" type="text" name="lastName" required>

            <label for="em">Email</label>
            <input id="em" class="input" type="email" name="email" required>

            <label for="dob">Date of Birth</label>
            <input id="dob" class="input" type="date" name="dob" required>
          </div>
        </div>

        <!-- Heard from -->
        <div class="section">
          <h2>How did you hear about us?</h2>
          <div class="choice-group">
            <label class="choice"><input type="radio" name="heardFrom" value="Search Engine" checked> Search engine</label>
            <label class="choice"><input type="radio" name="heardFrom" value="Word of mouth"> Word of mouth</label>
            <label class="choice"><input type="radio" name="heardFrom" value="Social Media"> Social Media</label>
            <label class="choice"><input type="radio" name="heardFrom" value="Other"> Other</label>
          </div>
        </div>

        <!-- Announcements -->
        <div class="section">
          <h2>Would you like to receive announcements about new CDs and special offers?</h2>
          <label class="choice"><input type="checkbox" name="receive"> YES, I'd like that.</label>
          <div class="helper">We only send a few messages per month.</div>
          <label class="choice" style="margin-top:10px;"><input type="checkbox" name="emailAnn"> YES, please send me email announcements.</label>
        </div>

        <!-- Contact -->
        <div class="section">
          <h2>Preferred contact method</h2>
          <select name="contactVia" class="input" style="max-width:260px;">
            <option value="Email">Email</option>
            <option value="Postal mail">Postal mail</option>
            <option value="Both">Both</option>
          </select>
        </div>

        <div class="actions">
          <button class="btn primary" type="submit">Submit</button>
          <button class="btn ghost" type="reset">Reset</button>
        </div>
      </form>
    </div>
  </div>
</body>
</html>
