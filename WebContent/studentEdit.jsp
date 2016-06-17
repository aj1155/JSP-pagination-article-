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
<% request.setCharacterEncoding("utf-8"); %>
<%  
    String error = null;
    Student student = null;
    String pg = request.getParameter("pg"); 


    if ("GET".equals(request.getMethod())) {
        String s = request.getParameter("id");
        int id = Integer.parseInt(s);
        student = StudentDAO.selectById(id);
    }
    if ("POST".equals(request.getMethod())) {
        student = StudentService.makeStudent(request);
        error = StudentService.validateBeforeUpdate(student);
        if (error == null) {        
            StudentDAO.update(student);
            response.sendRedirect("studentList.jsp?pg=" + pg); 

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
        <a href="studentDeleteAction.jsp?id=<%= student.getId() %>&pg=<%=pg %>" class="btn" onclick="return confirm('삭제하시겠습니까?');">
            <i class="icon-remove"></i> 삭제
        </a>
               <a href="studentList.jsp?pg=<%= pg %>" class="btn"> 

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
