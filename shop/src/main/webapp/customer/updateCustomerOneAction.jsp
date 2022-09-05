<%@page import="service.CustomerService"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
//요청받은 값
String customerId = request.getParameter("customerId");
String customerAddress = request.getParameter("customerAddress")+" "+request.getParameter("customerDetailAddr");
String customerTelephone = request.getParameter("customerTelephone");
Customer customer = new Customer();
customer.setCustomerId(customerId);
customer.setCustomerAddress(customerAddress);
customer.setCustomerTelephone(customerTelephone);
System.out.println(customer + "<-- customer");
//서비스 콜
int row = new CustomerService().modifyCustomerOne(customer);
if(row!=0){
	response.sendRedirect(request.getContextPath()+"/index.jsp");
} else {
	response.sendRedirect(request.getContextPath()+"/customer/updateCustomerOne.jsp");
}

%>