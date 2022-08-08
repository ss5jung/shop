<%@page import="service.EmployeeService"%>
<%@page import="repository.EmployeeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//흐름도
	//active -> service -> DAO -> service -> active
	//인코딩
	request.setCharacterEncoding("utf-8");
	//전송받은 값
	String active = request.getParameter("active");
	String adminId = request.getParameter("employeeId");
	//디버깅
	System.out.println(active + "<-- active");
	System.out.println(adminId + "<-- adminId");
	//service 실행확인 변수
	int row = new EmployeeService().modifyEmployeeActive(active, adminId);
	
	if(row == 1){	//DAO가 정상적으로 작동하면
		//디버깅
		System.out.println("접근권한이 정상적으로 변경되었습니다.");
	} else {	//실패한다면
		//디버깅
		System.out.println("접근권한 변경에 실패했습니다.");
	}
	//성공 or 실패 둘다 adminEmployeeList이동
	response.sendRedirect(request.getContextPath()+"/admin/adminEmployeeList.jsp");
%>
