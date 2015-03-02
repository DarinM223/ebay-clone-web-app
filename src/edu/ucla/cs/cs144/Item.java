package edu.ucla.cs.cs144;

public class Item {
    public String i_itemID;
    public String i_name;
    public String i_currently;
    public String i_buy_price;
    public String i_first_bid;
    public String i_number_of_bids;
    public String i_location;
    public String i_latitude;
    public String i_longitude;
    public String i_country;
    public String i_started;
    public String i_ends;
    public String i_seller;
    public String i_description;

    public Item(String itemID, String name, String currently, String buy_price,
                        String first_bid, String number_of_bids, String location, String latitude,
                        String longitude, String country, String started, String ends,
                        String seller, String description) {
        i_itemID = itemID;
        i_name = name;
        i_currently = currently;
        i_buy_price = buy_price;
        i_first_bid = first_bid;
        i_number_of_bids = number_of_bids;
        i_location = location;
        i_latitude = latitude;
        i_longitude = longitude;
        i_country = country;
        i_started = started;
        i_ends = ends;
        i_seller = seller;
        i_description = description;
    }
}