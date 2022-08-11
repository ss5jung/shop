package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Goods;

public class GoodsDAO {
	// 고객 페이지 - 상품리스트
	public List<Map<String, Object>> selectCustomerGoodsListByPage(Connection conn, int rowPerPage, int beginRow)
			throws Exception {
		// 파라미터 디버깅
		System.out.println(beginRow + "<-- beginRow - selectCustomerGoodsListByPage");
		System.out.println(rowPerPage + "<-- rowPerPage - selectCustomerGoodsListByPage");
		// 리턴할 변수 선언
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		// DB 자원
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice, g.sold_out soldOut, IFNULL(t.sumNum, 0) sumNum, gi.filename filename FROM goods g LEFT JOIN (SELECT goods_no, SUM(order_quantity) sumNum FROM orders GROUP BY goods_no) t USING (goods_no) Inner JOIN goods_img gi USING(goods_no) ORDER BY IFNULL(t.sumNum, 0) DESC LIMIT ?,?";
		/*
		 SELECT g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice,
		 g.sold_out soldOut, IFNULL(t.sumNum, 0) sumNum, gi.filename filename
		 FROM goods g 
		 LEFT JOIN (SELECT goods_no, SUM(order_quantity) sumNum FROM orders GROUP BY goods_no)t
		 USING (goods_no) 
		 Inner JOIN goods_img gi 
		 USING(goods_no)
		 ORDER BY IFNULL(t.sumNum, 0) DESC 
		 LIMIT ?,?;
		 */
		try {
			//DB자원
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			System.out.println(stmt + "<-- stmt");
			rs = stmt.executeQuery();
			System.out.println(rs + "<-- rs" );
			while (rs.next()) {
				Map<String, Object> map = new HashMap<>();
				map.put("goodsNo", rs.getInt("goodsNo"));
				map.put("goodsName", rs.getString("goodsName"));
				map.put("goodsPrice", rs.getString("goodsPrice"));
				map.put("soldOut", rs.getString("soldOut"));
				map.put("sumNum", rs.getString("sumNum"));
				map.put("filename", rs.getString("filename"));
				list.add(map);
			}
		} finally {
			//DB자원해제
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return list;
	}

	// 상품 추가 - key 값 리턴
	public int insertGoods(Connection conn, Goods goods) throws SQLException {
		// 파라미터 디버깅
		System.out.println(goods);
		// 리턴할 변수(Key값)
		int keyId = 0;
		int row = 0;
		// DB자원
		PreparedStatement stmt = null;
		ResultSet rs = null; // select가 아닌데 ResultSet을 선언한 이유는 키값을 리턴해야 하므로
		String sql = "insert into goods (goods_name, goods_price, update_date, create_date, sold_out) values (?, ?, now(), now(), 'N');";
		// 상품이 처음부터 품절상태는 아니므로 기본값은 N로 한다.
		try {
			stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			// stmt 셋팅
			stmt.setString(1, goods.getGoodsName());
			stmt.setInt(2, goods.getGoodsPrice());
			System.out.println(stmt + " <-- stmt insertGoods");
			// 1) insert가 실행이 되었다면
			row = stmt.executeUpdate();
			if (row > 0) {
				System.out.println("stmt - insertGoods가 실행되었습니다.");
				System.out.println(row + "<-- insert 성공한 row의 수 ");
				// 2) select last_ai_key from... 키 값 가져오기
				rs = stmt.getGeneratedKeys(); // getGeneratedKeys : 또 한번의 네트워크 통신 없이 바로 가져올 수 있다
				System.out.println(rs + "<-- rs - insertGoods");
				if (rs.next()) {
					System.out.println("rs가 실행되었습니다.");
					keyId = rs.getInt(1);
					System.out.println(keyId + "<-- keyId - insertGoods에서 추가된 상품의 key ");
				}
			}
		} finally {
			// DB자원 해제
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return keyId;
	}

	// 상세페이지
	public Map<String, Object> selectGoodsAndImgOne(Connection conn, int goodsNo) throws SQLException {
		// 파라미터 디버깅
		System.out.println(goodsNo + "<-- goodsNo - selectGoodsAndImgOne");
		// 리턴할 변수 선언
		Map<String, Object> map = null;
		// DB 자원 선언
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT g.*, gi.* FROM goods g INNER JOIN goods_img gi USING (goods_no) WHERE g.goods_no = ?";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo);
			System.out.println(stmt + "<-- stmt - selectGoodsAndImgOne");

			rs = stmt.executeQuery();
			System.out.println(rs + "<-- rs - selectGoodsAndImgOne");

			if (rs.next()) { // rs가 존재한다면
				// 데이터 셋팅할 map 객체 생성
				map = new HashMap<String, Object>();
				// 데이터 셋팅
				map.put("goodsNo", rs.getInt("g.goods_no"));
				map.put("goodsName", rs.getString("g.goods_name"));
				map.put("goodsPrice", rs.getInt("g.goods_price"));
				map.put("updateDate", rs.getString("g.update_date"));
				map.put("createDate", rs.getString("g.create_date"));
				map.put("soldOut", rs.getString("g.sold_out"));
				map.put("filename", rs.getString("gi.filename"));
				map.put("originFilename", rs.getString("gi.origin_filename"));
				map.put("contentType", rs.getString("gi.content_type"));
				map.put("imgCreateDate", rs.getString("gi.create_date"));

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// DB자원 해제
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}

		/*
		 * while(rs.next()) { map = new HashMap<String, Object>() map.put("goodsNo",
		 * rs.getInt("goodsNo")); }
		 * 
		 * 쿼리에서 where 조건이 없다면..반환 타입 List<Map<String, Object>> list
		 */
		return map;
	}

	// 라스트 페이지
	public int selectGoodsLastPage(Connection conn, int rowPerPage) throws SQLException {
		// 전송된 값 디버깅
		System.out.println(rowPerPage + "<-- rowPerPage");
		// 리턴할 변수 선언 및 초기화
		int lastPage = 0;

		String sql = "SELECT count(*) count FROM goods";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int totalCount = 0;

		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			// 디버깅
			if (rs.next()) {
				totalCount = rs.getInt("count");
				System.out.println(totalCount + "<--totalCount 상품 전체갯수");
			}
		} finally {
			rs.close();
			stmt.close();
		}
		// lastPage 연산 - 올림해서 lastPage구하기
		lastPage = (int) Math.ceil((double) totalCount / rowPerPage);
		return lastPage;
	}

	// 상품리스트
	public List<Goods> selectGoodsListByPage(Connection conn, int rowPerPage, int beginRow) throws SQLException {
		// 리턴값 선언 및 초기화
		List<Goods> list = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		String sql = "SELECT goods_no goodsNo, goods_name goodsName, goods_price goodsPrice, update_date updateDate, create_date createDate, sold_out soldOut FROM goods ORDER BY goods_no ASC LIMIT "
				+ beginRow + "," + rowPerPage;

		try {
			// 상품 정보를 담은 list객체 선언
			list = new ArrayList<Goods>();

			stmt = conn.prepareStatement(sql);
			System.out.println(stmt + "<-- stmt - selectGoodsListByPage");
			rs = stmt.executeQuery();

			while (rs.next()) { // 쿼리가 실행된다면
				// 디버깅
				System.out.println(rs + "<-- rs정상 실행 - selectGoodsListByPage");
				Goods g = new Goods();
				// 데이터 셋팅
				g.setGoodsNo(rs.getInt("goodsNo"));
				g.setGoodsName(rs.getString("goodsName"));
				g.setGoodsPrice(rs.getInt("goodsPrice"));
				g.setUpdateDate(rs.getString("updateDate"));
				g.setCreateDate(rs.getString("createDate"));
				g.setSoldOut(rs.getString("soldOut"));
				System.out.println(g + "<-- g Goods 정보");
				list.add(g);
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
			System.out.println("selectGoodsListByPage.jsp - DB연동 해제");
		}
		return list;
	}// end selectGoodsListByPdate
}
// end class
