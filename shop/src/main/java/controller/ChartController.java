package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import service.ChartService;

@WebServlet("/controller/*")
public class ChartController extends HttpServlet {
	private ChartService chartService;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 응답 형태 결정
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		Gson gson = new Gson();
		String result = "";
		
		String uri = request.getRequestURI();
		System.out.println(uri);
		int n = request.getContextPath().length();
		String command = uri.substring(n);
		
		chartService = new ChartService();
		
		if(command.equals("/controller/getCountByOrder")) {
			List<Map<String, Object>> list = chartService.getCountByOrder();
			result = gson.toJson(list);
		} else {
			System.out.println("잘못된 요청");
		}
		
		PrintWriter out = response.getWriter();
		out.write(result);
		out.flush();
		out.close();
	}
}
