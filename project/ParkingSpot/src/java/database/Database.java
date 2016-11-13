/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


/**
 *
 * @author katerina
 */
public final class Database {
    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/ParkingSpot";
    static final String USERNAME = "root";
    static final String PASSWORD = "root";
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    private Statement stmt;
    
    /**
     * Initialize a newly created Database object
     */
    public Database() {
	dbConnection();
    }
    /**
     * Establishes the connection with SQL server
     */
    public void dbConnection() {
		
        try {
            
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(DB_URL,USERNAME,PASSWORD);
                stmt = conn.createStatement();
            } catch (ClassNotFoundException ex) {
		return;
            }
                

            
        } catch(SQLException se) {
            System.out.println("Connection failed.");
            return;
        }
        if (conn!= null) {
            System.out.println("Connected with db.");
        } else {
            System.out.println("Failed to make connection with db.(conn==NULL)");
        }
    }
    
    public void createTables() {
	String sql;	
        try {
            sql = "CREATE TABLE user " + "(Username VARCHAR(255) not NULL, Password VARCHAR(255) not NULL, Email VARCHAR(255) not NULL UNIQUE, Name VARCHAR(255), Lastname VARCHAR(255), Phone VARCHAR(255), PRIMARY KEY(Username)) ENGINE=InnoDB";
            stmt.executeUpdate(sql);
            System.out.println("Creation of user table complete!");
        } catch(SQLException se) {
            System.out.println("Table user already exists.");
        }

        try {
            sql = "CREATE TABLE car " + "(Username VARCHAR(255) not NULL, CarModel VARCHAR(255) not NULL, CarSize VARCHAR(255) not NULL, CarColour VARCHAR(255), CarLicencePlate VARCHAR(255),FOREIGN KEY(Username) REFERENCES users(Username) ON DELETE CASCADE) ENGINE=InnoDB";
            stmt.executeUpdate(sql);
            System.out.println("Creation of car table complete!");
        } catch(SQLException se) {
            System.out.println("Table car already exists.");
        }
    }
    
    /**
     * Inserts the sign up data 
     * @param Username Username
     * @param Password Password
     * @param Email Email
     * @param Name Name
     * @param Lastname Lastname
     * @param Phone Phone
     * @return false if the user already exists else true
     */
    public boolean Registration(String Username, String Password, String Email, String Name, String Lastname, String Phone) {
        // Returns true if SignUp was successful otherwise returns false
        try {
            pstmt = conn.prepareStatement("INSERT INTO user values(?,?,?,?,?,?)");
            pstmt.setString(1,Username);
            pstmt.setString(2,Password);
            pstmt.setString(3,Email);
            pstmt.setString(4,Name);
            pstmt.setString(5,Lastname);
            pstmt.setString(6,Phone);
            pstmt.executeUpdate();
            return true;
        } catch(SQLException ex){
            return false;
        }
    }
    
    
    /**
     * Authorization for users data
     * @param Username Username
     * @param Password Password
     * @return false if the authorization fail else true
     */
    public boolean userLogin(String Username, String Password) {
		// Returns true if username & password are correct , otherwise it returns false
        try {
            rs = stmt.executeQuery("SELECT * FROM user WHERE Username='" + Username + "'" + " AND Password='" + Password + "'");
            
            return rs.isBeforeFirst();
            
        } catch(SQLException ex) {
            return false;
        }
    }
    
    public boolean forgotPassword(String Username, String Password, String Name, String Lastname, String Address, String Phone, String EmergencyCall) {
		
        try {
            pstmt = conn.prepareStatement("UPDATE user SET Password = ?, Name = ?, Lastname = ?, Address = ?, Phone = ? WHERE Username = ?");
            pstmt.setString(1,Password);
            pstmt.setString(2,Name);
            pstmt.setString(3,Lastname);
            pstmt.setString(4,Address);
            pstmt.setString(5,Phone);
            pstmt.setString(7,Username);
            pstmt.executeUpdate();
            System.out.println("Edited " + Username + " information.");
            return true;
        } catch(SQLException se) {
            return false;
        }
    }
    
    /**
     * Deletes the data of the user
     * @param Username Username
     * @return false if something go wrong
     */
    public boolean userDelete(String Username) {
        // Deletes the registration in users table and also it's dependencies in history table
        try {
            pstmt = conn.prepareStatement("DELETE FROM user WHERE Username = ?");
            pstmt.setString(1,Username);
            pstmt.executeUpdate();
            pstmt = conn.prepareStatement("DELETE FROM car WHERE Username = ?");
            pstmt.setString(1,Username);
            pstmt.executeUpdate();
            System.out.println(Username + " deleted from tables user and car.");
            return true;
        } catch(SQLException se) {
            return false;
        }
    }
    
    public boolean userExists(String Username){

        try{
            pstmt = conn.prepareStatement("SELECT `Username` FROM `user` WHERE Username = ?");
            pstmt.setString(1,Username);
            ResultSet rs = pstmt.executeQuery();
            if(rs.next()){
                return true;
            }
        }catch(SQLException se) {
            return true;
        }
        return false;
    }
    
    public String getUserEmail(String Username) {
		
        try {
            pstmt = conn.prepareStatement("SELECT Email FROM user WHERE Username = ?");
            pstmt.setString(1,Username);
            rs = pstmt.executeQuery();
            while(rs.next()) {
                return rs.getString("Email");
            }
        } catch(SQLException se) {
            se.printStackTrace();
            return "";
        }
        return "";
    }
    
    public boolean newCar(String Username, String CarModel, String CarSize, String CarColour, String CarLicencePlate) {
        // Returns true if SignUp was successful otherwise returns false
        try {
            pstmt = conn.prepareStatement("INSERT INTO car values(?,?,?,?,?)");
            pstmt.setString(1,Username);
            pstmt.setString(2,CarModel);
            pstmt.setString(3,CarSize);
            pstmt.setString(4,CarColour);
            pstmt.setString(5,CarLicencePlate);
            pstmt.executeUpdate();
            return true;
        } catch(SQLException ex){
            return false;
        }
    }
    
    public boolean carDelete(String Username, String CarModel) {
        // Deletes the registration in users table and also it's dependencies in history table
        try {
            pstmt = conn.prepareStatement("DELETE FROM car WHERE Username = ? AND CarModel = ?");
            pstmt.setString(1,Username);
            pstmt.setString(2,CarModel);
            pstmt.executeUpdate();
            System.out.println(CarModel + " deleted.");
            return true;
        } catch(SQLException se) {
            return false;
        }
    }
    
    public boolean editCar(String Username, String CarModel, String CarSize, String CarColour, String CarLicencePlate) {
		
        try {
            pstmt = conn.prepareStatement("UPDATE car SET CarModel = ?, CarSize = ?, CarColour = ?, CarLicencePlate = ? WHERE Username = ?"); 
            pstmt.setString(1,CarModel);
            pstmt.setString(2,CarSize);
            pstmt.setString(3,CarColour);
            pstmt.setString(4,CarLicencePlate);
            pstmt.setString(5,Username);
            pstmt.executeUpdate();
            System.out.println("Edited " + CarModel + " information.");
            return true;
        } catch(SQLException se) {
            return false;
        }
    }
	
   
    
}
