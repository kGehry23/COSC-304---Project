<!DOCTYPE html>
<html>
<head>
<style>
    body{
        background-color: powderblue;
    }
    h1 {
		font-family: Georgia, 'Times New Roman', Times, serif;
	}

	h2 {
		font-family: Georgia, 'Times New Roman', Times, serif;
	} 
</style>
<title>Chop & Co CheckOut Line</title>
</head>
<body>

<!-- Link to go back to cart -->
<a href = "showcart.jsp">Back To Cart</a>
<h1>Enter your customer id to complete the transaction:</h1>

<form method="get" action="order.jsp">
Customer Id: <input type="text" name="customerId" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset">
</form>



</body>
</html>

