/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

/**
 *
 * @author katerina
 */

public class DatabaseCreator {
    
    private static DatabaseCreator instance = null;
    private static Database db;
    
    /**
     * Initialize the database
     * @return database
     */
    public static Database getInstance(){
        if(instance==null){
            instance = new DatabaseCreator();
            db = new Database();
            db.createTables();
        }
        return db;
    }
}