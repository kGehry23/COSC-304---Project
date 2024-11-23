<%@ page import="java.sql.*" %>
	<%@ page import="java.text.NumberFormat" %>
		<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8" %>
			<!DOCTYPE html>
			<html>

			<head>
				<style>
					body {background-color: powderblue}
				</style>
				<title>Chop & Co Grocery Order List</title>
			</head>

			<body>

				<!-- links to product list and cart -->
				<a href = "listprod.jsp">Product List</a>
				<a href = "showcart.jsp">Cart</a>

				<h1>Order List</h1>

				<%
					NumberFormat currFormat = NumberFormat.getCurrencyInstance();
					
					//define server credentials
					String url="jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True"; 
					String uid="sa" ; 
					String pw="304#sa#pw";
					
					//define queries
					String sql = "SELECT orderId, orderDate, orderSummary.customerId, firstName, lastName, totalAmount FROM orderSummary JOIN customer ON orderSummary.customerId = customer.customerId";
					String sql2 = "SELECT productId, quantity, price FROM orderproduct WHERE orderId = ?";


					//attempt connection to DB
					try ( Connection con = DriverManager.getConnection(url, uid, pw);
	          		Statement stmt = con.createStatement();) 
	    			{			

						//execute first query and store in result set
						ResultSet rst = stmt.executeQuery(sql);

						//create table define headers and basic formatting
						out.print("<table border=\"1\">");
						out.print("<tr><th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");

						//iterate through result set to poulate table with data
						while (rst.next())
						{		

							//Obtain order information for particular orderId and user
							PreparedStatement pstmt = con.prepareStatement(sql2);
							pstmt.setInt(1, rst.getInt("orderId"));

							//execute order satement
							ResultSet rst2 = pstmt.executeQuery();

							//populate table with data
							out.println("<tr><td>"+rst.getInt("orderId")+"</td><td>"+rst.getTimestamp("orderDate")+"</td><td>"+rst.getInt("customerId")+"</td><td>"+rst.getString("firstName")+" "+rst.getString("lastName")+"</td><td>"+currFormat.format(rst.getDouble("totalAmount"))+"</td></tr>");
							out.println("<tr><td>"+rst.getInt("orderId")+"</td><td>"+rst.getDate("orderDate")+" "+rst.getTime("orderDate")+"</td><td>"+rst.getInt("customerId")+"</td><td>"+rst.getString("firstName")+" "+rst.getString("lastName")+"</td><td>"+currFormat.format(rst.getDouble("totalAmount"))+"</td></tr>");
							out.print("<tr align=\"right\"><td colspan=\"4\">");

							//insert seperate table for for products ordered. Displays product Id, individual prices, and order total
							out.print("<table border=\"1\"><tr><th>Product Id</th><th>Quantity</th><th>Price</th></tr>");
							
								
							//itearate through products in order and add to table
							while(rst2.next())
							{
								out.print("<tr><td>"+rst2.getInt("productId")+"</td><td>"+rst2.getInt("quantity")+"</td><td>"+currFormat.format(rst2.getDouble("price"))+"</td></tr>");
							}

							//Close table and terminate row
							out.print("</table></td></tr>");
	
						}

						//close entire orders table
						out.println("</table></body></html>");


						//close text output
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