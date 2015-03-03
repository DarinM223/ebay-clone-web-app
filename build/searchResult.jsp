<%@ page import="edu.ucla.cs.cs144.SearchResult" %>
<!DOCTYPE html>
<html>
	<head>
		<title>Auction site search results</title>
		<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	</head>
	<body>
		<div class="container">
			<div class="jumbotron">
				
				<h1>Search results:</h1>

				<%
					boolean isValid = (Boolean)request.getAttribute("isValid");
					SearchResult[] results = (SearchResult[])request.getAttribute("results");
					if (!isValid) {
				%>
					<h2>The search query is not valid</h2>
				<%
					} else {
				%>
					<div class="list-group">
						<%
							for (int i = 0; i < results.length; i++) { 
								SearchResult result = results[i];
						%>
								<a href="item?id=<%= result.getItemId() %>" class="list-group-item">
									<h4 class="list-group-item-heading">ID#: <%= result.getItemId() %></h4>
									<p class="list-group-item-text"><%= result.getName() %></p>
								</a>
						<%
							}
						%>
					</div>
				<%
					}
				%>
			</div>
		</div>

		<!-- jQuery -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
		<!-- Bootstrap -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	</body>
</html>