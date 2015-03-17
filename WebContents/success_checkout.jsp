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
                <h1>Order Checkout</h1>

                <ul class="list-group">
                    <li class="list-group-item"><b>ItemID:</b> <%= request.getAttribute("ItemID") %></li>
                    <li class="list-group-item"><b>Name:</b> <%= request.getAttribute("Name") %></li>
                    <li class="list-group-item"><b>Buy Price:</b> <%= request.getAttribute("BuyPrice") %></li>
                </ul>

                <form action="<%= request.getAttribute("SecureLink") %>/confirm" method="POST" class="form-horizontal">
                    <fieldset>
                        <div class="form-group">
                            <input type="text" name="CreditCard" value="" class="form-control" placeholder="Credit Card #">
                        </div>

                        <div class="form-group">
                            <input type="submit" value="Submit" class="btn btn-primary">
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>

        <!-- jQuery -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <!-- Bootstrap -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    </body>
</html>