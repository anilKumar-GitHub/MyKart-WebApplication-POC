package Controls;

import java.io.IOException;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dataModel.myKartDataBaseOperations;


@WebServlet("/removeFromCartServlet")
public class removeFromCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public removeFromCartServlet() {
        super();

    }


	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		HttpSession sess = request.getSession();		

		if( sess.getAttribute("curWishList") == null )		return;
	
		else	{
			
			Set<String> hs = (Set<String>)sess.getAttribute("curWishList");
			
			hs.remove(request.getParameter("prodId"));
		
			//Iterator<String> it = hs.iterator();
			
			//while( it.hasNext() )
			//response.getWriter().print("\n\n<br/>  "+it.next());
			
			sess.setAttribute("curWishList", hs);			
		}
		
		if( sess.getAttribute("myKartLoginUser") != null )	{
			
			((myKartDataBaseOperations)request.getServletContext().getAttribute("objectHandler")).setWishList(sess.getAttribute("curWishList").toString(), (String)sess.getAttribute("seessionEmailId"));
		}


		if( request.getParameter("en") != null && request.getParameter("en").equals("1") )	{
			
			response.sendRedirect("showProduct.jsp?prodId="+request.getParameter("prodId"));
		}

		if( request.getParameter("en") != null && request.getParameter("en").equals("2") )	{
			
			response.sendRedirect("myCart.jsp");
		}
	}
}
