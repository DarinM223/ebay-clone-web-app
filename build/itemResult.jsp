<!DOCTYPE html>
<%@ page import="edu.ucla.cs.cs144.Bidder" %>
<%@ page import="edu.ucla.cs.cs144.Bid" %>
<%@ page import="edu.ucla.cs.cs144.Seller" %>
<%@ page import="edu.ucla.cs.cs144.Item" %>
<%@ page import="java.util.*" %>
<%
	Map<String, Bidder> bidders = (Map<String, Bidder>) request.getAttribute("bidders");
	ArrayList<Bid> bids = (ArrayList<Bid>) request.getAttribute("bids");
	Seller seller = (Seller) request.getAttribute("seller");
	Item item = (Item) request.getAttribute("item");
	ArrayList<String> categories = (ArrayList<String>) request.getAttribute("categories");
	boolean itemFound = (Boolean) request.getAttribute("itemFound");
%>

<html>
	<head>
		<title>Item Information</title>
		<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

		<meta name="viewport" content="initial-scale=1.0, user-scalable=no" /> 
		<style type="text/css"> 
			html { height: 100% } 
			body { height: 100%; margin: 0px; padding: 0px } 
			#map_canvas { height: 100% }
		</style>
		<script type="text/javascript"
			src="http://maps.google.com/maps/api/js?sensor=false"> 
		</script>
		<script type="text/javascript"> 
		  	function initialize() { 
		    	var latlng = new google.maps.LatLng(34.063509,-118.44541); 
		    	var myOptions = { 
		    		zoom: 14, // default is 8  
		    		center: latlng, 
		    		mapTypeId: google.maps.MapTypeId.ROADMAP 
		    }; 
		    var map = new google.maps.Map(document.getElementById("map_canvas"), 
		        myOptions); 
		  }
		</script>
	</head>
	<body onload="initialize()">
		<div class="container">
			<%
				if (!itemFound) {
			%>
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">No Item Found</h3>
					</div>
				</div>
			<%
				} else {
			%>
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
					<%
						if (item.i_buy_price != "") {
					%>
					<li class="list-group-item">Buy Price: <%= item.i_buy_price %></li>
					<%
						} else {
					%>
					<li class="list-group-item">Buy Price: N/A</li>
					<%
						}
					%>
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
			<%
				if (bids.size() != 0) {
			%>
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">Bidders</h3>
	  				</div>
	  				<table class="table">
	  					<tr>
	  						<th>Bidder ID</th>
	  						<th>Rating</th>
	  						<th>Location</th>
	  						<th>Country</th>
	  						<th>Bid Amount</th>
	  						<th>Time</th>
	  					</tr>
	  					<tbody>
	  						<%
	  							for (Bid bid : bids) {
	  								Bidder bidder = bidders.get(bid.bd_userID);
	  						%>
	  							<tr>
	  								<td><%= bidder.b_userID%></td>
	  								<td><%= bidder.b_rating%></td>
									<%
										if (bidder.b_location == "") {
									%>
										<td>N/A</td>
									<%
										} else {
									%>
										<td><%= bidder.b_location%></td>
									<%
										}
									%>
									<%
										if (bidder.b_country == "") {
									%>
										<td>N/A</td>
									<%
										} else {
									%>
										<td><%= bidder.b_country%></td>
									<%
										}
									%>
	  								<td><%= bid.bd_amount%></td>
	  								<td><%= bid.bd_time%></td>
	  							<tr>
	  							<%
	  								}
	  							%>
	  					</tbody>
	  				</table>
				</div>
			<%
				}
			%>
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Seller Location</h3>
  				</div>
  				<ul class="list-group">
					<li class="list-group-item">Location: <%= item.i_location %></li>
					<li class="list-group-item">Country: <%= item.i_country%></li>
					<%
						if (item.i_latitude == "") {
					%>
						<li class="list-group-item">Latitude: N/A</li>
					<%
						} else {
					%>
						<li class="list-group-item">Latitude: <%= item.i_latitude%></li>
					<%
						}
					%>
					<%
						if (item.i_longitude == "") {
					%>
						<li class="list-group-item">Longitude: N/A</li>
					<%
						} else {
					%>
						<li class="list-group-item">Longitude: <%= item.i_longitude%></li>
					<%
						}
					%>
				</ul>
			</div>

			<div id="map_canvas" style="width:100%; height:500px"></div>

			<%
				}
			%>
		</div>

		


		<!-- jQuery -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
		<!-- Bootstrap -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	</body>
</html>