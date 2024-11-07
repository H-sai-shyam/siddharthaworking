<%-- dbconfig.jsp --%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.SQLException" %>

<%
    String url = "jdbc:mysql://localhost:3306/user_db";
    String user = "root";  // Change to your MySQL username
    String pass = "1234";       // Change to your MySQL password

    Connection conn = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, pass);
    } catch (ClassNotFoundException | SQLException e) {
        out.println("Database connection error: " + e.getMessage());
    }
%>
