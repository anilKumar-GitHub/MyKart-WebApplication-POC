package Controls;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dataModel.myKartDataBaseOperations;

@WebServlet("/myCartUserRegistration")
public class myCartUserRegistration extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public myCartUserRegistration() {
        super();

    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

			PrintWriter p = response.getWriter();
			ServletContext sc = request.getServletContext();
			
			if(	((myKartDataBaseOperations)sc.getAttribute("objectHandler")).addmyKartUser(request) )	{

				request.getSession().setAttribute("seessionProfilePic", request.getParameter("picName"));
				response.sendRedirect("welcomeToNewMyKartUser.jsp?email="+request.getParameter("email"));;
			}
			else	response.sendRedirect("registerMyKartNewUser.jsp?err=Account Can't be Created ! Already User Exists");
	}
}
