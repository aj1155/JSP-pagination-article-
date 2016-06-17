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
int id2;

if ("GET".equals(request.getMethod())) {
	String s = request.getParameter("id");
	int id = Integer.parseInt(s);
	id2 = Integer.parseInt(s);
    professor = ProfessorDAO.selectById(id);
}
if ("POST".equals(request.getMethod())) {
    professor = ProfessorService.makeProfessor(request);
    System.out.println(professor.getId());
    System.out.println(professor.getName());
    error = ProfessorService.validateBeforeUpdate(professor);
    System.out.println(error);
    id2 = professor.getId();
    if (error == null) {
        ProfessorDAO.update(professor);     
        response.sendRedirect("professorList.jsp");
        return;
    }
}
    List<Department> list = DepartmentDAO.selectAll();
%>
<body>

<div class="container">

<h1>사용자 정보 수정</h1>
<hr />

<form method="post">


    <div>교수번호</div>
    <input type="text" name="id" value="<%= professor.getId() %>" />

    <div>이름</div>
    <input type="text" name="name" value="<%= professor.getName() %>" />

    <div>학과</div>
    <select name="departmentId">
        <% for (Department department : list) { %>
            <% String selected = professor.getDepartmentId()==department.getId() ? "selected" : ""; %> 
            <option value="<%= department.getId() %>"  <%= selected %> >
                <%= department.getDepartmentName() %>
            </option>
        <% } %>
    </select>

    <hr />
    
    <div>
        <button type="submit" class="btn btn-primary">
            <i class="icon-hdd icon-white"></i> 저장
        </button>
        <a href="professorDeleteAction.jsp?id=<%= professor.getId() %>" class="btn" onclick="return confirm('삭제하시겠습니까?');">
            <i class="icon-remove"></i> 삭제
        </a>
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

