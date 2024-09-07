<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.Cookie" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
<link rel='stylesheet' href='stylesheet.css'>
</head>
<body>
    <section class='main'>
        <div class='text'>
            <h1>About This Project</h1>
            This project is a fun project made using JSP, JAVA servlet for backend, and HTML and CSS for frontend.
        </div>
        <div class='form'>
            <h1>Login</h1>
            <form action='sign-in' method='post'>
            	<div style='color:red;'>Invalid username or password </div>
                <label for="username">User name or Email Id:</label><br>
                <input type="text" id="username" name='username' required><br>
                <label for="password">Password:</label><br>
                <input id='password' type='password' name='password' pattern="[A-Za-z0-9]{8,}" required><br>
                <div class='button'>
    				<label>
        				<input type="checkbox" name='remember' value="yes" class="check"> Remember me
    				</label>
				</div>

                <input type="submit" value="Sign-in"><br>
                <hr class='bor'>
                <h3 style="display:inline-block;">OR</h3>
                <hr class='bor'>
            </form>
            <div class="reg">
                New user? <a href="reg.html">Sign-up</a>
            </div>
        </div>
    </section>
</body>
</html>
