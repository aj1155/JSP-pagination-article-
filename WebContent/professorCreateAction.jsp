<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="student1.*" %>
<%  
    request.setCharacterEncoding("UTF-8");
    String id = request.getParameter("id");
    String professorName = request.getParameter("professorName");
    String s = request.getParameter("departmentId");
    int departmentId = Integer.parseInt(s);

    int i = Integer.parseInt(id);
    
    ProfessorDAO.insert(i, professorName, departmentId);     
    response.sendRedirect("professorList.jsp");
%>
