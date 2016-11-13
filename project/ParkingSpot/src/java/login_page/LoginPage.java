/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package login_page;


import database.Database;
import database.DatabaseCreator;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
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
    
    public void sendEmail(String Yo){
        try{

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail..com"); // for gmail use smtp.gmail.com
        props.put("mail.smtp.auth", "true");
        props.put("mail.debug", "true"); 
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.port", "465");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.socketFactory.fallback", "false");

        Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {

            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("kat.karakoula@gmail.com", "****");
            }
        });

        mailSession.setDebug(true); // Enable the debug mode

        Message msg = new MimeMessage( mailSession );

        //--[ Set the FROM, TO, DATE and SUBJECT fields
        msg.setFrom( new InternetAddress( "kat.karakoula@gmail.com" ) );
        msg.setRecipients( Message.RecipientType.TO,InternetAddress.parse("katcool5@hotmail.com") );
        msg.setSentDate( new Date());
        msg.setSubject( "Hello World!" );

        //--[ Create the body of the mail
        msg.setText( "Hello from my first e-mail sent with JavaMail" );

        //--[ Ask the Transport class to send our mail message
        Transport.send( msg );

    }catch(Exception E){
        System.out.println( "Oops something has gone pearshaped!");
        System.out.println( E );
    }
    }
    

}

