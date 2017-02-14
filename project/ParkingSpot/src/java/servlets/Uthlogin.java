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
import login_page.UthLogin;
/**
 *
 * @author katerina
 */
public class Uthlogin extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher view;
        
        view = req.getRequestDispatcher("index.jsp");
        view.forward( req, resp );
    }

    @Override
    protected void doPost( HttpServletRequest req, HttpServletResponse resp ) throws ServletException, IOException
    {
        RequestDispatcher view;
        HttpSession session;
        
        
        String Username = req.getParameter("Username");
        String Password = req.getParameter("Password");

        UthLogin user = new UthLogin();

        if (user.setUser(Username, Password) != -1) {
            session = req.getSession();
            session.setAttribute("Username", user.getUsername());
            session.removeAttribute("error");
            view = req.getRequestDispatcher("MainPage.jsp");
            view.forward( req, resp );
        } else {
            session = req.getSession(false);
            session.setAttribute("error", "Your account or password is incorrect.");
            view = req.getRequestDispatcher( "login");
            view.forward( req, resp );

        }
        
    }
}
