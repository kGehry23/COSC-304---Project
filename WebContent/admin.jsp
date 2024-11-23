

<!DOCTYPE html>
<html>
<head>
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

