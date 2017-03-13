import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AcessDB extends HttpServlet 
{
   
	protected void doGet(HttpServletRequest arg0, HttpServletResponse arg1)
			throws ServletException, IOException 
	{
		arg1.setContentType("text/html");
	 	PrintWriter out=arg1.getWriter();
		try 
		{
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			out.println("driver loaded");
			Connection conn =
			      DriverManager.getConnection ("jdbc:odbc:TestDsn");
			out.println("conn ready");
			Statement stmt = conn.createStatement ();
			ResultSet rset = stmt.executeQuery ("select * from employees");
			out.println("resultset ready");
			 while (rset.next ())
			 {
			   String nm = rset.getString (1);
			   out.println(nm);
			   System.out.println(nm);
			 }
		} 
		catch (Exception e) {
		
			e.printStackTrace();
		}

	}
}
