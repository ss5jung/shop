package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import repository.DBUtil;
import repository.EmployeeDAO;
import repository.GoodsDAO;
import repository.OutIdDAO;
import vo.Employee;

public class EmployeeService {
	//last 페이지 구하기
	public int getEmployeeLastPage(int rowPerPage) throws SQLException {
		int lastPage = 0;
		Connection conn = null;
		try {
			// DB연동
			conn = new DBUtil().getConnection();
			System.out.println("DB 연동 - getEmployeeLastPage");
			// lastPage
			lastPage = new GoodsDAO().selectGoodsLastPage(conn, rowPerPage);
			System.out.println(lastPage + "lastPage - Goods");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// DB 자원 해제
			if (conn != null) {
				conn.close();
				System.out.println("conn 연결 해제");
			}
		}
		return lastPage;
	}

	// 회원 접근권한 변경
	// modifyEmployeeActive.jsp가 호출시
	public int modifyEmployeeActive(String active, String adminId) throws ClassNotFoundException, SQLException {
		// 리턴할 변수 선언 및 초기화
		int row = 0;
		Connection conn = null;
		try {
			//conn DB 연동하기
			conn = new DBUtil().getConnection();
			//디버깅
			System.out.println(conn + "<-- conn modifyEmployeeActive 정상 연결");
			//DAO로 전송
			row = new EmployeeDAO().modifyEmployeeActive(conn, active,adminId);
			//디버깅
			System.out.println(row + "<-- row ");
			if (row == 1) { //DAO 정상적으로 실행시
				System.out.println("modifyEmployeeActive DAO가 정상적으로 작동하였습니다.");
			} else {  //DAO 실행 실패시
				System.out.println("modifyEmployeeActive DAO 실행 실패");
				throw new Exception();
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			//DB 자원 해제
			if(conn != null) {
				conn.close();
			}
		}
		return row;
	}

	// 사원리스트
	public ArrayList<Employee> getEmployeeList(int rowPerPage, int currentPage) {
		// DAO에서 전송받은 직원들의 정보를 담을 list객체
		ArrayList<Employee> list = null;
		// beginRow 변수
		int beginRow = (currentPage - 1) * rowPerPage;

		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			System.out.println("getEmployeeList - DB연동 성공");

			// DAO에서 Employee 정보들을 담은 list 전달받음
			list = new EmployeeDAO().selectEmployeeList(conn, rowPerPage, beginRow);
			System.out.println(list + "<-- list EmployeeService. getEmployeeList");

			if (list == null) { // 실행되지 않았다면
				throw new Exception(); // 오류로 이동
			}
		} catch (Exception e) {
			e.printStackTrace(); // console에 예외메세지 출력
			try {
				conn.rollback(); // 실행시 예외가 발생하면 현재 conn 실행쿼리 롤백
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	// 회원가입
	// signUpEmployeeAction.jsp 호출시
	public int addEmployee(Employee paramEmployee) {
		int row = 0;
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			System.out.println("addEmployee - DB연동 성공");

			// DB에서 Employee 정보 insert
			row = new EmployeeDAO().insertEmployee(conn, paramEmployee);
			System.out.println(row + "<-- row EmployeeService. addEmployee");
			if (row == 0) { // 실행되지 않았다면
				throw new Exception(); // 오류로 이동
			}
		} catch (Exception e) {
			e.printStackTrace(); // console에 예외메세지 출력
			try {
				conn.rollback(); // 실행시 예외가 발생하면 현재 conn 실행쿼리 롤백
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return row;
	}

	// 직원탈퇴
	// signOutEmployeeAction.jsp 호출시
	public Boolean removeEmployee(Employee paramEmployee) {
		Connection conn = null;
		try {
			// 공통의 conn사용하기
			conn = new DBUtil().getConnection();
			System.out.println("removeEmployee - DB연동 성공");
			conn.setAutoCommit(false); // executeUpdate()실행시 자동 커밋을 막음

			// DB에서 Employee 정보 삭제 -> 백업
			EmployeeDAO employeeDAO = new EmployeeDAO();
			int removeEmployee = employeeDAO.deleteEmployee(conn, paramEmployee); // int 값 리턴
			// 디버깅
			if (removeEmployee == 1) { // 정보 삭제가 정상으로 이루워지면
				System.out.println("removeEmployee - 직원정보 삭제가 정상적으로 이루워졌습니다.");
				// outid 테이블에 탈퇴한 아이디 insert 하기
				OutIdDAO OutIdDao = new OutIdDAO();
				int insertOutId = OutIdDao.insertOutId(conn, paramEmployee.getEmployeeId()); // int 값 리턴
				// 디버깅
				if (insertOutId == 1) { // outid 테이블에 정상적으로 insert되면
					System.out.println("insertOutId - 탈퇴한 직원ID가 정상적으로 outid 테이블에 insert되었습니다.");
				} else { // outid 테이블에 insert 실패
					System.out.println("insertOutId -  탈퇴한 직원ID 백업실패");
					// 오류발생시 캐치절로 이동
					throw new Exception();
				}
			} else { // 정보 삭제가 실패할 경우
				System.out.println("removeEmployee - 직원정보 삭제가 실패하였습니다.");
				// 오류발생시 캐치절로 이동
				throw new Exception();
			}
			// 모든 데이터베이스 잠금을 해제
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace(); // console에 예외메세지 출력
			try {
				conn.rollback(); // 1) or 2) 실행시 예외가 발생하면 현재 conn 실행쿼리 모두 롤백
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			return false; // 탈퇴 실패
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true; // 탈퇴 성공
	}

	// 로그인
	// employeeLoginActoin에서 호출
	public Employee getEmployee(Employee paramEmployee) {
		Connection conn = null;
		Employee selectEmployeeByIdAndPw = null;
		try {
			// 공통의 conn사용하기
			conn = new DBUtil().getConnection();
			System.out.println("getEmployee - DB연동 성공");
			conn.setAutoCommit(false); // executeUpdate()실행시 자동 커밋을 막음

			// DB에서 Employee 정보 select
			EmployeeDAO employeeDAO = new EmployeeDAO();
			selectEmployeeByIdAndPw = employeeDAO.selectEmployeeByIdAndPw(conn, paramEmployee);
			// 디버깅
			if (selectEmployeeByIdAndPw != null) { // 로그인직원의 정보가 null값인 경우
				System.out.println("selectEmployeeByIdAndPw - 로그인이 정상적으로 이루워졌습니다.");
			} else {
				System.out.println("selectEmployeeByIdAndPw - 로그인 실패");
				// catch 오류
				throw new Exception();
			}

			// 모든 데이터베이스 잠금을 해제
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace(); // console에 예외메세지 출력
			try {
				conn.rollback(); // 실행시 예외가 발생하면 현재 conn 실행쿼리 롤백
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			return selectEmployeeByIdAndPw; // 로그인 실패
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return selectEmployeeByIdAndPw; // 로그인 성공
	}
}
