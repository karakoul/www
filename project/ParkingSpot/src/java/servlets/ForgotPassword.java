/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import login_page.LoginPage;

/**
 *
 * @author katerina
 */
public class ForgotPassword extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher view;
        
        view = req.getRequestDispatcher("ForgotPassword.jsp");
        view.forward( req, resp );
    }

    @Override
    protected void doPost( HttpServletRequest req, HttpServletResponse resp ) throws ServletException, IOException
    {
        RequestDispatcher view;
        String Username = req.getParameter("Username");
    
        LoginPage user = new LoginPage(); 

        user.setUserName(Username);

        user.getEmail();
        try {
            user.sendEmail(user.getEmail());
        } catch (MessagingException ex) {
            Logger.getLogger(ForgotPassword.class.getName()).log(Level.SEVERE, null, ex);
        }
        view = req.getRequestDispatcher("ForgotPassword.jsp");
        view.forward( req, resp );    
    }

}
