<%@page import="service.CustomerService"%>
<%@page import="vo.Customer"%>
<%@page import="java.util.UUID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
//전송받은 값
String customerId = request.getParameter("customerId");
String customerPass = UUID.randomUUID().toString().substring(0, 7);
Customer customer = new Customer();
customer.setCustomerId(customerId);
customer.setCustomerPass(customerPass);
//비밀번호 업데이트하기
int row = new CustomerService().modifyCustomerPass(customer);
if (row != 0) {
	System.out.println(customerId+"고객님의 비밀번호를 임시로 변경하였습니다.");
	response.sendRedirect(request.getContextPath() + "/admin/adminCustomerList.jsp");
} else {
	System.out.println(customerId+"고객님의 비밀번호 변경에 실패하였습니다.");
	response.sendRedirect(request.getContextPath() + "/admin/adminCustomerOneOrderList.jsp?customerId="+customerId);
}
%>