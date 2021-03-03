

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/logOutServlet")
public class logOutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public logOutServlet() {
        super();

    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession $sess = request.getSession();
		
		if( $sess.getAttribute("currentMyKartSessionUser") == null )		{
			
			System.out.println("Session Closed by not null");
			RequestDispatcher $reqDisp = request.getRequestDispatcher("LogIn.html");
			$reqDisp.forward(request, response);
			return;
		}
		
		
        Cookie $ck[] = request.getCookies();
		System.out.println("Cookies Cleared");
        if( $ck != null )	
        for( int $i = 0; $i < $ck.length; $i++ )
        	if( $ck[$i].getName().equals("currentMyKartCookieUser") ){
        	
        		$ck[$i].setMaxAge(0);
        		response.addCookie($ck[$i]);        		
        	}

        $sess.invalidate();
		System.out.println("Session Closed..!");
		
		System.out.println(" Redirected to log in page");
        
		RequestDispatcher $reqDisp = request.getRequestDispatcher("LogIn.html");
		$reqDisp.forward(request, response);
	}
}
