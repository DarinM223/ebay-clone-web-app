<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>Auction site checkout</title>
</head>
<body>
	<h1>Order Checkout</h1>
	<h3>Item ID: <%= request.getAttribute("ItemID") %></h3>
    <h3>Name: <%= request.getAttribute("Name") %></h3>
    <h3>Buy price: <%= request.getAttribute("BuyPrice") %></h3>
    <form action="<%= request.getAttribute("SecureLink") %>/confirm" method="POST">
    	<label for="CreditCard">Credit card #: </label>
    	<input type="text" id="CreditCard" name="CreditCard">
    	<input type="submit" value="submit">
    </form>
</body>
</html>