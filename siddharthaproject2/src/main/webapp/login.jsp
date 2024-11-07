<%@ include file="dbconfig.jsp" %>
<%@ page import="java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>

<html>
<head>
    <title>Login</title>
</head>
<body>
    <h2>Login</h2>
    <form action="login.jsp" method="post">
        Username: <input type="text" name="username" required><br>
        Password: <input type="password" name="password" required><br>
        <input type="submit" value="Login">
    </form>

    <%
        // Get username and password from form input
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username != null && password != null) {
            String query = "SELECT * FROM users WHERE username = ? AND password = ?";
            try {
                // Prepare and execute the query to validate the user
                PreparedStatement pstmt = conn.prepareStatement(query);
                pstmt.setString(1, username);
                pstmt.setString(2, password);
                ResultSet rs = pstmt.executeQuery();
                
                if (rs.next()) {
                    // Login successful - store username in session and redirect to home.jsp
                    session.setAttribute("username", username);
                    response.sendRedirect("home.jsp");
                } else {
                    // Login failed - display error message
                    out.println("<p>Invalid username or password.</p>");
                }
            } catch (SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>
