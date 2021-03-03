

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dataModel.*;

@WebServlet("/index")
public class index extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private static boolean isSet = false;
	private static int cnt = 1;
    public index() {
        super();
    }


	public void init(ServletConfig config) throws ServletException {

		isSet = false;
        System.out.println("Init Called "+ cnt);
        cnt++;
	}


	public void destroy() {
		System.out.println("Destroyed Called");
	}

	public ServletConfig getServletConfig() {

		return null;
	}

	public String getServletInfo() {

		return null; 
	}


	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				
		if( ! isSet ) {
			
			ServletContext $context = request.getServletContext();
			System.out.println("Iam in isSet");
			myKartDataBaseOperations $temp = new myKartDataBaseOperations();
			$temp.setConnection();
			$context.setAttribute("myKartDataBaseHandler", $temp);
    		request.getSession().setAttribute("sessionDB", $temp);

			isSet = true;
	        System.out.println("Connection Established using ourKart "+ cnt);
	        cnt++;
		}
        System.out.println("Reached "+ cnt);
        cnt++;			
    
        
        String $user = (String) request.getSession().getAttribute("currentMyKartSessionUser");
        
        if( $user != null )	{
        	
    		RequestDispatcher $reqDisp = request.getRequestDispatcher("myKartHomePage.jsp");
    		$reqDisp.forward(request, response);
    		return;
        }
        
        Cookie $ck[] = request.getCookies();
        if( $ck != null )	
        for( int $i = 0; $i < $ck.length; $i++ )
        	if( $ck[$i].getName().equals("currentMyKartCookieUser") ){
        	
        		request.getSession().setAttribute("currentMyKartSessionUser", $ck[$i].getValue());
        		RequestDispatcher $reqDisp = request.getRequestDispatcher("myKartHomePage.jsp");
        		$reqDisp.forward(request, response);
        		return;
        	}
        	
 		RequestDispatcher $reqDisp = request.getRequestDispatcher("LogIn.html");
		$reqDisp.forward(request, response);
	}	
}
