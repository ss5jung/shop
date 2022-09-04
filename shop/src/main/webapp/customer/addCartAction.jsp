<%@page import="vo.Cart"%>
<%@page import="service.CartService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
//요청받은 값
String customerId = (String)session.getAttribute("id");
int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
int qty = Integer.parseInt(request.getParameter("qty"));
System.out.println("---------------------addCartAction");
System.out.println(goodsNo + "<-- goodsNo");
System.out.println(qty + "<-- qty");
//cart set
Cart cart = new Cart();
cart.setGoodsNo(goodsNo);
cart.setCartQuantity(qty);
cart.setCustomerId(customerId);
//sevice call
int row = new CartService().addCart(cart);
if(row != 0){
	response.sendRedirect(request.getContextPath()+"/customer/customerCart.jsp");
} else {
	response.sendRedirect(request.getContextPath()+"/customer/customerGoodsList.jsp");
}
%>
