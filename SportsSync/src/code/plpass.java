package code;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import connect_package.connectDB;

/**
 * Servlet implementation class plpass
 */
public class plpass extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public plpass() {
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
		String pemail = request.getParameter("pemail");
        String oldPass = request.getParameter("oldPassword");
        String newPass = request.getParameter("newPassword");
        String confirmPass = request.getParameter("confirmPassword");

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
        	  Connection con = connectDB.getConnect();

            PreparedStatement check = con.prepareStatement("SELECT * FROM players WHERE pemail = ? AND ppass = ?");
            check.setString(1, pemail);
            check.setString(2, oldPass);
            ResultSet rs = check.executeQuery();

            if (rs.next()) {
               
                if (newPass.equals(confirmPass)) {
                	PreparedStatement update = con.prepareStatement("UPDATE players SET ppass = ? WHERE pemail = ?");
                    update.setString(1, newPass);
                    update.setString(2, pemail);
                    int rows = update.executeUpdate();
                    if(rows>0)
					{
						response.sendRedirect("playerLogin.html");
					}
					

                }}}

            
         catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
        }
}
	}

