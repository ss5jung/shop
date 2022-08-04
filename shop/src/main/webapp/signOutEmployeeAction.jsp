<%@page import="service.EmployeeService"%>
<%@page import="vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	/* 
	## 데이터 처리과정
	signOutEmployeeAction.jsp -> EmployeeService -> EmployeeDAO -> EmployeeService -> signOutEmployeeAction.jsp -> true 일때 loginForm.jsp / false 일때 signOutForm
	*/
	//인코딩
	request.setCharacterEncoding("utf-8");
	//전송받은 값
	String employeeId = request.getParameter("signOutId");
	String employeePass = request.getParameter("signOutPw");
	//전송받은 값을 넣은 Employee 객체 생성
	Employee paramEmployee = new Employee();
	//전송받은 데이터 셋팅
	paramEmployee.setEmployeeId(employeeId);
	paramEmployee.setEmployeePass(employeePass);
	//디버깅
	System.out.println("paramEmployee --> " + paramEmployee);
	//처리 메소드을 위한 EmployeeService 객체 생성
	EmployeeService employeeService = new EmployeeService();
	//리턴값 받을 변수 생성
	Boolean signOutBoolean = employeeService.removeEmployee(paramEmployee);
	//디버깅
	System.out.println("signOutBoolean --> " +signOutBoolean);
	
	if(signOutBoolean == true){
		System.out.println("직원탈퇴 성공");
		//session 초기화
		session.invalidate();
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	} else {
		System.out.println("직원탈퇴 실패");
		response.sendRedirect(request.getContextPath()+"/signOutForm.jsp");
	}
%>
