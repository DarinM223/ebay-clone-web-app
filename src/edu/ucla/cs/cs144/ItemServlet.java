package edu.ucla.cs.cs144;

import java.io.IOException;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.StringReader;
import org.xml.sax.InputSource;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.*;

//imports from MyParser.java
import java.io.*;
import java.text.*;
import java.util.*;
import javax.xml.parsers.FactoryConfigurationError;
import javax.xml.parsers.ParserConfigurationException;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;
import org.xml.sax.ErrorHandler;

public class ItemServlet extends HttpServlet implements Servlet {

    public ItemServlet() {}
    
    //helper functions from MyParser.java
    static final String[] typeName = {
        "none",
        "Element",
        "Attr",
        "Text",
        "CDATA",
        "EntityRef",
        "Entity",
        "ProcInstr",
        "Comment",
        "Document",
        "DocType",
        "DocFragment",
        "Notation",
    };



    static class MyErrorHandler implements ErrorHandler {
        
        public void warning(SAXParseException exception)
        throws SAXException {
            fatalError(exception);
        }
        
        public void error(SAXParseException exception)
        throws SAXException {
            fatalError(exception);
        }
        
        public void fatalError(SAXParseException exception)
        throws SAXException {
            exception.printStackTrace();
            System.out.println("There should be no errors " +
                               "in the supplied XML files.");
            System.exit(3);
        }
    }
    
    /* Non-recursive (NR) version of Node.getElementsByTagName(...)
     */
    static Element[] getElementsByTagNameNR(Element e, String tagName) {
        Vector< Element > elements = new Vector< Element >();
        Node child = e.getFirstChild();
        while (child != null) {
            if (child instanceof Element && child.getNodeName().equals(tagName))
            {
                elements.add( (Element)child );
            }
            child = child.getNextSibling();
        }
        Element[] result = new Element[elements.size()];
        elements.copyInto(result);
        return result;
    }
    
    /* Returns the first subelement of e matching the given tagName, or
     * null if one does not exist. NR means Non-Recursive.
     */
    static Element getElementByTagNameNR(Element e, String tagName) {
        Node child = e.getFirstChild();
        while (child != null) {
            if (child instanceof Element && child.getNodeName().equals(tagName))
                return (Element) child;
            child = child.getNextSibling();
        }
        return null;
    }
    
    /* Returns the text associated with the given element (which must have
     * type #PCDATA) as child, or "" if it contains no text.
     */
    static String getElementText(Element e) {
        if (e.getChildNodes().getLength() == 1) {
            Text elementText = (Text) e.getFirstChild();
            return elementText.getNodeValue();
        }
        else
            return "";
    }
    
    /* Returns the text (#PCDATA) associated with the first subelement X
     * of e with the given tagName. If no such X exists or X contains no
     * text, "" is returned. NR means Non-Recursive.
     */
    static String getElementTextByTagNameNR(Element e, String tagName) {
        Element elem = getElementByTagNameNR(e, tagName);
        if (elem != null)
            return getElementText(elem);
        else
            return "";
    }
    
    /* Returns the amount (in XXXXX.xx format) denoted by a money-string
     * like $3,453.23. Returns the input if the input is an empty string.
     */
    static String strip(String money) {
        if (money.equals(""))
            return money;
        else {
            double am = 0.0;
            NumberFormat nf = NumberFormat.getCurrencyInstance(Locale.US);
            try { am = nf.parse(money).doubleValue(); }
            catch (ParseException e) {
                System.out.println("This method should work for all " +
                                   "money values you find in our data.");
                System.exit(20);
            }
            nf.setGroupingUsed(false);
            return nf.format(am).substring(1);
        }
    }

    //escapes characters that need escaping
    static String escapeString(String s) {
        return s.replaceAll("\"", "\\\"");
    }

