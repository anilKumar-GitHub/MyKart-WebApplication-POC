package dataModel;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Iterator;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


public class myKartDataBaseOperations {
	
	private Connection $connectionPool = null;
	
	private Statement $stmt = null;
	
	private ResultSet $rsSet = null;
	
	private int count = 1;
	
	public myKartDataBaseOperations()	{
		
		if( setConnection() ) 	System.out.println(" Connection Established");
		else					System.out.println(" Connection Failed");
		
		System.out.println("myKart constructor Called : "+count);
		count++;
	}
	
	public Connection getConnection()	{
		
		if( $connectionPool != null )	
			return $connectionPool;
		return null;
	}
	
	public Statement getStatement() {
		if( $connectionPool != null )	{
			try{
				return $connectionPool.createStatement();
			}catch (SQLException mySqlErr) {
				// TODO: handle exception
				System.out.println("Error from statement creation : "+mySqlErr.getLocalizedMessage());
			}
		}
		return null;
	}
	
	
	public Connection getNewConnection(){
		
		Connection $tempConnection = null;
		
		try	{
			
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			$tempConnection = DriverManager.getConnection("jdbc:sqlserver://ADMIN-PC;port=1433;database=OurKartDataBase","vayuDev","root");
		}catch (ClassNotFoundException $mySqlErr) {
			System.out.println("Error From Calss Not Found  : "+$mySqlErr.getLocalizedMessage());
		}catch (SQLException $mySqlErr) {
			System.out.println("Error From Calss Not Found  : "+$mySqlErr.getLocalizedMessage());
		}
		return $tempConnection;
	}
	
	
	
	public boolean setConnection(){
		
		System.out.println("Connection Establiched in setConnection");
		try	{
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			$connectionPool = DriverManager.getConnection("jdbc:sqlserver://ADMIN-PC;port=1433;database=OurKartDataBase","vayuDev","root");

		}catch (ClassNotFoundException $mySqlErr) {
			System.out.println("Error From Calss Not Found  : "+$mySqlErr.getLocalizedMessage());
			return false;
		}catch (SQLException $mySqlErr) {
			System.out.println("Error From Calss Not Found  : "+$mySqlErr.getLocalizedMessage());
			return false;
		}
		return true;
	}
	
	
	public ResultSet execeteQuery(String query) {
		
		if( $connectionPool != null )	{
		
			try {				
				return $connectionPool.createStatement().executeQuery(query);
			}catch (SQLException $mySqlErr) {

				System.out.println("Error From Result hs  : "+$mySqlErr.getLocalizedMessage());
			}
		}
		return null;
	}
	
	
	public boolean authenticateUser(String $userName, String $password )	{
		
		System.out.println(" authentication is going on ");
		
		if( $userName.equals("admin") && $password.equals("myKart"))	{
			System.out.println(" successed ");
			return true;
		}
		else	{
			System.out.println(" failed ");
			return false;
		}
		
		
	}
		
	public String message()	{
		
		return "OK Working";
	}

	public String arrayToString(String arr[])	{
		String str = new String();
		
		for( int i = 0; i < arr.length; i ++)			str += "'"+arr[i] + "',";
		
		str = str.substring(0, str.lastIndexOf(","));
		return str;
	}
	
	
	public boolean authenticateMyKartLoginUser( String email, String pass )		{
		try {
			
/*			$rsSet = $connectionPool.createStatement().executeQuery("SELECT password FROM myKartUser WHERE Email='"+email+"' OR PhoneNum = '"+email+"'");
			
			if( $rsSet.next() )	{
				
				if(pass.equals($rsSet.getString("password")))	return	true;
				else											return	false;
			}

*/
			
			$rsSet = $connectionPool.createStatement().executeQuery("SELECT password FROM myKartUser WHERE ( Email='"+email+"' OR PhoneNum = '"+email+"' ) and password = '"+pass+"' ");
			System.out.println("Testin Sql Injection");
			if( $rsSet.next() )	{
					return true;
			}else
					return false;
		}catch (SQLException e) {

			System.out.println("Error From myKart User authentication : "+e.getLocalizedMessage());
		}

			return false;
	}
	
