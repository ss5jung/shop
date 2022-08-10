package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import service.SignService;

@WebServlet("/idckController")
public class IdCkController extends HttpServlet {
	private SignService signService;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//인코딩
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		
		//SignService 객체 생성
		this.signService = new SignService();
		
		//중복검사하려는 값
		String idck = request.getParameter("idck");
		System.out.println(idck + " <-- idck");
		
		//service에서 받은 리턴값 저장
		String id = this.signService.getIdCheck(idck);
		
		Gson gson = new Gson();
		String jsonStr = "";
		if(id == null) { // id -> null -> idck사용가능 -> yes
			jsonStr = gson.toJson("y");
		} else {	// id -> select값 -> idck사용불가 -> no
			jsonStr = gson.toJson("n");
		}
		
		PrintWriter out = response.getWriter();
		out.write(jsonStr);
		out.flush();
		out.close();
	}
}