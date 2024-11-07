<%@ include file="dbconfig.jsp" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>

<%
    // Check if the user is logged in
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp"); // Redirect to login if user is not logged in
        return;
    }
%>

<html>
<head>
    <title>Home</title>
</head>
<body>
    <h2>Welcome, <%= username %>!</h2>

    <!-- Form for adding new business and amount entries -->
    <form action="home.jsp" method="post">
        <table border="1">
            <tr>
                <th>Business Name</th>
                <th>Amount to be Paid</th>
            </tr>
            <tr>
                <td><input type="text" name="business_name" required></td>
                <td><input type="number" name="amount" step="0.01" required></td>
            </tr>
        </table>
        <input type="submit" value="Save">
    </form>

    <%
        // Handle form submission to insert data into the database
        String businessName = request.getParameter("business_name");
        String amountStr = request.getParameter("amount");

        if (businessName != null && amountStr != null) {
            try {
                String query = "INSERT INTO payments (username, business_name, amount) VALUES (?, ?, ?)";
                PreparedStatement pstmt = conn.prepareStatement(query);
                pstmt.setString(1, username);
                pstmt.setString(2, businessName);
                pstmt.setBigDecimal(3, new java.math.BigDecimal(amountStr));
                pstmt.executeUpdate();
                out.println("<p>Entry saved successfully!</p>");
            } catch (SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        }
    %>

    <!-- Display entries for the logged-in user -->
    <h3>Your Entries</h3>
    <table border="1">
        <tr>
            <th>Business Name</th>
            <th>Amount to be Paid</th>
        </tr>
        <%
            // Retrieve and display all entries for the logged-in user
            try {
                String query = "SELECT business_name, amount FROM payments WHERE username = ?";
                PreparedStatement pstmt = conn.prepareStatement(query);
                pstmt.setString(1, username);
                ResultSet rs = pstmt.executeQuery();

                while (rs.next()) {
                    String business = rs.getString("business_name");
                    String amount = rs.getBigDecimal("amount").toString();
        %>
                    <tr>
                        <td><%= business %></td>
                        <td><%= amount %></td>
                    </tr>
        <%
                }
            } catch (SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        %>
    </table>
</body>
</html>
