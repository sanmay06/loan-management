<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.* " %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update</title>
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

.menu button:hover, .header button:hover ,.menu .selected {
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
    width:750px;
    max-width: 75%;
}

.check{
    width:auto;
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
    width:100px;
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
        <div class='h1'>Insert  </div>
        <div class='span'></div>
    </div>
    <section class='menu'>
        <button onclick="window.location.href='/loan_management/home/insert.html'">Insert</button>
        <button class='selected' onclick="window.location.href='/loan_management/home/update'">Update</button>
        <button onclick="window.location.href='/loan_management/home/delete'">Delete</button>
    	<button onclick="window.location.href='/loan_management/home/InsertPayment.html'">Insert Payment</button>
    	<button onclick="window.location.href='/loan_management/home/estimate'">estimate</button>
    </section>
    <section class='form'>
    <form action='updated' method="post">
        Enter the LoanID to be updated:<br><input type='text' name ='loanid' required><br>
        Enter the updated Remaining Balance:<br><input type='text' name ='balance' ><br>
        Enter the updated Interest Rate:<br><input type='text' name ='interest' ><br>
        Enter the updated Loan Status:<br><input type='text' name ='LoanStatus' ><br>
        <input type='submit' value='Submit'>
    </form>
    </section>
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
                    <th>Loan Term</th>
                    <th>Loan Status</th>
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
                    <td><%= rs.getString(8) %></td>
                    <td><%= rs.getString(9) %></td>
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
