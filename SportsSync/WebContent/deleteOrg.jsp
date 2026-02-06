<%@page import="java.sql.*" %>
<%@page import="connect_package.connectDB" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <title>Remove Players</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="background-color:#f8f9fa;">

<%
  try {
    String oid = request.getParameter("oid");
    Connection con = connectDB.getConnect();
    PreparedStatement ps = con.prepareStatement("delete from organizer where oid=?");
    ps.setString(1, oid);
    int i = ps.executeUpdate();
    if(i > 0){
      response.sendRedirect("viewOrganizers.jsp");
    } else {
      response.sendRedirect("error.html");
    }
  } catch(Exception e) {
    // You can optionally log the error if needed
  }
%>

<!-- In case user hits this page directly without parameters -->
<div class="container mt-5 text-center">
  <div class="alert alert-warning" role="alert">
    <h4 class="alert-heading">Removing Officer...</h4>
    <p>If you're seeing this, the request may not have been triggered correctly.</p>
    <hr>
    <p class="mb-0">Please return to the <a href="viewOrganizers.jsp" class="alert-link">Organizers Page</a>.</p>
  </div>
</div>

<!-- Bootstrap JS Bundle (optional) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
