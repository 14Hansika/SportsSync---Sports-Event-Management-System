<%@ page language="java" contentType="text/html; charset=ISO-8859-1" %>
<%@ page import="java.sql.*, connect_package.connectDB" %>
<%@ page import="connect_package.pojo" %> 

<html>
<head>
<title>My Bookings | SportSync</title>
<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
    :root {
        --primary-color: #4361ee;
        --secondary-color: #3a0ca3;
        --accent-color: #4cc9f0;
        --success-color: #28a745;
        --warning-color: #ffc107;
        --danger-color: #dc3545;
        --light-color: #f8f9fa;
        --dark-color: #212529;
        --card-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
    }
    
    body {
        background: linear-gradient(135deg, #f5f7ff 0%, #e3eeff 100%);
        font-family: 'Poppins', sans-serif;
        min-height: 100vh;
        padding: 20px 0;
    }

    .header-section {
        text-align: center;
        margin: 30px 0 40px;
        position: relative;
    }

    .header-section h2 {
        color: var(--primary-color);
        font-weight: 700;
        font-size: 2.5rem;
        margin-bottom: 10px;
        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .header-section p {
        color: #6c757d;
        font-size: 1.1rem;
        max-width: 600px;
        margin: 0 auto;
    }

    .bookings-icon {
        background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
        width: 80px;
        height: 80px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 20px;
        box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
    }

    .bookings-icon i {
        font-size: 2rem;
        color: white;
    }

    .table-container {
        background: #fff;
        border-radius: 16px;
        box-shadow: var(--card-shadow);
        padding: 30px;
        position: relative;
        overflow: hidden;
        margin-bottom: 30px;
    }

    .table-container::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 5px;
        background: linear-gradient(to right, var(--primary-color), var(--accent-color));
    }

    table {
        text-align: center;
        vertical-align: middle;
        border-radius: 12px;
        overflow: hidden;
        border-collapse: separate;
        border-spacing: 0;
        width: 100%;
    }

    thead {
        background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
        color: white;
    }

    th {
        font-weight: 600;
        font-size: 16px;
        padding: 18px 15px;
        border: none;
    }

    td {
        color: #333;
        font-size: 15px;
        padding: 16px 15px;
        border-bottom: 1px solid #f0f0f0;
    }

    tbody tr {
        transition: all 0.3s ease;
    }

    tbody tr:hover {
        background-color: #f8fbff;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    }

    .status-badge {
        padding: 8px 16px;
        border-radius: 50px;
        font-weight: 600;
        font-size: 0.85rem;
    }

    .status-pending {
        background: linear-gradient(135deg, var(--warning-color), #ff9500);
        color: white;
    }

    .status-accepted {
        background: linear-gradient(135deg, var(--success-color), #20c997);
        color: white;
    }

    .status-rejected {
        background: linear-gradient(135deg, var(--danger-color), #e52d5a);
        color: white;
    }

    .sport-icon {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto;
        font-size: 1.2rem;
        color: white;
    }

    .sport-basketball {
        background: linear-gradient(135deg, #ff6b35, #f7931e);
    }

    .sport-football {
        background: linear-gradient(135deg, #00b4d8, #0077b6);
    }

    .sport-tennis {
        background: linear-gradient(135deg, #38b000, #2d7d46);
    }

    .sport-cricket {
        background: linear-gradient(135deg, #9d4edd, #7b2cbf);
    }

    .sport-default {
        background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
    }

    .booking-card {
        background: white;
        border-radius: 12px;
        padding: 20px;
        margin-bottom: 20px;
        box-shadow: var(--card-shadow);
        border-left: 4px solid var(--primary-color);
        display: none;
    }

    .booking-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 15px;
    }

    .booking-sport {
        font-weight: 600;
        color: var(--primary-color);
        font-size: 1.2rem;
        display: flex;
        align-items: center;
    }

    .booking-sport i {
        margin-right: 10px;
    }

    .booking-details {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
        gap: 15px;
        margin-bottom: 15px;
    }

    .detail-item {
        text-align: center;
    }

    .detail-label {
        font-size: 0.8rem;
        color: #6c757d;
        margin-bottom: 5px;
    }

    .detail-value {
        font-weight: 600;
        color: var(--dark-color);
    }

    .go-back {
        display: flex;
        align-items: center;
        justify-content: center;
        width: fit-content;
        margin: 30px auto;
        text-decoration: none;
        background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
        color: white;
        padding: 12px 30px;
        border-radius: 50px;
        font-weight: 600;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(67, 97, 238, 0.3);
    }

    .go-back:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 20px rgba(67, 97, 238, 0.4);
        color: white;
        text-decoration: none;
    }

    .go-back i {
        margin-right: 8px;
    }

    .empty-state {
        text-align: center;
        padding: 40px 20px;
        color: #6c757d;
    }

    .empty-state i {
        font-size: 4rem;
        margin-bottom: 20px;
        color: #dee2e6;
    }

    .stats-container {
        display: flex;
        justify-content: center;
        gap: 20px;
        margin-bottom: 30px;
        flex-wrap: wrap;
    }

    .stat-card {
        background: white;
        border-radius: 12px;
        padding: 20px;
        box-shadow: var(--card-shadow);
        text-align: center;
        min-width: 150px;
        transition: transform 0.3s ease;
    }

    .stat-card:hover {
        transform: translateY(-5px);
    }

    .stat-value {
        font-size: 2rem;
        font-weight: 700;
        color: var(--primary-color);
        margin-bottom: 5px;
    }

    .stat-label {
        font-size: 0.9rem;
        color: #6c757d;
        font-weight: 500;
    }

    .view-toggle {
        text-align: center;
        margin-bottom: 20px;
    }

    .toggle-btn {
        background: white;
        border: 1px solid #dee2e6;
        color: var(--dark-color);
        padding: 8px 20px;
        border-radius: 50px;
        margin: 0 5px;
        transition: all 0.3s ease;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    .toggle-btn.active {
        background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
        color: white;
        border-color: var(--primary-color);
    }

    .toggle-btn:hover {
        background: var(--primary-color);
        color: white;
        border-color: var(--primary-color);
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
        .table-container {
            padding: 15px;
            border-radius: 12px;
        }
        
        .header-section h2 {
            font-size: 2rem;
        }
        
        table {
            font-size: 0.9rem;
        }
        
        th, td {
            padding: 12px 8px;
        }
        
        .stats-container {
            gap: 10px;
        }
        
        .stat-card {
            min-width: 120px;
            padding: 15px;
        }
        
        .stat-value {
            font-size: 1.5rem;
        }
    }

    @media (max-width: 576px) {
        .d-none-mobile {
            display: none;
        }
    }
</style>
</head>
<body>
<div class="container">
    <div class="header-section">
        <div class="bookings-icon">
            <i class="fas fa-calendar-check"></i>
        </div>
        <h2>My Joined Matches</h2>
        <p>Track all your match bookings and their current status</p>
    </div>

    <%
    int playerId = pojo.getPid();
    Connection con = connectDB.getConnect();
    PreparedStatement ps = con.prepareStatement(
        "SELECT s.sport, m.date, m.time, pm.status " +
        "FROM playermatches pm " +
        "JOIN matches m ON pm.mid = m.mid " +
        "JOIN sports s ON m.sid = s.sid " +
        "WHERE pm.pid = ?"
    );
    ps.setInt(1, playerId);
    ResultSet rs = ps.executeQuery();
    
    int bookingCount = 0;
    int pendingCount = 0;
    int acceptedCount = 0;
    
    while (rs.next()) {
        bookingCount++;
        String status = rs.getString("status");
        if ("Pending".equals(status)) {
            pendingCount++;
        } else if ("Accepted".equals(status)) {
            acceptedCount++;
        }
    }
    rs.beforeFirst(); // Reset the result set to beginning
    %>

    <div class="stats-container">
        <div class="stat-card">
            <div class="stat-value"><%= bookingCount %></div>
            <div class="stat-label">Total Bookings</div>
        </div>
        <div class="stat-card">
            <div class="stat-value"><%= acceptedCount %></div>
            <div class="stat-label">Accepted</div>
        </div>
        <div class="stat-card">
            <div class="stat-value"><%= pendingCount %></div>
            <div class="stat-label">Pending</div>
        </div>
    </div>

    <div class="view-toggle">
        <button class="toggle-btn active" id="tableViewBtn">
            <i class="fas fa-table"></i> Table View
        </button>
        <button class="toggle-btn" id="cardViewBtn">
            <i class="fas fa-th-large"></i> Card View
        </button>
    </div>

    <div class="table-container">
        <!-- Table View -->
        <div id="tableView">
            <table class="table table-hover align-middle">
                <thead>
                    <tr>
                        <th>Sport</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                <%
                if (bookingCount == 0) {
                %>
                    <tr>
                        <td colspan="4">
                            <div class="empty-state">
                                <i class="fas fa-calendar-times"></i>
                                <h4>No Bookings Yet</h4>
                                <p>You haven't joined any matches yet. <a href="viewMatch.jsp">Browse available matches</a> to get started!</p>
                            </div>
                        </td>
                    </tr>
                <%
                } else {
                    while (rs.next()) {
                        String sport = rs.getString("sport");
                        String status = rs.getString("status");
                        String sportIconClass = "sport-default";
                        
                        // Set specific icons for different sports
                        if (sport != null) {
                            if (sport.toLowerCase().contains("basketball")) {
                                sportIconClass = "sport-basketball";
                            } else if (sport.toLowerCase().contains("football") || sport.toLowerCase().contains("soccer")) {
                                sportIconClass = "sport-football";
                            } else if (sport.toLowerCase().contains("tennis")) {
                                sportIconClass = "sport-tennis";
                            } else if (sport.toLowerCase().contains("cricket")) {
                                sportIconClass = "sport-cricket";
                            }
                        }
                        
                        String statusClass = "status-pending";
                        if ("Accepted".equals(status)) {
                            statusClass = "status-accepted";
                        } else if ("Rejected".equals(status)) {
                            statusClass = "status-rejected";
                        }
                %>
                    <tr>
                        <td>
                            <div class="d-flex align-items-center justify-content-center">
                                <div class="sport-icon <%= sportIconClass %> me-3">
                                    <i class="fas fa-<%= getSportIcon(sport) %>"></i>
                                </div>
                                <div>
                                    <strong><%= sport %></strong>
                                </div>
                            </div>
                        </td>
                        <td><%= rs.getString("date") %></td>
                        <td><%= rs.getString("time") %></td>
                        <td>
                            <span class="status-badge <%= statusClass %>">
                                <%= status %>
                            </span>
                        </td>
                    </tr>
                <%
                    }
                }
                con.close();
                %>
                </tbody>
            </table>
        </div>

        <!-- Card View -->
        <div id="cardView" style="display: none;">
            <%
            // Re-execute query for card view
            Connection con2 = connectDB.getConnect();
            PreparedStatement ps2 = con2.prepareStatement(
                "SELECT s.sport, m.date, m.time, pm.status " +
                "FROM playermatches pm " +
                "JOIN matches m ON pm.mid = m.mid " +
                "JOIN sports s ON m.sid = s.sid " +
                "WHERE pm.pid = ?"
            );
            ps2.setInt(1, playerId);
            ResultSet rs2 = ps2.executeQuery();
            
            if (bookingCount == 0) {
            %>
                <div class="empty-state">
                    <i class="fas fa-calendar-times"></i>
                    <h4>No Bookings Yet</h4>
                    <p>You haven't joined any matches yet. <a href="viewMatch.jsp">Browse available matches</a> to get started!</p>
                </div>
            <%
            } else {
                while (rs2.next()) {
                    String sport = rs2.getString("sport");
                    String status = rs2.getString("status");
                    String statusClass = "status-pending";
                    if ("Accepted".equals(status)) {
                        statusClass = "status-accepted";
                    } else if ("Rejected".equals(status)) {
                        statusClass = "status-rejected";
                    }
            %>
                <div class="booking-card">
                    <div class="booking-header">
                        <div class="booking-sport">
                            <i class="fas fa-<%= getSportIcon(sport) %>"></i>
                            <%= sport %>
                        </div>
                        <span class="status-badge <%= statusClass %>">
                            <%= status %>
                        </span>
                    </div>
                    <div class="booking-details">
                        <div class="detail-item">
                            <div class="detail-label">Date</div>
                            <div class="detail-value"><%= rs2.getString("date") %></div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Time</div>
                            <div class="detail-value"><%= rs2.getString("time") %></div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Status</div>
                            <div class="detail-value">
                                <span class="status-badge <%= statusClass %>">
                                    <%= status %>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            <%
                }
                rs2.close();
                ps2.close();
                con2.close();
            }
            %>
        </div>
    </div>

    <a href="playerDashboard.html" class="go-back">
        <i class="fas fa-arrow-left"></i> Back to Dashboard
    </a>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Toggle between table and card view
    document.getElementById('tableViewBtn').addEventListener('click', function() {
        document.getElementById('tableView').style.display = 'block';
        document.getElementById('cardView').style.display = 'none';
        this.classList.add('active');
        document.getElementById('cardViewBtn').classList.remove('active');
    });

    document.getElementById('cardViewBtn').addEventListener('click', function() {
        document.getElementById('tableView').style.display = 'none';
        document.getElementById('cardView').style.display = 'block';
        this.classList.add('active');
        document.getElementById('tableViewBtn').classList.remove('active');
    });
</script>
</body>
</html>

<%!
// Helper method to get appropriate icon for each sport
private String getSportIcon(String sport) {
    if (sport == null) return "running";
    
    String sportLower = sport.toLowerCase();
    if (sportLower.contains("basketball")) return "basketball-ball";
    if (sportLower.contains("football") || sportLower.contains("soccer")) return "futbol";
    if (sportLower.contains("tennis")) return "table-tennis";
    if (sportLower.contains("cricket")) return "baseball-ball";
    if (sportLower.contains("volleyball")) return "volleyball-ball";
    if (sportLower.contains("badminton")) return "table-tennis";
    if (sportLower.contains("hockey")) return "hockey-puck";
    if (sportLower.contains("golf")) return "golf-ball";
    if (sportLower.contains("swim")) return "swimmer";
    
    return "running";
}
%>