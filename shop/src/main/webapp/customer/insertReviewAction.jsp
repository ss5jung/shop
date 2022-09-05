<%@page import="service.ReviewService"%>
<%@page import="vo.Review"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
//접근제한
if (session.getAttribute("id") == null) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
//로그인한 유저의 정보 가져오기
int orderNo = Integer.parseInt(request.getParameter("orderNo"));
String reviewContent = request.getParameter("reviewContent");
Review review = new Review();
review.setOrderNo(orderNo);
review.setReviewContent(reviewContent);
//service cal
int row = new ReviewService().addReview(review);
if(row != 0){
	response.sendRedirect(request.getContextPath()+"/index.jsp");
} else {
	response.sendRedirect(request.getContextPath()+"/customer/insertReview.jsp?orderNo="+orderNo);
}
%>