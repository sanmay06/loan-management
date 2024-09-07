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
    <%
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            String user = null;
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("projuser")) {
                    user = cookie.getValue();
                }
            }

            if (user != null && !user.equals("loggedout")) {
                try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "1234");
                     PreparedStatement stmt = con.prepareStatement("SELECT * FROM login WHERE email = ? OR username = ?")) {

                    stmt.setString(1, user);
                    stmt.setString(2, user);

                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            HttpSession userSession = request.getSession(); 
                            userSession.setAttribute("Username", rs.getString("username"));
                            response.sendRedirect("home");
                            return; 
                        }
                    }
                } catch (Exception e) {
                    log("Database connection or query failed", e);
                    response.getWriter().println("An error occurred while processing your request. Please try again later.");
                }
            }
        }
    %>

    <section class='main'>
        <div class='text'>
            <h1>About This Project</h1>
            This project is a fun project made using JSP, JAVA servlet for backend, and HTML and CSS for frontend.
        </div>
        <div class='form'>
            <h1>Login</h1>
            <form action='sign-in' method='post'>
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
                New user? <a href="register.html">Sign-up</a>
            </div>
        </div>
    </section>
</body>
</html>
