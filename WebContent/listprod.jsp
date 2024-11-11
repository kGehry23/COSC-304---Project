<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Chop & Co Grocery</title>
</head>
<body>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>


<h2>All Products</h2>

<% // Get product name to search for
String name = request.getParameter("productName");
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

	NumberFormat currFormat = NumberFormat.getCurrencyInstance();


	String url="jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True"; 
	String uid="sa" ; 
	String pw="304#sa#pw";

	String sql = "SELECT * FROM product";


	try ( Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();) 
  	{	

		PreparedStatement pstmt = con.prepareStatement(sql);
		ResultSet rst = pstmt.executeQuery();

		out.print("<table></th><th></th><th align=\"left\">Product Name</th><th align=\"left\">Price</th></tr>");
		String link;
		String message = "Add to Cart";


			while(rst.next())
			{
				link = "<a href =\"addcart.jsp?id=" + rst.getInt("productId") + "&name=" + rst.getString("productName") + "&price=" + rst.getDouble("productPrice") +"\">" + message + "</a>";
				out.println("<tr><td>"+link+"</td><td>"+rst.getString("productName")+"</td><td>"+currFormat.format(rst.getDouble("productPrice"))+"</td></tr>");
		
			}
			
			
	
	}

	catch (SQLException ex)
	{
		System.err.println("SQLException: " + ex);
	}







// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection

// Print out the ResultSet






// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>

</body>
</html>