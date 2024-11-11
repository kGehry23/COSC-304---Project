<%@ page import="java.sql.*" %>
	<%@ page import="java.text.NumberFormat" %>
		<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8" %>
			<!DOCTYPE html>
			<html>

			<head>
				<title>Chop & Co Grocery Order List</title>
			</head>

			<body>

				<h1>Order List</h1>

				<%

				
					

					String url="jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True"; 
					String uid="sa" ; 
					String pw="304#sa#pw";
					
					String sql = "SELECT orderId, orderDate, orderSummary.customerId, firstName, lastName, totalAmount FROM orderSummary JOIN customer ON orderSummary.customerId = customer.customerId";
					String sql2 = "SELECT productId, quantity, price FROM orderproduct WHERE orderId = ?";


		
					try ( Connection con = DriverManager.getConnection(url, uid, pw);
	          		Statement stmt = con.createStatement();) 
	    			{			

						
						ResultSet rst = stmt.executeQuery(sql);

						out.print("<table border=\"1\">");
						out.print("<tr><th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");

						while (rst.next())
						{		

							PreparedStatement pstmt = con.prepareStatement(sql2);
							pstmt.setInt(1, rst.getInt("orderId"));

							ResultSet rst2 = pstmt.executeQuery();

							out.println("<tr><td>"+rst.getInt("orderId")+"</td><td>"+rst.getDate("orderDate")+" "+rst.getTime("orderDate")+"</td><td>"+rst.getInt("customerId")+"</td><td>"+rst.getString("firstName")+" "+rst.getString("lastName")+"</td><td>"+"$"+String.format("%.2f", rst.getDouble("totalAmount"))+"</td></tr>");
							out.print("<tr align=\"right\"><td colspan=\"4\">");

							out.print("<table border=\"1\"><tr><th>Product Id</th><th>Quantity</th><th>Price</th></tr>");
							
								
							while(rst2.next())
							{

								out.print("<tr><td>"+rst2.getInt("productId")+"</td><td>"+rst2.getInt("quantity")+"</td><td>"+"$"+String.format("%.2f",rst2.getDouble("price"))+"</td></tr>");
					
							}


							out.print("</table></td></tr>");

							



							
						}

						out.println("</table></body></html>");
					}
					catch (SQLException ex)
					{
						System.err.println("SQLException: " + ex);
					}

					
					
					
					

				%>
					
					
			

			</body>

			</html>