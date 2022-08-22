package listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class DirverListener implements ServletContextListener {

	public void contextInitialized(ServletContextEvent sce) {
		//현재 접속자 수 0로 설정
		sce.getServletContext().setAttribute("currentCounter", 0);
		
		//
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			System.out.println("####드라이버 로딩 성공####");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
}
