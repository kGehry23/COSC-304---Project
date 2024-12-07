<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.*" %>
<%@ include file="jdbc.jsp" %>
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
		  <li class="right"><a href="logout.jsp">Log out</a></li>
		  <li class="right"><a href = "login.jsp">Login</a></li>
		  <li class="right"><a href = "admin.jsp">Administrator Page</a></li>
		  <li class="right"><a href = "create_account.jsp">Create Account</a></li>
		  <li class="right"><a href = "index.jsp">Index</a></li>


		</ul>

		<jsp:include page="header.jsp" />

		
		</body>
		</html>
        

<%
	// TODO: Get order id
	String orderId = request.getParameter("orderId");

          
	// TODO: Check if valid order id in database

	String url="jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True"; 
    String uid="sa" ; 
    String pw="304#sa#pw";


	String sql2 = "SELECT * FROM orderproduct WHERE orderId = ?";
	String sql4 = "SELECT * FROM productinventory WHERE productId = ?";
	

	try ( Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();) 
  	{	

		String sql = "SELECT * FROM ordersummary WHERE orderId = " +orderId;
		ResultSet rst = stmt.executeQuery(sql);

		if(rst.next())
		{

			// TODO: Start a transaction (turn-off auto-commit)
			//turn off autcommit
			con.setAutoCommit(false);


			// TODO: Retrieve all items in order with given id

			PreparedStatement pstmt = con.prepareStatement(sql2);
			pstmt.setString(1, orderId);
			ResultSet rst1 = pstmt.executeQuery();

			// TODO: Create a new shipment record.

			TimeZone.setDefault(TimeZone.getTimeZone("America/Los_Angeles"));
			long now = System.currentTimeMillis();
			Timestamp time = new Timestamp(now);

			String sql3 = "INSERT INTO shipment (warehouseId) VALUES (?, ?)";

			Statement stmt2 = con.createStatement();
			stmt2.execute("INSERT INTO shipment (warehouseId) VALUES ("+1+")");
		
		
			// TODO: For each item verify sufficient quantity available in warehouse 1.


			int newQuantity = 0;

			while(rst1.next())
			{
				int id = rst1.getInt("productId");
			
				PreparedStatement pstmt1 = con.prepareStatement(sql4);
				pstmt1.setInt(1, id);
				ResultSet rst2 = pstmt1.executeQuery();

				rst2.next();
		
				newQuantity = rst2.getInt("quantity") - rst1.getInt("quantity");


				// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.

				if(newQuantity > 0)
				{
					out.print("<h4>"+"Ordered Product: " +rst1.getInt("productId")+ "&ensp;Qty: " +rst1.getInt("quantity"));
					out.print("&ensp;Previous Inventory: " +rst2.getInt("quantity")+ "&ensp;New Inventory: " +newQuantity+ "</h4>");

					String sql5 = "UPDATE productinventory SET quantity = "+newQuantity+" WHERE productId = "+id;

					//create statement to be executed if transaction is successful
					Statement stmt3 = con.createStatement();
					stmt3.execute(sql5);
				}

				else
				{
					//rollback if quantity is not enough
					con.rollback();
					out.print("<h2>Shipment Not Completed. Insufficient Inventory For Product Id: " +id+ "</h2>");
					out.print("<h2><a href=\"shop.html\">Back to Main Page</a></h2>");
					return;

				}
			}

			//commit changes if transaction was successful
			con.commit();
			out.print("<h2>Shipment Successfully Processed.</h2>");


			// TODO: Auto-commit should be turned back on
			con.setAutoCommit(true);
		

		}


		else{
			out.print("That Order Id Does Not Exist");
		}


	}

	catch (SQLException ex)
	{
		System.err.println("SQLException: " + ex);
	}

%>                       				


<form method="get" action="listprod.jsp">
    <input type="submit" value="Back to Main Page" style="border-radius: 15px;padding: 10px;border: 2px solid #ccc;">
    </form>

</body>
</html>
