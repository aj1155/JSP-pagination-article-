<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, student1.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>lecture1</title>
<link href="http://maxcdn.bootstrapcdn.com/bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" media="screen">
<style>
    form > div { margin-top: 20px; }
</style>
</head>
<%


String error = null;
Professor professor = null;

if ("GET".equals(request.getMethod())) {
    professor = ProfessorService.makeProfessor();
}
if ("POST".equals(request.getMethod())) {
    professor = ProfessorService.makeProfessor(request);
    error = ProfessorService.validateBeforeInsert(professor);
    if (error == null) {
        ProfessorDAO.insert(professor);     
        response.sendRedirect("professorList.jsp");
        return;
    }
}
List<Department> list = DepartmentDAO.selectAll(); 

    
%>
<body>

<div class="container">

<h1>교수 생성</h1>
<hr />

<form method="post">
    <div>교수번호</div>
    <input type="text" name="id" value="<%=professor.getId()%>"/>

    <div>이름</div>
    <input type="text" name="professorName" value="<%=professor.getName()%>"/>

    <div>학과</div>
    <select name="departmentId">
        <% for (Department department : list) { %>
        <% String selected = professor.getId()==department.getId() ? "selected" : ""; %> 
            <option value="<%= department.getId() %>" <%=selected %>>
                <%= department.getDepartmentName() %>
            </option>
        <% } %>
    </select>

   

    <hr />
    
    <div>
        <button type="submit" class="btn btn-primary">
            <i class="icon-hdd icon-white"></i> 저장
        </button>
        <a href="professorList.jsp" class="btn">
            <i class="icon-list"></i> 목록으로
        </a>
    </div>
</form>
<% if (error != null) { %>
    <div class="alert alert-error"><%= error %></div>
<% } %>

</div>
</body>
</html>
