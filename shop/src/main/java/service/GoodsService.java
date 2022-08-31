package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import repository.DBUtil;
import repository.GoodsDAO;
import repository.GoodsImgDAO;
import vo.Goods;
import vo.GoodsImg;

//트랜잭션 + action이나 DAO가 해서는 안되는 일
public class GoodsService {
	// DAO는 모든 이너클래스에서 사용할 것이므로 필드로 만들어둔다.
	private GoodsDAO goodsDAO;
	private GoodsImgDAO goodsImgDAO;

	// 상품 추가 C
	public int addGoods(Goods goods, GoodsImg goodsImg) throws SQLException {
		// 파라미터 디버깅
		System.out.println(goods);
		System.out.println(goodsImg);
		// 리턴할 변수 선언
		int row = 0;
		// DB 연동
		Connection conn = null;

		try {
			conn = new DBUtil().getConnection();
			System.out.println("DB 연동 성공 - addGoods");
			conn.setAutoCommit(false);
			// DAO 객체 생성
			goodsDAO = new GoodsDAO();
			goodsImgDAO = new GoodsImgDAO();

			// 1)insertGoods 실행후 성공시 -> 2)img 삽입
			// goodsNo가 AutoIncrement로 자동생성되어 DB입력
			// 새로 생성된 key값이 리턴된다.
			int goodsNo = goodsDAO.insertGoods(conn, goods);

			if (goodsNo != 0) { // insertGoods가 정상적으로 실행되었다면
				goodsImg.setGoodsNo(goodsNo); // 리턴 받아온 key값을 goodsImg의 goodsNo로 셋팅
				row = goodsImgDAO.insertGoodsImg(conn, goodsImg);
				if (row == 0) { // 이미지입력 실패시
					throw new Exception(); // catch절로 이동
				}
			}
			conn.commit();
		} catch (Exception e) { // 예외처리되면
			e.printStackTrace();
			try {
				conn.rollback(); // rollback해서 이전상태로 만들기
			} catch (Exception e2) {
				e.printStackTrace();
			}
		} finally {
			// DB자원 해제
			if (conn != null) {
				conn.close();
			}
		}
		System.out.println(row + "<-- row - addGoods");
		return row;
	}

