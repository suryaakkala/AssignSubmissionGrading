<%@page import="com.klef.jfsd.springboot.model.Faculty"%>
<%@page import="com.klef.jfsd.springboot.model.Assignment"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Faculty f = (Faculty) session.getAttribute("faculty");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Faculty Home</title>
<!-- Link to the external CSS file -->
<link rel="stylesheet" href="style/facultynav.css">
<style type="text/css">
/* Styles adapted for professional alignment */
.card {	
  position: relative;
  border-radius: 10px;
  width: 300px; /* Increased card width for better visibility */
  height: 350px; /* Adjusted card height */
  background-color: whitesmoke;
  -webkit-box-shadow: 1px 1px 12px #000;
  box-shadow: 1px 1px 12px #000;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: center;
  color: #000;
  padding: 20px; /* Added padding for better spacing */
  margin: 10px;
  overflow: hidden;
}

.card h3, .card p {
  text-align: center;
  margin: 10px 0;
  word-wrap: break-word; /* Wrap text to prevent overflow */
}

.grading-cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); /* Responsive grid layout */
  gap: 30px; /* Add spacing between cards */
  max-width: 1000px; /* Restrict container width */
  margin: 20px auto; /* Center content */
  padding: 20px; /* Add padding around the grid */
}

form {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 10px;
  width: 100%; /* Ensure form spans the width of the card */
}

button {
  background-color: #4CAF50;
  color: white;
  border: none;
  padding: 10px 15px;
  cursor: pointer;
  border-radius: 5px;
  font-size: 14px;
  font-weight: bold;
}

button:hover {
  background-color: #45a049;
}

input[type="number"], input[type="hidden"] {
  width: 90%; /* Adjust input width */
  padding: 8px;
  margin: 5px;
  border: 1px solid #ccc;
  border-radius: 4px;
}

label {
  font-size: 14px;
  font-weight: bold;
}
</style>

</head>
<body>
<%@include file="facultynav.jsp" %><br/><br/>
Welcome <%=f.getName()%>

<div class="grading-cards">
    <% 
    List<Assignment> assignments = (List<Assignment>) request.getAttribute("assignments");
    if (assignments != null && !assignments.isEmpty()) {
        for (Assignment assignment : assignments) {
            if (assignment.getSubmitted() && assignment.getGrade() == null) {
    %>
                <div class="card">
                    <h3><%= assignment.getSubject() %></h3>
                    <p><%= assignment.getAssignmentName() %></p>
                    <p>Submission Status: Submitted</p>
                    <form action="/api/assignments/grade" method="post">
                        <input type="hidden" name="assignmentId" value="<%= assignment.getId() %>">
                        <label for="grade">Grade:</label>
                        <input type="number" name="grade" min="0" max="100" required>
                        <button type="submit">Submit Grade</button>
                    </form>
                </div>
    <% 
            }
        }
    } else { 
    %>
        <p>No assignments to grade.</p>
    <% 
    } 
    %>
</div>

</body>
</html>
