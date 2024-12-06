<!-- ********************************************************
 --- COSC 304 - Project
 ---
 --- 
 --- This file allows for creating an account and storing the
 --- information in the db
 --- 
 ---
 --- Author: Kai Gehry
 ---
 ---
 --- ********************************************************-->

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
<title>Create Account Screen</title>
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

<h3>Create Account</h3>

<form name="MyForm" method=post action="create_account.jsp">
<table style="display:inline">
<tr>
	<td><input align="right" type="text" placeholder="Username" name="username" size=10 maxlength=10 style="border-radius: 15px;padding: 10px;border: 2px solid #ccc;"></td>
	<td><input align="right" type="password" placeholder="Password" name="password" size=10 maxlength="10"style="border-radius: 15px;padding: 10px;border: 2px solid #ccc;"></td>
</tr>
</table>

<br>
<br>

<table style="display:inline">
<tr>
	<td><input align="right" type="text" placeholder="First Name" name="first_name" size=10 maxlength="10"style="border-radius: 15px;padding: 10px;border: 2px solid #ccc;"></td>
	<td><input align="right" type="text" placeholder="Last Name" name="last_name" size=10 maxlength="10"style="border-radius: 15px;padding: 10px;border: 2px solid #ccc;"></td>
	<td><input align="right" type="text" placeholder="Email" name="email" size=10 maxlength="10"style="border-radius: 15px;padding: 10px;border: 2px solid #ccc;"></td>
	<td><input align="right" type="text" placeholder="Phone Number" name="phone_number" size=10 maxlength="10"style="border-radius: 15px;padding: 10px;border: 2px solid #ccc;"></td>
</tr>
<tr>
	<td><input align="right" type="text" placeholder="Address" name="address" size=10 maxlength="10"style="border-radius: 15px;padding: 10px;border: 2px solid #ccc;"></td>
	<td><input align="right" type="text" placeholder="City" name="city" size=10 maxlength="10"style="border-radius: 15px;padding: 10px;border: 2px solid #ccc;"></td>
    <td><input align="right" type="text" placeholder="State" name="state" size=10 maxlength="10"style="border-radius: 15px;padding: 10px;border: 2px solid #ccc;"></td>
    <td><input align="right" type="text" placeholder="Country" name="country" size=10 maxlength="10"style="border-radius: 15px;padding: 10px;border: 2px solid #ccc;"></td>
	<td><input align="right" type="text" placeholder="Postal Code" name="postal_code" size=10 maxlength="10"style="border-radius: 15px;padding: 10px;border: 2px solid #ccc;"></td>
</tr>

</table>

<br>
<br>

<td><input align="right" class="submit" type="submit" name="Submit2" value="Finish" style="border-radius: 15px;padding: 10px;border: 2px solid #ccc;"></td>

</form>



<%

    String user_name = request.getParameter("username");
    String user_password = request.getParameter("password");
    String first_name = request.getParameter("first_name");
    String last_name = request.getParameter("last_name");
    String email = request.getParameter("email");
    String phone_number = request.getParameter("phone_number");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String country = request.getParameter("country");
    String postal_code = request.getParameter("postal_code");



if(user_name != "" && email != "")
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


    String sql1 = "SELECT * FROM customer WHERE email = ? OR userid = ?";
    String sql2 = "INSERT INTO customer VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";


    //attempt connection to DB
	try ( Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();) 
  	{	

        PreparedStatement pstmt = con.prepareStatement(sql1);
        pstmt.setString(1, email);
        pstmt.setString(2, user_name);

        ResultSet rst = pstmt.executeQuery();

        if(!rst.next())
        {

            out.print("<h2>"+"Your Account Has Been Successfully Created!"+"</h2>");

            PreparedStatement pstmt2 = con.prepareStatement(sql2);
            pstmt2.setString(1, first_name);
            pstmt2.setString(2, last_name);
            pstmt2.setString(3, email);
            pstmt2.setString(4, phone_number);
            pstmt2.setString(5, address);
            pstmt2.setString(6, city);
            pstmt2.setString(7, state);
            pstmt2.setString(8, country);
            pstmt2.setString(9, postal_code);
            pstmt2.setString(10, user_name);
            pstmt2.setString(11, user_password);

            pstmt2.executeUpdate();
        }

        else
        {
            out.print("<h2>"+"That user name or password is already associated with an account. Please make a different entry."+"</h2>");
        }


    }

    catch (SQLException ex)
    {
        System.err.println("SQLException: " + ex);
    }

}


    

%>

</div>

</body>
</html>