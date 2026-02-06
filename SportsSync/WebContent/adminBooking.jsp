<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="connect_package.connectDB" %>
<%@ page import="java.sql.*" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SkillHub | View Feedback</title>

<!-- ✅ Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- ✅ Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!-- ✅ Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
    :root {
        --primary: #6366f1;
        --primary-dark: #4f46e5;
        --secondary: #10b981;
        --accent: #f59e0b;
        --success: #22c55e;
        --warning: #eab308;
        --dark: #1e1b4b;
        --light: #f8fafc;
        --gray: #64748b;
    }

    body {
        font-family: 'Poppins', sans-serif;
        background: linear-gradient(135deg, #0f172a 0%, #1e1b4b 100%);
        margin: 0;
        padding: 0;
        min-height: 100vh;
        color: var(--light);
    }

    .container {
        max-width: 1400px;
        margin: 0 auto;
        padding: 40px 20px;
    }

    .header {
        text-align: center;
        margin-bottom: 50px;
        position: relative;
    }

    .header h1 {
        font-weight: 700;
        font-size: 3rem;
        background: linear-gradient(45deg, var(--accent), var(--primary));
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        margin-bottom: 15px;
    }

    .header p {
        color: var(--gray);
        font-size: 1.1rem;
        max-width: 600px;
        margin: 0 auto;
    }

    .table-container {
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(20px);
        border-radius: 20px;
        padding: 30px;
        box-shadow: 0 25px 50px rgba(0, 0, 0, 0.3);
        border: 1px solid rgba(255, 255, 255, 0.1);
        overflow: hidden;
        position: relative;
    }

    .table-container::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 5px;
        background: linear-gradient(45deg, var(--primary), var(--accent));
    }

    .feedback-table {
        width: 100%;
        border-collapse: collapse;
        margin: 0;
        color: var(--light);
    }

    .feedback-table thead {
        background: linear-gradient(45deg, var(--primary), var(--primary-dark));
    }

    .feedback-table th {
        padding: 20px 15px;
        text-align: center;
        font-weight: 600;
        font-size: 1rem;
        text-transform: uppercase;
        letter-spacing: 0.05em;
        border: none;
        position: relative;
        overflow: hidden;
    }

    .feedback-table th::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 100%;
        height: 2px;
        background: linear-gradient(45deg, var(--accent), transparent);
    }

    .feedback-table tbody tr {
        background: rgba(255, 255, 255, 0.05);
        transition: all 0.3s ease;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    .feedback-table tbody tr:nth-child(even) {
        background: rgba(255, 255, 255, 0.08);
    }

    .feedback-table tbody tr:hover {
        background: rgba(99, 102, 241, 0.2);
        transform: translateX(5px);
        box-shadow: 0 5px 15px rgba(99, 102, 241, 0.3);
    }

    .feedback-table td {
        padding: 16px 15px;
        border: none;
        font-weight: 500;
        position: relative;
        vertical-align: middle;
        text-align: center;
    }

    .feedback-table tbody tr:hover td:first-child::before {
        content: '';
        position: absolute;
        left: 0;
        top: 0;
        height: 100%;
        width: 4px;
        background: linear-gradient(45deg, var(--accent), var(--primary));
    }

    .btn-back {
        display: inline-flex;
        align-items: center;
        gap: 10px;
        background: linear-gradient(45deg, var(--primary), var(--primary-dark));
        color: white;
        text-decoration: none;
        padding: 14px 30px;
        border-radius: 15px;
        font-weight: 600;
        transition: all 0.3s ease;
        box-shadow: 0 8px 25px rgba(99, 102, 241, 0.3);
        border: none;
        margin-top: 40px;
    }

    .btn-back:hover {
        transform: translateY(-3px);
        box-shadow: 0 12px 30px rgba(99, 102, 241, 0.5);
        color: white;
    }

    .stats-bar {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 20px;
        margin-bottom: 40px;
    }

    .stat-card {
        background: linear-gradient(135deg, rgba(99, 102, 241, 0.1) 0%, rgba(245, 158, 11, 0.1) 100%);
        border: 1px solid rgba(255, 255, 255, 0.1);
        padding: 25px;
        border-radius: 15px;
        text-align: center;
        backdrop-filter: blur(10px);
        transition: all 0.3s ease;
    }

    .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 30px rgba(99, 102, 241, 0.2);
    }

    .stat-number {
        font-size: 2.5rem;
        font-weight: 800;
        background: linear-gradient(45deg, var(--accent), var(--primary));
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        margin: 10px 0;
    }

    .stat-label {
        color: var(--gray);
        font-weight: 500;
        font-size: 1rem;
    }

    .empty-state {
        text-align: center;
        padding: 60px 20px;
        color: var(--gray);
    }

    .empty-state i {
        font-size: 4rem;
        margin-bottom: 20px;
        opacity: 0.5;
    }

    .status-badge {
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .status-completed {
        background: linear-gradient(45deg, var(--success), #16a34a);
        color: white;
    }

    .status-pending {
        background: linear-gradient(45deg, var(--warning), #ca8a04);
        color: white;
    }

    .status-cancelled {
        background: linear-gradient(45deg, #ef4444, #dc2626);
        color: white;
    }

    .date-badge {
        background: rgba(245, 158, 11, 0.2);
        color: var(--accent);
        padding: 6px 12px;
        border-radius: 15px;
        font-weight: 600;
        font-size: 0.85rem;
        border: 1px solid rgba(245, 158, 11, 0.3);
    }

    .id-badge {
        background: linear-gradient(45deg, var(--primary), var(--primary-dark));
        color: white;
        padding: 6px 12px;
        border-radius: 15px;
        font-weight: 700;
        font-size: 0.85rem;
    }

    @media (max-width: 768px) {
        .container {
            padding: 20px 15px;
        }
        
        .header h1 {
            font-size: 2.2rem;
        }
        
        .table-container {
            padding: 20px 15px;
            border-radius: 15px;
            overflow-x: auto;
        }
        
        .feedback-table {
            min-width: 800px;
        }
        
        .feedback-table th,
        .feedback-table td {
            padding: 12px 10px;
            font-size: 0.85rem;
        }
        
        .stats-bar {
            grid-template-columns: 1fr;
        }
    }

    @media (max-width: 480px) {
        .header h1 {
            font-size: 1.8rem;
        }
    }
</style>
</head>

<body>

<div class="container">
    <div class="header">
        <h1><i class="fas fa-comments me-3"></i>Booking</h1>
        
    </div>

    <div class="stats-bar">
        <div class="stat-card">
            <i class="fas fa-list-alt fa-2x text-primary"></i>
            <div class="stat-number" id="totalMatches">0</div>
            <div class="stat-label">Total Matches</div>
        </div>
        <div class="stat-card">
            <i class="fas fa-check-circle fa-2x text-success"></i>
            <div class="stat-number" id="completedMatches">0</div>
            <div class="stat-label">Completed</div>
        </div>
        <div class="stat-card">
            <i class="fas fa-clock fa-2x text-warning"></i>
            <div class="stat-number" id="pendingMatches">0</div>
            <div class="stat-label">Pending</div>
        </div>
    </div>

    <div class="table-container">
        <table class="feedback-table">
            <thead>
                <tr>
                    <th><i class="fas fa-hashtag me-2"></i>ID</th>
                    <th><i class="fas fa-users me-2"></i>Match ID</th>
                    <th><i class="fas fa-user me-2"></i>Player ID</th>
                    <th><i class="fas fa-calendar me-2"></i>Date</th>
                    <th><i class="fas fa-flag me-2"></i>Status</th>
                </tr>
            </thead>
            <tbody>
            <%
                int count = 0;
                int completedCount = 0;
                int pendingCount = 0;
                try {
                    Connection con = connectDB.getConnect();
                    PreparedStatement ps = con.prepareStatement("SELECT * FROM playermatches");
                    ResultSet rs = ps.executeQuery();
                    while(rs.next()) {
                        count++;
                        String status = rs.getString(5);
                        if("Completed".equalsIgnoreCase(status)) {
                            completedCount++;
                        } else if("Pending".equalsIgnoreCase(status)) {
                            pendingCount++;
                        }
            %>
                <tr>
                    <td><span class="id-badge">#<%= rs.getString(1) %></span></td>
                    <td><span class="badge bg-secondary rounded-pill">M-<%= rs.getString(2) %></span></td>
                    <td><span class="badge bg-info rounded-pill">P-<%= rs.getString(3) %></span></td>
                    <td><span class="date-badge"><i class="fas fa-calendar-day me-1"></i><%= rs.getString(4) %></span></td>
                    <td>
                        <%
                            String statusClass = "status-pending";
                            if("Completed".equalsIgnoreCase(status)) {
                                statusClass = "status-completed";
                            } else if("Cancelled".equalsIgnoreCase(status)) {
                                statusClass = "status-cancelled";
                            }
                        %>
                        <span class="status-badge <%= statusClass %>">
                            <i class="fas fa-circle me-1" style="font-size: 6px;"></i>
                            <%= status %>
                        </span>
                    </td>
                </tr>
            <%
                    }
                    con.close();
                } catch(Exception e) {
                    e.printStackTrace();
                }
                
                if(count == 0) {
            %>
                <tr>
                    <td colspan="5">
                        <div class="empty-state">
                            <i class="fas fa-inbox"></i>
                            <h4>No Match Records Found</h4>
                            <p>No player matches have been recorded yet</p>
                        </div>
                    </td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

    <div class="text-center">
        <a href="AdminDashboard.html" class="btn-back">
            <i class="fas fa-arrow-left"></i>
            Back to Dashboard
        </a>
    </div>
</div>

<script>
    // Update match counts
    document.getElementById('totalMatches').textContent = '<%= count %>';
    document.getElementById('completedMatches').textContent = '<%= completedCount %>';
    document.getElementById('pendingMatches').textContent = '<%= pendingCount %>';
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>