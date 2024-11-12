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

String sql = "SELECT customerId FROM customer WHERE customerId = ?";
String sql2 = "INSERT INTO ordersummary VALUES ";


try ( Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();) 
{

	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1,custId);

	ResultSet rst = pstmt.executeQuery();

	if(!rst.next())
	{
		out.print("<font color = \"#ff0000\">"+"The Entered Customer ID is Invalid. Please return to the Previous Page and Enter a Valid Customer ID."+"</font>");
	}

	else
	{



		// Use retrieval of auto-generated keys.
		PreparedStatement pstmt1 = con.prepareStatement(sql2, Statement.RETURN_GENERATED_KEYS);		
		
		ResultSet keys = pstmt1.getGeneratedKeys();
		keys.next();
		int orderId = keys.getInt(1);

		out.print("Test: " +orderId);




		
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
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int qty = ( (Integer)product.get(3)).intValue();
            ...
	}
*/

// Print out order summary

// Clear cart if order placed successfully
%>
</BODY>
</HTML>

