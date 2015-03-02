<!DOCTYPE html>
<%@ page import="edu.ucla.cs.cs144.Item" %>
<%@ page import="java.util.*" %>
<% Item item = (Item) request.getAttribute("item"); %>
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
			</div>
		</div>

		<!-- jQuery -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
		<!-- Bootstrap -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	</body>
</html>