import java.io.IOException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hello.HelloHome;
import com.hello.HelloLocal;
import com.hello.HelloLocalHome;

public class LocalServlet extends HttpServlet 
{

	
	protected void doGet(HttpServletRequest arg0, HttpServletResponse arg1)
			throws ServletException, IOException 
	{
		try 
		{
			InitialContext ctx = new InitialContext();
			HelloLocalHome hm = (HelloLocalHome) ctx.lookup("HelloLocal");
			HelloLocal hl = hm.create();
			System.out.println(hl.welcome());
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		
	}
}
