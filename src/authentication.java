

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dataModel.*;

@WebServlet("/authentication")
public class authentication extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public authentication() {
        super();

    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		ServletContext sc = request.getServletContext();		
		
		if( sc.getAttribute("myKartDataBaseHandler") != null )	{
					
			myKartDataBaseOperations $DBHandler = (myKartDataBaseOperations) sc.getAttribute("myKartDataBaseHandler");

		if( $DBHandler.authenticateUser(request.getParameter("uname"), request.getParameter("pass")) )	{
			
			if( request.getParameter("cookieSelection") != null ) {
				
				System.out.println(" Cookies Saved");
				Cookie $ck = new Cookie("currentMyKartCookieUser", request.getParameter("uname"));
				
				$ck.setMaxAge(60*2);
				
				response.addCookie($ck);
			}else
			System.out.println(" Cookies are not  Saved");
			
			HttpSession $sess = request.getSession();
			
			$sess.setAttribute("currentMyKartSessionUser", request.getParameter("uname"));
			
			System.out.println("log ined ");
			RequestDispatcher $reqDisp = request.getRequestDispatcher("myKartHomePage.jsp");
			$reqDisp.forward(request, response);
			return;
		}
		
		}
			System.out.println("Proble in Servlet Context Connection Handler by pass ");
			RequestDispatcher $disp = request.getRequestDispatcher("LogIn.html");
			$disp.forward(request, response);	
	}

}
