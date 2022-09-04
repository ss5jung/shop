<%@page import="vo.Cart"%>
<%@page import="service.CartService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
//요청받은 값
int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
String customerId = (String) session.getAttribute("id");
//셋팅
Cart cart = new Cart();
cart.setCustomerId(customerId);
cart.setGoodsNo(goodsNo);
//service call
int row = new CartService().removeCart(cart);
if (row != 0) {
	System.out.println("장바구니 삭제");
}
//리다이렉트
response.sendRedirect(request.getContextPath() + "/customer/customerCart.jsp");
%>
