package repository;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

public interface IChartDao {
	List<Map<String,Object>> selectCountByOrder(Connection conn) throws Exception;
}
