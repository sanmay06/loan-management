<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.math.BigDecimal, java.sql.*" %>
<%
    HttpSession s = request.getSession(false); 
    String username = (String) s.getAttribute("Username");
    if (username == null) {
        response.sendRedirect("login.jsp"); 
        return;
    }

    String loanId = request.getParameter("loanid");
    String amountStr = request.getParameter("amount");
    String pdate = request.getParameter("date");
    String type = request.getParameter("type");
    String status = request.getParameter("status");

    if (loanId != null && amountStr != null && pdate != null) {
        try {
            BigDecimal amount = new BigDecimal(amountStr);
            Date date = Date.valueOf(pdate);

            Connection con = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "1234");

                // Retrieve the current remaining balance
                String balanceQuery = "SELECT RemainingBalance FROM Loan WHERE LoanID = ?";
                stmt = con.prepareStatement(balanceQuery);
                stmt.setString(1, loanId);
                rs = stmt.executeQuery();

                if (rs.next()) {
                    BigDecimal remainingBalance = rs.getBigDecimal("RemainingBalance");
                    
                    // Update the remaining balance
                    BigDecimal newBalance = remainingBalance.subtract(amount);
                    String updateQuery = "UPDATE Loan SET RemainingBalance = ? WHERE LoanID = ?";
                    stmt = con.prepareStatement(updateQuery);
                    stmt.setBigDecimal(1, newBalance);
                    stmt.setString(2, loanId);
                    stmt.executeUpdate();
                    
                    // Insert the payment record
                    String insertQuery = "INSERT INTO Payment (LoanID, PaymentDate, PaymentAmount, PaymentType, PaymentStatus) VALUES (?, ?, ?, ?, ?)";
                    stmt = con.prepareStatement(insertQuery);
                    stmt.setString(1, loanId);
                    stmt.setDate(2, date);
                    stmt.setBigDecimal(3, amount);
                    stmt.setString(4, type);
                    stmt.setString(5, status);
                    stmt.executeUpdate();

                    response.sendRedirect("/loan_management/home"); 
                } else {
                    response.getWriter().println("Loan not found.");
                }
            } catch (SQLException e) {
                e.printStackTrace(); 
                response.getWriter().println("Database error: " + e.getMessage());
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
                response.getWriter().println("Driver class not found: " + e.getMessage());
            } catch (Exception e) {
                e.printStackTrace(); 
                response.getWriter().println("Unexpected error: " + e.getMessage());
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
                if (con != null) try { con.close(); } catch (SQLException ignored) {}
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.getWriter().println("Invalid number format: " + e.getMessage());
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            response.getWriter().println("Invalid date format: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error processing input: " + e.getMessage());
        }
    } else {
        response.sendRedirect("insert.jsp"); 
    }
%>