	public String getmyKartLogInUserName(String email)	{
		try {
			
			$rsSet = $connectionPool.createStatement().executeQuery("SELECT Name FROM myKartUser WHERE Email='"+email+"' OR PhoneNum = '"+email+"'");
			
			if( $rsSet.next() )	{
				return  $rsSet.getString("Name");
			}
		}catch (SQLException e) {

			System.out.println("Error From myKart User authentication : "+e.getLocalizedMessage());
		}
		return null;
	}
	
	public String getmyKartLogInUserImage(String email)	{
		try {
			
			$rsSet = $connectionPool.createStatement().executeQuery("SELECT image FROM myKartUser WHERE Email='"+email+"' OR PhoneNum = '"+email+"'");
			
			if( $rsSet.next() )	{
				return  $rsSet.getString("image");
			}
		}catch (SQLException e) {

			System.out.println("Error From myKart User authentication : "+e.getLocalizedMessage());
		}
		return null;
	}
	
	
	public boolean addmyKartUser(HttpServletRequest req) {

		try{
			$connectionPool.createStatement().execute("INSERT INTO myKartUser VALUES('"+req.getParameter("uname")+"','"+req.getParameter("email")+"','"+req.getParameter("phno")+"','"+req.getParameter("pass1")+"', '"+req.getParameter("picName")+"', default)");
			return true;
		}catch (SQLException e) {
			System.out.println("Error While Adding myKart User : "+e.getLocalizedMessage());
		}
		return false;
	}
	
	public String getString(String field, String condition){
		
		try {
			
			$rsSet = $connectionPool.createStatement().executeQuery("SELECT "+field+" FROM myKartUser WHERE Email='"+condition+"' OR PhoneNum = '"+condition+"'");
			
			if( $rsSet.next() )	{
				return  $rsSet.getString(field);
			}
		}catch (SQLException e) {

			System.out.println("Error From myKart User authentication : "+e.getLocalizedMessage());
		}
		return null;		
	}
	
	public boolean setWishList(String list, String email) {
		try {
			list = convertHashSetToString(list);
			int row = $connectionPool.createStatement().executeUpdate("UPDATE myKartUser SET wishList = '"+list+"' WHERE Email='"+email+"'");
			
			if( row > 0 )	{
				return  true;
			}
		}catch (SQLException e) {

			System.out.println("Error From myKart User authentication : "+e.getLocalizedMessage());
		}
		return false;				
	}

	public String getWishList(String email) {
		try {
			
			$rsSet = $connectionPool.createStatement().executeQuery("SELECT wishList FROM myKartUser  WHERE Email='"+email+"'");
			
			if( $rsSet.next() )	{
				return  $rsSet.getString("wishList");
			}
		}catch (SQLException e) {

			System.out.println("Error From myKart User authentication : "+e.getLocalizedMessage());
		}
		return null;				
	}
	
	public String convertHashSetToString(String list)	{

		list = list.substring(1, list.length() -1 );
		list = list.replaceAll(" ","");		
		return list;
	}
	
	public Set<String> loadSessionWithOldWishList(Set<String> list, String email){
					
			String  oldList[] = getWishList(email).split(",");

			if( oldList.length == 1 && oldList[0].equals(""))	return list; 

			for( int i = 0; i < oldList.length; i++ )	{
				System.out.println("old Value : "+oldList[i]);
				list.add(oldList[i]);
			}
		return list;
	}
	
	public String getNextTransactionTokenNo() {
		try {
			$rsSet = $connectionPool.createStatement().executeQuery("SELECT GETDATE()[currentTime]");
			
			if($rsSet.next())	{
				String temp = $rsSet.getString(1);
		    	temp = temp.replace(" ", "");
				temp = temp.replace("-", "");
				temp = temp.replace(":", "");
				temp = temp.replace(".", "");
				return temp;
			}
		}catch (SQLException e) {
			System.out.println("Error while Generating Random Number : "+e.getLocalizedMessage());
		}
		return null;
	}
	
