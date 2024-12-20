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
	
<title>Chop & Co CheckOut Line</title>
</head>
<body>

<!-- Link to go back to cart -->
<h1  align = "middle">Enter your customer id to complete the transaction:</h1>


<form align = "middle" method="get" action="order.jsp">
<input type="text" name="customerId" placeholder="Customer Id" size="50" style="border-radius: 15px;padding: 10px;border: 2px solid #ccc;">
<input type="submit" value="Submit" style="border-radius: 15px;padding: 10px;border: 2px solid #ccc;"><input type="submit" value="Reset" style="border-radius: 15px;padding: 10px;border: 2px solid #ccc;">
</form>



</body>
</html>

