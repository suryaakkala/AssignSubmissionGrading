<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:choose>
    <c:when test="${!assignment.submitted}">
        <form action="/api/assignments/submit" method="post" enctype="multipart/form-data">
            <input type="hidden" name="assignmentId" value="${assignment.id}">
            <input type="hidden" name="studentId" value="${studentId}">
            <label for="file">Upload Assignment:</label>
            <input type="file" name="file" required>
            <button type="submit">Submit</button>
        </form>
    </c:when>
    <c:otherwise>
        <p>You have already submitted this assignment.</p>
        <c:if test="${assignment.grade != null}">
            <p>Your Grade: ${assignment.grade}</p>
        </c:if>
    </c:otherwise>
</c:choose>

</body>
</html>