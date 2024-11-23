<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	body {background-color: powderblue}

	h1 {
		font-family: cursive;
	}

	table, td, th {
  		border: 1px solid;
		padding: 15px;
		font-family:Georgia, 'Times New Roman', Times, serif;
	}

	table {
		width: 100%;
  		border-collapse: collapse;
	}

	td:hover {background-color: rgb(0, 179, 255);}

	h1 {
		font-family: Georgia, 'Times New Roman', Times, serif;
	}

	h2 {
		font-family: Georgia, 'Times New Roman', Times, serif;
	}
</style>
<title>Chop & Co Grocery</title>
</head>
<body>

<!-- Links for viewing cart or order list -->
<a href = "listorder.jsp">Orders</a>
<a href = "showcart.jsp">Cart</a>

<h1 align = "middle">Chop & Co Grocery</h1>
<br>
<h2>Search for the products you want to buy:</h2>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<!-- Drop down menu for category filtering -->
<form method="get" action="listprod.jsp">
Category: <select name="Category"><option value="All">All</option><option value="Beverages">Beverages</option><option value="Condiments">Condiments</option>
	<option value="Dairy Products">Dairy Products</option><option value="Produce">Produce</option><option value="Meat/Poultry">Meat/Poultry</option><option value="Seafood">Seafood</option><option value="Confections">Confections</option><option value="Grains/Cereals">Grains/Cereals</option></select>
	<input type="submit" value="Submit">
</form>




<% // Get product name to search for
String name = request.getParameter("productName");

//Get category string from dropdown
String cat = (String)request.getParameter("Category");

		
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

	//query strings for category filtering
	String sql3 = "SELECT categoryName FROM category WHERE categoryId = ?";
	String sql4 = "SELECT categoryId FROM category WHERE categoryName = ?";
	String sql5 = "SELECT * FROM product WHERE categoryId = ?";

	//attempt connection to DB
	try ( Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();) 
  	{	

		//display table headers 
		out.print("<table></th><th></th><th align=\"left\">Product Name</th><th align=\"left\">Category</th><th align=\"left\">Price</th></tr>");

		//define hyperlink text
		String link;
		String prod_link;
		String hyper_text = "Add to Cart";


		//if no prompt is entered into product search bar, or no choice is selected from the category dropdown all products are listed
		if((name == null || name == "") && (cat == null || cat.compareTo("All")==0))
		{

			out.print("<h2>"+"All Products"+"</h2>");
			
			//create prepared statement
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rst = pstmt.executeQuery();

			
			//iterate through products in result set and add to table
			while(rst.next())
			{

				link = "<a href =\"addcart.jsp?id=" + rst.getInt("productId") + "&name=" + rst.getString("productName") + "&price=" + rst.getDouble("productPrice") +"\">" + hyper_text + "</a>";


				//define hyperlink with apropriate data for particular product
				prod_link = "<a href =\"product.jsp?id=" + rst.getInt("productId") + "\">" + rst.getString("productName") + "</a>";


				//creates and executes query for category names from a particular categoryId for a product
				PreparedStatement pstmt2 = con.prepareStatement(sql3);
				pstmt2.setInt(1, rst.getInt("categoryId"));
				ResultSet rst2 = pstmt2.executeQuery();
				rst2.next();

				//add data and hyperlink to table
				out.println("<tr><td>"+link+"</td><td>"+prod_link+"</td><td>"+rst2.getString("categoryName")+"</td><td>"+currFormat.format(rst.getDouble("productPrice"))+"</td></tr>");
		
			}

		}

		
		//if a cagtegory choice has been made, the choice is not "All", and the nothing has been entered in the search bar a category query is performed
		else if((cat != null && cat.compareTo("All") != 0) && (name == null || name == ""))
		{

			out.print("<h2>"+"Results for Products in Category: "+cat+"</h2>");

			//queries for a categoryId from a selected dropdown category name
			PreparedStatement pstmt = con.prepareStatement(sql4);
			pstmt.setString(1,cat);
			ResultSet rst = pstmt.executeQuery();

			rst.next();

			//queries for products based in the categoryId
			PreparedStatement pstmt1 = con.prepareStatement(sql5);
			pstmt1.setInt(1,rst.getInt("categoryId"));
			ResultSet rst1 = pstmt1.executeQuery();


			//iterate through the products in the result set and add to table
			while(rst1.next())
			{
				//define hyperlink with apropriate data for particular product
				link = "<a href =\"addcart.jsp?id=" + rst1.getInt("productId") + "&name=" + rst1.getString("productName") + "&price=" + rst1.getDouble("productPrice") +"\">" + hyper_text + "</a>";

				//define hyperlink with apropriate data for particular product
				prod_link = "<a href =\"product.jsp?id=" + rst1.getInt("productId") + "\">" + rst1.getString("productName") + "</a>";

				PreparedStatement pstmt2 = con.prepareStatement(sql3);
				pstmt2.setInt(1, rst1.getInt("categoryId"));
				ResultSet rst2 = pstmt2.executeQuery();
				rst2.next();

				//add data and hyperlink to table
				out.println("<tr><td>"+link+"</td><td>"+prod_link+"</td><td>"+rst2.getString("categoryName")+"</td><td>"+currFormat.format(rst1.getDouble("productPrice"))+"</td></tr>");

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

				PreparedStatement pstmt2 = con.prepareStatement(sql3);
				pstmt2.setInt(1, rst1.getInt("categoryId"));
				ResultSet rst2 = pstmt2.executeQuery();
				rst2.next();

				//add data and hyperlink to table
				out.println("<tr><td>"+link+"</td><td>"+rst1.getString("productName")+"</td><td>"+rst2.getString("categoryName")+"</td><td>"+currFormat.format(rst1.getDouble("productPrice"))+"</td></tr>");

			}


		}

		//close output
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


%>

</body>
</html>