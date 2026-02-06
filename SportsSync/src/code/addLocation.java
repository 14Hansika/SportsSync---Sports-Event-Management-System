package code;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.jdbc.ResultSet;

import connect_package.connectDB;
import connect_package.pojo;

/**
 * Servlet implementation class addLocation
 */
public class addLocation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addLocation() {
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
		try {
			int lid=pojo.setLid();
			String lname = request.getParameter("lname");
			String laddress = request.getParameter("laddress");
			String sportName = request.getParameter("sportName");
			String price = request.getParameter("price");

			Connection con = connectDB.getConnect();

			// Step 1: Fetch sport id (sid) based on sport name
			int sid = -1;
			PreparedStatement getSidStmt = con.prepareStatement("select sid from sports where sport = ?");
			getSidStmt.setString(1, sportName);
			ResultSet rs = (ResultSet) getSidStmt.executeQuery();

			if (rs.next()) {
				sid = rs.getInt("sid");
			} else {
				// Sport not found
				System.out.println("Sport not found: " + sportName);
				response.sendRedirect("error.html");
				return;
			}

			// Step 2: Insert into location table
			PreparedStatement ps1 = con.prepareStatement(
			    "INSERT INTO location values(?,?, ?, ?, ?, ?, ?)"
			);
			ps1.setInt(1, lid);
			ps1.setString(2, lname);
			ps1.setString(3, laddress);
			ps1.setInt(4, sid);
			ps1.setString(5, sportName);
			ps1.setString(6, price);
			ps1.setString(7, "Available");
			
			

			int i = ps1.executeUpdate();

			if (i > 0) {
			
				System.out.println("Added Successfully!");
				response.sendRedirect("addLocation.html");
			} else {
				response.sendRedirect("error.html");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("error.html");
		}
	}
}