	// 상품 삭제하기 D
	// DB에서 goods테이블의 goods_noorder와 FK랑 연결되어 있는 상품의 경우에는 삭제가 안 됨
	public int deleteGoodsOne(int goodsNo) throws SQLException {
		// 파라미터 디버깅
		System.out.println(goodsNo + "<-- goodsNo -deleteGoodsOne GoodsService");
		// DB연결
		Connection conn = null;
		// 리턴할 변수 선언
		int imgRow = 0;
		int row = 0;
		try {
			// 상품 이미지 삭제 -> 상품 정보 삭제
			// DB 연결
			conn = new DBUtil().getConnection();
			System.out.println("deleteGoodsOne DB 연결 성공");
			// sql문으로 조회할 DAO 객체 생성
			goodsDAO = new GoodsDAO();
			goodsImgDAO = new GoodsImgDAO();
			// 개별 트랙잭션모드 끄기
			conn.setAutoCommit(false);
			// FK로 연결되어 있어서 goods_img에서 먼저 데이터를 삭제해야 됨
			imgRow = goodsImgDAO.deleteGoodsOneImg(conn, goodsNo);
			if (imgRow != 0) { // goods_img 테이블에서 삭제가 성공한다면
				row = goodsDAO.deleteGoodsOne(conn, goodsNo);
				if (row == 0) { // goods 테이블에서 데이터 삭제에 실패했다면
					throw new Exception(); // 예외
				}
			}
			// 변경된 내용 적용(커밋)하기
			conn.commit();
		} catch (Exception e) { // 예외처리되면
			e.printStackTrace();
			try {
				conn.rollback(); // rollback해서 이전상태로 만들기
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		} finally {
			// DB자원 해제
			if (conn != null) {
				conn.close();
			}
		}
		return row;
	}

	// 상품 수정하기 U
	public int updateGoodsOne(Goods goods, GoodsImg goodsImg) throws SQLException {
		// 리턴하려는 변수 선언
		int row = 0;
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			System.out.println("updateGoodsOne - DB 연결 성공");
			// DAO 객체 생성
			goodsDAO = new GoodsDAO();
			goodsImgDAO = new GoodsImgDAO();
			// 개별 트랙잭션모드 끄기
			conn.setAutoCommit(false);
			// goods 정보 수정
			row = goodsDAO.updateGoodsOne(conn, goods);
			// 정보 수정에 성공하면 img도 수정
			if (row != 0) {
				int imgRow = goodsImgDAO.updateGoodsImg(conn, goodsImg);
				if(imgRow == 0) {
					throw new Exception();
				}
			}
			// 변경된 사항 적용하기
			conn.commit();
		} catch (Exception e) { // 예외처리되면
			e.printStackTrace();
			try {
				conn.rollback(); // rollback해서 이전상태로 만들기
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		} finally {
			// DB자원 해제
			if (conn != null) {
				conn.close();
			}
		}
		return row;

	}

	// 상품 목록 R
	public List<Map<String, Object>> getCustomerGoodsListByPage(int rowPerPage, int currentPage, String orderSql)
			throws SQLException {
		// 파라미터 디버깅
		System.out.println("getCustomerGoodsListByPage 파라미터 디버깅 : " + "rowPerPage > " + rowPerPage + ",currentPage >"
				+ currentPage + " ,orderSql >" + orderSql);
		// beginRow
		int beginRow = (currentPage - 1) * rowPerPage;
		// DB자원 만들기
		Connection conn = null;
		// List객체 생성 - 상품리스트 받아오기
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		try {
			// DB driver 연결
			conn = new DBUtil().getConnection();
			System.out.println("getCustomerGoodsListByPage - Driver 연동 성공");
			// 상품 리스트 받아오기
			list = new GoodsDAO().selectCustomerGoodsListByPage(conn, rowPerPage, beginRow, orderSql);
			if (list == null) {
				System.out.println("getCustomerGoodsListByPage list가 null값");
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// DB자원 해제
			if (conn != null) {
				conn.close();
			}
		}
		return list;
	}

	// 상세페이지 R
	public Map<String, Object> getGoodsAndImgOne(int goodsNo) throws Exception {
		// 전송받은 값 디버깅
		System.out.println(goodsNo + "<--goodsNo - getGoodsAndImgOne");
		// 리턴할 변수 선언
		Map<String, Object> goodsOne = null;
		Connection conn = null;
		try {
			// DB 연동
			conn = new DBUtil().getConnection();
			System.out.println("getGoodsAndImgOne - DB연동 성공");
			goodsOne = new GoodsDAO().selectGoodsAndImgOne(conn, goodsNo);
			if (goodsOne == null) {
				System.out.println("goodsOne null 오류");
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// DB 자원해제
			if (conn != null) {
				conn.close();
			}
		}
		return goodsOne;
	}

	// last 페이지 구하기
	public int getGoodsLastPage(int rowPerPage) throws SQLException {
		int lastPage = 0;
		Connection conn = null;
		try {
			// DB연동
			conn = new DBUtil().getConnection();
			System.out.println("DB 연동 - getGoodsLastPage");
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

	// 상품 리스트 R
	public List<Goods> getGoodsListByPage(int rowPerPage, int currentPage) throws SQLException, ClassNotFoundException {
		// 리턴할 변수 생성
		List<Goods> list = null;
		// DAO 객체 생성
		this.goodsDAO = new GoodsDAO();
		// select rollback 대상이 아니다.
		// conn 선언
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			System.out.println("getGoodsListByPage - DB연동 성공");

			// 페이지의 첫 글의 number 구하기
			int beginRow = (currentPage - 1) * rowPerPage;
			// DAO에서 전송받은 상품 정보를 담을 리스트
			list = goodsDAO.selectGoodsListByPage(conn, rowPerPage, beginRow);
			// 디버깅
			if (list != null) { // 정상적으로 DAO가 실행되었다면
				System.out.println("getGoodsListByPage에서 GoodsDAO.selectGoodsListByPage 정상 실행");
			} else { // DAO가 실행되지 않았다면
				System.out.println("getGoodsListByPage에서 GoodsDAO.selectGoodsListByPage 실행 실패");
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}

}
