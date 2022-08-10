package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import repository.DBUtil;
import repository.GoodsDAO;
import repository.OrdersDAO;
import vo.Orders;

public class OrdersService {
	// 고객1의 주문 내역
	
	// 주문 내역 수정하기
	public int addOrdersOne(Map<String,Object> map) throws SQLException {
		//리턴할 변수 선언 및 초기화
		int row = 0;
		//DB 자원
		Connection conn = null;
		try {
			//DB driver 연결
			conn = new DBUtil().getConnection();
			System.out.println("addOrdersOne DB Driver 연결");
			
			row = new OrdersDAO().insertOrdersOne(conn, map);
			System.out.println(row + "<-- addOrdersOne 실행된 row의 수");
			if(row == 0) {	//row가 실행되지 않았으면
				throw new Exception();	//예외처리
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			//DB자원 해제
			if(conn !=null) {
				conn.close();
			}
		}
		return row;	
	}
	
	// 주문 상세 보기
	public Map<String, Object> getOrdersOne(int orderNo) throws SQLException {
		// 파라미터 디버깅
		System.out.println("getOrdersOne 파라미터 디버깅 --> orderNo :" + orderNo);
		// 리턴하려는 변수 생성
		Map<String, Object> map = null; // 다형성
		//DB 자원 초기화
		Connection conn = null;
		try {
			//DB 연동
			conn = new DBUtil().getConnection();
			System.out.println("getOrdersOne - DB 연동");
			//ordersNo의 정보 가져올 map 객체
			map = new OrdersDAO().selectOrdersOne(conn, orderNo);
			System.out.println(map + "<--map getOrdersOne");
			
			if(map == null) {	//map이 null이면
				throw new Exception();	//catch절로 보내기
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			//DB자원 해제
			if(conn != null) {
				conn.close();
			}
		}
		return map;
	}

	// last 페이지 구하기
	public int getOrdersLastPage(int rowPerPage) throws SQLException {
		int lastPage = 0;
		Connection conn = null;
		try {
			// DB연동
			conn = new DBUtil().getConnection();
			System.out.println("DB 연동 - getOrdersLastPage");
			// lastPage
			lastPage = new OrdersDAO().selectOrdersLastPage(conn, rowPerPage);
			System.out.println(lastPage + "lastPage - getOrdersLastPage");
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

	// 전체 주문 목록 - 관리자 페이지
	public List<Map<String, Object>> getOrdersList(int rowPerPage, int currentPage) throws SQLException {
		// 파라미터 디버깅
		System.out.println("selectOrdersList 파라미터 디버깅 --> rowPerPage :" + rowPerPage + "  currentPage : " + currentPage);
		// 리턴하려는 변수 생성
		List<Map<String, Object>> list = null; // 다형성
		int beginRow = (currentPage - 1)*rowPerPage;
		// DB연동
		Connection conn = null;
		try {
			list = new ArrayList<>();
			// DB연동하기
			conn = new DBUtil().getConnection();
			System.out.println("DB 연동 - getOrdersList");
			// DAO에서 주문목록을 담은 list 객체 전달 받기
			list = new OrdersDAO().selectOrdersList(conn, rowPerPage, beginRow);
			// 예외처리
			if (list == null) { // list가 null이면
				throw new Exception(); // catch절로 보내기
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// DB자원해제
			if (conn != null) {
				conn.close();
			}
		}
		return list;
	}

	// 특정 고객의 주문 목록 - 관리자페이지 & 고객페이지
	public List<Map<String, Object>> getOrdersListByCustomer(Connection conn, String customerId, int rowPerPage,
			int beginRow) {
		// 파라미터 디버깅
		System.out.println("selectOrdersListByCustomer 파라미터 디버깅 --> customerId : " + customerId + " rowPerPage : "
				+ rowPerPage + "  beginRow : " + beginRow);
		// 리턴하려는 변수 생성
		List<Map<String, Object>> list = new ArrayList<>(); // 다형성
		/*
		 * SELECT o.*, g.* FROM order o INNER JOIN goods g USING (goods_no) WHERE
		 * customer_id = ? ORDER BY create_date DESC LIMIT ?,?
		 */

		return list;
	}
}
