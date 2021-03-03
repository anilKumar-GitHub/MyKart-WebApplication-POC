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

/**
 * Servlet implementation class connectApplication
 */
@WebServlet("/connectApplication")
public class connectApplication extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public connectApplication() {
        super();

    }

	public void init(ServletConfig config) throws ServletException {
		
        System.out.println("Server Started :: Instance is Created ");
        
        myKartDataBaseOperations mk = new myKartDataBaseOperations();
		
        System.out.println(" Just Object is Created.............! ");
		
		config.getServletContext().setAttribute("objectHandler", mk);
	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.sendRedirect("indexOfmyKart.jsp");
	}

	public void destroy() {
        System.out.println("Server Stopped :: Instance is Destroyed ");
	}

}
