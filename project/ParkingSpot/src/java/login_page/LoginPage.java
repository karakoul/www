/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package login_page;


import database.Database;
import database.DatabaseCreator;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

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
    public void changePassword(String Username,String Password){
        
        db.forgotPassword(Username, Password);
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
        
        return db.userLogin(Username, Password);
 
    }
    
    public String getEmail(){
        return db.getUserEmail(Username);
    }
    
    public void sendEmail(String Email) throws AddressException, MessagingException{
        Properties mailServerProperties;
	Session getMailSession;
	MimeMessage generateMailMessage;
        //setup Mail Server Properties
        mailServerProperties = System.getProperties();
        mailServerProperties.put("mail.smtp.port", "587");
        mailServerProperties.put("mail.smtp.auth", "true");
        mailServerProperties.put("mail.smtp.starttls.enable", "true");
        System.out.println("Mail Server Properties have been setup successfully..");

        //get Mail Session
        getMailSession = Session.getDefaultInstance(mailServerProperties, null);
        generateMailMessage = new MimeMessage(getMailSession);
        generateMailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(Email));
        generateMailMessage.setSubject("Parking Spot password reminder");
        String emailBody = "<i> Hi " + getUserName() + "</i><br>";
        emailBody += "<b>If you want to reset your password press the link above</b><br>";
        emailBody += "<font color=blue > <a href=\"http://83.212.99.202:8080/ParkingSpot/PasswordReminder.jsp?Username=" + Username +"\">ParkingSpot email reset</a> </font>";
        generateMailMessage.setContent(emailBody, "text/html");

        //Get Session and Send mail
        Transport transport = getMailSession.getTransport("smtp");

        // Enter your correct gmail UserID and Password
        // if you have 2FA enabled then provide App Specific Password
        transport.connect("smtp.gmail.com", "kat.karakoula@gmail.com", "****");
        transport.sendMessage(generateMailMessage, generateMailMessage.getAllRecipients());
        transport.close();
    }
    
    public void sendFixedEmail(String Email, String emailBody, String Subject) throws AddressException, MessagingException{
        Properties mailServerProperties;
	Session getMailSession;
	MimeMessage generateMailMessage;
        //setup Mail Server Properties
        mailServerProperties = System.getProperties();
        mailServerProperties.put("mail.smtp.port", "587");
        mailServerProperties.put("mail.smtp.auth", "true");
        mailServerProperties.put("mail.smtp.starttls.enable", "true");
        System.out.println("Mail Server Properties have been setup successfully..");

        //get Mail Session
        getMailSession = Session.getDefaultInstance(mailServerProperties, null);
        generateMailMessage = new MimeMessage(getMailSession);
        System.out.println("EMAIL = "+ Email);
        generateMailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(Email));
        generateMailMessage.setSubject(Subject);
        generateMailMessage.setContent(emailBody, "text/html");

        //Get Session and Send mail
        Transport transport = getMailSession.getTransport("smtp");

        // Enter your correct gmail UserID and Password
        // if you have 2FA enabled then provide App Specific Password
        transport.connect("smtp.gmail.com", "kat.karakoula@gmail.com", "****");
        transport.sendMessage(generateMailMessage, generateMailMessage.getAllRecipients());
        transport.close();
    }
    

}

