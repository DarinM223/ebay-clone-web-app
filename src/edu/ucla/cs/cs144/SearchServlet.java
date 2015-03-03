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
        String q = request.getParameter("q");
        String skip = request.getParameter("numResultsToSkip");
        String numReturn = request.getParameter("numResultsToReturn");

        boolean isValid = true;

        int numResultsToSkip = -1;
        int numResultsToReturn = -1;

        try {
            numResultsToSkip = Integer.parseInt(skip);
            numResultsToReturn = Integer.parseInt(numReturn);
        } catch (Exception e) {
            isValid = false;
        } finally {
            SearchResult[] results = null;
            if (isValid) {
                results = AuctionSearchClient.basicSearch(q, numResultsToSkip, numResultsToReturn);
            }
            request.setAttribute("isValid", isValid);
            request.setAttribute("results", results);
            request.getRequestDispatcher("/searchResult.jsp").forward(request, response);
        }
    }
}