	public boolean placeOrderAndUpdateCart(HttpServletRequest request) {
		
		try {
			$connectionPool.setAutoCommit(false);
			System.out.println("Commit Set to false");
		}catch (SQLException e) {
			System.out.println("Error while setting auto commite to false: "+e.getLocalizedMessage());
		}

		String trnsToken = getNextTransactionTokenNo();
		String accNo = new String();
		String bankName = new String();
		String email = request.getSession().getAttribute("seessionEmailId").toString();
		
		if( request.getParameter("mode").equals("Credit Card") )		{
		
			accNo = request.getParameter("creditNo");
			bankName = request.getParameter("bankName1");
		}else	if( request.getParameter("mode").equals("Debit Card") )	{

			accNo = request.getParameter("debitNo");
			bankName = request.getParameter("bankName2");	
		}else if( request.getParameter("mode").equals("Cash On Delivery") )	{
			
			accNo = "";
			bankName = "";
		}	
		
		try {

		$connectionPool.createStatement().execute("INSERT INTO DeliveryDetail VALUES " +
				"('"+trnsToken+"', '"+email+"', default, " +
				"'"+request.getParameter("userName")+"', '"+request.getParameter("phno")+"', '"+request.getParameter("add")+"', '"+request.getParameter("city")+"', '"+request.getParameter("state")+"', '"+request.getParameter("pin")+"', " +
				"'"+request.getParameter("mode")+"', '"+accNo+"', '"+bankName+"')");

		Iterator<String> it = ((Set<String>)request.getSession().getAttribute("curWishList")).iterator();

		while(it.hasNext()) {
    		String key = it.next();

    		$connectionPool.createStatement().executeUpdate("UPDATE ProductMaster SET Quantity = Quantity - "+Integer.parseInt( request.getParameter(key) )+" WHERE Pid = '"+key+"' ");

    		$connectionPool.createStatement().execute("INSERT INTO DeliveredProductList VALUES " +
				"('"+trnsToken+"', '"+key+"', "+Integer.parseInt( request.getParameter(key) )+")");
    		
    	}
		
		request.getSession().removeAttribute("curWishList");
		
		$connectionPool.createStatement().execute("UPDATE myKartUser SET wishList =  '' WHERE Email = '"+email+"'");
		
		$connectionPool.commit();
		
		System.out.println("Commit is done by explicitly");
			
		}catch (SQLException e) {
			System.out.println("Error while commmiting data : "+e.getLocalizedMessage());
			return false;
		}
		finally	{
			try {
				$connectionPool.setAutoCommit(true);
				System.out.println("autoCommit Set to true");
			}catch (SQLException e) {
				System.out.println("Error while setting auto commite to true: "+e.getLocalizedMessage());
				return false;
			}			
		}
		request.getSession().setAttribute("lastTransactionTokenId", trnsToken);
		return true;
	}
	
	
	public void getEmployeeInfo(int id) {
		
		try {
			
			CallableStatement call = $connectionPool.prepareCall("exec getInfo ?, ?, ?, ?");
			
			call.setInt(1, id);
			
			call.registerOutParameter(2, java.sql.Types.VARCHAR);
			call.registerOutParameter(3, java.sql.Types.VARCHAR);
			call.registerOutParameter(4, java.sql.Types.VARCHAR);			
			
			call.executeUpdate();
			
			System.out.println("Out Put : ");
			System.out.println("Name : "+call.getString(2));
			System.out.println("Email : "+call.getString(3));
			System.out.println("Phone Numer : "+call.getString(4));

		}catch (SQLException e) {
			
			System.out.println("Error : "+e.getLocalizedMessage());
		}
		
	}

	public static void main(String[] args) {
		
		myKartDataBaseOperations db = new myKartDataBaseOperations();
		
		db.getEmployeeInfo(6);
	}
	
}
