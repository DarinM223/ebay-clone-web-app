package edu.ucla.cs.cs144;

import java.io.IOException;
import java.net.HttpURLConnection;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.net.HttpURLConnection;
import java.net.URL;
import java.io.*;
import java.net.URLEncoder;

public class ProxyServlet extends HttpServlet implements Servlet {
       
    public ProxyServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        // your codes here
        try {
        	String q = request.getParameter("q");
        	URL url = new URL("http://google.com/complete/search?output=toolbar&q="+ URLEncoder.encode(q, "UTF-8"));
        	HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        	InputStream is = conn.getInputStream();
        	InputStreamReader isr = new InputStreamReader(is);
        	BufferedReader bufR = new BufferedReader(isr);
        	StringBuffer strBuf = new StringBuffer();

        	String line = bufR.readLine();
            
        	while (line != null) {
        		strBuf.append(line);
        		line = bufR.readLine();
        	}

        	response.setContentType("text/xml");
        	PrintWriter out = response.getWriter();
        	out.println(strBuf.toString());
        } catch (Exception e) {
        	System.out.println(e);
        }
    }
}
