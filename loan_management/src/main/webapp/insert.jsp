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
    String interestStr = request.getParameter("interest");
    String remainStr = request.getParameter("remain");
    String start = request.getParameter("start");
    String end = request.getParameter("end");

    if (loanId != null && amountStr != null && interestStr != null && remainStr != null && start != null && end != null) {
        try {
            int amount = Integer.parseInt(amountStr);
            BigDecimal interest = new BigDecimal(interestStr);
            BigDecimal remaining = new BigDecimal(remainStr);
            Date startDate = Date.valueOf(start);
            Date endDate = Date.valueOf(end);

            String query = "INSERT INTO loan () VALUES (?, ?, ?, ?, ?, ?, ?)";
            
            Connection con = null;
            PreparedStatement stmt = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "1234");
                stmt = con.prepareStatement(query);
                stmt.setString(1, loanId);
                stmt.setString(2, username);
                stmt.setInt(3, amount);
                stmt.setBigDecimal(4, interest);
                stmt.setDate(5, startDate);
                stmt.setDate(6, endDate);
                stmt.setBigDecimal(7, remaining);
                stmt.executeUpdate();
                response.sendRedirect("/loan_management/home"); 
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
