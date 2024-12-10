<%@page import="com.klef.jfsd.springboot.model.Student"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c" %>
<%@page import="com.klef.jfsd.springboot.model.Assignment"%>
<%@page import="java.util.List"%>
<%
Student s = (Student) session.getAttribute("student");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Home</title>
<!-- Link to the external CSS file -->
<link rel="stylesheet" href="style/studentnav.css">
<style type="text/css">
/* Donor CSS styles */
.book {
  position: relative;
  border-radius: 10px;
  width: 220px;
  height: 300px;
  background-color: whitesmoke;
  -webkit-box-shadow: 1px 1px 12px #000;
  box-shadow: 1px 1px 12px #000;
  -webkit-transform: preserve-3d;
  -ms-transform: preserve-3d;
  transform: preserve-3d;
  -webkit-perspective: 2000px;
  perspective: 2000px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #000;
  margin: 15px;
  overflow: hidden; /* Prevent overflow */
}

.cover {
  top: 0;
  position: absolute;
  background-color: lightgray;
  width: 100%;
  height: 100%;
  border-radius: 10px;
  cursor: pointer;
  -webkit-transition: all 0.5s;
  transition: all 0.5s;
  -webkit-transform-origin: 0;
  -ms-transform-origin: 0;
  transform-origin: 0;
  -webkit-box-shadow: 1px 1px 12px #000;
  box-shadow: 1px 1px 12px #000;
  display: flex;
  align-items: center;
  justify-content: center;
}

.book:hover .cover {
  -webkit-transition: all 0.5s;
  transition: all 0.5s;
  -webkit-transform: rotatey(-80deg);
  -ms-transform: rotatey(-80deg);
  transform: rotatey(-80deg);
}

p {
  font-size: 16px;
  font-weight: bolder;
  text-align: center;
  word-wrap: break-word; /* Wrap text to prevent overflow */
}

.assignment-cards {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
  gap: 20px; /* Add spacing between rows */
  max-width: 1000px;
  margin: 0 auto; /* Center content */
}
</style>



</head>
<body>
<%@include file="studentnavbar.jsp" %><br/><br/>
Welcome <%=s.getName()%>
<div class="assignment-cards">
    <% 
    List<Assignment> assignments = (List<Assignment>) request.getAttribute("assignments");
    if (assignments != null && !assignments.isEmpty()) {
        for (Assignment assignment : assignments) {
    %>
            <div class="book">
                <h3><%= assignment.getSubject() %></h3>
                <div class="cover">
                    <p><%= assignment.getAssignmentName() %></p>
                </div>
                <p>Submission Status: <%= assignment.getSubmitted() ? "Submitted" : "Not Submitted" %></p>
                <% if (!assignment.getSubmitted()) { %>
                    <form action="/api/assignments/submit" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="assignmentId" value="<%= assignment.getId() %>">
                        <input type="hidden" name="studentId" value="1">
                        <label for="file">Upload File:</label>
                        <input type="file" name="file" required>
                        <button type="submit">Submit Assignment</button>
                    </form>
                <% } %>
                <% if (assignment.getSubmitted() && assignment.getGrade() != null) { %>
                    <p>Grade: <%= assignment.getGrade() %></p>
                <% } %>
            </div>
    <% 
        }
    } else { 
    %>
        <p>No assignments available.</p>
    <% 
    } 
    %>
</div>


<div id="assignmentModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <div id="modal-body">
            <!-- Assignment details will load dynamically -->
        </div>
    </div>
</div>

<script type="text/javascript">
function viewAssignment(assignmentId, status) {
    const modalBody = document.getElementById("modal-body");
    if (status === "Not Submitted") {
        modalBody.innerHTML = `
            <form action="/api/assignments/submit" method="post" enctype="multipart/form-data">
                <input type="hidden" name="assignmentId" value="${assignmentId}">
                <input type="hidden" name="studentId" value="1">
                <label for="file">Upload Assignment:</label>
                <input type="file" name="file" required>
                <button type="submit">Submit</button>
            </form>
        `;
    } else {
        modalBody.innerHTML = `
            <form action="/api/assignments/submit" method="post" enctype="multipart/form-data">
                <input type="hidden" name="assignmentId" value="${assignmentId}">
                <input type="hidden" name="studentId" value="1">
                <label for="file">Update Assignment:</label>
                <input type="file" name="file" required>
                <button type="submit">Update Submission</button>
            </form>
        `;
    }
    document.getElementById("assignmentModal").style.display = "block";
}

function closeModal() {
    document.getElementById("assignmentModal").style.display = "none";
}

</script>
</body>
</html>
