package edu.ucla.cs.cs144;

import java.text.*;
import java.util.*;

public class Bid implements Comparable<Bid>{
    public String bd_itemID;
    public String bd_userID;
    public String bd_time;
    public String bd_amount;

    public Bid(String itemID, String userID, String time, String amount) {
        bd_itemID = itemID;
        bd_userID = userID;
        bd_time = time;
        bd_amount = amount;
    }

    //override compareTo
    public int compareTo(Bid bid) {
        try {
            //convert to Date and compare
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

            return format.parse(this.bd_time).compareTo(format.parse(bid.bd_time));

        }
        catch(ParseException e) {
            System.out.println("Parse error!");
        }

        return this.bd_time.compareTo(bid.bd_time);
    }
}