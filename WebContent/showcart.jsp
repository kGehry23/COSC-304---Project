<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<style>
body {background-color: powderblue}

table, td, th {
  		border: 1px solid;
		padding: 15px;
		font-family:Georgia, 'Times New Roman', Times, serif;
	
	}

table {
	width: 100%;
  	border-collapse: collapse;
}


h1 {
	font-family: Georgia, 'Times New Roman', Times, serif;
}

h2 {
	font-family: Georgia, 'Times New Roman', Times, serif;
}
</style>
<title>Your Shopping Cart</title>
</head>
<body>

	<script>
		function func(id)
		{
			productList.remove(id);
		}
	</script>

<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");


String prodId = "";

if (productList == null)
{	out.println("<H1>Your shopping cart is empty!</H1>");
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

		

	

		out.print("<td align=\"center\"><form><input type =\"text\" name = \"quant\" size = \"3\" value = \""+product.get(3)+"\"></form></td>");

		

		prodId = (String) product.get(0);
		String act = (String) product.get(0);




		out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
		out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td>");
		
		total = total +pr*qty;
	}


	out.println("</tr>");

	out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
			+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
	out.println("</table>");

	out.println("<h2><a href=\"checkout.jsp\">Check Out</a></h2>");

}
%>
<h2><a href="listprod.jsp">Continue Shopping</a></h2>

</body>
</html> 

