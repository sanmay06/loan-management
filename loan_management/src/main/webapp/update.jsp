<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.* " %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel='stylesheet' href='stylesheet.css'>
<title>update</title>
</head>
<body>
	
	<section class='table'>
        <%
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "1234");
            String query = "SELECT * FROM Loan WHERE user = ?";
            pstmt = con.prepareStatement(query);
            HttpSession s = request.getSession();
            String user = (String) s.getAttribute("Username");
            pstmt.setString(1, user);
            rs = pstmt.executeQuery();
        %>
        <table>
            <thead>
                <tr>
                    <th>Loan ID</th>
                    <th>Loan Amount</th>
                    <th>Interest Rate</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Remaining Balance</th>
                </tr>
            </thead>
            <tbody>
        <%
            while (rs.next()) {
        %>
                <tr>
                    <td><%= rs.getString(1) %></td>
                    <td><%= rs.getString(3) %></td>
                    <td><%= rs.getString(4) %></td>
                    <td><%= rs.getString(5) %></td>
                    <td><%= rs.getString(6) %></td>
                    <td><%= rs.getString(7) %></td>
                </tr>
        <%
            }
        } catch (Exception e) {
            response.getWriter().println(e);
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (con != null) try { con.close(); } catch (SQLException ignore) {}
        }
        %>
</body>
</html>