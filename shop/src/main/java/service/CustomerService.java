package service;

import java.sql.Connection;
import java.sql.SQLException;

import repository.CustomerDAO;
import repository.DBUtil;
import repository.OutIdDAO;
import vo.Customer;

public class CustomerService {
	// 회원가입
	// signUpAction.jsp 호출시
	public int addCustomer(Customer paramCustomer) {
		int row = 0;
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			System.out.println("addCustomer - DB연동 성공");

			// DB에서 customer 정보 insert
			row = new CustomerDAO().insertCustomer(conn, paramCustomer);
			System.out.println(row + "<-- row CustomerService. addCustomer");
			if(row == 0) {	//실행되지 않았다면
				throw new Exception();	//오류로 이동
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

	// 회원탈퇴
	// signOutCustomerAction.jsp 호출시
	public Boolean removeCustomer(Customer paramCustomer) {
		Connection conn = null;
		try {
			// 공통의 conn사용하기
			conn = new DBUtil().getConnection();
			System.out.println("removeCustomer - DB연동 성공");
			conn.setAutoCommit(false); // executeUpdate()실행시 자동 커밋을 막음

			// DB에서 customer 정보 삭제 -> 백업
			CustomerDAO customerDAO = new CustomerDAO();
			int removeCustomer = customerDAO.deleteCustomer(conn, paramCustomer); // int 값 리턴
			// 디버깅
			if (removeCustomer == 1) { // 정상적으로 삭제가 되면
				System.out.println("removeCustomer - 회원정보 삭제가 정상적으로 이루워졌습니다.");
				// outid 테이블에 탈퇴한 아이디 insert 하기
				OutIdDAO OutIdDao = new OutIdDAO();
				int insertOutId = OutIdDao.insertOutId(conn, paramCustomer.getCustomerId()); // int 값 리턴
				// 디버깅
				if (insertOutId == 1) { // outid 테이블에 insert가 성공하면
					System.out.println("insertOutId - 탈퇴한 회원ID가 정상적으로 outid 테이블에 insert되었습니다.");
				} else { // outid 테이블에 insert에 실패하면
					System.out.println("insertOutId -  탈퇴한 회원ID 백업실패");
					// 오류발생시 캐치절로 이동
					throw new Exception();
				}
			} else { // 삭제에 실패할 경우
				System.out.println("removeCustomer - 회원정보 삭제가 실패하였습니다.");
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
	// customerLoginActoin에서 호출
	public Customer getCustomer(Customer paramCustomer) {
		Connection conn = null;
		Customer selectCustomerByIdAndPw = null;
		try {
			// 공통의 conn사용하기
			conn = new DBUtil().getConnection();
			System.out.println("getCustomer - DB연동 성공");
			conn.setAutoCommit(false); // executeUpdate()실행시 자동 커밋을 막음

			// DB에서 customer 정보 select
			CustomerDAO customerDAO = new CustomerDAO();
			selectCustomerByIdAndPw = customerDAO.selectCustomerByIdAndPw(conn, paramCustomer); // customer 리턴
			// 디버깅
			if (selectCustomerByIdAndPw != null) { // 로그인회원의 정보가 null값인 경우
				System.out.println("selectCustomerByIdAndPw - 로그인이 정상적으로 이루워졌습니다.");
			} else {
				System.out.println("selectCustomerByIdAndPw - 로그인 실패");
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
			return selectCustomerByIdAndPw; // 로그인 실패
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return selectCustomerByIdAndPw;
	}
}
