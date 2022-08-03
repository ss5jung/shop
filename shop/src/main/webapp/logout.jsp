<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	session.invalidate();	//원래 session의 값을 지우기 - session reset
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
%>
