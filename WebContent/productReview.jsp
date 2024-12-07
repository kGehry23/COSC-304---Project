<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<%
    String userName = (String) session.getAttribute("authenticatedUser");
    
    // Database connection details
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True"; 
    String uid = "sa"; 
    String pw = "304#sa#pw";

    // Retrieve form parameters
    String productId = request.getParameter("productId");
    String reviewRating = request.getParameter("reviewRating");
    String reviewComment = request.getParameter("reviewComment");

    // Assuming you have a logged-in customer; replace this with session-based customer ID
    int customerId = 1; // Placeholder: Replace with session-based logic

    // Validate input data
    if (productId == null || reviewRating == null || reviewComment == null || reviewComment.trim().isEmpty()) {
        out.print("<p>Error: All fields are required.</p>");
        out.print("<a href=\"product.jsp?id=" + productId + "\">Back to Product</a>");
    } else {
        // SQL query to insert a review
        String sql = "INSERT INTO review (reviewRating, reviewDate, userName, productId, reviewComment) " +
                     "VALUES (?, GETDATE(), ?, ?, ?)";

        try (Connection con = DriverManager.getConnection(url, uid, pw)) {
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(reviewRating)); // Review Rating
            pstmt.setInt(2, userName); // Customer ID
            pstmt.setInt(3, Integer.parseInt(productId)); // Product ID
            pstmt.setString(4, reviewComment); // Review Comment

            pstmt.executeUpdate();
            out.print("<p>Review submitted successfully!</p>");
        } catch (SQLException ex) {
            out.print("<p>Error submitting review: " + ex.getMessage() + "</p>");
            ex.printStackTrace();
        }
    }
%>

<a href="product.jsp?id=<%= productId %>">Back to Product</a>
