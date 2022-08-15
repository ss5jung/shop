<%@page import="vo.GoodsImg"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="service.GoodsService"%>
<%@page import="vo.Goods"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
//이미지 저장된 폴더의 위치
// String dir = "/shop/src/main/webapp/upload";
// C:\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp2\wtpwebapps
String dir = request.getSession().getServletContext().getRealPath("/upload");
System.out.println(dir + "<-- 이미지를 저장하는 폴더의 위치 dir");
//저장하려는 파일의 최대 용량 10MB 제한
int max = 10 * 1024 * 1024;
//MultipartRequest mRequest = new MultipartRequest(request 객체, 저장될 서버 경로, 파일 최대 크기, 인코딩 방식, 같은 이름의 파일명 방지 처리);
MultipartRequest mRequest = new MultipartRequest(request, dir, max, "utf-8", new DefaultFileRenamePolicy());
//데이터 셋팅할 goods객체 생성
Goods goods = new Goods();
//전송받은 데이터 셋팅
goods.setGoodsNo(Integer.parseInt(mRequest.getParameter("goodsNo")));
goods.setGoodsName(mRequest.getParameter("goodsName"));
goods.setGoodsPrice(Integer.parseInt(mRequest.getParameter("goodsPrice")));
goods.setSoldOut(mRequest.getParameter("soldOut"));
//디버깅
System.out.println("#######수정할 상품 정보 > " + goods);

//기존에 저장된 이미지 사진이 겹치는 데이터여서 삭제가 하면 안됨
//mRequest로 얻을 수 있는 변수 값
String contentType = mRequest.getContentType("goodsImg");
System.out.println(contentType + "<-- contentType");

String originFilename = mRequest.getOriginalFileName("goodsImg");
System.out.println(originFilename + "<-- originFilename 파일의 원본이름");

String filename = mRequest.getFilesystemName("goodsImg");
System.out.println(filename + "<-- filename 새로 생성된 파일이름");

//파일 형식 제한
if (!( contentType.equals("image/gif") || contentType.equals("image/png") || contentType.equals("image/jpeg") ) ) {
	//
	File f = new File(dir + "\\" + filename);
	//이미 업로드된 파일을 삭제
	if (f.exists()) {
		f.delete();
	}
	//에러메세지
	System.out.println("이미지 파일만 업로드 가능");
	//String errorMsg = URLEncoder.encode("이미지 파일만 업로드 가능", "utf-8");
	response.sendRedirect(request.getContextPath() + "/admin/adminGoodsOneUpdate.jsp");
	return;
}

//addGoods에 보낼 파라미터 GoodsImg 객체  
GoodsImg goodsImg = new GoodsImg();
goodsImg.setGoodsNo(Integer.parseInt(mRequest.getParameter("goodsNo")));
goodsImg.setFilename(filename);
goodsImg.setContentType(contentType);
goodsImg.setOriginFilename(originFilename);

int row = new GoodsService().updateGoodsOne(goods, goodsImg);

if (row == 1) { //상품 수정 성공했을 경우 
	System.out.println("상품 정보 수정이 정상적으로 이루워졌습니다.");
	response.sendRedirect(request.getContextPath() + "/admin/adminGoodsList.jsp");
} else { //상품 수정 실패했을 경우
	System.out.println("상품 정보 수정에 실패했습니다.");
	response.sendRedirect(request.getContextPath() + "/admin/adminGoodsOneUpdate.jsp?goodsNo="+goods.getGoodsNo());
}
%>
