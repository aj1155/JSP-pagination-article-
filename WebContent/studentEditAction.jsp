<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="student1.*" %>
<%  
    request.setCharacterEncoding("UTF-8");
    String studentNumber = request.getParameter("studentNumber");
    String s = request.getParameter("id");
    int id = Integer.parseInt(s);
    String studentName = request.getParameter("studentName");
    s = request.getParameter("departmentId");
    int departmentId = Integer.parseInt(s);
    s = request.getParameter("year");
    int year = Integer.parseInt(s);
    
    StudentDAO.update(id, studentNumber, studentName, departmentId, year);    
    response.sendRedirect("studentList.jsp");
%>
