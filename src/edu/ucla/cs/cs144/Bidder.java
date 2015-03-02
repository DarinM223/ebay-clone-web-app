package edu.ucla.cs.cs144;

public class Bidder {
    
    public String b_userID;
    public String b_rating;
    public String b_location;
    public String b_country;

    public Bidder(String userID, String rating, String location, String country) {
        b_userID = userID;
        b_rating = rating;
        b_location = location;
        b_country = country;
    }
}