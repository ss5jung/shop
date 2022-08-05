<%@page import="service.SignService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
/* 
흐름도 : idCheckAction -> SignService -> SignDAO -> SignService -> idCheckAction
*/
//인코딩
request.setCharacterEncoding("utf-8");
//전송받은 값
String id = request.getParameter("checkId");
String user = request.getParameter("user");

//에러메세지
String idCkMsg=null;
System.out.println(id + "<-- id");
System.out.println(user + "<-- user");
//아이디 중복검사 서비스 전송 후 값 리턴
Boolean idCkBoolean = new SignService().idCheck(id);
if (idCkBoolean == true) { //아이디 중복검사에서 통과하면
	idCkMsg="This id is available";
	response.sendRedirect(request.getContextPath() + "/add"+user+".jsp?idCkBoolean="+idCkBoolean+"&checkedId=" + id + "&idCkMsg="+idCkMsg);
} else {
	idCkMsg="This id is already in use.";
	response.sendRedirect(request.getContextPath() + "/add"+user+".jsp?idCkBoolean="+idCkBoolean+"&idCkMsg="+idCkMsg);
}
%>
