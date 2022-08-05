<%@page import="service.EmployeeService"%>
<%@page import="repository.EmployeeDAO"%>
<%@page import="vo.Employee"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//처리과정
//employeeLoginAction.jsp -> EmployeeService -> EmployeeDAO -> EmployeeService -> employeeLoginAction.jsp 
//null값이 아니면 index.jsp / null값이면 loginForm.jsp

//인코딩
request.setCharacterEncoding("utf-8");
//전송받은 값
String employeeId = request.getParameter("employeeId");
String employeePass = request.getParameter("employeePass");
//전송받은 값을 employee 객체에 삽입
Employee paramEmployee = new Employee();
paramEmployee.setEmployeeId(employeeId);
paramEmployee.setEmployeePass(employeePass);

//employee 정보 처리할 EmployeeService 객체 생성
EmployeeService employeeService = new EmployeeService();
//DB에서 가져올 회원정보를 담은 Employee 객체 생성
Employee loginEmployee = employeeService.getEmployee(paramEmployee);
//디버깅
System.out.println("loginEmployee --> " + loginEmployee);

if (loginEmployee != null) { //로그인되면
	System.out.println("Employee 로그인 성공!");
	//session 값 설정
	session.setAttribute("user", "Employee");
	session.setAttribute("id", loginEmployee.getEmployeeId());
	session.setAttribute("name", loginEmployee.getEmployeeName());
	//페이지 넘겨주기
	response.sendRedirect(request.getContextPath() + "/index.jsp");
} else {
	System.out.println("Employee 로그인 실패");
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp?errorMsg=check your id or password");
}
%>