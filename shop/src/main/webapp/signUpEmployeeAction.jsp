<%@page import="service.EmployeeService"%>
<%@page import="vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//흐름도
//Action -> service -> DAO -> service -> Action
//인코딩
request.setCharacterEncoding("utf-8");
//전송받은 값
String employeeId = request.getParameter("employeeId");
String employeePass = request.getParameter("employeePass");
String employeeName = request.getParameter("employeeName");
//전송받은 값 employee 객체 셋팅
Employee requestEmployee = new Employee();
requestEmployee.setEmployeeId(employeeId);
requestEmployee.setEmployeePass(employeePass);
requestEmployee.setEmployeeName(employeeName);
//디버깅
System.out.println("requestEmployee"+requestEmployee);
//실행 확인
int row = new EmployeeService().addEmployee(requestEmployee);
if(row == 1){
	System.out.println("직원 회원가입이 완료되었습니다.");
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
} else {
	System.out.println("직원 회원가입이 실패했습니다.");
	response.sendRedirect(request.getContextPath()+"/addEmployee.jsp");
}

%>