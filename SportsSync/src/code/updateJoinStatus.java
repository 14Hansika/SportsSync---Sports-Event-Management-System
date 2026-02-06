package code;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import connect_package.connectDB;

public class updateJoinStatus extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int playerMatchId = Integer.parseInt(request.getParameter("playerMatchId"));
            String status = request.getParameter("status");

            Connection con = connectDB.getConnect();
            PreparedStatement ps = con.prepareStatement(
                    "UPDATE playermatches SET status=? WHERE id=?");
            ps.setString(1, status);
            ps.setInt(2, playerMatchId);
            ps.executeUpdate();

            con.close();
            response.sendRedirect("viewJoinRequests.jsp?msg=Updated");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
