package code;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import connect_package.connectDB;
import connect_package.pojo;

public class joinMatch extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public joinMatch() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int matchId = Integer.parseInt(request.getParameter("mid"));
        int playerId = pojo.getPid(); // player id from login session

        try {
            Connection con = connectDB.getConnect();

            // check if already joined
            PreparedStatement psCheck = con.prepareStatement(
                    "SELECT * FROM playermatches WHERE mid=? AND pid=?");
            psCheck.setInt(1, matchId);
            psCheck.setInt(2, playerId);
            ResultSet rs = psCheck.executeQuery();

            if (!rs.next()) {
                PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO playermatches (mid, pid, jionAt, status) VALUES (?, ?, NOW(), ?)");
                ps.setInt(1, matchId);
                ps.setInt(2, playerId);
                ps.setString(3, "Pending");

                int i = ps.executeUpdate();
                if (i > 0) {
                    response.sendRedirect("viewBookings.jsp?msg=Request Sent Successfully");
                } else {
                    response.sendRedirect("viewMatch.jsp?msg=Insert Failed");
                }
            } else {
                response.sendRedirect("viewMatch.jsp?msg=Already Joined");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("viewMatch.jsp?msg=Error Occurred");
        }
    }
}
