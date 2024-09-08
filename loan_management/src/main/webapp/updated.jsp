<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Loan</title>
</head>
<body>
    <%
    String loanID = request.getParameter("loanid");
    String balanceStr = request.getParameter("balance");
    if (loanID != null && balanceStr != null) {
        try {
            int balance = Integer.parseInt(balanceStr);
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = null;
            PreparedStatement stmt = null;
            try {
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "1234");
                String query = "UPDATE loan SET RemainingBalance = ? WHERE LoanID = ?";
                stmt = con.prepareStatement(query);
                stmt.setInt(1, balance);
                stmt.setString(2, loanID);
                stmt.executeUpdate();
            } finally {
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {
        out.println("Invalid parameters");
    }
	response.sendRedirect("/loan_management/home");
    %>
</body>
</html>
