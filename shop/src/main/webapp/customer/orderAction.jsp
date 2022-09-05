<%@page import="service.CartService"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="vo.Orders"%>
<%@page import="service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%
//인코딩
request.setCharacterEncoding("utf-8");
//장바구니 리스트 가져오기
String customerId = (String) session.getAttribute("id");
List<Map<String, Object>> list = new CartService().getCartList(customerId);
//주문하기
for(Map<String, Object> o : list){
	Orders order = new Orders();
	order.setGoodsNo((int)o.get("goodsNo"));
	order.setCustomerId(customerId);
	order.setOrderQuantity((int)o.get("cartQuantity"));
	order.setOrderPrice((int)o.get("goodsPrice"));
	order.setOrderAddr(request.getParameter("customerAddress")+" "+request.getParameter("customerDetailAddr"));
	order.setOrderState("주문완료");
	System.out.println(order+"<-- order");
	new OrdersService().addOrder(order);
}
response.sendRedirect(request.getContextPath()+"/customer/orderSuccess.jsp");
%>