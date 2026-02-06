package code;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import connect_package.connectDB;

/**
 * Servlet implementation class playerReg
 */
public class playerReg extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public playerReg() {
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
			int pid=0;
			String pname=request.getParameter("pname");
			String pemail=request.getParameter("pemail");
			String ppass=request.getParameter("ppass");
			String pcontact=request.getParameter("pcontact");
			
			PreparedStatement ps1 = con.prepareStatement("insert into players values(?,?,?,?,?)");
			ps1.setInt(1,pid);
			ps1.setString(2,pname);
			ps1.setString(3,pemail);
			ps1.setString(4,ppass);
			ps1.setString(5,pcontact);
		
			int i = ps1.executeUpdate();

			if (i > 0) {
			
				System.out.println("Registered Successfully..!!");
				response.sendRedirect("playerLogin.html");
				
			} else {
				response.sendRedirect("error.html");
			}
		} catch (Exception e)
		{
			e.printStackTrace();
			response.sendRedirect("error.html");
		}
	}

}
