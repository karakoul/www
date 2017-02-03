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
    static final String DB_URL = "jdbc:mysql://83.212.99.202:3306/ParkingSpot";
    static final String USERNAME = "***";
    static final String PASSWORD = "***";
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
                conn = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD);
                stmt = conn.createStatement();
            } catch (ClassNotFoundException ex) {
                ex.printStackTrace();
                return;
            }

        } catch (SQLException se) {
            System.out.println("Connection failed.");
            return;
        }
        if (conn != null) {
            System.out.println("Connected with db.");
        } else {
            System.out.println("Failed to make connection with db.(conn==NULL)");
        }
    }

    public void createTables() {
        try {
            String sql = "CREATE TABLE user " + "(Username VARCHAR(255) not NULL, Password VARCHAR(255), Email VARCHAR(255) not NULL UNIQUE, Name VARCHAR(255), Lastname VARCHAR(255), Phone VARCHAR(255),coins VARCHAR(255),PRIMARY KEY(Username)) ENGINE=InnoDB";
            stmt.executeUpdate(sql);
            System.out.println("Creation of user table complete!\n");
        } catch (SQLException se) {
            System.out.println("Table user already exists.\n");
        }

        try {
            String sql = "CREATE TABLE car " + "(Username VARCHAR(255) not NULL, CarModel VARCHAR(255) not NULL, CarSize VARCHAR(255) not NULL, CarColour VARCHAR(255), CarLicencePlate VARCHAR(255),FOREIGN KEY(Username) REFERENCES user(Username) ON DELETE CASCADE) ENGINE=InnoDB";
            stmt.executeUpdate(sql);
            System.out.println("Creation of car table complete!");
        } catch (SQLException se) {
            System.out.println("Table car already exists. " + se);
        }

        try {
            String sql = "CREATE TABLE spot " + "(Username VARCHAR(255), lat VARCHAR(255) not NULL, lon VARCHAR(255) not NULL, address VARCHAR(255) not NULL, payment VARCHAR(255) not NULL, timestamp VARCHAR(255) not NULL) ENGINE=InnoDB";
            stmt.executeUpdate(sql);
            System.out.println("Creation of spot table complete!");
        } catch (SQLException se) {
            System.out.println("Table spot already exists. " + se);
        }
    }

    /**
     * Inserts the sign up data
     *
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
            pstmt = conn.prepareStatement("INSERT INTO user values(?,?,?,?,?,?,?)");
            pstmt.setString(1, Username);
            pstmt.setString(2, Password);
            pstmt.setString(3, Email);
            pstmt.setString(4, Name);
            pstmt.setString(5, Lastname);
            pstmt.setString(6, Phone);
            pstmt.setString(7, "20");
            pstmt.executeUpdate();
            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    /**
     * Authorization for users data
     *
     * @param Username Username
     * @param Password Password
     * @return false if the authorization fail else true
     */
    public boolean userLogin(String Username, String Password) {
        // Returns true if username & password are correct , otherwise it returns false
        try {
            rs = stmt.executeQuery("SELECT * FROM user WHERE Username='" + Username + "'" + " AND Password='" + Password + "'");

            return rs.isBeforeFirst();

        } catch (SQLException ex) {
            return false;
        }
    }

    public boolean forgotPassword(String Username, String Password) {

        try {
            pstmt = conn.prepareStatement("UPDATE user SET Password = '" + Password + "' WHERE Username = '" + Username + "'");
            pstmt.executeUpdate();
            System.out.println("Edited " + Username + " information.");
            return true;
        } catch (SQLException se) {
            return false;
        }
    }

    /**
     * Deletes the data of the user
     *
     * @param Username Username
     * @return false if something go wrong
     */
    public boolean userDelete(String Username) {
        // Deletes the registration in users table and also it's dependencies in history table
        try {
            pstmt = conn.prepareStatement("DELETE FROM user WHERE Username = ?");
            pstmt.setString(1, Username);
            pstmt.executeUpdate();
            pstmt = conn.prepareStatement("DELETE FROM car WHERE Username = ?");
            pstmt.setString(1, Username);
            pstmt.executeUpdate();
            System.out.println(Username + " deleted from tables user and car.");
            return true;
        } catch (SQLException se) {
            return false;
        }
    }

    public boolean userExists(String Username) {

        try {
            pstmt = conn.prepareStatement("SELECT `Username` FROM `user` WHERE Username = ?");
            pstmt.setString(1, Username);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException se) {
            return true;
        }
        return false;
    }
     public boolean emailExists(String email) {

        try {
            pstmt = conn.prepareStatement("SELECT `Email` FROM `user` WHERE Email = ?");
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException se) {
            return true;
        }
        return false;
    }
    
    

    public String getUserEmail(String Username) {

        try {
            pstmt = conn.prepareStatement("SELECT Email FROM user WHERE Username = ?");
            pstmt.setString(1, Username);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                return rs.getString("Email");
            }
        } catch (SQLException se) {
            se.printStackTrace();
            return "";
        }
        return "";
    }
    
    public String getUsername(String email) {

        try {
            pstmt = conn.prepareStatement("SELECT Username FROM user WHERE Email = ?");
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                return rs.getString("Username");
            }
        } catch (SQLException se) {
            se.printStackTrace();
            return "";
        }
        return "";
    }

    public boolean newSpot(String Username, String lat, String lon, String address) {
        // Returns true if SignUp was successful otherwise returns false
        try {
            pstmt = conn.prepareStatement("INSERT INTO spot values(?,?,?,?,?,?)");
            if (Username != null) {
                pstmt.setString(1, Username);
                pstmt.setString(2, lat);
                pstmt.setString(3, lon);
                pstmt.setString(4, address);
                pstmt.setString(5, "3");
                long cur_time;
                cur_time = System.currentTimeMillis();
                String timestamp = Long.toString(cur_time);
                pstmt.setString(6, timestamp);
                pstmt.executeUpdate();

            } else {
                pstmt.setString(1, "NULL");
                pstmt.setString(2, lat);
                pstmt.setString(3, lon);
                pstmt.setString(4, address);
                pstmt.setString(5, "0");
                long cur_time;
                cur_time = System.currentTimeMillis();
                String timestamp = Long.toString(cur_time);
                pstmt.setString(6, timestamp);
                pstmt.executeUpdate();
            }

            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public boolean newSpotP(String Username, String lat, String lon, String address, Boolean check) {
        // Returns true if SignUp was successful otherwise returns false
        try {
            pstmt = conn.prepareStatement("INSERT INTO spot values(?,?,?,?,?,?)");
            if (Username != null) {
                pstmt.setString(1, Username);
                pstmt.setString(2, lat);
                pstmt.setString(3, lon);
                pstmt.setString(4, address);
                if (check) {
                    pstmt.setString(5, "3");
                } else {
                    pstmt.setString(5, "0");
                }
                long cur_time;
                cur_time = System.currentTimeMillis();
                String timestamp = Long.toString(cur_time);
                pstmt.setString(6, timestamp);
                pstmt.executeUpdate();

            } else {
                pstmt.setString(1, "NULL");
                pstmt.setString(2, lat);
                pstmt.setString(3, lon);
                pstmt.setString(4, address);
                pstmt.setString(5, "0");
                long cur_time;
                cur_time = System.currentTimeMillis();
                String timestamp = Long.toString(cur_time);
                pstmt.setString(6, timestamp);
                pstmt.executeUpdate();
            }

            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public boolean newCar(String Username, String CarModel, String CarSize, String CarColour, String CarLicencePlate) {
        // Returns true if SignUp was successful otherwise returns false
        try {
            pstmt = conn.prepareStatement("INSERT INTO car values(?,?,?,?,?)");
            pstmt.setString(1, Username);
            pstmt.setString(2, CarModel);
            pstmt.setString(3, CarSize);
            pstmt.setString(4, CarColour);
            pstmt.setString(5, CarLicencePlate);
            pstmt.executeUpdate();
            return true;
        } catch (SQLException ex) {
            return false;
        }
    }

    public boolean carDelete(String Username, String CarModel) {
        // Deletes the registration in users table and also it's dependencies in history table
        try {
            pstmt = conn.prepareStatement("DELETE FROM car WHERE Username = ? AND CarModel = ?");
            pstmt.setString(1, Username);
            pstmt.setString(2, CarModel);
            pstmt.executeUpdate();
            System.out.println(CarModel + " deleted.");
            return true;
        } catch (SQLException se) {
            return false;
        }
    }

    public boolean editCar(String Username, String CarModel, String CarSize, String CarColour, String CarLicencePlate) {

        try {
            pstmt = conn.prepareStatement("UPDATE car SET CarModel = ?, CarSize = ?, CarColour = ?, CarLicencePlate = ? WHERE Username = ?");
            pstmt.setString(1, CarModel);
            pstmt.setString(2, CarSize);
            pstmt.setString(3, CarColour);
            pstmt.setString(4, CarLicencePlate);
            pstmt.setString(5, Username);
            pstmt.executeUpdate();
            System.out.println("Edited " + CarModel + " information.");
            return true;
        } catch (SQLException se) {
            return false;
        }
    }

    public String getDatSpots() {
        String spots = "";
        try {
            pstmt = conn.prepareStatement("SELECT * FROM spot");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                long start_time = Long.parseLong(rs.getString(6));
                long cur_time = System.currentTimeMillis();

                if ((cur_time - start_time) > 420000) {
                    try {
                        String lat = rs.getString(1);
                        String lon = rs.getString(2);
                        pstmt = conn.prepareStatement("DELETE FROM spot WHERE lat = ? AND lon = ?");
                        pstmt.setString(1, lat);
                        pstmt.setString(2, lon);
                        pstmt.executeUpdate();
                    } catch (SQLException se) {
                        se.printStackTrace();
                    }
                    continue;
                }
                spots += rs.getString(2);
                spots += "/";
                spots += rs.getString(3);
                spots += "/";
                spots += rs.getString(4);
                spots += "/";
            }
        } catch (SQLException se) {
            se.printStackTrace();
            return "";
        }
        return spots;

    }

    public boolean ifPay(String lat, String lng) {
        try {
            pstmt = conn.prepareStatement("SELECT * FROM spot");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String lat1 = rs.getString(2);
                String lon1 = rs.getString(3);if (lat.equals(lat1) && lng.equals(lon1)) {
                    if (rs.getString(5).equals("0")) {
                        return false;
                    }
                    return true;
                }
            }
        } catch (SQLException se) {
            se.printStackTrace();
            return false;
        }
        return false;
    }

    public String UsernamePay(String lat, String lng) {
        try {
            pstmt = conn.prepareStatement("SELECT * FROM spot");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String lat1 = rs.getString(2);
                String lon1 = rs.getString(3);
                if (lat.equals(lat1) && lng.equals(lon1)) {
                    if (rs.getString(5).equals("0")) {
                        return "";
                    }
                    return rs.getString(1);
                }
            }
        } catch (SQLException se) {
            se.printStackTrace();
            return "";
        }
        return "";
    }

    public boolean Payment(String Username, boolean pay) {
        try {
            pstmt = conn.prepareStatement("SELECT coins FROM user WHERE Username = ?");
            pstmt.setString(1, Username);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int paym = Integer.parseInt(rs.getString("coins"));
                if (pay) {
                    paym = paym + 3;
                } else {
                    if(paym>3){
                        paym = paym - 3;
                    }
                    else {
                        return false;
                    }
                }
                pstmt = conn.prepareStatement("UPDATE user SET coins = '" + Integer.toString(paym) + "' WHERE Username = '" + Username + "'");
                pstmt.executeUpdate();
            }
        } catch (SQLException se) {
            se.printStackTrace();
            return false;
        }

        return true;
    }
    
    public boolean spotDelete(String lat, String lng) {
        // Deletes the registration in users table and also it's dependencies in history table
        try {
            pstmt = conn.prepareStatement("DELETE FROM spot WHERE lat = ? AND lon = ?");
            pstmt.setString(1, lat);
            pstmt.setString(2, lng);
            pstmt.executeUpdate();
            return true;
        } catch (SQLException se) {
            return false;
        }
    }

}
