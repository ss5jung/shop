package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import vo.Employee;

public class EmployeeDAO {
	//로그인
		public Employee loginAction(Employee employee) throws ClassNotFoundException, SQLException {
			DBUtil dbUtil = new DBUtil();
			//새로 받아오는 객체
			Employee employee2 = null;
			String sql ="SELECT employee_id employeeId, employee_name employeeName FROM employee where employee_id=? and employee_pass=PASSWORD(?)";
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;

			try {
				conn = dbUtil.getConnection();
				System.out.println("DB연동 성공");
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, employee.getEmployeeId());
				stmt.setString(2, employee.getEmployeePass());
				System.out.println(stmt + "<-- stmt");
				rs = stmt.executeQuery();
				
				if(rs.next()) {
					System.out.println(rs + "<-- rs 실행됨");
					employee2 = new Employee();
					employee2.setEmployeeId(rs.getString("employeeId"));
					employee2.setEmployeeName(rs.getString("employeeName"));
					System.out.println("employee2에 데이터 셋팅 성공");
				}
			}
			finally {
				if (rs != null) {
					rs.close();
				}
				if (stmt != null) {
					stmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			}
			return employee2;
		}
}
