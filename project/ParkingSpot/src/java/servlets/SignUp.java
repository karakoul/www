/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import login_page.Register;

/**
/**
 *
 * @author katerina
 */
public class SignUp extends HttpServlet {

   @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher view;
        
        view = req.getRequestDispatcher("Reg.jsp");
        view.forward( req, resp );
    }

    @Override
    protected void doPost( HttpServletRequest req, HttpServletResponse resp ) throws ServletException, IOException
    {
        RequestDispatcher view;
        HttpSession session;
        
        
        String Username = req.getParameter("Username");
        String Password = req.getParameter("Password");
        String PasswordCheck = req.getParameter("PasswordCheck");
        String email = req.getParameter("email");
        String Name = req.getParameter("Name");
        String Lastname = req.getParameter("Lastname");
        String Phone = req.getParameter("Phone");

        Register user = new Register(); 
        if(user.checkUsername(Username)){
            session = req.getSession(false);
            session.setAttribute("error", "This username already exists, please try again.");
            view = req.getRequestDispatcher("Reg.jsp");
            view.forward( req, resp );
        }
        else if(!user.isEmail(email)){
            session = req.getSession(false);
            session.setAttribute("error", "This is not a valid email, please try again.");
            view = req.getRequestDispatcher("Reg.jsp");
            view.forward( req, resp );
        }
        else if(!Password.equals(PasswordCheck)){
            session = req.getSession(false);
            session.setAttribute("error", "Wrong Password");
            view = req.getRequestDispatcher("Reg.jsp");
            view.forward( req, resp );
        }
        else if(!user.checkPassword(Password)){
            session = req.getSession(false);
            session.setAttribute("error", "Password must contain minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character.");
            view = req.getRequestDispatcher("Reg.jsp");
            view.forward( req, resp );
        }
        else{
            user.setUsername(Username);
            user.setPassword(Password);
            user.setEmail(email);
            user.setLastname(Lastname);
            user.setName(Name);
            user.setPhone(Phone);
            if(user.Registration()){
                session = req.getSession();
                session.setAttribute("Username", Username);
                view = req.getRequestDispatcher("MainPage.jsp");
                view.forward( req, resp );
            } 
            else{
                session = req.getSession();
                session.setAttribute("error", "An error occured. Please try again.");
                view = req.getRequestDispatcher("Reg.jsp");
                view.forward( req, resp );
            }
        }
    }
}
