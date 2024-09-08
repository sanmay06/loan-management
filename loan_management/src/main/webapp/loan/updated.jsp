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
    String interestRateStr = request.getParameter("interest");
    String loanStatus = request.getParameter("LoanStatus");
    
    if (loanID != null) {
        Connection con = null;
        PreparedStatement stmt = null;
        try {
            int balance = balanceStr != null && !balanceStr.isEmpty() ? Integer.parseInt(balanceStr) : -1;
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "1234");

            StringBuilder query = new StringBuilder("UPDATE loan SET ");
            boolean hasPrevious = false;

            if (balance != -1) {
                query.append("RemainingBalance = ?");
                hasPrevious = true;
            }

            if (interestRateStr != null && !interestRateStr.isEmpty()) {
                if (hasPrevious) query.append(", ");
                query.append("InterestRate = ?");
                hasPrevious = true;
            }

            if (loanStatus != null && !loanStatus.isEmpty()) {
                if (hasPrevious) query.append(", ");
                query.append("LoanStatus = ?");
            }

            query.append(" WHERE LoanID = ?");

            stmt = con.prepareStatement(query.toString());
            int index = 1;

            if (balance != -1) {
                stmt.setInt(index++, balance);
            }

            if (interestRateStr != null && !interestRateStr.isEmpty()) {
                stmt.setString(index++, interestRateStr);
            }

            if (loanStatus != null && !loanStatus.isEmpty()) {
                stmt.setString(index++, loanStatus);
            }

            stmt.setString(index, loanID);
            stmt.executeUpdate();
            response.sendRedirect("/loan_management/home");
        } catch (NumberFormatException e) {
            out.println("Invalid number format.");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) stmt.close();
            if (con != null) con.close();
        }
    } else {
        out.println("Invalid parameters");
    }
    %>
</body>
</html>
