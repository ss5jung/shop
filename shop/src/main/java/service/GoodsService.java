package service;

import java.sql.Connection;
import java.sql.SQLException;
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
	
	
	//상품 추가
	public int addGoods(Goods goods, GoodsImg goodsImg) throws SQLException {
		//리턴할 변수 선언
		int row = 0;
		//DB 연동
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			System.out.println("DB 연동 성공 - addGoods");
			conn.setAutoCommit(false);
			
			//DAO 객체 생성
			goodsDAO = new GoodsDAO();
			goodsImgDAO = new GoodsImgDAO();
			
			//insertGoods 실행후 성공시 -> img 삽입
			//goodsNo가 AutoIncrement로 자동생성되어 DB입력
			//단, insertGoods메소드의 리턴값은 key값
			int goodsNo = goodsDAO.insertGoods(conn, goods);	
		
			if(goodsNo != 0) {		//insertGoods가 정상적으로 실행되었다면
				goodsImg.setGoodsNo(goodsNo);
				if(goodsImgDAO.insertGoodsImg(conn, goodsImg) == 0) {	//이미지입력 실패시
					throw new Exception();	//catch절로 이동
				}
			}
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();	
			} catch (Exception e2) {
				e.printStackTrace();
			}

		} finally {
			if(conn != null) {
				conn.close();
			}
		}
		return row;
	} 

	
	
	// 상세페이지
	public Map<String, Object> getGoodsAndImgOne(int goodsNo) throws SQLException {
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

	// 상품 리스트
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
