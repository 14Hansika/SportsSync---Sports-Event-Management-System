package code;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import connect_package.connectDB;
import connect_package.pojo;

/**
 * Servlet implementation class createMatch
 */
public class createMatch extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public createMatch() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection con = null;
        PreparedStatement ps1 = null;
        ResultSet rs = null;
        PreparedStatement getSidStmt = null;
        
        try {
            int oid = pojo.getOid();
            String date = request.getParameter("date");
            String time = request.getParameter("time");
            String sportName = request.getParameter("sportName");
            int maxPlayers = Integer.parseInt(request.getParameter("maxPlayer"));

            con = connectDB.getConnect();

            // Step 1: Get sport ID
            int sid = -1;
            getSidStmt = con.prepareStatement("SELECT sid FROM sports WHERE sport = ?");
            getSidStmt.setString(1, sportName);
            rs = getSidStmt.executeQuery();

            if (rs.next()) {
                sid = rs.getInt("sid");
            } else {
                System.out.println("Sport not found: " + sportName);
                response.sendRedirect("error.html");
                return;
            }

            // Close the first result set
            rs.close();
            getSidStmt.close();

            // Step 2: Insert match and get auto-generated mid
            // Use PreparedStatement with RETURN_GENERATED_KEYS
            ps1 = con.prepareStatement(
                "INSERT INTO matches (oid, sid, sportName, date, time, maxPlayers) VALUES (?, ?, ?, ?, ?, ?)", 
                Statement.RETURN_GENERATED_KEYS
            );
            
            ps1.setInt(1, oid);
            ps1.setInt(2, sid);
            ps1.setString(3, sportName);
            ps1.setString(4, date);
            ps1.setString(5, time);
            ps1.setInt(6, maxPlayers);

            int i = ps1.executeUpdate();

            if (i > 0) {
                // Get the auto-generated mid
                ResultSet generatedKeys = ps1.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int mid = generatedKeys.getInt(1);
                    pojo.setMid(mid);
                    System.out.println("Match Added Successfully! Match ID: " + mid);
                } else {
                    System.out.println("Match Added but could not retrieve Match ID");
                }
                generatedKeys.close();
                response.sendRedirect("OrganizerDashboard.html");
            } else {
                response.sendRedirect("error.html");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.html");
        } finally {
            // Close resources in finally block
            try {
                if (rs != null) rs.close();
                if (getSidStmt != null) getSidStmt.close();
                if (ps1 != null) ps1.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}