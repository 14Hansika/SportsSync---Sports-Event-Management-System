<%@ page language="java" contentType="text/html; charset=ISO-8859-1" %>
<%@ page import="java.sql.*, connect_package.connectDB" %>
<%@ page import="connect_package.connectDB" %>
<%@ page import="connect_package.pojo" %> 

<html>
<head>
<title>Join Requests | SkillHub</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
    :root {
        --primary-color: #4361ee;
        --secondary-color: #3a0ca3;
        --accent-color: #4cc9f0;
        --success-color: #28a745;
        --danger-color: #dc3545;
        --warning-color: #ffc107;
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

    .container {
        max-width: 1200px;
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

    .requests-icon {
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

    .requests-icon i {
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

    .btn-accept {
        background: linear-gradient(to right, var(--success-color), #20c997);
        border: none;
        color: white;
        padding: 8px 20px;
        border-radius: 50px;
        font-weight: 500;
        transition: all 0.3s ease;
        box-shadow: 0 4px 10px rgba(40, 167, 69, 0.3);
    }

    .btn-accept:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 15px rgba(40, 167, 69, 0.4);
        color: white;
    }

    .btn-reject {
        background: linear-gradient(to right, var(--danger-color), #e52d5a);
        border: none;
        color: white;
        padding: 8px 20px;
        border-radius: 50px;
        font-weight: 500;
        transition: all 0.3s ease;
        box-shadow: 0 4px 10px rgba(220, 53, 69, 0.3);
    }

    .btn-reject:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 15px rgba(220, 53, 69, 0.4);
        color: white;
    }

    .action-buttons {
        display: flex;
        gap: 10px;
        justify-content: center;
        flex-wrap: wrap;
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

    .player-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-weight: 600;
        margin: 0 auto;
    }

    .sport-badge {
        background: linear-gradient(135deg, var(--accent-color), #560bad);
        color: white;
        padding: 6px 12px;
        border-radius: 50px;
        font-size: 0.85rem;
        font-weight: 500;
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
        
        .action-buttons {
            flex-direction: column;
            align-items: center;
        }
        
        .btn-accept, .btn-reject {
            width: 120px;
        }
    }
</style>
</head>
<body class="bg-light">

<div class="container mt-4">
    <div class="header-section">
        <div class="requests-icon">
            <i class="fas fa-user-clock"></i>
        </div>
        <h2>Pending Player Requests</h2>
        <p>Manage join requests from players for your matches</p>
    </div>

    <%
    int organizerId = pojo.getOid();
    Connection con = connectDB.getConnect();
    PreparedStatement ps = con.prepareStatement(
        "SELECT pm.id AS playerMatchId, p.pname, m.date AS match_date, s.sport " +
        "FROM playermatches pm " +
        "JOIN players p ON pm.pid = p.pid " +
        "JOIN matches m ON pm.mid = m.mid " +
        "JOIN sports s ON s.sid = m.sid " +
        "WHERE m.oid=? AND pm.status='Pending'"
    );

    ps.setInt(1, organizerId);
    ResultSet rs = ps.executeQuery();
    
    int requestCount = 0;
    while(rs.next()){
        requestCount++;
    }
    rs.beforeFirst(); // Reset the result set to beginning
    %>

    <div class="stats-container">
        <div class="stat-card">
            <div class="stat-value"><%= requestCount %></div>
            <div class="stat-label">Pending Requests</div>
        </div>
    </div>

    <div class="table-container">
        <table class="table table-hover align-middle">
            <thead>
                <tr>
                    <th>Player</th>
                    <th>Sport</th>
                    <th>Match Date</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <%
            if (requestCount == 0) {
            %>
                <tr>
                    <td colspan="4">
                        <div class="empty-state">
                            <i class="fas fa-inbox"></i>
                            <h4>No Pending Requests</h4>
                            <p>There are no pending join requests at the moment.</p>
                        </div>
                    </td>
                </tr>
            <%
            } else {
                while(rs.next()){
            %>
                <tr>
                    <td>
                        <div class="d-flex align-items-center justify-content-center">
                            <div class="player-avatar me-3">
                                <%= rs.getString("pname").substring(0, 1).toUpperCase() %>
                            </div>
                            <div class="text-start">
                                <strong><%= rs.getString("pname") %></strong>
                            </div>
                        </div>
                    </td>
                    <td>
                        <span class="sport-badge"><%= rs.getString("sport") %></span>
                    </td>
                    <td><%= rs.getString("match_date") %></td>
                    <td>
                        <form action="updateJoinStatus" method="post" class="mb-0">
                            <input type="hidden" name="playerMatchId" value="<%= rs.getInt("playerMatchId") %>">
                            <div class="action-buttons">
                                <button name="status" value="Accepted" class="btn btn-accept">
                                    <i class="fas fa-check me-1"></i> Accept
                                </button>
                                <button name="status" value="Rejected" class="btn btn-reject">
                                    <i class="fas fa-times me-1"></i> Reject
                                </button>
                            </div>
                        </form>
                    </td>
                </tr>
            <%
                }
            }
            %>
            </tbody>
        </table>
    </div>
</div>

<a href="OrganizerDashboard.html" class="go-back">
    <i class="fas fa-arrow-left"></i> Back to Dashboard
</a>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Add confirmation for reject action
    document.addEventListener('DOMContentLoaded', function() {
        const rejectButtons = document.querySelectorAll('.btn-reject');
        rejectButtons.forEach(button => {
            button.addEventListener('click', function(e) {
                if (!confirm('Are you sure you want to reject this request?')) {
                    e.preventDefault();
                }
            });
        });
    });
</script>
</body>
</html>