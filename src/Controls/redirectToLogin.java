package Controls;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dataModel.myKartDataBaseOperations;

@WebServlet("/redirectToLogin")
public class redirectToLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public redirectToLogin() {
        super();

    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

/*		PrintWriter p = response.getWriter();
		
		p.print(request.getParameter("email"));
*/		
		String em = request.getParameter("email");
		
		ServletContext sc = request.getServletContext();
		
		myKartDataBaseOperations db = (myKartDataBaseOperations) sc.getAttribute("objectHandler");
		
/*		p.print("\n\n"+db.getString("Name",	em));

		p.print("\n\n"+db.getString("PhoneNum",em));
		
		p.print("\n\n"+db.getString("image",em));

		p.print("\n\n"+db.getString("Password",em));
*/		
		response.sendRedirect("myCartUserAuthentication?email="+request.getParameter("email")+"&pass="+db.getString("Password",em));

	}
}
