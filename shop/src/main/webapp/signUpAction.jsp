<%@page import="service.CustomerService"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//흐름도
//Action -> service -> DAO -> service -> Action
//인코딩
request.setCharacterEncoding("utf-8");
//전송받은 값
String customerId = request.getParameter("customerId");
String customerPass = request.getParameter("customerPass");
String customerName = request.getParameter("customerName");
String customerAddress = request.getParameter("customerAddress");
String customerTelephone = request.getParameter("customerTelephone");
//전송받은 값 customer 객체 셋팅
Customer requestCustomer = new Customer();
requestCustomer.setCustomerId(customerId);
requestCustomer.setCustomerPass(customerPass);
requestCustomer.setCustomerName(customerName);
requestCustomer.setCustomerAddress(customerAddress);
requestCustomer.setCustomerTelephone(customerTelephone);
//디버깅
System.out.println("requestCustomer"+requestCustomer);
//실행 확인
int row = new CustomerService().addCustomer(requestCustomer);
if(row == 1){
	System.out.println("고객님의 회원가입이 완료되었습니다.");
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
} else {
	System.out.println("고객님의 회원가입이 실패했습니다.");
	response.sendRedirect(request.getContextPath()+"/addCustomer.jsp");
}

%>