package Controls;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dataModel.myKartDataBaseOperations;

/**
 * Servlet implementation class addToCartServletDemo
 */
@WebServlet("/addToCartServletDemo")
public class addToCartServletDemo extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public addToCartServletDemo() {
        super();

    }


	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		

		ServletContext sc = request.getServletContext();
			
		response.getWriter().print(request.getParameter("prodId"));
		
		
		myKartDataBaseOperations db = (myKartDataBaseOperations) sc.getAttribute("objectHandler");
		
		
		response.getWriter().print(db.message());
			
		try {
		
			ResultSet rs = db.execeteQuery("SELECT * FROM ProductMaster WHERE Pid = '"+request.getParameter("prodId")+"'");
		
			while( rs.next() )	{
			
				response.getWriter().print("<BR/><br/><br/>"+rs.getString("image"));
				
				response.getWriter().print("<img src='"+rs.getString("image")+"' />");
			}
		}catch (SQLException e) {
			// TODO: handle exception
			response.getWriter().print("Error : "+e.getLocalizedMessage());
		}
	}

}
