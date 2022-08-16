<%@page import="service.CustomerService"%>
<%@page import="service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
//전송받은 값
String customerId = request.getParameter("customerId");
System.out.println(customerId + "<-- customerId");
//삭제 실행하기
Boolean tf = new CustomerService().removeCustomer(customerId);
if (tf == true) {
	System.out.println(customerId+"고객님을 정상적으로 강제 탈퇴시켰습니다.");
	response.sendRedirect(request.getContextPath() + "/admin/adminCustomerList.jsp");
} else {
	System.out.println(customerId+"고객님의 강제 탈퇴가 실패하였습니다.");
	response.sendRedirect(request.getContextPath() + "/admin/adminCustomerOneOrderList.jsp?customerId="+customerId);
}
%>