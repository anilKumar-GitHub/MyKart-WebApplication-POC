package Controls;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dataModel.myKartDataBaseOperations;


@WebServlet("/myCartUserAuthentication")
public class myCartUserAuthentication extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public myCartUserAuthentication() {
        super();

    }


	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		PrintWriter p = response.getWriter();
		
		p.print(request.getParameter("email")+"======"+request.getParameter("pass"));
		
		ServletContext sc = request.getServletContext();

		myKartDataBaseOperations db = (myKartDataBaseOperations) sc.getAttribute("objectHandler");
		
		HttpSession sess = request.getSession();
		
		p.print(db.message());
		
		if( db.authenticateMyKartLoginUser(request.getParameter("email"), request.getParameter("pass")))	{
			
			
			if( sess.getAttribute("curWishList") != null )	{
			
				if( ((Set)sess.getAttribute("curWishList")).size() > 0 )	{
					sess.setAttribute("curWishList", db.loadSessionWithOldWishList((Set)sess.getAttribute("curWishList"),request.getParameter("email")));
				}
				((myKartDataBaseOperations)request.getServletContext().getAttribute("objectHandler")).setWishList(sess.getAttribute("curWishList").toString(), request.getParameter("email"));
			}else
			
				sess.setAttribute("curWishList", db.loadSessionWithOldWishList(new HashSet<String>(),request.getParameter("email")));
			
			sess.setAttribute("myKartLoginUser",db.getmyKartLogInUserName(request.getParameter("email")));
			sess.setAttribute("seessionProfilePic", db.getmyKartLogInUserImage(request.getParameter("email")));
			sess.setAttribute("seessionEmailId", request.getParameter("email"));

			if(sess.getAttribute("redirectToOrder") != null )	{
				
				sess.removeAttribute("redirectToOrder");
				//p.print(db.getmyKartLogInUserName(request.getParameter("email")));
				response.sendRedirect("placeOrder.jsp?"+(String)sess.getAttribute("orderListWithQuatity"));
				return;
			}
			
			sess.removeAttribute("redirectToOrder");			
			response.sendRedirect("indexOfmyKart.jsp?en=2&catType=1");	
			return;
			

		}
			
			
			response.sendRedirect("cartUserLogin.jsp?err=Enter Corrrect Email Id or Password");
		

	}

}
