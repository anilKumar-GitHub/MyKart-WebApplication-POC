package Controls;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dataModel.myKartDataBaseOperations;

@WebServlet("/initObject")
public class initObject extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static boolean isSet = false;
	
    public initObject() {
        super();
        System.out.println("Server Started :: Instance is Created ");
    }

	public void init(ServletConfig config) throws ServletException {


	}

	public void destroy() {
        System.out.println("Server Stopped :: Instance is Destroyed ");
	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		myKartDataBaseOperations mk = new myKartDataBaseOperations();
		
		response.getWriter().print("Hello in servlet");
		
		request.getServletContext().setAttribute("objectHandler", mk);
		
		request.getRequestDispatcher("indexOfmyKart.jsp").forward(request, response);
	}

}
