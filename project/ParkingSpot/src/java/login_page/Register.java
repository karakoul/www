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
public class Register {
    private static Database db;
    String Username;
    String Password;
    String email;
    String Name;
    String Lastname;
    String Phone;

    public Register() {
        db = DatabaseCreator.getInstance();
    }

    public void setUsername(String Username) {
        this.Username = Username;
    }

    public void setPassword(String Password) {
        this.Password = Password;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

    public void setLastname(String Lastname) {
        this.Lastname = Lastname;
    }

    public void setPhone(String Phone) {
        this.Phone = Phone;
    }

    public String getUsername() {
        return Username;
    }

    public String getPassword() {
        return Password;
    }

    public String getEmail() {
        return email;
    }

    public String getName() {
        return Name;
    }

    public String getLastname() {
        return Lastname;
    }

    public String getPhone() {
        return Phone;
    }
    
    public boolean Registration() {
        if(!db.Registration(Username, Password, email, Name, Lastname, Phone)){
            JOptionPane.showMessageDialog(null,"Username already in use!");
            return false;
        }
        return true;
    }
    
    public void checkPassword(){
        JOptionPane.showMessageDialog(null,"Wrong Password!");
    }
    

}
