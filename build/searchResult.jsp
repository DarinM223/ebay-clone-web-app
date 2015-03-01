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
					String query = (String) request.getAttribute("q");
					int numResultsToSkip = (Integer) request.getAttribute("numResultsToSkip");
					int numResultsToReturn = (Integer) request.getAttribute("numResultsToReturn");
					SearchResult[] results = (SearchResult[])request.getAttribute("results");
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
					if (numResultsToSkip - numResultsToReturn >= 0) {
				%>
					<a href="search?q=<%= query %>&numResultsToSkip=<%= numResultsToSkip - numResultsToReturn %>&numResultsToReturn=<%= numResultsToReturn %>" class="btn btn-primary">Previous</a>
				<%
					}
				%>

				<% 
					if (results.length > 0) {
				%>
					<a href="search?q=<%= query %>&numResultsToSkip=<%= numResultsToSkip + numResultsToReturn %>&numResultsToReturn=<%= numResultsToReturn %>" class="btn btn-primary" style="float: right;">Next</a>
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