<%@page import="model.EmployeeDAO"%>
<%@page import="vo.Employee"%>
<%@page import="model.CustomerDAO"%>
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
//전송받은 값을 customer 객체에 삽입
Employee employee = new Employee();
employee.setEmployeeId(employeeId);
employee.setEmployeePass(employeePass);
//DAO 객체 생성
EmployeeDAO employeeDAO = new EmployeeDAO();
//loginAction 메소드
Employee loginEmployee = employeeDAO.selectEmployeeByIdAndPw(employee);

if (loginEmployee != null) { //로그인되면
	//session 값 설정
	session.setAttribute("user", "Employee");
	session.setAttribute("id", loginEmployee.getEmployeeId());
	session.setAttribute("name", loginEmployee.getEmployeeName());
	//페이지 넘겨주기
	response.sendRedirect(request.getContextPath() + "/index.jsp");
} else {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp?errorMsg=check your id or password");
}
%>