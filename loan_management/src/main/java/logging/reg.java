package logging;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

public class reg extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        String email = request.getParameter("email");
        String user=request.getParameter("username");
        String pass = request.getParameter("password");
        int sal=Integer.parseInt(request.getParameter("salary"));
        String cpass = request.getParameter("confirmpass");
        response.getWriter().print("<html><body>");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "1234");

            if (!pass.equals(cpass)) {
                response.getWriter().println("<h1>Both password and confirm password should be the same<br>Redirecting shortly...</h1>");
                response.setHeader("Refresh", "5; URL=reg.html");
                return;
            }

            String query = "Select * from Login where username = ?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, user);
            ResultSet rs = stmt.executeQuery();

            boolean userExists = rs.next();
            if (userExists) {
                response.getWriter().println("<center><h2><b>User already present</b></h2></center>");
            } else {
                String insertQuery = "Insert into login values(?,?,?,?)";
                PreparedStatement pstmt = con.prepareStatement(insertQuery);
                pstmt.setString(1, user);
                pstmt.setString(2, pass);
                pstmt.setString(3, email);
                pstmt.setInt(4, sal);
                pstmt.executeUpdate();
                pstmt.close();

                response.getWriter().println("<h2>User created successfully!</h2>");
                response.getWriter().println("<a href='login'>Login Here</a>");
            }

            response.getWriter().println("<hr> <br><br><center><a href='login'>Press here if existing user</a><br></center>");
            response.getWriter().println("<center><a href='reg.html'>Press here if you want to create a new user</a><br></center>");

            stmt.close();
            con.close();
        } catch (Exception e) {
            response.getWriter().println(e);
        }
        response.getWriter().print("</body></html>");
    }
}