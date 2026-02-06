package code;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.jdbc.PreparedStatement;

import connect_package.connectDB;

/**
 * Servlet implementation class feedbackform
 */
public class feedback extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public feedback() {
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
		        // Set content type
		        response.setContentType("text/html");
		        
		        // Get form data
		        int fid=0;
		        String name = request.getParameter("name");
		        String rating = request.getParameter("rating");
		        String comment = request.getParameter("comment");
//		        int userId = 1;  // Assuming logged-in user ID is 1 for this example (You should fetch it from session)
		        
		        Connection conn = null;
		        PreparedStatement ps = null;
		        PrintWriter out = response.getWriter();
		        
		        try{
		        	Connection con = connectDB.getConnect();
		            // Step 3: Create SQL query
		            String sql = "INSERT INTO Feedback (fid,name,rating, comment, date) VALUES (?, ?, ?, ?, NOW())";
		            ps = (PreparedStatement) con.prepareStatement(sql);
		            ps.setInt(1, fid);
		            ps.setString(2, name);
		            ps.setInt(3, Integer.parseInt(rating));
		            ps.setString(4, comment);
		            
		            // Step 4: Execute query
		            int result = ps.executeUpdate();
		            
		            // Step 5: Provide feedback to the player
		            if (result > 0) {
		            	response.sendRedirect("Thankyou.html");
		            } else {
		                out.println("<h3>Sorry, something went wrong. Please try again later.</h3>");
		            }
		        } catch (Exception e) {
		            e.printStackTrace();
		            out.println("<h3>Error: " + e.getMessage() + "</h3>");
		        } finally {
		            // Step 6: Clean up environment
		            try {
		                if (ps != null) ps.close();
		                if (conn != null) conn.close();
		            } catch (SQLException se) {
		                se.printStackTrace();
		            }
		        }
		    }
	
		
	}
