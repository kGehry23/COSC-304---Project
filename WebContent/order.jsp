<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Chop & Co Grocery Order Processing</title>
</head>
<body>

<% 
// Get customer id
String custId = request.getParameter("customerId");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Determine if valid customer id was entered
// Determine if there are products in the shopping cart
// If either are not true, display an error message

// Make connection

String url="jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True"; 
String uid="sa" ; 
String pw="304#sa#pw";

String sql = "SELECT * FROM customer WHERE customerId = ?";
String sql2 = "SELECT orderId FROM ordersummary";
String sql3 = "INSERT INTO ordersummary (orderDate, shiptoAddress, shiptoCity, shiptoState, shiptoPostalCode, shiptoCountry, customerId) VALUES (?, ?, ?, ?, ?, ?, ?)";
String sql4 = "UPDATE ordersummary SET totalAmount = ? WHERE orderId = ?";
String sql5 = "INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (?, ?, ?, ?)";


try ( Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();) 
{

	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1,custId);

	ResultSet rst = pstmt.executeQuery();

	if(!rst.next())
	{
		out.print("<h1><font color = \"#ff0000\">"+"The Entered Customer ID is Invalid. Please return to the Previous Page and Enter a Valid Customer ID."+"</font></h1>");
	}

	else
	{


		
		long now = System.currentTimeMillis();
		Timestamp time = new Timestamp(now);
		out.print(time);

		String address = rst.getString("address");
		out.print("<br><br>"+address);

		String city = rst.getString("city");
		out.print("<br><br>"+city);

		String state = rst.getString("state");
		out.print("<br><br>"+state);

		String postalcode = rst.getString("postalcode");
		out.print("<br><br>"+postalcode);

		String country = rst.getString("country");
		out.print("<br><br>"+country);

		int cid = rst.getInt("customerId");
		out.print("<br><br>"+cid);

	

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
		out.print(row);
	
		ResultSet keys = pstmt1.getGeneratedKeys();
		keys.next();
		int orderId = keys.getInt(1);

		out.print("Test: " +orderId);


		double total = 0;

		Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();

			while (iterator.hasNext())
			{ 
				Map.Entry<String, ArrayList<Object>> entry = iterator.next();
				ArrayList<Object> product = (ArrayList<Object>) entry.getValue();

				String productId = (String) product.get(0);
				String price = (String) product.get(2);

				int qty = ( (Integer)product.get(3)).intValue();
				double pr = Double.parseDouble(price);

				total = total + pr*qty;	


				PreparedStatement pstmt_prod = con.prepareStatement(sql5);
				pstmt_prod.setInt(1,orderId);
				pstmt_prod.setString(2,productId);
				pstmt_prod.setInt(3,qty);
				pstmt_prod.setDouble(4,pr);

				int row3 = pstmt_prod.executeUpdate();

			}


			out.print("<br><br>"+total);


		PreparedStatement pstmt2 = con.prepareStatement(sql4);
		pstmt2.setDouble(1,total);
		pstmt2.setInt(2,orderId);

		int row2 = pstmt2.executeUpdate();







		




		
	}



}	

catch (SQLException ex)
{
	System.err.println("SQLException: " + ex);
}

					
// Save order information to database


	
	

// Insert each item into OrderProduct table using OrderId from previous INSERT

// Update total amount for order record

// Here is the code to traverse through a HashMap
// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price

/*

*/

// Print out order summary

// Clear cart if order placed successfully
%>
</BODY>
</HTML>

