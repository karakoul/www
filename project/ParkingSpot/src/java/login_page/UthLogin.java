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

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class UthLogin extends HttpServlet
{

    /**
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doPost( HttpServletRequest req, HttpServletResponse resp ) throws ServletException, IOException
    {
        String uid = req.getParameter( "uname" );
        String passwd = req.getParameter( "psw" );

        Uthldap uthldap = new Uthldap( uid, passwd );

        if ( uthldap.auth() )
        {
            RequestDispatcher view = req.getRequestDispatcher( "index.jsp" );

            view.forward( req, resp );
        }
        else
        {
            RequestDispatcher view;
            view = req.getRequestDispatcher( "login.html" );

            view.forward( req, resp );
        }
    }
}

