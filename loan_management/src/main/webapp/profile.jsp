<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import='java.sql.*' %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile</title>
<link rel='stylesheet' href='stylesheet.css'>
<script>
    function checkChanges() {
        let emailField = document.getElementById('email');
        let salaryField = document.getElementById('salary');

        // Initial values for comparison
        const originalEmail = emailField.value;
        const originalSalary = salaryField.value;

        emailField.addEventListener('input', function() {
            if (emailField.value !== originalEmail) {
                document.getElementById('saveChanges').disabled = false;
            }
        });

        salaryField.addEventListener('input', function() {
            if (salaryField.value !== originalSalary) {
                document.getElementById('saveChanges').disabled = false;
            }
        });
    }
</script>
</head>
<body onload="checkChanges()">
	 <div class='header'>
        <button onclick="window.location.href='home'">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house" viewBox="0 0 16 16">
  <path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L2 8.207V13.5A1.5 1.5 0 0 0 3.5 15h9a1.5 1.5 0 0 0 1.5-1.5V8.207l.646.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293zM13 7.207V13.5a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5V7.207l5-5z"/>
</svg>
            Home
        </button>
        <div class='h1'>Profile  </div>
        <div class='span'>   </div>
        </div>
    <%
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "1234");
        HttpSession s = request.getSession();
        String user = (String) s.getAttribute("Username");
        String q="Select * from login where username = ?";
        PreparedStatement stmt = con.prepareStatement(q);
        stmt.setString(1, user);
        ResultSet rs = stmt.executeQuery();
        rs.next();
        String email = rs.getString(3);
        int salary = rs.getInt(4);
        rs.close();
        stmt.close();
        con.close();
    %>
    <section class='main'>
        <div class='form'>
            <form action='profilesave' method='POST'>
                Name:<br><input type='text' value='<%= user %>' name='name' readonly>
                <hr>
                Email:<br><input type='email' value='<%= email %>' name='email' id='email'>
                <hr>
                Salary:<br><input type='number' value='<%= salary %>' name='salary' id='salary'>
                <hr>
                <button type='submit' id='saveChanges' disabled>Save Changes</button>
            </form>
        </div>
    </section>
</body>
</html>
