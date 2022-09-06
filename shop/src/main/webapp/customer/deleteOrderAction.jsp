<%@page import="service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
//접근제한
if (session.getAttribute("id") == null) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
//전송받은 값
int orderNo = Integer.parseInt(request.getParameter("orderNo"));
String customerId = (String) session.getAttribute("id");
int row = new OrdersService().removeOrder(orderNo);
if (row != 0) {
	System.out.println("주문 취소 성공");
} else {
	System.out.println("주문 취소 실패");
}
response.sendRedirect(request.getContextPath() + "/index.jsp");
%>
