<!DOCTYPE html>
<%@ page import="edu.ucla.cs.cs144.Seller" %>
<%@ page import="edu.ucla.cs.cs144.Item" %>
<%@ page import="java.util.*" %>
<%
	Seller seller = (Seller) request.getAttribute("seller");
	Item item = (Item) request.getAttribute("item");
	ArrayList<String> categories = (ArrayList<String>) request.getAttribute("categories");
%>

<html>
	<head>
		<title>Item Information</title>
		<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	</head>
	<body>
		<div class="container">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Item ID: <%= item.i_itemID %> </h3>
  				</div>
  				<ul class="list-group">
					<li class="list-group-item">Item Name: <%= item.i_name %></li>
					<li class="list-group-item">Description: <%= item.i_description %></li>
					<li class="list-group-item">Number of Bids: <%= item.i_number_of_bids %></li>
					<li class="list-group-item">Starting Price: <%= item.i_first_bid %></li>
					<li class="list-group-item">Current Price: <%= item.i_currently %></li>
					<li class="list-group-item">Buy Price: <%= item.i_buy_price %></li>
					<li class="list-group-item">Start Time: <%= item.i_started %></li>
					<li class="list-group-item">End Time: <%= item.i_ends %></li>
				</ul>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Seller Info</h3>
  				</div>
  				<ul class="list-group">
					<li class="list-group-item">UserID: <%= seller.s_userID %></li>
					<li class="list-group-item">Rating: <%= seller.s_rating%></li>
				</ul>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Categories</h3>
  				</div>
  				<table class="table">
  					<tbody>
  						<%
  							for (String category : categories) {
  						%>
  							<tr>
  								<td><%= category %></td>
  							</tr>
  						<%
  							}
  						%>
  					</tbody>
  				</table>

			</div>


		</div>

		<!-- jQuery -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
		<!-- Bootstrap -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	</body>
</html>