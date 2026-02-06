<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="connect_package.connectDB" %>
<%@ page import="java.sql.*" %>
<%@ page import="connect_package.pojo" %>  
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Available Matches | SportSync</title>
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
            --light-color: #f8f9fa;
            --dark-color: #212529;
            --card-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        }
        
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            color: white;
            font-weight: 700;
            font-size: 2.5rem;
            margin-bottom: 10px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .header-section p {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1.1rem;
            max-width: 600px;
            margin: 0 auto;
        }

        .matches-icon {
            background: rgba(255, 255, 255, 0.2);
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            backdrop-filter: blur(10px);
            border: 2px solid rgba(255, 255, 255, 0.3);
        }

        .matches-icon i {
            font-size: 2rem;
            color: white;
        }

        .table-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 16px;
            box-shadow: var(--card-shadow);
            padding: 30px;
            position: relative;
            overflow: hidden;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
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

        .btn-join {
            background: linear-gradient(to right, var(--success-color), #20c997);
            border: none;
            color: white;
            padding: 8px 20px;
            border-radius: 50px;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(40, 167, 69, 0.3);
        }

        .btn-join:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(40, 167, 69, 0.4);
            color: white;
        }

        .sport-badge {
            background: linear-gradient(135deg, var(--accent-color), #560bad);
            color: white;
            padding: 6px 12px;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .match-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: var(--card-shadow);
            border-left: 4px solid var(--primary-color);
            display: none;
        }

        .match-header {
            display: flex;
            justify-content: between;
            align-items: center;
            margin-bottom: 15px;
        }

        .match-sport {
            font-weight: 600;
            color: var(--primary-color);
            font-size: 1.2rem;
        }

        .match-id {
            color: #6c757d;
            font-size: 0.9rem;
        }

        .match-details {
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
            background: rgba(255, 255, 255, 0.2);
            color: white;
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .go-back:hover {
            background: rgba(255, 255, 255, 0.3);
            color: white;
            transform: translateY(-2px);
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
            background: rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            min-width: 150px;
            transition: transform 0.3s ease;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 0.9rem;
            opacity: 0.9;
        }

        .view-toggle {
            text-align: center;
            margin-bottom: 20px;
        }

        .toggle-btn {
            background: rgba(255, 255, 255, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
            padding: 8px 20px;
            border-radius: 50px;
            margin: 0 5px;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

        .toggle-btn.active {
            background: rgba(255, 255, 255, 0.4);
            color: white;
        }

        .toggle-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            color: white;
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
            <div class="matches-icon">
                <i class="fas fa-trophy"></i>
            </div>
            <h2>Available Matches</h2>
            <p>Join exciting sports matches and tournaments near you</p>
        </div>

        <%
        Connection con = connectDB.getConnect();
        PreparedStatement ps = con.prepareStatement("SELECT * FROM matches");
        ResultSet rs = ps.executeQuery();
        
        int matchCount = 0;
        while(rs.next()) {
            matchCount++;
        }
        rs.beforeFirst(); // Reset the result set to beginning
        %>

        <div class="stats-container">
            <div class="stat-card">
                <div class="stat-value"><%= matchCount %></div>
                <div class="stat-label">Total Matches</div>
            </div>
            <div class="stat-card">
                <div class="stat-value"><%= matchCount %></div>
                <div class="stat-label">Available Now</div>
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
                            <th>Match ID</th>
                            <th class="d-none-mobile">Organizer</th>
                            <th class="d-none-mobile">Sport ID</th>
                            <th>Sport</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Players</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                    if (matchCount == 0) {
                    %>
                        <tr>
                            <td colspan="8">
                                <div class="empty-state">
                                    <i class="fas fa-calendar-times"></i>
                                    <h4>No Matches Available</h4>
                                    <p>There are no matches available at the moment.</p>
                                </div>
                            </td>
                        </tr>
                    <%
                    } else {
                        while(rs.next()) {
                    %>
                        <tr>
                            <td><strong>#<%= rs.getInt("mid") %></strong></td>
                            <td class="d-none-mobile"><%= rs.getInt("oid") %></td>
                            <td class="d-none-mobile"><%= rs.getInt("sid") %></td>
                            <td>
                                <span class="sport-badge"><%= rs.getString("sportName") %></span>
                            </td>
                            <td><%= rs.getString("date") %></td>
                            <td><%= rs.getString("time") %></td>
                            <td><%= rs.getInt("maxPlayers") %></td>
                            <td>
                                <form action="joinMatch" method="post">
                                    <input type="hidden" name="mid" value="<%= rs.getInt("mid") %>">
                                    <button type="submit" class="btn btn-join">
                                        <i class="fas fa-plus-circle me-1"></i> Join
                                    </button>
                                </form>
                            </td>
                        </tr>
                    <%
                        }
                    }
                    rs.close();
                    ps.close();
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
                PreparedStatement ps2 = con2.prepareStatement("SELECT * FROM matches");
                ResultSet rs2 = ps2.executeQuery();
                
                if (matchCount == 0) {
                %>
                    <div class="empty-state">
                        <i class="fas fa-calendar-times"></i>
                        <h4>No Matches Available</h4>
                        <p>There are no matches available at the moment.</p>
                    </div>
                <%
                } else {
                    while(rs2.next()) {
                %>
                    <div class="match-card">
                        <div class="match-header">
                            <div class="match-sport"><%= rs2.getString("sportName") %></div>
                            <div class="match-id">Match #<%= rs2.getInt("mid") %></div>
                        </div>
                        <div class="match-details">
                            <div class="detail-item">
                                <div class="detail-label">Date</div>
                                <div class="detail-value"><%= rs2.getString("date") %></div>
                            </div>
                            <div class="detail-item">
                                <div class="detail-label">Time</div>
                                <div class="detail-value"><%= rs2.getString("time") %></div>
                            </div>
                            <div class="detail-item">
                                <div class="detail-label">Max Players</div>
                                <div class="detail-value"><%= rs2.getInt("maxPlayers") %></div>
                            </div>
                            <div class="detail-item">
                                <div class="detail-label">Organizer</div>
                                <div class="detail-value"><%= rs2.getInt("oid") %></div>
                            </div>
                        </div>
                        <form action="joinMatch" method="post" class="text-center">
                            <input type="hidden" name="mid" value="<%= rs2.getInt("mid") %>">
                            <button type="submit" class="btn btn-join">
                                <i class="fas fa-plus-circle me-1"></i> Join This Match
                            </button>
                        </form>
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