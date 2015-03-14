package edu.ucla.cs.cs144;

import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by D_2 on 3/14/2015.
 */
public class PurchaseConfirmationServlet extends HttpServlet implements Servlet {
    public PurchaseConfirmationServlet() {}

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(true);
        String itemID = (String)session.getAttribute("ItemID");
        String name = (String)session.getAttribute("Name");
        String buyPrice = (String)session.getAttribute("BuyPrice");
        String creditCard = (String)session.getAttribute("CreditCard");

        req.setAttribute("ItemID", itemID);
        req.setAttribute("Name", name);
        req.setAttribute("BuyPrice", buyPrice);
        req.setAttribute("CreditCard", creditCard);

        // if parameters are not valid, go to fail checkout page
        if (itemID == null || itemID.trim().isEmpty() || name == null || name.trim().isEmpty() || buyPrice == null || buyPrice.trim().isEmpty()) {
            req.getRequestDispatcher("/fail_checkout.jsp").forward(req, resp);
            return;
        } else if (creditCard == null || creditCard.trim().isEmpty()) { // if credit card is not valid, go to fail confirmation page
            req.getRequestDispatcher("/fail_confirm.jsp").forward(req, resp);
        }

        // Get current time
        DateFormat format = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
        Date d = new Date();
        String currTime = format.format(d);
        req.setAttribute("CurrTime", currTime);

        req.getRequestDispatcher("/success_confirm.jsp").forward(req, resp);
    }
}
