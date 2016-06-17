<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="student1.*" %>
<%  
    String s = request.getParameter("id");
	String pg = request.getParameter("pg");
    int id = Integer.parseInt(s);
    StudentDAO.delete(id);
    response.sendRedirect("studentList.jsp?pg="+pg);
%>
