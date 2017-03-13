import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;
import com.hello.Hello;
import com.hello.HelloHome;
import java.io.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class MyHttpServlet extends HttpServlet
{
	 public void doGet(HttpServletRequest req, HttpServletResponse res) 
		throws IOException
	 {
	 	res.setContentType("text/html");
	 	PrintWriter out=res.getWriter();
		try 
		{
			InitialContext ctx = new InitialContext();
			DataSource ds =(DataSource) ctx.lookup("OracleDS");
			Connection con = ds.getConnection("scott", "tiger");
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("select * from dept");
			while(rs.next())
			{
				out.println(rs.getString(1) +  " : "+ rs.getString(2));
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		  
	 }
}






/* res.setContentType("text/html");
PrintWriter out=res.getWriter();
try 
{
	InitialContext ctx = new InitialContext();
	HelloHome hm = (HelloHome) ctx.lookup("HelloBean");
	Hello h = hm.create();
	out.println(h.welcome());
} 
catch (Exception e) 
{
	e.printStackTrace();
}*/