package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import repository.ChartDao;
import repository.DBUtil;

public class ChartService implements IChartService {
	private ChartDao chartDao;

	@Override
	public List<Map<String, Object>> getCountByOrder() {
		List<Map<String, Object>> list = null;
		chartDao = new ChartDao();
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			System.out.println("드라이버 연결 성공");
			//개별 커밋 해제
			conn.setAutoCommit(false);
			list = chartDao.selectCountByOrder(conn);
			//전체 커밋적용
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
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

}
