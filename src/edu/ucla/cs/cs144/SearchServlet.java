package edu.ucla.cs.cs144;

import java.io.IOException;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SearchServlet extends HttpServlet implements Servlet {
       
    public SearchServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        // your codes here
        String query = request.getParameter("q");
        int numResultsToSkip = Integer.parseInt(request.getParameter("numResultsToSkip"));
        int numResultsToReturn = Integer.parseInt(request.getParameter("numResultsToReturn"));

        SearchResult[] results = AuctionSearchClient.basicSearch(query, numResultsToSkip, numResultsToReturn);

        request.setAttribute("results", results);
        request.setAttribute("q", query);
        request.setAttribute("numResultsToSkip", numResultsToSkip);
        request.setAttribute("numResultsToReturn", numResultsToReturn);
        request.getRequestDispatcher("/searchResult.jsp").forward(request, response);
    }
}
