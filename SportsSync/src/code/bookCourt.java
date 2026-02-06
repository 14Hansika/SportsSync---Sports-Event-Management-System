package code;
import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import connect_package.connectDB;

import java.sql.*;

public class bookCourt extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
        HttpSession session = request.getSession(false);
        Integer organizerId = (Integer) session.getAttribute("userId");

        if (organizerId == null) {
            response.sendRedirect("login.html");
            return;
        }

       
        int sportId = Integer.parseInt(request.getParameter("sportId"));
        int locationId = Integer.parseInt(request.getParameter("locationId"));
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        int maxPlayers = Integer.parseInt(request.getParameter("maxPlayers"));

   
        try {
        	Connection con = connectDB.getConnect();
           
            String sql = "INSERT INTO Matches (organizerId, sportId, date, time, locationId, maxPlayers) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, organizerId);   
            ps.setInt(2, sportId);       
            ps.setString(3, date);      
            ps.setString(4, time);       
            ps.setInt(5, locationId);
            ps.setInt(6, maxPlayers);    


            int rows = ps.executeUpdate();
            PrintWriter out = response.getWriter();
            response.setContentType("text/html");

            if (rows > 0) {
                out.println("<h2>Match booked successfully!</h2>");
            } else {
                out.println("<h2>Booking failed. Try again.</h2>");
            }

            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h2>Error: " + e.getMessage() + "</h2>");
        }
    }
}
