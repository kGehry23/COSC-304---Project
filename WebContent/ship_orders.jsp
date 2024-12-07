<!DOCTYPE html>
<html>
<head>
    <style>
        body {background-color: powderblue}

    
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
		  <li><a href = "add_product.jsp">Add Product</a></li>
          <li><a href = "remove_product.jsp">Remove Product</a></li>
		  <li><a href = "listprod.jsp">Product List</a></li>
          <li><a href = "customer.jsp">View All Users</a></li>
          <li class="right"><a href="logout.jsp">Log out</a></li>
		  <li class="right"><a href="login.jsp">Log In</a></li>

		</ul>

        <jsp:include page="header.jsp" />

		
		</body>
		</html>
	
    </style>
<title>Administrator Page</title>
</head>
<body>


    
<h4 align="center"><a href="ship.jsp?orderId=1">Test Ship orderId=1</a></h4>

<h4 align="center"><a href="ship.jsp?orderId=3">Test Ship orderId=3</a></h4>

<h4 align="center"><a href="ship.jsp?orderId=12">Test Ship orderId=12</a></h4>


</body>
</html>




