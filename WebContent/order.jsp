<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
    body {margin: 0;}
    
    ul.topnav {
      list-style-type: none;
      margin: 0;
      padding: 0;
      overflow: hidden;
      background-color: #333;
    }
    
    ul.topnav li {float: left;}
    
    ul.topnav li a {
      display: block;
      color: white;
      text-align: center;
      padding: 14px 16px;
      text-decoration: none;
    }
    
    ul.topnav li a:hover:not(.active) {background-color: #0454aa;}
    
    ul.topnav li a.active {background-color: #0454aa;}
    
    ul.topnav li.right {float: right;}
    
    @media screen and (max-width: 600px) {
      ul.topnav li.right, 
      ul.topnav li {float: none;}
    }


	body { background-color: #555}

	h1 {
		font-family: "Barlow", arial, sans-serif;
		font-size: 50px;
		text-shadow: 2px 2px #0454aa;
	}

	table, td, th {
  		border: 0.5px solid;
		padding: 15px;
		font-family:Georgia, 'Times New Roman', Times, serif;
		background-color: #444;
	}

	tr {
		color:black;
 		font-size:18px;
	}

	table {
		width: 100%;
  		border-collapse: collapse;
	}

	td:hover { background-color: #0454aa;}

	h2 {
		font-family: Georgia, 'Times New Roman', Times, serif;
	}

		</style>

		
		</head>
		<body>
			
		<ul class="topnav">
		  <li><a href = "listorder.jsp">Orders</a></li>
		  <li><a href = "showcart.jsp">Cart</a></li>
		  <li><a href = "listprod.jsp">Product List</a></li>
		  <li class="right"><a href="logout.jsp">Log out</a></li>
		  <li class="right"><a href = "login.jsp">Login</a></li>
		  <li class="right"><a href = "admin.jsp">Administrator Page</a></li>
		  <li class="right"><a href = "create_account.jsp">Create Account</a></li>
		  <li class="right"><a href = "index.jsp">Index</a></li>


		</ul>

		<jsp:include page="header.jsp" />

		
		</body>
		</html>
	
	
</style>
<title>Chop & Co Grocery Order Processing</title>
</head>
<body>

<h1 align ="middle">Your Order Summary</h1>


<% 


// Get customer id
String custId = request.getParameter("customerId");

@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

//used to format prices correctly
NumberFormat currFormat = NumberFormat.getCurrencyInstance();


// Determine if there are products in the shopping cart
// If either are not true, display an error message

//Connect to DB
String url="jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True"; 
String uid="sa" ; 
String pw="304#sa#pw";

//Query Declaration
String sql = "SELECT * FROM customer WHERE customerId = ?";
String sql2 = "SELECT orderId FROM ordersummary";
String sql3 = "INSERT INTO ordersummary (orderDate, shiptoAddress, shiptoCity, shiptoState, shiptoPostalCode, shiptoCountry, customerId) VALUES (?, ?, ?, ?, ?, ?, ?)";
String sql4 = "UPDATE ordersummary SET totalAmount = ? WHERE orderId = ?";
String sql5 = "INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (?, ?, ?, ?)";


try ( Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();) 
{

	//Perfom query for customerId to check if it is in the DB
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1,custId);

	ResultSet rst = pstmt.executeQuery();
	
	
	String check = "";

	//check if userId is an integer
	try
	{
		int i = Integer.parseInt(custId);
	}
	catch(NumberFormatException e)
	{
		check = "NAN";

	}
		

	//If the customer ID is not in the DB, and error message is displayed.
	if(check.compareTo("NAN")==0 || !rst.next())
	{
		out.print("<h1><font color = \"#ff0000\">"+"The Entered Customer ID is Invalid. Please return to the Previous Page and Enter a Valid Customer ID."+"</font></h1>");
		out.print("<a href = \"showcart.jsp\">Return to Cart</a>");

	}

	//if the cusomer ID is valid, an order summary is displayed as well as information about the customer and their order.

	else if(productList.isEmpty())
	{
		out.print("<h2 align =\"middle\">"+"Your Cart is Empty!"+"</h2>");

	}

	//if the cusomer ID is valid, an order summary is displayed as well as information about the customer and their order.
	else
	{

		out.print("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
		out.println("<th>Price</th><th>Subtotal</th></tr>");
		
		
		TimeZone.setDefault(TimeZone.getTimeZone("America/Los_Angeles"));
		long now = System.currentTimeMillis();
		Timestamp time = new Timestamp(now);

		String address = rst.getString("address");
		String city = rst.getString("city");
		String state = rst.getString("state");
		String postalcode = rst.getString("postalcode");
		String country = rst.getString("country");
		int cid = rst.getInt("customerId");
	

		// Use retrieval of auto-generated keys.
		PreparedStatement pstmt1 = con.prepareStatement(sql3, Statement.RETURN_GENERATED_KEYS);
		
		pstmt1.setObject(1,time);
		pstmt1.setString(2,address);
		pstmt1.setString(3,city);
		pstmt1.setString(4,state);
		pstmt1.setString(5,postalcode);
		pstmt1.setString(6,country);
		pstmt1.setInt(7,cid);


		int row = pstmt1.executeUpdate();
	
		ResultSet keys = pstmt1.getGeneratedKeys();
		keys.next();
		int orderId = keys.getInt(1);


		double total =0;
			Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
			while (iterator.hasNext()) 
			{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
				ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
				if (product.size() < 4)
				{
					out.println("Expected product with four entries. Got: "+product);
					continue;
				}
				
				out.print("<tr><td>"+product.get(0)+"</td>");
				out.print("<td>"+product.get(1)+"</td>");

				String productId = (String) product.get(0);
		
				out.print("<td align=\"center\">"+product.get(3)+"</td>");
				Object price = product.get(2);
				Object itemqty = product.get(3);
				double pr = 0;
				int qty = 0;
				
				try
				{
					pr = Double.parseDouble(price.toString());
				}
				catch (Exception e)
				{
					out.println("Invalid price for product: "+product.get(0)+" price: "+price);
				}
				try
				{
					qty = Integer.parseInt(itemqty.toString());
				}
				catch (Exception e)
				{
					out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
				}		
		
				out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
				out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td></tr>");
				out.println("</tr>");
				total = total +pr*qty;


				PreparedStatement pstmt_prod = con.prepareStatement(sql5);
				pstmt_prod.setInt(1,orderId);
				pstmt_prod.setString(2,(String)productId);
				pstmt_prod.setInt(3,qty);
				pstmt_prod.setDouble(4,pr);

				int row3 = pstmt_prod.executeUpdate();

			}
			out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
					+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
			out.println("</table>");


		PreparedStatement pstmt2 = con.prepareStatement(sql4);
		pstmt2.setDouble(1,total);
		pstmt2.setInt(2,orderId);

		int row2 = pstmt2.executeUpdate();



		out.print("<br><h2>Order Completed. Your Order Will Be Shipped Soon.</h2>");
		out.print("<h2>"+"Your Order Rererence Number Is:" +orderId+"</h2>");
		out.print("<h2>"+"Shipping To Customer: "+rst.getInt("customerId")+"&emsp;Name: "+rst.getString("firstName")+" "+rst.getString("lastName")+"</h2>");


		// Clear cart if order placed successfully
		productList.clear();
		
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




					



%>
</BODY>
</HTML>

