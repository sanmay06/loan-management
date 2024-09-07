<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="jakarta.servlet.http.Cookie" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Loans</title>
<link rel="stylesheet" href="stylesheet.css">
</head>
<body>
    <div class='header'>
        <button onclick="window.location.href='profile'">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
                <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6"/>
            </svg>
            Profile
        </button>
        <div class='h1'>Home</div>
        <form method='post'>
            <button type='submit' name='logout'>
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-box-arrow-left" viewBox="0 0 16 16">
                    <path fill-rule="evenodd" d="M6 12.5a.5.5 0 0 0 .5.5h8a.5.5 0 0 0 .5-.5v-9a.5.5 0 0 0-.5-.5h-8a.5.5 0 0 0-.5.5v2a.5.5 0 0 1-1 0v-2A1.5 1.5 0 0 1 6.5 2h8A1.5 1.5 0 0 1 16 3.5v9a1.5 1.5 0 0 1-1.5 1.5h-8A1.5 1.5 0 0 1 5 12.5v-2a.5.5 0 0 1 1 0z"/>
                    <path fill-rule="evenodd" d="M.146 8.354a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L1.707 7.5H10.5a.5.5 0 0 1 0 1H1.707l2.147 2.146a.5.5 0 0 1-.708.708z"/>
                </svg>
                Log-out
            </button>
        </form>
        <%
        String button = request.getParameter("logout");
        if (button != null) {
            // Handle logout
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("projuser")) { 
                        cookie.setPath("/");
                        cookie.setValue("loggedout");
                        cookie.setMaxAge(1000); 
                        response.addCookie(cookie);
                    }
                }
            }
            HttpSession s = request.getSession(false);
            if (s != null) {
                s.invalidate();
            }
            response.sendRedirect("login");
        }
        %>
    </div>
    <div class='menu'>
        <button onclick="window.location.href='/loan_management/home/insert.html'">Insert</button>
        <button onclick="window.location.href='/loan_management/home/update'">Update</button>
        <button onclick="window.location.href='/loan_management/home/delete'">Delete</button>
    </div>
    <h2>Loans</h2>
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
            </tbody>
        </table>
    </section>
</body>
</html>
