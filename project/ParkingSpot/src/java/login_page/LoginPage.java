/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package login_page;


import database.Database;
import database.DatabaseCreator;
import javax.swing.JOptionPane;

/**
 *
 * @author katerina
 */
public class LoginPage{
    private static Database db;
    String Username;
    String Password;

    public LoginPage() {
        db = DatabaseCreator.getInstance();
    }

    public void setUserName(String Username )
    {
        this.Username = Username;
        
    }
    public void setPassword(String Password )
    {
        this.Password = Password;
        
    }
    
    public String getUserName()
    {
        return Username;
        
    }
    
    public String getPassword()
    {
        return Password;
        
    }
    
    public boolean checkUser(){
        if(!db.userLogin(Username, Password)){
            JOptionPane.showMessageDialog(null,"Wrong Password or Username!");
            return false;
        }
        return true;
 
    }

}

