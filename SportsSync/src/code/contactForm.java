package code;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import connect_package.connectDB;

/**
 * Servlet implementation class contactForm
 */
public class contactForm extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public contactForm() {
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
		 String name = request.getParameter("name");
		    String email = request.getParameter("email");
		    String subject = request.getParameter("subject");
		    String message = request.getParameter("message");

		    response.setContentType("text/html");
		    PrintWriter out = response.getWriter();

		    try {
		        Connection con = connectDB.getConnect();
		        
		        // Insert message into database
		        String sql = "INSERT INTO contactmesg (name, email, subject, message, sdate) VALUES (?, ?, ?, ?, ?)";
		        PreparedStatement pst = con.prepareStatement(sql);
		        pst.setString(1, name);
		        pst.setString(2, email);
		        pst.setString(3, subject);
		        pst.setString(4, message);
		        pst.setTimestamp(5, new Timestamp(new Date(0).getTime()));
		        
		        int rows = pst.executeUpdate();
		        
		        if (rows > 0) {
		            // Success - show confirmation message
		            out.println("<script>alert('Thank you for your message! We will get back to you soon.'); window.location='contact.html';</script>");
		        } else {
		            // Error
		            out.println("<script>alert('Sorry, there was an error sending your message. Please try again.'); window.location='contact.html';</script>");
		        }
		        
		    } catch (Exception e) {
		        e.printStackTrace();
		        out.println("<script>alert('Error: " + e.getMessage() + "'); window.location='contact.html';</script>");
		    }
		}
}
