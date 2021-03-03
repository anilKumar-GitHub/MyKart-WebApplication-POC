package Controls;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dataModel.myKartDataBaseOperations;
@WebServlet("/checkOutOrder")
public class checkOutOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public checkOutOrder() {
        super();
    }

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    if(	((myKartDataBaseOperations)request.getServletContext().getAttribute("objectHandler")).placeOrderAndUpdateCart(request)  )
    		response.sendRedirect("orderBillReciept.jsp");
    else	response.sendRedirect("orderBillReciept.jsp?err=1");
    }

}
