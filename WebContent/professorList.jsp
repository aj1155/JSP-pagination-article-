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
            location.href = "professorEdit.jsp?id=" + $(this).attr("data-id");
        });
    });
</script>
</head>
<% 
    String s = request.getParameter("pg"); 
    int currentPage = (s == null) ? 1 : Integer.parseInt(s); 
    int pageSize = 10; 
    ArrayList<Professor> list = ProfessorDAO.selectPage(currentPage, pageSize);
    int recordCount = ProfessorDAO.getRecordCount(); 
    int pageCount = (recordCount + pageSize - 1) / pageSize; 
    int basePage = ((currentPage - 1) / 10) * 10; 
%>
<body>

<div class="container">

    <h1>교수 목록</h1>
    <hr />

    <table class="table table-bordered">
        <thead>
            <tr>
                <th>ID</th>
                <th>professorNamer</th>
                <th>departmentName</th>
               
            </tr>
        </thead>
        <tbody>        
            <% for (Professor professor : list) { %>
                <tr data-id="<%= professor.getId() %>">
                    <td><%= professor.getId() %></td>
                    <td><%= professor.getName() %></td>
                    <td><%= professor.getDepartmentName() %></td>
                    
                </tr>
            <% } %>
        </tbody>        
    </table>

    <div class="pull-right">
        <a href="professorCreate.jsp" class="btn">
            <i class="icon-plus"></i> 교수 추가
        </a>
    </div>
    
    <div class="pagination pagination-small pagination-centered">
        <ul>
            <% if (basePage > 0) { %>
                <li><a href="professorList.jsp?pg=<%= basePage %>">Prev</a></li>
            <% } %>
            <% for (int i=1; i <= 10 && basePage + i <= pageCount; ++i) { %>
                <li class='<%= basePage+i==currentPage ? "active" : "" %>'>
                    <a href="professorList.jsp?pg=<%= basePage+i %>"><%= basePage + i %></a>
                </li>
            <% } %>
            <% if (basePage + 11 <= pageCount) { %>
                <li><a href="professorList.jsp?pg=<%= basePage+11 %>">Next</a></li>
            <% } %>
        </ul>
    </div>
    
</div>

</body>
</html>
