<%@ page import="edu.ucla.cs.cs144.SearchResult" %>
<!DOCTYPE html>
<html>
	<head>
		<title>Auction site search results</title>
		<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="css/styles.css">
	</head>
	<body>
		<div class="container">
			<div class="jumbotron">
				
				<h1>Search results:</h1>

				<form action="search" method="GET">
					<input type="text" name="q" id="q-input">
					<input type="hidden" name="numResultsToSkip" value="0">
					<input type="hidden" name="numResultsToReturn" value="20">
					<input type="submit" value="Search!" class="btn btn-primary">
				</form>

				<%
					boolean isValid = (Boolean)request.getAttribute("isValid");
					if (!isValid) {
				%>
						<h2>The search query is not valid</h2>
				<%
					} else {
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
							<a href="search?q=<%= query %>&numResultsToSkip=<%= numResultsToSkip + numResultsToReturn %>&numResultsToReturn=<%= numResultsToReturn %>" class="btn btn-primary" id="next">Next</a>
						<%
							}
						%>
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