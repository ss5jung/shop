package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ChartDao implements IChartDao {

	@Override
	public List<Map<String, Object>> selectCountByOrder(Connection conn) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		String sql = ChartQuery.SELECT_COUNT_BY_ORDER;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> m = new HashMap<String, Object>();
				m.put("ym", rs.getString("ym"));
				m.put("cnt", rs.getInt("cnt"));
				list.add(m);
			}
		} finally {
			if(rs != null) {
				rs.close();
			}
			if(stmt != null) {
				stmt.close();
			}
		}
		return list;
	}

}
