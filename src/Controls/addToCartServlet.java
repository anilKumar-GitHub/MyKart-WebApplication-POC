package Controls;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
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

@WebServlet("/addToCartServlet")
public class addToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public addToCartServlet() {
        super();

    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession sess = request.getSession();

		//response.getWriter().print(request.getParameter("prodId"));
		
		if( sess.getAttribute("curWishList") == null )	{
			
			Set<String> hs = new HashSet<String>();
			
			hs.add(request.getParameter("prodId"));

			sess.setAttribute("curWishList", hs);
			
		}else	{

			Set<String> hs = (Set<String>)sess.getAttribute("curWishList");

			hs.add(request.getParameter("prodId"));

			Iterator<String> it = hs.iterator();

		//	while( it.hasNext() )
		//		response.getWriter().print("\n\n<br/>  "+it.next());
			
			sess.setAttribute("curWishList", hs);			
		}
		
		if( sess.getAttribute("myKartLoginUser") != null )	{
			
			((myKartDataBaseOperations)request.getServletContext().getAttribute("objectHandler")).setWishList(sess.getAttribute("curWishList").toString(), (String)sess.getAttribute("seessionEmailId"));
		}
		
		response.sendRedirect("showProduct.jsp?prodId="+request.getParameter("prodId"));
	}
}