<%@page import="service.CustomerService"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	/* 
	## 데이터 처리과정
	signOutCustomerAction.jsp -> CustomerService -> CustomerDAO -> CustomerService -> signOutCustomerAction.jsp -> true 일때 loginForm.jsp / false 일때 signOutForm
	*/
	//인코딩
	request.setCharacterEncoding("utf-8");
	//전송받은 값
	String customerId = request.getParameter("signOutId");
	String customerPass = request.getParameter("signOutPw");
	//전송받은 값을 넣은 customer 객체 생성
	Customer paramCustomer = new Customer();
	//전송받은 데이터 셋팅
	paramCustomer.setCustomerId(customerId);
	paramCustomer.setCustomerPass(customerPass);
	//디버깅
	System.out.println("paramCustomer --> " + paramCustomer);
	//처리 메소드을 위한 CustomerService 객체 생성
	CustomerService customerService = new CustomerService();
	//리턴값 받을 변수 생성
	Boolean signOutBoolean = customerService.removeCustomer(paramCustomer);
	//디버깅
	System.out.println("signOutBoolean --> " +signOutBoolean);
	
	if(signOutBoolean == true){
		System.out.println("회원탈퇴 성공");
		//session 초기화
		session.invalidate();
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	} else {
		System.out.println("회원탈퇴 실패");
		response.sendRedirect(request.getContextPath()+"/signOutForm.jsp");
	}
%>
