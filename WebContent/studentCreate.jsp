<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import=" java.util.*, student1.*" %>
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
    Student student = null;
    
    if ("GET".equals(request.getMethod())) {
        student = StudentService.makeStudent();
    }
    if ("POST".equals(request.getMethod())) {
        student = StudentService.makeStudent(request);
        error = StudentService.validateBeforeInsert(student);
        if (error == null) {
            StudentDAO.insert(student);     
            response.sendRedirect("studentList.jsp");
            return;
        }
    }
    List<Department> list = DepartmentDAO.selectAll(); 
%>
<body>

<div class="container">

<h1>학생 생성</h1>
<hr />

<form method="post">
    <div>학번</div>
    <input type="text" name="studentNumber" value="<%= student.getStudentNumber() %>" />

    <div>이름</div>
    <input type="text" name="studentName" value="<%= student.getStudentName() %>" />

    <div>학과</div>
    <select name="departmentId">
        <% for (Department department : list) { %>
            <% String selected = student.getDepartmentId()==department.getId() ? "selected" : ""; %> 
            <option value="<%= department.getId() %>"  <%= selected %> >
                <%= department.getDepartmentName() %>
            </option>
        <% } %>
    </select>

    <div>학년</div>
    <input type="text" name="year" value="<%= student.getYear() %>" />

    <hr />
    
    <div>
        <button type="submit" class="btn btn-primary">
            <i class="icon-hdd icon-white"></i> 저장
        </button>
        <a href="studentList.jsp" class="btn">
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
