package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import vo.GoodsImg;

public class GoodsImgDAO {
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
