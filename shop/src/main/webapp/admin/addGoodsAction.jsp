<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.oreilly.servlet.*"%>
<%@page import="com.oreilly.servlet.multipart.*"%>
<%@page import="service.GoodsService"%>
<%@page import="vo.Goods"%>
<%@page import="vo.GoodsImg"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
//저장하고자하는 폴더의 위치
// String dir = "/shop/src/main/webapp/upload";
String dir = request.getServletContext().getRealPath("/upload");
System.out.println(dir + "<-- 이미지를 저장하는 폴더의 위치 dir");
//저장하려는 파일의 최대 용량 10MB 제한
int max = 15 * 1024 * 1024;
//MultipartRequest mRequest = new MultipartRequest(request 객체, 저장될 서버 경로, 파일 최대 크기, 인코딩 방식, 같은 이름의 파일명 방지 처리);
MultipartRequest mRequest = new MultipartRequest(request, dir, max, "utf-8", new DefaultFileRenamePolicy());
//전송받은 값
String goodsName = mRequest.getParameter("goodsName");
System.out.println(goodsName + "<-- goodsName");

int goodsPrice = Integer.parseInt(mRequest.getParameter("goodsPrice"));
System.out.println(goodsPrice + "<-- goodsPrice");
//service에서 전송할 파라미터 goods 객체
Goods goods = new Goods();
goods.setGoodsName(goodsName);
goods.setGoodsPrice(goodsPrice);

//mRequest로 얻을 수 있는 변수 값
String contentType = mRequest.getContentType("goodsImg");
System.out.println(contentType + "<-- contentType");

String originFilename = mRequest.getOriginalFileName("goodsImg");
System.out.println(originFilename + "<-- originFilename 파일의 원본이름");

String filename = mRequest.getFilesystemName("goodsImg");
System.out.println(filename + "<-- filename 새로 생성된 파일이름");

//파일 형식 제한
if (!(contentType.equals("image/gif") || contentType.equals("image/png") || contentType.equals("image/jpg"))) {
	File f = new File(dir + "\\" + filename);
	//이미 업로드된 파일을 삭제
	if (f.exists()) {
		f.delete();
	}
	//에러메세지
	System.out.println("이미지 파일만 업로드 가능");
	//String errorMsg = URLEncoder.encode("이미지 파일만 업로드 가능", "utf-8");
	response.sendRedirect(request.getContextPath() + "/addGoodsForm.jsp");
	return;
}
//addGoods에 보낼 파라미터 GoodsImg 객체  
GoodsImg goodsImg = new GoodsImg();

goodsImg.setFilename(filename);
goodsImg.setContentType(contentType);
goodsImg.setOriginFilename(originFilename);

//리턴받을 값
int row = new GoodsService().addGoods(goods, goodsImg);

if(row == 1){
	System.out.println("상품 추가가 정상적으로 이루워졌습니다.");
} else {
	System.out.println("상품 추가에 실패했습니다.");
}
%>
