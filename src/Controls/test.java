package Controls;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class test
 */
@WebServlet("/test")
public class test extends HttpServlet {
	private static final long serialVersionUID = 1L;
	int count = Integer.MAX_VALUE - 100;       
    public test() {
        super();

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().print("From Get  : "+count);
		count++;
	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.setContentType("text/pdf");
		response.getWriter().print("From Serviece  : "+count);
		count++;
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().print("From Post  : "+count);
		count++;
	}

}
