package edu.ucla.cs.cs144;

import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by D_2 on 3/14/2015.
 */
public class PurchaseServlet extends HttpServlet implements Servlet {
    public PurchaseServlet() {}

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(true);
        String itemID = (String)session.getAttribute("ItemID");
        String name = (String)session.getAttribute("Name");
        String buyPrice = (String)session.getAttribute("BuyPrice");
        String secureLink = "https://" + req.getServerName() + ":8443" + req.getContextPath();

        // if parameters are not valid, go to fail checkout page
        if (itemID == null || itemID.trim().isEmpty() || name == null || name.trim().isEmpty() || buyPrice == null || buyPrice.trim().isEmpty()) {
            req.getRequestDispatcher("/fail_checkout.jsp").forward(req, resp);
            return;
        }

        // set attribute and go to success checkout page
        req.setAttribute("ItemID", itemID);
        req.setAttribute("Name", name);
        req.setAttribute("BuyPrice", buyPrice);
        req.setAttribute("SecureLink", secureLink);
        req.getRequestDispatcher("/success_checkout.jsp").forward(req, resp);
    }
}
