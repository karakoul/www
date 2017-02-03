/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package maps;

import database.Database;
import database.DatabaseCreator;
/**
 *
 * @author katerina
 */
public class CreateSpot {
    
    private static Database db;
    
    public CreateSpot() {        
        db = DatabaseCreator.getInstance();
    }
    
    public boolean addSpot(String Username, String lat, String lon, String address) {
        if(!db.newSpot(Username, lat, lon, address)){
            return false;
        } else {
        }
        return true;
    }
    public boolean addSpot(String lat, String lon, String address) {
        if(!db.newSpot(null, lat, lon, address)){
            return false;
        } else {
        }
        return true;
    }
    
    public boolean addSpotP(String Username, String lat, String lon, String address, boolean pay) {
        if(!db.newSpotP(Username, lat, lon, address,pay)){
            return false;
        } else {
        }
        return true;
    }
    
    public String getSpots(){
        
        return db.getDatSpots();
    }
    
    public boolean ifPayment(String lat, String lng){
        
        return db.ifPay(lat,lng);
    }
    
    public String UserPayment(String lat, String lng){
        return db.UsernamePay(lat, lng);
    }
    
    public boolean Payment(String Username, boolean check){
        
        return db.Payment(Username,check);
    }
    
    public boolean deleteSpot(String lat, String lng) {
        
        return db.spotDelete(lat, lng);
    }
}
