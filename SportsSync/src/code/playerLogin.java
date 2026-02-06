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
import connect_package.pojo;

/**
 * Servlet implementation class playerLogin
 */
public class playerLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public playerLogin() {
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
			String pemail=request.getParameter("pemail");
			String ppass=request.getParameter("ppass");
			
			PreparedStatement ps1 = con.prepareStatement("select * from players where pemail=? and ppass=?");
			ps1.setString(1,pemail);
			ps1.setString(2,ppass);
			ResultSet rs = ps1.executeQuery();
			
			if(rs.next())
			{

				int pid=rs.getInt("pid");
				pojo.setPid(pid);
				response.sendRedirect("playerDashboard.html");
			}
			else{
				response.sendRedirect("playerLogin.html");
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
