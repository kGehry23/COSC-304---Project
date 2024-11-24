<!DOCTYPE html>
<html>
<head>
	<style>
		body {background-color: powderblue}
	</style>
        <title>Chop & Co Grocery Main Page</title>
</head>
<body>
<h1 align="center">Welcome to Chop and Co Grocery</h1>

<h2 align="center"><a href="login.jsp">Login</a></h2>

<h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

<h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

<h2 align="center"><a href="admin.jsp">Administrators</a></h2>

<h2 align="center"><a href="logout.jsp">Log out</a></h2>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null)
		out.println("<h3 align=\"center\">Signed in as: "+userName+"</h3>");
%>

<h4 align="center"><a href="ship.jsp?orderId=1">Test Ship orderId=1</a></h4>

<h4 align="center"><a href="ship.jsp?orderId=3">Test Ship orderId=3</a></h4>

<h4 align="center"><a href="ship.jsp?orderId=12">Test Ship orderId=12</a></h4>

</body>
</head>


