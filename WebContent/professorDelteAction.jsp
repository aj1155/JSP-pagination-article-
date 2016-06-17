<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="student1.*" %>
<%  

    String s = request.getParameter("id");
    int id = Integer.parseInt(s);
    ProfessorDAO.delete(id);
    response.sendRedirect("professorList.jsp");
%>
