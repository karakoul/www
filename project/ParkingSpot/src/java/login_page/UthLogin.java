/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package login_page;

/**
 *
 * @author katerina
 */
import com.uthldap.Uthldap;
import database.Database;
import database.DatabaseCreator;

public class UthLogin
{
    private static Database db;
    String Username;
    String Password;

    
    public UthLogin() {
        db = DatabaseCreator.getInstance();
    }

    public int setUser(String Username, String Password )
    {
        Uthldap uthldap = new Uthldap( Username, Password );
        String currUsername = Username;
        if (! uthldap.auth() )
        {
            return -1;
        }
        if(!db.emailExists(Username+"@uth.gr")){
            while(db.userExists(currUsername)){
                currUsername += "1";
            }
            if(!db.Registration(currUsername, null, Username + "@uth.gr", null, null, null)){
                this.Username = currUsername;
                return -2;
            } 
        }
        else {
            this.Username = db.getUsername(Username+"@uth.gr");
        }
        
        return 0;
        
    }
    public String getUsername(){
        
        return Username;
    }
    
    
    
}

