<%@ include file="dbconfig.jsp" %>
<%@ page import="java.sql.PreparedStatement" %>

<html>
<head>
    <title>Register</title>
</head>
<body>
    <h2>Register</h2>
    <form action="register.jsp" method="post">
        Username: <input type="text" name="username" required><br>
        Password: <input type="password" name="password" required><br>
        <input type="submit" value="Register">
    </form>

    <%
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username != null && password != null) {
            String query = "INSERT INTO users (username, password) VALUES (?, ?)";
            try {
                PreparedStatement pstmt = conn.prepareStatement(query);
                pstmt.setString(1, username);
                pstmt.setString(2, password);
                int rows = pstmt.executeUpdate();
                if (rows > 0) {
                    out.println("Registration successful! <a href='login.jsp'>Login here</a>");
                }
            } catch (SQLException e) {
                out.println("Error: " + e.getMessage());
            } finally {
                if (conn != null) conn.close();
            }
        }
    %>
</body>
</html>
