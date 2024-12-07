<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
    <style>
		body {background-color: powderblue}
	</style>
<title>Chop & Co - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<%
// Get product name to search for
// TODO: Retrieve and display info for the product
    String userName = (String) session.getAttribute("authenticatedUser");

    NumberFormat currFormat = NumberFormat.getCurrencyInstance();

    //DB connection credentials
    String url="jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True"; 
    String uid="sa" ; 
    String pw="304#sa#pw";

    String hyper_text = "Add to Cart";


    //retrieve id
    String productId = request.getParameter("id");
    //create query string
    String sql = "SELECT * FROM product WHERE productId = ?";
    //review query
    String sql2 = "SELECT reviewRating, reviewComment, reviewDate, customerId FROM review WHERE productId = ?";



    //connect to DB
    try ( Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();) 
  	{	

        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, productId);
        ResultSet rst = pstmt.executeQuery();

        rst.next();
        String prodName = rst.getString("productName");
        out.print("<h1>"+prodName+"</h1><br>");

        String prodURL = rst.getString("productImageURL");

        //code to dipslay image for each product
        out.print("<img src = \"" +prodURL+ "\">");

        //code added to display second image for frst prodcut
        if(Integer.parseInt(productId) == 1)
            out.println("<img src=\"displayImage.jsp?id="+productId+"\">");

        out.print("<br><br><b>Product Id: </b>" +productId);
        out.print("<br><b>Price: </b>" +currFormat.format(rst.getDouble("productPrice")));

        out.print("<br><br><a href =\"addcart.jsp?id=" + rst.getInt("productId") + "&name=" + rst.getString("productName") + "&price=" + rst.getDouble("productPrice") +"\">" + hyper_text + "</a>");
        //reviews
        out.print("<h2>Current Reviews</h2>");
        PreparedStatement pstmt2 = con.prepareStatement(sql2);
        pstmt2.setString(1, productId);
        ResultSet rst2 = pstmt2.executeQuery();
        if (!rst2.next()) { 
            out.print("<p>No Customer Reviews</p>");
        } else {
            // If there are reviews, display them
                do {
                    out.print("<div style=\"border:1px solid black; padding:10px; margin:10px;\">");
                    out.print("<b>Rating:</b> " + rst2.getInt("reviewRating") + " / 5<br>");
                    out.print("<b>Comment:</b> " + rst2.getString("reviewComment") + "<br>");
                    out.print("<b>By Customer ID:</b> " + rst2.getInt("customerId") + " on " + rst2.getDate("reviewDate") + "<br>");
                    out.print("</div>");
                } while (rst2.next()); // Continue to fetch and display reviews
        }// Review form
        if (userName != null) {
            out.print("<h2>Leave a Review</h2>");
            out.print("<form method='post' action='productReview.jsp'>");
            out.print("<input type='hidden' name='productId' value='" + productId + "'>");
            out.print("<label for='reviewRating'>Rating (1-5):</label>");
            out.print("<select name='reviewRating' id='reviewRating'>");
            out.print("<option value='1'>1</option>");
            out.print("<option value='2'>2</option>");
            out.print("<option value='3'>3</option>");
            out.print("<option value='4'>4</option>");
            out.print("<option value='5'>5</option>");
            out.print("</select><br>");
            out.print("<label for='reviewComment'>Comment:</label><br>");
            out.print("<textarea name='reviewComment' id='reviewComment' rows='4' cols='50'></textarea><br>");
            out.print("<input type='submit' value='Submit Review'>");
            out.print("</form>");
        } else {
            out.print("<p>You must <a href='login.jsp'>log in</a> to leave a review.</p>");
        }
    }

    catch (SQLException ex)
	{
		System.err.println("SQLException: " + ex);
	}


// TODO: If there is a productImageURL, display using IMG tag
		
// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
		
// TODO: Add links to Add to Cart and Continue Shopping

%>

<br>
<form method="get" action="listprod.jsp">
    <input type="submit" value="Continue Shopping" style="border-radius: 15px;padding: 10px;border: 2px solid #ccc;">
    </form>

</body>
    </html>