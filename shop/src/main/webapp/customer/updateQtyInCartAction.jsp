<%@page import="service.CartService"%>
<%@page import="vo.Cart"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
//요청받은 값
int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
int cartQuantity = Integer.parseInt(request.getParameter("cartQuantity"));
String customerId = (String)session.getAttribute("id");
System.out.println(goodsNo+"<--goodsNo");
System.out.println(cartQuantity+"<--cartQuantity");
Cart cart = new Cart();
cart.setGoodsNo(goodsNo);
cart.setCartQuantity(cartQuantity);
cart.setCustomerId(customerId);
System.out.println(cart + "<-- cart");
//service call
int row = new CartService().modifyCart(cart);
response.sendRedirect(request.getContextPath()+"/customer/customerCart.jsp");

%>
