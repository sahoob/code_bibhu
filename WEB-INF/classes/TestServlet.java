import java.io.IOException;
import java.io.PrintWriter;
import javax.jms.JMSException;
import javax.jms.Queue;
import javax.jms.QueueConnection;
import javax.jms.QueueConnectionFactory;
import javax.jms.QueueSender;
import javax.jms.QueueSession;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.jms.QueueReceiver;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TestServlet extends HttpServlet 
{

	
	protected void doGet(HttpServletRequest arg0, HttpServletResponse arg1)
			throws ServletException, IOException 
	{
		try 
		{
			arg1.setContentType("text/html");
		 	PrintWriter out=arg1.getWriter();
		 	

			InitialContext ctx = new InitialContext();

			QueueConnectionFactory cFactory = (QueueConnectionFactory) ctx.lookup("dizzyworldCF" );
			QueueConnection con =  cFactory.createQueueConnection() ;
			con.start();
			QueueSession ses = con.createQueueSession(false, Session.AUTO_ACKNOWLEDGE);
			Queue q = (Queue) ctx.lookup("dizzyworldQueue");
			out.println("Msg from Weblogic " + "<br/>"); 	
			System.out.println("queue found");
			QueueReceiver rec = ses.createReceiver(q);
			TextMessage msg =  (TextMessage) rec.receive(); 
			out.println("First Message is :" +msg.getText()  + "<br/>");
			 msg =  (TextMessage) rec.receive(); 
			out.println("Second Message is :" +msg.getText()  + "<br/>");

		 	 
			System.out.println("msg received");
			
		} 
		catch (Exception e) {
			e.printStackTrace();
		} 
		
	}
}
