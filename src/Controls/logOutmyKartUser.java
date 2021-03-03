package Controls;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/logOutmyKartUser")
public class logOutmyKartUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public logOutmyKartUser() {
        super();

    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		response.getWriter().print("Hello");
		
		HttpSession sess = request.getSession();
		
		sess.removeAttribute("myKartLoginUser");
		
		sess.removeAttribute("seessionProfilePic");

		sess.removeAttribute("curWishList");

		sess.removeAttribute("seessionEmailId");

		System.out.println("Session Destroyed Using individual remove");
		response.sendRedirect("indexOfmyKart.jsp?en=2&catType=1");
	}
}
