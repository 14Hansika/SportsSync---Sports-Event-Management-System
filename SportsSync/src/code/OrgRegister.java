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
 * Servlet implementation class OrgRegister
 */
public class OrgRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrgRegister() {
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
			int oid=0;
			String oname=request.getParameter("oname");
			String oemail=request.getParameter("oemail");
			String opass=request.getParameter("opass");
			String ocontact=request.getParameter("ocontact");
			
			PreparedStatement ps1 = con.prepareStatement("insert into organizer values(?,?,?,?,?)");
			ps1.setInt(1,oid);
			ps1.setString(2,oname);
			ps1.setString(3,oemail);
			ps1.setString(4,opass);
			ps1.setString(5,ocontact);
		
			
			int i = ps1.executeUpdate();

			if (i > 0) {
			
				System.out.println("Registered Successfully..!!");
				response.sendRedirect("OrgLogin.html");
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
