<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
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
		  <li><a href = "listprod.jsp">Product List</a></li>
		  <li class="right"><a href="logout.jsp">Log out</a></li>
		  <li class="right"><a href = "login.jsp">Login</a></li>
		  <li class="right"><a href = "admin.jsp">Administrator Page</a></li>
		  <li class="right"><a href = "create_account.jsp">Create Account</a></li>
		  <li class="right"><a href = "index.jsp">Index</a></li>


		</ul>

		
		</body>
		</html>

	


<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");


String prodId = "";

if (productList == null)
{	out.println("<H1 align=\"center\">Your shopping cart is empty!</H1>");
	productList = new HashMap<String, ArrayList<Object>>();
}
else if(productList.isEmpty())
{
	out.println("<H1>Your shopping cart is empty!</H1>");
}
else
{
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();

	out.println("<h1>Your Shopping Cart</h1>");
	out.print("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
	out.println("<th>Price</th><th>Subtotal</th></tr>");

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

		


		out.print("<td align=\"center\"><form align = \"middle\", method=\"get\" action=\"updateItem.jsp\"><input type=\"text\" name=\"quant\" value = " +qty+ "><input type=\"submit\" name=\"btn\" value=\"Add\"></form></td>");


	
		prodId = (String) product.get(0);
		String act = (String) product.get(0);

		out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
		out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td>");
		total = total +pr*qty;


		String name = request.getParameter("quant");


	}


	out.println("</tr>");

	out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
			+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
	out.println("</table>");



}
%>

<br>
<br>
<form align = "middle", method="get" action="checkout.jsp">
	<input type="submit" value="Check Out" style="border-radius: 15px;padding: 10px;border: 2px solid #ccc;">
	</form>
<br>
<form align = "middle", method="get" action="listprod.jsp">
<input type="submit" value="Continue Shopping" style="border-radius: 15px;padding: 10px;border: 2px solid #ccc;">
</form>


</body>
</html> 