    //converts xml date format to sql date format
    static String convertDateFormat(String date) {
        try {
                SimpleDateFormat old_format = new SimpleDateFormat("MMM-dd-yy HH:mm:ss");
                SimpleDateFormat new_format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                date = new_format.format(old_format.parse(date));
        }
        catch(ParseException e) {
            System.out.println("Parse error!");
        }
        
        return date;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {

        //hashmaps and arraylist to store
        Map<String, Bidder> bidderMap = new HashMap<String, Bidder>();
        ArrayList<Bid> bidList = new ArrayList<Bid>();
        ArrayList<String> categoryList = new ArrayList<String>();
        
        // your codes here
        String id = request.getParameter("id");
        String xml = AuctionSearchClient.getXMLDataForItemId(id);

        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setValidating(false);
        factory.setIgnoringElementContentWhitespace(true);
        DocumentBuilder builder;
        Document doc = null;
        try {
            builder = factory.newDocumentBuilder();
            doc = builder.parse(new InputSource(new StringReader(xml)));
        } catch (Exception e) {
            System.out.println(e);
        }

        //check if the item is found
        if (doc == null) {
            request.setAttribute("itemFound", false);

            //send to jsp page for display
            request.getRequestDispatcher("/itemResult.jsp").forward(request, response);
        }
        else {
            Element item = doc.getDocumentElement();

            String itemID = item.getAttribute("ItemID");
            String name = escapeString(getElementTextByTagNameNR(item, "Name"));
            
            //convert currently, buy_price, first_bid to money-string
            String currently = strip(getElementTextByTagNameNR(item, "Currently"));
            String buy_price = strip(getElementTextByTagNameNR(item, "Buy_Price"));
            String first_bid = strip(getElementTextByTagNameNR(item, "First_Bid"));

            String number_of_bids = getElementTextByTagNameNR(item, "Number_of_Bids");
            Element location_e = getElementByTagNameNR(item, "Location");
            String location = escapeString(getElementText(location_e));
            String latitude = location_e.getAttribute("Latitude");
            String longitude = location_e.getAttribute("Longitude");
            String country = escapeString(getElementTextByTagNameNR(item, "Country"));

            //convert started and ends
            String started = convertDateFormat(getElementTextByTagNameNR(item, "Started"));
            String ends = convertDateFormat(getElementTextByTagNameNR(item, "Ends"));

            //get seller userID and rating
            Element seller = getElementByTagNameNR(item, "Seller");
            String s_userID = seller.getAttribute("UserID");
            String s_rating = seller.getAttribute("Rating");

            //create seller object for request
            Seller seller_obj = new Seller(s_userID, s_rating);

            //truncate description to 4000 characters if its longer than 4000
            String description = escapeString(getElementTextByTagNameNR(item, "Description"));
            if (description.length() > 4000) {
                description = description.substring(0, 4000);
            }

            //get bids for the item if any
            Element bids_root = getElementByTagNameNR(item, "Bids");
            Element[] bids = getElementsByTagNameNR(bids_root, "Bid");
            for (Element b : bids) {
                //get bidder info
                Element bidder = getElementByTagNameNR(b, "Bidder");
                String b_userID = bidder.getAttribute("UserID");
                String b_rating = bidder.getAttribute("Rating");
                String b_location = escapeString(getElementTextByTagNameNR(bidder, "Location"));
                String b_country = escapeString(getElementTextByTagNameNR(bidder, "Country"));

                //check if bidder is already in bidderMap and add bidder if not
                if (!bidderMap.containsKey(b_userID)) {
                    Bidder b_bidder = new Bidder(b_userID, b_rating, b_location, b_country);
                    bidderMap.put(b_userID, b_bidder);
                }

                //get remaining bid info
                String time = convertDateFormat(getElementTextByTagNameNR(b, "Time"));
                String amount = strip(getElementTextByTagNameNR(b, "Amount"));

                //add bid to bidList
                Bid bid = new Bid(itemID, b_userID, time, amount);
                bidList.add(bid);
            }

            //get all categories and put into categories
            Element[] categories = getElementsByTagNameNR(item, "Category");
            for (Element c : categories) {
                //get category and add to categories
                String category = getElementText(c);
                categoryList.add(category);
            }

            //create item object for request
            Item item_obj = new Item(itemID, name, currently, buy_price, first_bid,
                            number_of_bids, location, latitude, longitude,
                            country, started, ends, s_userID, description);

            //sort bids by date before passing for display
            Collections.sort(bidList);

            //sort categories alphabetically before passing for display
            Collections.sort(categoryList);

            //set attributes for the 5 sections
            request.setAttribute("bidders", bidderMap);
            request.setAttribute("seller", seller_obj);
            request.setAttribute("bids", bidList);
            request.setAttribute("item", item_obj);
            request.setAttribute("categories", categoryList);
            request.setAttribute("itemFound", true);

            //send to jsp page for display
            request.getRequestDispatcher("/itemResult.jsp").forward(request, response);
        }
    }
}
