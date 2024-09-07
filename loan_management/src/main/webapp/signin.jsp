<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import =" java.sql.* , jakarta.servlet.http.Cookie , jakarta.servlet.http.HttpSession " %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>signing in</title>
</head>
<body>
<%
String username = request.getParameter("username");
String password = request.getParameter("password");
String remember = request.getParameter("remember");

try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "1234")) {
    String query = "SELECT * FROM Login WHERE username = ? OR email = ?";
    try (PreparedStatement stmt = con.prepareStatement(query)) {
        stmt.setString(1, username);
        stmt.setString(2, username);

        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                if (rs.getString("password").equals(password)) { 
                    HttpSession s = request.getSession();
                    s.setAttribute("Username", rs.getString("username")); 

                    if ("yes".equals(remember)) {
                        Cookie cookie = new Cookie("projuser", rs.getString("username"));
                        cookie.setMaxAge(86400); 
                        cookie.setPath("/");
                        response.addCookie(cookie);
                    }
                    
                    response.sendRedirect("home");
                } else {
                    response.sendRedirect("loginfail");
                }
            } else {
            	response.sendRedirect("loginfail.jsp");
            }
        }
    }
} catch (Exception e) {
	response.sendRedirect("loginfail.jsp");
}
%>
</body>
</html>