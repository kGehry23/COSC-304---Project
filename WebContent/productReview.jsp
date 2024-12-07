<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<%
    String userName = (String) session.getAttribute("authenticatedUser");

    // login check
    if (userName == null) { 
        out.print("<p>Error: Please login to leave a review.</p>");
        out.print("<a href=\"login.jsp\">Log in</a>");
        return;
    }
    
    // database connect
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True"; 
    String uid = "sa"; 
    String pw = "304#sa#pw";

    // sql
    String productId = request.getParameter("productId");
    String reviewRating = request.getParameter("reviewRating");
    String reviewComment = request.getParameter("reviewComment");

    // check if fields are checked in
    if (productId == null || reviewRating == null || reviewComment == null || reviewComment.trim().isEmpty()) {
        out.print("<p>Error: Fill in all fields.</p>");
        out.print("<a href=\"product.jsp?id=" + productId + "\">Back to Product</a>");
        return;
    }

    // db connect
    try (Connection con = DriverManager.getConnection(url, uid, pw)) {

        // Getting customer's ID from their username, -1 uninitialized
        String sqlCustomer = "select customerId FROM customer where userid = ?";
        int customerId = -1;

        try (PreparedStatement pstmt = con.prepareStatement(sqlCustomer)) {
            pstmt.setString(1, userName);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                customerId = rs.getInt("customerId");
            }
        }

        // Review into DB
        String sqlReview = "insert into review (reviewRating, reviewDate, customerId, productId, reviewComment) " +
                                 "values (?, getdate(), ?, ?, ?)";
        //add
        try (PreparedStatement pstmt = con.prepareStatement(sqlReview)) {
            pstmt.setInt(1, Integer.parseInt(reviewRating)); 
            pstmt.setInt(2, customerId);                     
            pstmt.setInt(3, Integer.parseInt(productId));   
            pstmt.setString(4, reviewComment);               

            pstmt.executeUpdate();
            out.print("<p>Thank you for the review!</p>");
        }

    } catch (SQLException ex) {
        out.print("<p>Error submitting review: " + ex.getMessage() + "</p>");
        ex.printStackTrace();
    }
%>

<a href="product.jsp?id=<%= productId %>">Back to Product</a>
