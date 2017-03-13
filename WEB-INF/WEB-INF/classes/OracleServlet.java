import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

public class OracleServlet extends HttpServlet 
{
  
	
	protected void doGet(HttpServletRequest arg0, HttpServletResponse arg1)
			throws ServletException, IOException 
	{
		arg1.setContentType("text/html");
	 	PrintWriter out=arg1.getWriter();
		try 
		{
			InitialContext ctx = new InitialContext();
			DataSource ds =  (DataSource) ctx.lookup("dizzyworldDS");
			Connection con = ds.getConnection();
			out.println("conn ready");
			Statement stmt = con.createStatement ();
			out.println("stmt ready");
			ResultSet rset = stmt.executeQuery ("select * from EMP");
			out.println("resultset ready");
			 while (rset.next ())
			 {
			   String nm = rset.getString (2);
			   out.println(nm + "<br/>");
			 }
		} 
		catch (Exception e) {
		
			e.printStackTrace();
		}

	
	}
}
