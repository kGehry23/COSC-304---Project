<!DOCTYPE html>
<html>

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

    h3 {
        font-size: 30px;
        color: lightgray;
    }


	</style>
<title>Login Screen</title>
</head>
<body>

	<!-- Header -->
<ul class="topnav">
	<li><a href = "listprod.jsp">Product List</a></li>
    <li><a href = "listorder.jsp">Orders</a></li>
    <li><a href = "showcart.jsp">Cart</a></li>
    <li class="right"><a href="logout.jsp">Log out</a></li>

</ul>

<div style="margin:0 auto;text-align:center;display:inline">

<h3>Login Page</h3>

<%
// Print prior error login message if present
if (session.getAttribute("loginMessage") != null)
	out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
%>

<br>
<form name="MyForm" method=post action="validateLogin.jsp">
<table style="display:inline">
<tr>
	<td><input type="text" placeholder="User Name" name="username"  size=10 maxlength=10 style="border-radius: 15px;padding: 10px;border: 2px solid #ccc;"></td>
</tr>
<tr>
	<td><input type="password" placeholder="Password" name="password" size=10 maxlength="10" style="border-radius: 15px;padding: 10px;border: 2px solid #ccc;"></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Log In" style="border-radius: 15px;padding: 10px;border: 2px solid #ccc;">
</form>

</div>

</body>
</html>

