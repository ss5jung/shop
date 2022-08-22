package repository;

public class ChartQuery {
	public static final String SELECT_COUNT_BY_ORDER
		= "SELECT CONCAT(YEAR(create_date), '-', MONTH(create_date)) ym, COUNT(*) cnt FROM orders GROUP BY ym";

}
