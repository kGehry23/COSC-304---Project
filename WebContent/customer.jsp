<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName == null){
	output.println("<h1>You must log in to access this page </h1>")
	return;
	}
%>

<%
//customerID, fistName, lastName, email, phoneNum, address, city,state, postalCode, country, userID
// TODO: Print Customer information
String sql = "SELECT * FROM customer WHERE userName = ?";
PreparedStatement stmt = con.prepareStatement(sql);
stmt.setString(1,userName);
ResultSet rs = stmt.executeQuery();

if (rs.next()){
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

	out.println("<h2> Customer Information </h2>");
	out.println("<table border '1' >");
	out.println("<tr><td>Customer ID<td><td>"+ customerID + >"</td><tr>");
	out.println("<tr><td>First Name<td><td>"+ firstName + >"</td><tr>");
	out.println("<tr><td>Last Name<td><td>"+ lastName + >"</td><tr>");
	out.println("<tr><td>Email<td><td>"+ email + >"</td><tr>");
	out.println("<tr><td>Phone<td><td>"+ phoneNum + >"</td><tr>");
	out.println("<tr><td>Address<td><td>"+ address + >"</td><tr>");
	out.println("<tr><td>City<td><td>"+ city + >"</td><tr>");
	out.println("<tr><td>State<td><td>"+ state + >"</td><tr>");
	out.println("<tr><td>postalCode<td><td>"+ postalCode + >"</td><tr>");
	out.println("<tr><td>Country<td><td>"+ country + >"</td><tr>");
	out.println("<tr><td>UserId</td><td>"+ userID + >"</td><tr>");
	out.println("</table");
	

}else{
	out.println("User Not Found")
}

catch (SQLException e){
	out.println("Error: "+ e); 
}finally{
	try
}

// Make sure to close connection

%>

</body>
</html>

