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


        out.print("<img src = \"" +prodURL+ "\">");

        out.print("<br><br><b>Product Id: </b>" +productId);
        out.print("<br><b>Price: </b>" +currFormat.format(rst.getDouble("productPrice")));

        out.print("<br><br><a href =\"addcart.jsp?id=" + rst.getInt("productId") + "&name=" + rst.getString("productName") + "&price=" + rst.getDouble("productPrice") +"\">" + hyper_text + "</a>");


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
<a href = "listprod.jsp">Continue Shopping</a>

</body>
</html>

