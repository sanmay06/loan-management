<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.*" %>
<html>
<head>
    <meta charset='UTF-8'>
    <title>Estimate Result</title>
    <style>
        body {
            background-color: #F8F9FA;
            font-family: Lato, sans-serif;
            color: #333333;
        }
        .header {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            border-bottom: 2px solid #4682B4;
            margin: 10px 0;
            background-color: #1E90FF;
            padding: 10px;
        }
        .menu button, .header button {
            border-radius: 20px;
            background-color: #1E90FF;
            color: white;
            padding: 15px 32px;
            text-align: center;
            font-size: 16px;
            cursor: pointer;
            border: none;
        }
        .menu button:hover, .header button:hover, .menu .select {
            background-color: #FF4500;
            box-shadow: 0 10px 25px rgba(255, 69, 0, 0.5);
        }
        .h1 {
            font-size: 2.5rem;
            color: white;
        }
        h2 {
            text-align: center;
            font-size: 1.4rem;
            color: #1E90FF;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        td, th {
            border: 1px solid #4682B4;
            padding: 10px;
            text-align: center;
        }
        td:hover {
            background-color: #E8F0FE;
        }
        .main {
            background-color: #FFFFFF;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            padding: 20px;
            max-width: 900px;
            margin: 40px auto;
        }
        input {
            border: 1px solid #CCCCCC;
            background-color: #E8F0FE;
            color: #333333;
            padding: 10px;
            border-radius: 5px;
            margin: 10px 0;
            width: 750px;
            max-width: 75%;
        }
        .check {
            width: auto;
        }
        input[type='submit'] {
            background-color: #1E90FF;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            cursor: pointer;
        }
        input[type='submit']:hover {
            background-color: #FF4500;
        }
        .reg a {
            color: #FF4500;
        }
        .form {
            background-color: #FFFFFF;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }
        .bor {
            border-top: 1px solid #CCCCCC;
            margin-top: 20px;
        }
        .span {
            width: 100px;
        }
        .text {
            background-color: #E8F0FE;
            padding: 20px;
            border-radius: 10px;
        }
    </style>
</head>
<body>
    <div class='header'>
        <button onclick="window.location.href='/loan_management/home'">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house" viewBox="0 0 16 16">
                <path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L2 8.207V13.5A1.5 1.5 0 0 0 3.5 15h9a1.5 1.5 0 0 0 1.5-1.5V8.207l.646.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293zM13 7.207V13.5a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5V7.207l5-5z"/>
            </svg>
            Home
        </button>
        <div class='h1'>Estimate</div>
        <div class='span'></div>
    </div>
    <div class='menu'>
        <button onclick="window.location.href='/loan_management/home/insert.html'">Insert</button>
        <button onclick="window.location.href='/loan_management/home/update'">Update</button>
        <button onclick="window.location.href='/loan_management/home/delete'">Delete</button>
        <button onclick="window.location.href='/loan_management/home/InsertPayment.html'">Insert Payment</button>
        <button class='select' onclick="window.location.href='/loan_management/home/estimate'">Estimate</button>
    </div>
    <div class='form'>
        <%
            String dbUrl = "jdbc:mysql://localhost:3306/project";
            String dbUser = "root";
            String dbPassword = "1234";
            HttpSession s = request.getSession();
            String userId = (String) s.getAttribute("Username");

            Connection con = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
%>
<%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

                String userQuery = "SELECT Salary FROM login WHERE username = ?";
                stmt = con.prepareStatement(userQuery);
                stmt.setString(1, userId);
                rs = stmt.executeQuery();

                double userSalary = 0.0;
                if (rs.next()) {
                    userSalary = rs.getDouble("Salary");
                }
                rs.close();

                String loanQuery = "SELECT LoanId, LoanAmount, InterestRate, RemainingBalance FROM Loan WHERE User = '"+userId+"'";
                stmt = con.prepareStatement(loanQuery);
                rs = stmt.executeQuery();

                double totalLoanBalance = 0.0;
                int loanCount = 0;

                while (rs.next()) {
                    double remainingBalance = rs.getDouble("RemainingBalance");
                    totalLoanBalance += remainingBalance;
                    loanCount++;
                }
                rs.close();

                double affordableMonthlyPayment = userSalary / loanCount;

                out.println("<h3>Monthly Income Allocated Per Loan:</h3>");
                out.println("<p>" + String.format("$%.2f", affordableMonthlyPayment) + "</p>");

                if (loanCount > 0) {
                    stmt = con.prepareStatement(loanQuery);
                    rs = stmt.executeQuery();

                    while (rs.next()) {
                        double loanAmount = rs.getDouble("LoanAmount");
                        double annualInterestRate = rs.getDouble("InterestRate");
                        double remainingBalance = rs.getDouble("RemainingBalance");

                        double monthlyInterestRate = annualInterestRate / 12;

                        double numPayments = Math.log(affordableMonthlyPayment / (affordableMonthlyPayment - monthlyInterestRate * remainingBalance)) /
                                             Math.log(1 + monthlyInterestRate);

                        int monthsToPayOff = (int) Math.ceil(numPayments);

                        Calendar calendar = Calendar.getInstance();
                        calendar.add(Calendar.MONTH, monthsToPayOff);
                        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");

                        out.println("<h3>Estimated Time to Pay Off the Loan (LoanID: " + rs.getString("LoanID") + "):</h3>");
                        out.println("<p>" + monthsToPayOff + " months</p>");
                        out.println("<h3>Estimated Payoff Date:</h3>");
                        out.println("<p>" + sdf.format(calendar.getTime()) + "</p>");
                    }
                } else {
                    out.println("<p>No loans found for this user.</p>");
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
        %>
    </div>
</body>
</html>
