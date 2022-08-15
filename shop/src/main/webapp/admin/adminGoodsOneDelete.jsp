<%@page import="service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
//전송받은 값
int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
System.out.println(goodsNo + "<-- goodsNo");
//삭제 실행하기
int row = new GoodsService().deleteGoodsOne(goodsNo);
if (row == 1) {
	System.out.println(goodsNo+"번째 상품이 정상적으로 삭제되었습니다.");
	response.sendRedirect(request.getContextPath() + "/admin/adminGoodsList.jsp");
} else {
	System.out.println("상품 삭제에 실패하였습니다.");
	response.sendRedirect(request.getContextPath() + "/admin/adminGoodsOne.jsp?goodsNo=" + goodsNo);
}
%>