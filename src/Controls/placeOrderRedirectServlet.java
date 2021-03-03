package Controls;

import java.applet.AppletContext;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class placeOrderRedirectServlet
 */
@WebServlet("/placeOrderRedirectServlet")
public class placeOrderRedirectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public placeOrderRedirectServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		HttpSession sess = request.getSession();
		
		PrintWriter p = response.getWriter();
		
		
			
		if( sess.getAttribute("myKartLoginUser") == null )	{
			sess.setAttribute("orderListWithQuatity", request.getQueryString());
			sess.setAttribute("redirectToOrder", true);
			response.sendRedirect("cartUserLogin.jsp");
		}else	{
			request.getRequestDispatcher("placeOrder.jsp").forward(request, response);
			//p.print("take login");
		}


		
	}

}
