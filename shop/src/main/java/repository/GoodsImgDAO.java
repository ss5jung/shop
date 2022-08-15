package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import vo.GoodsImg;

public class GoodsImgDAO {
	// 상품 사진 삭제하기 D
	public int deleteGoodsOneImg(Connection conn, int goodsNo) throws Exception {
		// 파라미터 디버깅
		System.out.println(goodsNo + "<-- goodsNo - deleteGoodsOneImg");
		// 리턴할 변수 선언
		int imgRow = 0;
		// DB 자원
		PreparedStatement stmt = null;
		String sql = "DELETE FROM goods_img WHERE goods_no = ?";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo);
			System.out.println(stmt + "<-- stmt");
			imgRow = stmt.executeUpdate();
			if (imgRow == 0) { // goods_img 테이블에서 삭제가 안되면 goods 테이블에서 삭제가 되지 않으니까 예외처리한다
				throw new Exception();
			}
		} finally {
			// DB 자원 해제
			if (stmt != null) {
				stmt.close();
			}
		}
		return imgRow;
	}

	// 이미지 수정
	public int updateGoodsImg(Connection conn, GoodsImg goodsImg) throws Exception {
		// 리턴할 변수
		int row = 0;
		PreparedStatement stmt = null;
		String sql = "UPDATE goods_img SET filename=?, origin_filename=?, content_type = ? WHERE goods_no =?";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, goodsImg.getFilename());
			stmt.setString(2, goodsImg.getOriginFilename());
			stmt.setString(3, goodsImg.getContentType());
			stmt.setInt(4, goodsImg.getGoodsNo());
			// 디버깅
			System.out.println(stmt + "<-- stmt");
			row = stmt.executeUpdate();
			if (row == 0) {
				throw new Exception();
			}
		} finally {
			// DB자원 해제
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// 이미지 추가
	public int insertGoodsImg(Connection conn, GoodsImg goodsImg) throws SQLException {
		// 파라미터 디버깅
		System.out.println(goodsImg + "<-- insertGoodsImg 파라미터 디버깅");
		// 리턴할 변수 선언 및 초기화
		int row = 0;
		// DB 자원 초기화
		PreparedStatement stmt = null;
		String sql = "INSERT INTO goods_img (goods_no, filename, origin_filename, content_type, create_date) VALUES (?, ?, ?, ?, NOW())";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsImg.getGoodsNo());
			stmt.setString(2, goodsImg.getFilename());
			stmt.setString(3, goodsImg.getOriginFilename());
			stmt.setString(4, goodsImg.getContentType());
			System.out.println(stmt + "<--stmt - insertGoodsImg");
			// 실행
			row = stmt.executeUpdate();
			System.out.println(row + "<-- row - insertGoodsImg");
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}
}
