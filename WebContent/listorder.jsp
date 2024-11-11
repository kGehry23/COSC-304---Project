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


		
					try ( Connection con = DriverManager.getConnection(url, uid, pw);
	          		Statement stmt = con.createStatement();) 
	    			{			

						
						ResultSet rst = stmt.executeQuery(sql);

						out.print("<table border=\"1\">");
						out.print("<tr><th>OrderId</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");

						while (rst.next())
						{		
								
							out.println("<tr><td>"+rst.getInt("orderId")+"</td><td>"+rst.getDate("orderDate")+" "+rst.getTime("orderDate")+"</td><td>"+rst.getInt("customerId")+"</td><td>"+rst.getString("firstName")+" "+rst.getString("lastName")+"</td><td>"+rst.getDouble("totalAmount")+"</td></tr>");
							
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