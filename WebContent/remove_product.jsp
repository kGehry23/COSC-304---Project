
<!-- The following file allows for adding a product to the product list -->

<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
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
<title>Remove Product Page</title>
</head>
<body>

<!-- Header -->
<ul class="topnav">
    <li><a href = "listorder.jsp">Orders</a></li>
    <li><a href = "showcart.jsp">Cart</a></li>
    <li class="right"><a href="logout.jsp">Log out</a></li>
    <li class="right"><a href = "login.jsp">Login</a></li>

</ul>

<div style="margin:0 auto;text-align:center;display:inline">

<h3>Remove Product</h3>

<form name="MyForm" method=post action="remove_product.jsp">
<table style="display:inline">
<tr>
    <td><input align="right" type="text" placeholder="Product Name" name="pname" size=10 maxlength=10 style="border-radius: 15px;padding: 10px;border: 2px solid #ccc;"></td>
</tr>
</table>
<br>
<br>
<table style="display:inline">
</table>
<br>
<td><input align="right" class="submit" type="submit" name="Submit2" value="Finish" style="border-radius: 15px;padding: 10px;border: 2px solid #ccc;"></td>

</form>



<%


    String prod_name = request.getParameter("pname");
  
   



if(prod_name != "" && prod_name != null)
{
    try
    {	// Load driver class
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    }
    catch (java.lang.ClassNotFoundException e)
    {
        out.println("ClassNotFoundException: " +e);
    }

    String url="jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True"; 
    String uid="sa" ; 
    String pw="304#sa#pw";


    String sql1 = "SELECT * FROM product WHERE productName = ?";
    String sql2 = "DELETE FROM product WHERE productName = ?";


    //attempt connection to DB
    try ( Connection con = DriverManager.getConnection(url, uid, pw);
    Statement stmt = con.createStatement();) 
      {	

        PreparedStatement pstmt = con.prepareStatement(sql1);
        pstmt.setString(1, prod_name);

        ResultSet rst = pstmt.executeQuery();

        if(rst.next())
        {

            out.print("<h2>"+"The Product Has Been Removed!"+"</h2>");

            PreparedStatement pstmt2 = con.prepareStatement(sql2);
            pstmt2.setString(1, prod_name);
     
            pstmt2.executeUpdate();

        }

        else
        {
            out.print("<h2>"+"That Product Does Not Exist in the Database."+"</h2>");
        }


    }

    catch (SQLException ex)
    {
        out.println("SQLException: " + ex);
    }

}


    

%>

</div>

</body>
</html>