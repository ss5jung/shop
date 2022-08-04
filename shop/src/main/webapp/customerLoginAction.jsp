<%@page import="service.CustomerService"%>
<%@page import="model.CustomerDAO"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//처리과정
//customerLoginAction.jsp -> CustomerService -> CustomerDAO -> CustomerService -> customerLoginAction.jsp 
//null값이 아니면 index.jsp / null값이면 loginForm.jsp

//인코딩
request.setCharacterEncoding("utf-8");
//전송받은 값
String customerId = request.getParameter("customerId");
String customerPass = request.getParameter("customerPass");
//전송받은 값을 customer 객체에 삽입
Customer paramCustomer = new Customer();
paramCustomer.setCustomerId(customerId);
paramCustomer.setCustomerPass(customerPass);
//customer 정보 처리할 CustomerService 객체 생성
CustomerService customerService = new CustomerService();
//DB에서 가져올 회원정보를 담은 Customer 객체 생성
Customer loginCustomer = customerService.getCustomer(paramCustomer);
//디버깅
System.out.println("loginCustomer --> " + loginCustomer);
if (loginCustomer != null) { //로그인되면
	System.out.println("로그인 성공!");
	//session 값 설정
	session.setAttribute("user", "Customer");
	session.setAttribute("id", loginCustomer.getCustomerId());
	session.setAttribute("name", loginCustomer.getCustomerName());
	//페이지 넘겨주기
	response.sendRedirect(request.getContextPath() + "/index.jsp");
} else {
	System.out.println("로그인 실패");
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp?errorMsg=check your id or password");
}
%>