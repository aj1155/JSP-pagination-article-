<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="student1.*" %>
<%  
    request.setCharacterEncoding("UTF-8");
    String studentNumber = request.getParameter("studentNumber");
    String studentName = request.getParameter("studentName");
    String s = request.getParameter("departmentId");
    int departmentId = Integer.parseInt(s);
    s = request.getParameter("year");
    int year = Integer.parseInt(s);
    
    StudentDAO.insert(studentNumber, studentName, departmentId, year);     
    response.sendRedirect("studentList.jsp");
%>
