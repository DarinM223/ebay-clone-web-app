<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>Auction site checkout</title>
</head>
<body>
    <h1>Order confirmation</h1>
    <h1>Your order has been processed</h1>
    <h3>Item ID: <%= request.getAttribute("ItemID") %></h3>
    <h3>Name: <%= request.getAttribute("Name") %></h3>
    <h3>Buy price: <%= request.getAttribute("BuyPrice") %></h3>

    <h3>Credit Card: <%= request.getAttribute("CreditCard") %></h3><br/>
    <h3>Time: <%= request.getAttribute("CurrTime") %></h3><br/>

    <a href="<%= request.getAttribute("UnsecureLink") %>/keywordSearch.html">Search</a>
    <a href="<%= request.getAttribute("UnsecureLink") %>/getItem.html">Find item by id</a>

</body>
</html>