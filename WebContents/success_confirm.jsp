<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>Auction site checkout</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <div class="jumbotron">
            <h1>Order confirmation</h1>
            <h3>Your order has been processed</h3>

            <ul class="list-group">
                <li class="list-group-item"><b>ItemID:</b> <%= request.getAttribute("ItemID") %></li>
                <li class="list-group-item"><b>Name:</b> <%= request.getAttribute("Name") %></li>
                <li class="list-group-item"><b>Buy Price:</b> <%= request.getAttribute("BuyPrice") %></li>
                <li class="list-group-item"><b>Credit Card:</b> <%= request.getAttribute("CreditCard") %></li>
                <li class="list-group-item"><b>Time:</b> <%= request.getAttribute("CurrTime") %></li>
            </ul>

            <ul class="nav nav-pills">
                <li><a href="<%= request.getAttribute("UnsecureLink") %>/">Home</a></li>
                <li><a href="<%= request.getAttribute("UnsecureLink") %>/keywordSearch.html">Search</a></li>
                <li><a href="<%= request.getAttribute("UnsecureLink") %>/getItem.html">Find item by id</a></li>
            </ul>
        </div>
    </div>

    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</body>
</html>