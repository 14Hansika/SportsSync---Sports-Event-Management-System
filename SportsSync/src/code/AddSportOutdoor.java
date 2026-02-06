package code;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import connect_package.connectDB;

/**
 * Servlet implementation class AddSportServlet
 */
public class AddSportOutdoor extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddSportOutdoor() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
		try
		{
			Connection con = connectDB.getConnect();
			int sid=0;
			String name=request.getParameter("sport");
			PreparedStatement ps1 = con.prepareStatement("insert into sports values(?,?)");
			ps1.setInt(1,sid);
			ps1.setString(2,name);
			
			int i=ps1.executeUpdate();
			 if (i > 0) {
				  // ✅ Show JS alert
//	                System.out.println("<script type='text/javascript'>");
//	                System. out.println("alert('Sport \"" + name + "\" added successfully!');");
//	                System.out.println("window.location = document.referrer;"); // Go back to previous page
//	                System. out.println("</script>");
	                response.sendRedirect("addOutdoor.html");
	            } else {
	            	 System.out.println("<script type='text/javascript'>");
	            	 System. out.println("alert('Failed to add sport.');");
	            	 System. out.println("window.location = document.referrer;");
	            	 System.out.println("</script>");
	            }


	        } catch (Exception e) {
	        	 System.out.println("<script type='text/javascript'>");
	        	 System.out.println("alert('Error occurred: " + e.getMessage().replace("'", "") + "');");
	        	 System.out.println("window.location = document.referrer;");
	        	 System.out.println("</script>");
	        }
	    }
	}