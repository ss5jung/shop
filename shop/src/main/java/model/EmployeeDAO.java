package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import vo.Customer;
import vo.Employee;

public class EmployeeDAO {
	// 회원 탈퇴
	// EmployeerService.removeEmployee(Employee paramEmployee)가 호출
	public int deleteEmployee(Connection conn, Employee paramEmployee) throws SQLException {
		// 리턴할 변수 선언
		int row = 0;
		// DB연동
		System.out.println(conn + "<-- conn - deleteEmployee(){}");

		String sql = "DELETE FROM employee WHERE employee_id=? AND employee_pass=PASSWORD(?);";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramEmployee.getEmployeeId());
		stmt.setString(2, paramEmployee.getEmployeePass());
		// 디버깅
		System.out.println(stmt + "<-- stmt - deleteEmployee(){}");
		row = stmt.executeUpdate();
		// 디버깅
		System.out.println(row + "<-- row");
		return row;
	}

	// 로그인
	public Employee selectEmployeeByIdAndPw(Connection conn, Employee employee) throws ClassNotFoundException, SQLException {
		// getConnection을 사용하기 위한 DBUtil 객체 생성
		DBUtil dbUtil = new DBUtil();
		// 새로 받아오는 객체
		Employee loginEmployee = null;
		// 로그인한 Employee의 정보를 받아오기 위한 sql
		String sql = "SELECT employee_id employeeId, employee_name employeeName FROM employee where employee_id=? and employee_pass=PASSWORD(?)";
		// DB연동
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			conn = dbUtil.getConnection();
			System.out.println("selectEmployeeByIdAndPw - DB연동 성공");
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, employee.getEmployeeId());
			stmt.setString(2, employee.getEmployeePass());
			System.out.println(stmt + "<-- stmt");
			rs = stmt.executeQuery();

			if (rs.next()) {
				System.out.println(rs + "<-- rs 실행됨");
				loginEmployee = new Employee();
				loginEmployee.setEmployeeId(rs.getString("employeeId"));
				loginEmployee.setEmployeeName(rs.getString("employeeName"));
				System.out.println("selectEmployeeByIdAndPw에 데이터 셋팅 성공");
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
			if (conn != null) {
				conn.close();
			}
			System.out.println("selectEmployeeByIdAndPw.jsp - DB연동 해제");
		}
		return loginEmployee;
	}
}
