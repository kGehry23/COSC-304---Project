<!DOCTYPE html>
<html>
<head>
	<style>
		body { background-color: #555}

		table, td, th {
  		border: 0.5px solid;
		padding: 15px;
		font-family:Georgia, 'Times New Roman', Times, serif;
		background-color: #444;
		color: lightslategray;
	}

	tr {
		color:black;
 		font-size:18px;
	}

	table {
		width: 100%;
  		border-collapse: collapse;
	}

	h2 {

		color: white
	}
	</style>
<title>Customer Page</title>
</head>
<body>
	

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<h2> Customer Information </h2>



<%

	String userName = (String) session.getAttribute("authenticatedUser");

	if (userName == null){
		out.println("<h1>You must log in to access this page </h1>");
		return;
	}		


//DB connection credentials
String url="jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True"; 
String uid="sa" ; 
String pw="304#sa#pw";

//customerID, fistName, lastName, email, phoneNum, address, city,state, postalCode, country, userID
// TODO: Print Customer information
String sql = "SELECT * FROM customer";




//connect to DB
try ( Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();) 
{	
	
	PreparedStatement pstmt = con.prepareStatement(sql);

	ResultSet rs = pstmt.executeQuery();

	while(rs.next())
	{

		int customerID = rs.getInt("customerId");
		String firstName = rs.getString("firstName");
		String lastName = rs.getString("lastName");
		String email = rs.getString("email");
		String phoneNum = rs.getString("phoneNum");
		String address = rs.getString("address");
		String city = rs.getString("city");
		String state = rs.getString("state");
		String postalCode = rs.getString("postalCode");
		String country = rs.getString("country");
		String userID = rs.getString("userID");
		//String = rs.getString("");

		out.print("<table border=\"1\">");
		out.println("<tr><td>Customer ID</td><td>" +customerID+ "</td><tr>");
		out.println("<tr><td>First Name</td><td>"+ firstName +"</td><tr>");
		out.println("<tr><td>Last Name</td><td>"+ lastName +"</td><tr>");
		out.println("<tr><td>Email</td><td>"+ email +"</td><tr>");
		out.println("<tr><td>Phone</td><td>"+ phoneNum +"</td><tr>");
		out.println("<tr><td>Address</td><td>"+ address +"</td><tr>");
		out.println("<tr><td>City</td><td>"+ city +"</td><tr>");
		out.println("<tr><td>State</td><td>"+ state +"</td><tr>");
		out.println("<tr><td>postalCode</td><td>"+ postalCode +"</td><tr>");
		out.println("<tr><td>Country</td><td>"+ country +"</td><tr>");
		out.println("<tr><td>UserId</td><td>"+ userID +"</td><tr>");
		out.println("</table>");

		out.print("<br>");
		out.print("<br>");

	}

}

catch (SQLException ex)
{
	System.err.println("SQLException: " + ex);
}


%>


</body>
</html>

