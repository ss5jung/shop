<%@page import="service.OrdersService"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
//전송받은 값 map에 셋팅
Map<String, Object> map = new HashMap<>();
map.put("orderNo", Integer.parseInt(request.getParameter("orderNo")));
map.put("orderAddr", request.getParameter("orderAddr"));
map.put("goodsNo", Integer.parseInt(request.getParameter("goodsNo")));
map.put("orderQuantity", Integer.parseInt(request.getParameter("orderQuantity")));
map.put("orderPrice", Integer.parseInt(request.getParameter("orderPrice")));
map.put("orderState", request.getParameter("orderState"));
//Serivce에 전송하기
int row = new OrdersService().addOrdersOne(map);
if(row == 1){
	System.out.println("주문 내역이 정상적으로 수정되었습니다.");
	response.sendRedirect(request.getContextPath()+"/admin/adminOrderList.jsp");
} else {
	System.out.println("주문 내역 수정이 실패하였습니다.");
	response.sendRedirect(request.getContextPath()+"/admin/adminOrderOne.jsp?orderNo="+map.get("orderNo"));
}
%>