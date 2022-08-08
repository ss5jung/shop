<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.oreilly.servlet.*" %>
<%@page import="com.oreilly.servlet.multipart.*" %>
<%@page import="service.GoodsService" %>
<%@page import="vo.Goods" %>
<%@page import="vo.GoodsImg" %>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	//저장하고자하는 폴더의 위치
	// String dir = "/shop/src/main/webapp/upload";
	String dir = request.getServletContext().getRealPath("/upload");
	System.out.println(dir + "<-- 이미지를 저장하는 폴더의 위치 dir");
	//저장하려는 파일의 최대 용량 10MB 제한
	int max = 10 * 1024 * 1024;
	//MultipartRequest mRequest = new MultipartRequest(request 객체, 저장될 서버 경로, 파일 최대 크기, 인코딩 방식, 같은 이름의 파일명 방지 처리);
	MultipartRequest mRequest = new MultipartRequest(request, dir, max, "utf-8", new DefaultFileRenamePolicy());
	//전송받은 값
	String goodsName = mRequest.getParameter("goodsName");
	String goodsPrice = mRequest.getParameter("goodsPrice");
	//디버깅
	System.out.println(goodsName + "<-- goodsName");
	System.out.println(goodsPrice + "<-- goodsPrice");
	//
	String contentType = mRequest.getContentType("goodsImg");
	String originFilename = mRequest.getOriginalFileName("goodsImg");
	String filename = mRequest.getFileNames("goodsImg");
	//리턴받을 값
	int row = new GoodsService().
%>
