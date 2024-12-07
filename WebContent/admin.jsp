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
		  <li class="right"><a href="logout.jsp">Log out</a></li>
		  

		</ul>

		
		</body>
		</html>
	
    </style>
<title>Administrator Page</title>
</head>
<body>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<h1>Administrator Sales Report By Day</h1>


<%

    NumberFormat currFormat = NumberFormat.getCurrencyInstance();


    String userName = (String) session.getAttribute("authenticatedUser");

	if (userName == null){
	    out.println("<h1>You must log in to access this page </h1>");
	    return;
	}


    //DB connection credentials
    String url="jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True"; 
    String uid="sa" ; 
    String pw="304#sa#pw";

    // TODO: Write SQL query that prints out total order amount by day
    String sql = "SELECT YEAR(orderDate) as year, MONTH(orderDate) as month, DAY(orderDate) as day, SUM(totalAmount) AS total FROM orderSummary GROUP BY YEAR(orderDate), MONTH(orderDate), DAY(orderDate)";

    out.print("<table border=\"1\">");
    out.print("<tr><th>Order Date</th><th>Total Order Amount</th></tr>");
    
    //connect to DB
    try ( Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();) 
  	{	
    
        ResultSet rst = stmt.executeQuery(sql);

        while(rst.next())
        {
            out.print("<tr><td>"+rst.getString("year")+"-"+rst.getString("month")+"-"+rst.getString("day")+"</td><td>"+currFormat.format(rst.getDouble("total"))+"</td></tr>");
        }
        

    }

    catch (SQLException ex)
	{
		System.err.println("SQLException: " + ex);
	}


%>

</body>
</html>

