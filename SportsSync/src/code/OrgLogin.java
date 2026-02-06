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
 * Servlet implementation class OrgLogin
 */
public class OrgLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrgLogin() {
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
			String oemail=request.getParameter("oemail");
			String opass=request.getParameter("opass");
			
			PreparedStatement ps1 = con.prepareStatement("select * from organizer where oemail=? and opass=?");
			ps1.setString(1,oemail);
			ps1.setString(2,opass);
			ResultSet rs = ps1.executeQuery();
			
			
			if(rs.next())
			{
				int oid=rs.getInt("oid");
				pojo.setOid(oid);
				response.sendRedirect("OrganizerDashboard.html");
			}
			else{
				response.sendRedirect("OrgLogin.html");
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
