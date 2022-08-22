<%@page import="service.ReviewService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
int orderNo = 0;	//전송받은 값을 받을 변수
if (request.getParameter("orderNo") != null) {	//전송받은 값이 있다면
	orderNo = Integer.parseInt(request.getParameter("orderNo"));
	System.out.println(orderNo + "<-- orderNo의 리뷰 삭제");
} else {	//전송받은 값 없다면
	System.out.println("리뷰 삭제 orderNo을 전송받지 못함");
	response.sendRedirect(request.getContextPath()+"/admin/adminGoodsList.jsp");
	return;
}
//Service call
int row = new ReviewService().removeReview(orderNo);
if(row != 0){
	System.out.println(orderNo + "의 리뷰 삭제 성공!");
	response.sendRedirect(request.getContextPath()+"/admin/adminGoodsOne.jsp?orderNo="+orderNo);
} else{
	System.out.println(orderNo + "의 리뷰 삭제 실패!");
	response.sendRedirect(request.getContextPath()+"/admin/adminGoodsOne.jsp?orderNo="+orderNo);
}
%>
