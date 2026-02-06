<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="connect_package.connectDB" %>
<%@ page import="java.sql.*" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SkillHub | View Feedback</title>

<!-- ✅ Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- ✅ Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<!-- ✅ Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
    :root {
        --primary-color: #4361ee;
        --secondary-color: #3a0ca3;
        --accent-color: #4cc9f0;
        --success-color: #4bb543;
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

    .feedback-icon {
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

    .feedback-icon i {
        font-size: 2rem;
        color: white;
    }

    .table-container {
        max-width: 95%;
        margin: 0 auto;
        background: #fff;
        border-radius: 16px;
        box-shadow: var(--card-shadow);
        padding: 30px;
        position: relative;
        overflow: hidden;
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

    .rating-stars {
        color: var(--warning-color);
        font-size: 1.1rem;
    }

    .comments-cell {
        max-width: 300px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .comments-cell:hover {
        overflow: visible;
        white-space: normal;
        background-color: white;
        z-index: 10;
        position: relative;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }

    .go-back {
        display: flex;
        align-items: center;
        justify-content: center;
        width: fit-content;
        margin: 40px auto;
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

    /* Responsive adjustments */
    @media (max-width: 768px) {
        .table-container {
            max-width: 100%;
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
</style>
</head>

<body>

<div class="header-section">
    <div class="feedback-icon">
        <i class="fas fa-comment-dots"></i>
    </div>
    <h2>Customer Feedback</h2>
    <p>Review all feedback and ratings from your users</p>
</div>

<div class="stats-container">
    <div class="stat-card">
        <div class="stat-value" id="totalFeedback">0</div>
        <div class="stat-label">Total Feedback</div>
    </div>
    <div class="stat-card">
        <div class="stat-value" id="avgRating">0.0</div>
        <div class="stat-label">Average Rating</div>
    </div>
    <div class="stat-card">
        <div class="stat-value" id="recentFeedback">0</div>
        <div class="stat-label">This Month</div>
    </div>
</div>

<div class="table-container">
  <table class="table table-hover align-middle">
    <thead>
      <tr>
        <th>ID</th>
        <th>NAME</th>
        <th>RATING</th>
        <th>COMMENTS</th>
        <th>DATE</th>
      </tr>
    </thead>
    <tbody id="feedbackTableBody">
    <%
      int feedbackCount = 0;
      double totalRating = 0;
      int recentCount = 0;
      java.util.Calendar cal = java.util.Calendar.getInstance();
      int currentMonth = cal.get(java.util.Calendar.MONTH) + 1; // Months are 0-based
      int currentYear = cal.get(java.util.Calendar.YEAR);
      
      try {
        Connection con = connectDB.getConnect();
        PreparedStatement ps = con.prepareStatement("SELECT * FROM feedback");
        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
          feedbackCount++;
          String rating = rs.getString(3);
          if (rating != null && !rating.isEmpty()) {
            try {
              totalRating += Double.parseDouble(rating);
            } catch (NumberFormatException e) {
              // Skip if rating is not a valid number
            }
          }
          
          // Check if feedback is from current month
          String dateStr = rs.getString(5);
          if (dateStr != null && !dateStr.isEmpty()) {
            try {
              String[] dateParts = dateStr.split("-");
              if (dateParts.length >= 2) {
                int feedbackMonth = Integer.parseInt(dateParts[1]);
                int feedbackYear = Integer.parseInt(dateParts[0]);
                if (feedbackMonth == currentMonth && feedbackYear == currentYear) {
                  recentCount++;
                }
              }
            } catch (NumberFormatException e) {
              // Skip if date parsing fails
            }
          }
    %>
      <tr>
        <td><%= rs.getString(1) %></td>
        <td><%= rs.getString(2) %></td>
        <td>
          <div class="rating-stars">
            <% 
              int ratingValue = 0;
              try {
                ratingValue = Integer.parseInt(rs.getString(3));
              } catch (NumberFormatException e) {
                ratingValue = 0;
              }
              for (int i = 1; i <= 5; i++) {
                if (i <= ratingValue) {
            %>
              <i class="fas fa-star"></i>
            <% } else { %>
              <i class="far fa-star"></i>
            <% }} %>
            <span class="ms-1">(<%= ratingValue %>)</span>
          </div>
        </td>
        <td class="comments-cell"><%= rs.getString(4) != null ? rs.getString(4) : "No comments" %></td>
        <td><%= rs.getString(5) %></td>
      </tr>
    <%
        }
        con.close();
      } catch(Exception e) {
        e.printStackTrace();
      }
    %>
    </tbody>
  </table>
  
  <% if (feedbackCount == 0) { %>
    <div class="empty-state">
      <i class="far fa-folder-open"></i>
      <h4>No Feedback Yet</h4>
      <p>There is no feedback to display at the moment.</p>
    </div>
  <% } %>
</div>

<a href="OrganizerDashboard.html" class="go-back">
  <i class="fas fa-arrow-left"></i> Back to Dashboard
</a>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
  // Update stats with animation
  document.addEventListener('DOMContentLoaded', function() {
    // Get values from server-side variables
    const totalFeedback = <%= feedbackCount %>;
    const avgRating = <%= feedbackCount > 0 ? totalRating / feedbackCount : 0 %>;
    const recentFeedback = <%= recentCount %>;
    
    // Animate counting up
    animateValue('totalFeedback', 0, totalFeedback, 1000);
    animateValue('recentFeedback', 0, recentFeedback, 1000);
    
    // Format average rating to one decimal place
    const formattedAvg = avgRating.toFixed(1);
    animateValue('avgRating', 0, parseFloat(formattedAvg), 1000);
  });
  
  function animateValue(id, start, end, duration) {
    const obj = document.getElementById(id);
    let startTimestamp = null;
    const step = (timestamp) => {
      if (!startTimestamp) startTimestamp = timestamp;
      const progress = Math.min((timestamp - startTimestamp) / duration, 1);
      const value = Math.floor(progress * (end - start) + start);
      
      if (id === 'avgRating') {
        obj.innerHTML = value.toFixed(1);
      } else {
        obj.innerHTML = value;
      }
      
      if (progress < 1) {
        window.requestAnimationFrame(step);
      }
    };
    window.requestAnimationFrame(step);
  }
</script>
</body>
</html>