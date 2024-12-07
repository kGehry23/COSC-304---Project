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
		  <li><a href = "showcart.jsp">Cart</a></li>
		  <li><a href = "listprod.jsp">Product List</a></li>
		  <li class="right"><a href="logout.jsp">Log out</a></li>
		  <li class="right"><a href = "login.jsp">Login</a></li>
		  <li class="right"><a href = "admin.jsp">Administrator Page</a></li>
		  <li class="right"><a href = "create_account.jsp">Create Account</a></li>
		  <li class="right"><a href = "index.jsp">Index</a></li>


		</ul>

		<jsp:include page="header.jsp" />
	
</style>
<script>
    function updateSubtotal(productId) {
        const qty = document.getElementById("quantity_" + productId).value;
        const price = parseFloat(document.getElementById("price_" + productId).innerText.replace('$', ''));
        const subtotal = qty * price;
        document.getElementById("subtotal_" + productId).innerText = "$" + subtotal.toFixed(2);

        let total = 0;
        const subtotals = document.querySelectorAll(".subtotal");
        subtotals.forEach((item) => {
            total += parseFloat(item.innerText.replace('$', ''));
        });
        document.getElementById("total").innerText = "$" + total.toFixed(2);
    }

    function removeItem(productId) {
        document.location.href = "addcart.jsp?action=remove&id=" + productId;
    }
</script>
<title>Your Shopping Cart</title>
</head>
<body>

	

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
	out.println("<h1 align = \"middle\">Your shopping cart is empty!</h1>");
}
else
{
    NumberFormat currFormat = NumberFormat.getCurrencyInstance();

    out.println("<h1>Your Shopping Cart</h1>");
    out.print("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
    out.println("<th>Price</th><th>Subtotal</th><th>Action</th></tr>");

    double total = 0;
    for (Map.Entry<String, ArrayList<Object>> entry : productList.entrySet()) {
        ArrayList<Object> product = entry.getValue();

        String productId = (String) product.get(0);
        String productName = (String) product.get(1);
        double price = 0;
        int quantity = 0;
        int availableStock = 0;

        try {
            price = Double.parseDouble(product.get(2).toString());
            quantity = Integer.parseInt(product.get(3).toString());
            if (product.size() > 4) {
                availableStock = Integer.parseInt(product.get(4).toString());
            } else {
                availableStock = 10; // Default stock if not provided
            }
        } catch (Exception e) {
            out.println("<tr><td colspan='6'>Error parsing product data for product ID: " + productId + "</td></tr>");
            continue;
        }

        double subtotal = price * quantity;
        total += subtotal;

        out.print("<tr>");
        out.print("<td>" + productId + "</td>");
        out.print("<td>" + productName + "</td>");
        out.print("<td>");
        out.print("<select id='quantity_" + productId + "' onchange='updateSubtotal(\"" + productId + "\")'>");
        for (int i = 1; i <= availableStock; i++) {
            out.print("<option value='" + i + "'" + (i == quantity ? " selected" : "") + ">" + i + "</option>");
        }
        out.print("</select>");
        out.print("</td>");
        out.print("<td id='price_" + productId + "'>" + currFormat.format(price) + "</td>");
        out.print("<td id='subtotal_" + productId + "' class='subtotal'>" + currFormat.format(subtotal) + "</td>");
        out.print("<td><button onclick=removeItem(\"" + productId + "\")'>Remove</button></td>");
        out.print("</tr>");
    }

    out.println("<tr><td colspan='4' align='right'><b>Order Total</b></td>");
    out.println("<td id='total' align='right'>" + currFormat.format(total) + "</td>");
    out.println("<td></td></tr>");
    out.println("</table>");

	out.print("<form align = \"middle\", method=\"get\" action=\"checkout.jsp\">");
	out.print("<input type=\"submit\" value=\"Check Out\" style=\"border-radius: 15px;padding: 10px;border: 2px solid #ccc;\">");
	out.print("</form>");

}
%>

<br>
<br>

<form align = "middle", method="get" action="listprod.jsp">
<input type="submit" value="Continue Shopping" style="border-radius: 15px;padding: 10px;border: 2px solid #ccc;">
</form>

</body>
</html>
