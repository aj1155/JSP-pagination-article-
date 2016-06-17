<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, student1.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>lecture1</title>
<link href="http://maxcdn.bootstrapcdn.com/bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" media="screen">
<style>
    thead tr { background: #eee; }
    tbody tr:hover { background-color: #ffa; cursor: pointer; }
</style>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script>
    $(function() {
        $("tbody tr").click(function() {
            location.href = $(this).attr("data-url"); 

        });
    });
</script>
</head>
<% request.setCharacterEncoding("utf-8"); %>
<% 
    String s = request.getParameter("pg"); 
    int currentPage = (s == null) ? 1 : Integer.parseInt(s); 
    int pageSize = 10; 
    ArrayList<Student> list = StudentDAO.selectPage(currentPage, pageSize);
    int recordCount = StudentDAO.getRecordCount(); 
    int pageCount = (recordCount + pageSize - 1) / pageSize; 
    int basePage = ((currentPage - 1) / 10) * 10; 
%>
<body>

<div class="container">

    <h1>학생 목록</h1>
    <hr />

    <table class="table table-bordered">
        <thead>
            <tr>
                <th>ID</th>
                <th>studentNumber</th>
                <th>studentName</th>
                <th>departmentName</th>
                <th>year</th>
            </tr>
        </thead>
        <tbody>        
            <% for (Student student : list) { %>
 <tr data-url="studentEdit.jsp?id=<%= student.getId() %>&pg=<%= currentPage %>"> 

                    <td><%= student.getId() %></td>
                    <td><%= student.getStudentNumber() %></td>
                    <td><%= student.getStudentName() %></td>
                    <td><%= student.getDepartmentName() %></td>
                    <td><%= student.getYear() %></td>
                </tr>
            <% } %>
        </tbody>        
    </table>

    <div class="pull-right">
        <a href="studentCreate.jsp" class="btn">
            <i class="icon-plus"></i> 학생 추가
        </a>
    </div>
    
    <div class="pagination pagination-small pagination-centered">
        <ul>
            <% if (basePage > 0) { %>
                <li><a href="studentList.jsp?pg=<%= basePage %>">Prev</a></li>
            <% } %>
            <% for (int i=1; i <= 10 && basePage + i <= pageCount; ++i) { %>
                <li class='<%= basePage+i==currentPage ? "active" : "" %>'>
                    <a href="studentList.jsp?pg=<%= basePage+i %>"><%= basePage + i %></a>
                </li>
            <% } %>
            <% if (basePage + 11 <= pageCount) { %>
                <li><a href="studentList.jsp?pg=<%= basePage+11 %>">Next</a></li>
            <% } %>
        </ul>
    </div>
    
</div>

</body>
</html>
