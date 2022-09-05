<%@page import="service.ReviewService"%>
<%@page import="vo.Cart"%>
<%@page import="service.CartService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
//요청받은 값
int orderNo = Integer.parseInt(request.getParameter("orderNo"));
//service call
int row = new ReviewService().removeReview(orderNo);
if (row != 0) {
	System.out.println("리뷰 삭제");
	//리다이렉트
	response.sendRedirect(request.getContextPath() + "/index.jsp");
} else {
	response.sendRedirect(request.getContextPath() + "/customer/updateReview.jsp?orderNo="+orderNo);
}

%>
