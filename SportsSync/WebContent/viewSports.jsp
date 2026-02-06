<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="connect_package.connectDB" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>View Sports | SportsSync</title>
<!-- Bootstrap 5 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
    :root {
        --primary: #6366f1;
        --primary-dark: #4f46e5;
        --secondary: #10b981;
        --accent: #f59e0b;
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
        max-width: 1200px;
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

    .sports-table {
        width: 100%;
        border-collapse: collapse;
        margin: 0;
        color: var(--light);
    }

    .sports-table thead {
        background: linear-gradient(45deg, var(--primary), var(--primary-dark));
    }

    .sports-table th {
        padding: 20px 25px;
        text-align: left;
        font-weight: 600;
        font-size: 1.1rem;
        text-transform: uppercase;
        letter-spacing: 0.05em;
        border: none;
        position: relative;
        overflow: hidden;
    }

    .sports-table th::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 100%;
        height: 2px;
        background: linear-gradient(45deg, var(--accent), transparent);
    }

    .sports-table tbody tr {
        background: rgba(255, 255, 255, 0.05);
        transition: all 0.3s ease;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    .sports-table tbody tr:nth-child(even) {
        background: rgba(255, 255, 255, 0.08);
    }

    .sports-table tbody tr:hover {
        background: rgba(99, 102, 241, 0.2);
        transform: translateX(5px);
        box-shadow: 0 5px 15px rgba(99, 102, 241, 0.3);
    }

    .sports-table td {
        padding: 18px 25px;
        border: none;
        font-weight: 500;
        position: relative;
    }

    .sports-table tbody tr:hover td {
        color: var(--light);
    }

    .sports-table tbody tr:hover td:first-child::before {
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
        }
        
        .sports-table th,
        .sports-table td {
            padding: 12px 15px;
            font-size: 0.9rem;
        }
        
        .stats-bar {
            grid-template-columns: 1fr;
        }
    }

    @media (max-width: 480px) {
        .header h1 {
            font-size: 1.8rem;
        }
        
        .sports-table {
            font-size: 0.8rem;
        }
        
        .sports-table th,
        .sports-table td {
            padding: 10px 12px;
        }
    }
</style>
</head>
<body>

<div class="container">
    <div class="header">
        <h1><i class="fas fa-trophy me-3"></i>Sports Catalog</h1>
        <p>Manage and view all available sports in your system</p>
    </div>

    <div class="stats-bar">
        <div class="stat-card">
            <i class="fas fa-list-alt fa-2x text-primary"></i>
            <div class="stat-number" id="sportsCount">0</div>
            <div class="stat-label">Total Sports</div>
        </div>
        <div class="stat-card">
            <i class="fas fa-home fa-2x text-secondary"></i>
            <div class="stat-number" id="indoorCount">0</div>
            <div class="stat-label">Indoor Sports</div>
        </div>
        <div class="stat-card">
            <i class="fas fa-tree fa-2x text-accent"></i>
            <div class="stat-number" id="outdoorCount">0</div>
            <div class="stat-label">Outdoor Sports</div>
        </div>
    </div>

    <div class="table-container">
        <table class="sports-table">
            <thead>
                <tr>
                    <th><i class="fas fa-hashtag me-2"></i>Sports ID</th>
                    <th><i class="fas fa-baseball-ball me-2"></i>Sports Name</th>
                </tr>
            </thead>
            <tbody>
            <%
                int count = 0;
                try {
                    Connection con = connectDB.getConnect();
                    PreparedStatement ps = con.prepareStatement("select * from sports");
                    ResultSet rs = ps.executeQuery();
                    while(rs.next()) {
                        count++;
            %>
                <tr>
                    <td><span class="badge bg-primary rounded-pill">#<%= rs.getInt(1) %></span></td>
                    <td><i class="fas fa-basketball-ball me-2 text-warning"></i><%= rs.getString(2) %></td>
                </tr>
            <%
                    }
                } catch(Exception e) {
                    e.printStackTrace();
                }
                
                if(count == 0) {
            %>
                <tr>
                    <td colspan="2">
                        <div class="empty-state">
                            <i class="fas fa-inbox"></i>
                            <h4>No Sports Found</h4>
                            <p>Get started by adding your first sport to the system</p>
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
    // Update sports count
    document.getElementById('sportsCount').textContent = '<%= count %>';
    
    // For demo purposes - in real application, these would come from the database
    document.getElementById('indoorCount').textContent = Math.floor(<%= count %> * 0.6);
    document.getElementById('outdoorCount').textContent = Math.floor(<%= count %> * 0.4);
</script>

</body>
</html>