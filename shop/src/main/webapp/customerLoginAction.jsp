<%@page import="model.CustomerDAO"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	//전송받은 값
	String customerId = request.getParameter("customerId");
	String customerPass = request.getParameter("customerPass");
	//전송받은 값을 customer 객체에 삽입
	Customer customer = new Customer();
	customer.setCustomerId(customerId);
	customer.setCustomerPass(customerPass);
	//DAO 객체 생성
	CustomerDAO customerDAO = new CustomerDAO();
	
 	Customer customer2 = customerDAO.loginAction(customer);
 	
 	if(customer2 != null){	//로그인되면
 		//session 값 설정
 		session.setAttribute("user", "customer");
 		session.setAttribute("id", customer2.getCustomerId());
 		session.setAttribute("name", customer2.getCustomerName());
 		//페이지 넘겨주기
 		response.sendRedirect(request.getContextPath()+"/index.jsp");
 	} else {
 		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?errorMsg=check your id or password");
 	}
%>