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
	//instantiate number format object to format currency values
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();

	//define connection information to orders DB
	String url="jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True"; 
	String uid="sa" ; 
	String pw="304#sa#pw";

	//define queries for viewing all items, or particular item a user searches for
	String sql = "SELECT * FROM product";
	String sql2 = "SELECT * FROM product WHERE productName LIKE ?";
	String sql3 = "SELECT categoryName FROM category WHERE categoryId = ?";


	//attempt connection to DB
	try ( Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();) 
  	{	

		//display table headers 
		out.print("<table></th><th></th><th align=\"left\">Product Name</th><th align=\"left\">Category</th><th align=\"left\">Price</th></tr>");

		//define hyperlink text
		String link;
		String hyper_text = "Add to Cart";


		//if no prompt is entered into product search bar, all products are listed
		if(name == null || name == "")
		{

			out.print("<h2>"+"All Products"+"</h2>");
			
			//create prepared statement
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rst = pstmt.executeQuery();

			


			//iterate through products in result set and add to table
			while(rst.next())
			{
				//define hyperlink with apropriate data for particular product
				link = "<a href =\"addcart.jsp?id=" + rst.getInt("productId") + "&name=" + rst.getString("productName") + "&price=" + rst.getDouble("productPrice") +"\">" + hyper_text + "</a>";


				PreparedStatement pstmt2 = con.prepareStatement(sql3);
				pstmt2.setInt(1, rst.getInt("categoryId"));
				ResultSet rst2 = pstmt2.executeQuery();
				rst2.next();

				//add data and hyperlink to table
				out.println("<tr><td>"+link+"</td><td>"+rst.getString("productName")+"</td><td>"+rst2.getString("categoryName")+"</td><td>"+currFormat.format(rst.getDouble("productPrice"))+"</td></tr>");
		
			}

		}

		//when a prompt is entered into the search bar, the search is filtered accordingly
		else
		{

			out.print("<h2>"+"Results for Products Beginning With: "+name+"</h2>");

			//create prepared statement
			PreparedStatement pstmt1 = con.prepareStatement(sql2);
			
			//define search string. Empty charactes are removed from the end and beginning of the search string
			String find = name.strip();

			//Query is created to find any items that have matching beginning characters to the entered string
			pstmt1.setString(1,find+"%");
			

			ResultSet rst1 = pstmt1.executeQuery();


			

			//iterate through the products in the result set and add to table
			while(rst1.next())
			{
				//define hyperlink with apropriate data for particular product
				link = "<a href =\"addcart.jsp?id=" + rst1.getInt("productId") + "&name=" + rst1.getString("productName") + "&price=" + rst1.getDouble("productPrice") +"\">" + hyper_text + "</a>";

				//add data and hyperlink to table
				out.println("<tr><td>"+link+"</td><td>"+rst1.getString("productName")+"</td><td>"+currFormat.format(rst1.getDouble("productPrice"))+"</td></tr>");

			}


		}


		out.close();


		//close DB connection
		if (con != null)
		{
			con.close();
		}
				
	
	}

	catch (SQLException ex)
	{
		System.err.println("SQLException: " + ex);
	}






// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>

</body>
</html>