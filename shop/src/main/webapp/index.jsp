<%@page import="service.ReviewService"%>
<%@page import="service.CustomerService"%>
<%@page import="java.util.List"%>
<%@page import="service.OrdersService"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="service.GoodsService"%>
<%@page import="vo.*"%>
<%@page import="service.EmployeeService"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
//접근제한
if (session.getAttribute("id") == null) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
//전송받은 값
String customerId = (String) session.getAttribute("id");
Customer loginUser = new CustomerService().getCustomerOne(customerId);
System.out.println("----" + customerId + " 주문리스트----");
//회원 정보 가져오기
Customer customer = new CustomerService().getCustomerOne(customerId);
//customer_id와 연관된 주문가져오기 - List<Order>
List<Map<String, Object>> list = new OrdersService().getCustomerOrdersList(customerId);
System.out.println(list + "<-- list");
if (list.isEmpty()) {
	System.out.println("주문 내역이 존재하지 않습니다");
}
%>
<%@include file="/hearder.jsp"%>

<!-- BREADCRUMB -->
<div id="breadcrumb" class="section">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<div class="col-md-12">
				<h3 class="breadcrumb-header"><%=session.getAttribute("user")%>
					정보
				</h3>
			</div>
		</div>
		<!-- /row -->
	</div>
	<!-- /container -->
</div>
<!-- /BREADCRUMB -->

<!-- SECTION -->
<div class="section">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<h3>내 정보</h3>
			<hr>
			<table class="table table-striped">
				<tr>
					<th>아이디</th>
					<td><%=loginUser.getCustomerId()%></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><%=loginUser.getCustomerName()%></td>
				</tr>
				<tr>
					<th>주소</th>
					<td><%=loginUser.getCustomerAddress()%></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td><%=loginUser.getCustomerTelephone()%></td>
				</tr>
				<tr>
					<th>가입일</th>
					<td><%=loginUser.getCreateDate()%></td>
				</tr>
			</table>
			<a href="<%=request.getContextPath()%>/signOut.jsp"><button type="button" class="btn btn-danger" style="float: left;">회원탈퇴</button></a> <a href="<%=request.getContextPath()%>/logout.jsp"><button type="button" class="btn btn-primary" style="float: right; margin-left: 5px">로그아웃</button></a> <a href="<%=request.getContextPath()%>/customer/updateCustomerOne.jsp"><button type="button" class="btn btn-success" style="float: right;">정보수정</button></a>
		</div>
		<div class="row">
			<h3 style="margin-top: 5%">주문내역</h3>
			<hr>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>상품명</th>
						<th>수량</th>
						<th>가격</th>
						<th>합계</th>
						<th>배송지</th>
						<th>주문상태</th>
						<th>주문일</th>
						<th>비고</th>
					</tr>
				</thead>
				<tbody>
					<%
					if (list.isEmpty()) {
					%>
					<tr>
						<td colspan="10" style="text-align: center;">주문 내역이 존재하지 않습니다</td>
					</tr>
					<%
					} else {
					for (Map<String, Object> m : list) {
					%>
					<tr>
						<td><%=m.get("goodsName")%></td>
						<td><%=m.get("orderQuantity")%></td>
						<td><%=m.get("orderPrice")%></td>
						<td><%=m.get("orderTotalPrice")%></td>
						<td><%=m.get("orderAddr")%></td>
						<td><%=m.get("orderState")%></td>
						<td><%=m.get("createDate")%></td>
						<td>
							<%
							if (m.get("orderState").equals("배송완료")) {
								if(new ReviewService().getReviewCk((int)m.get("orderNo")) == 0){
							%>
								<a href="<%=request.getContextPath()%>/customer/insertReview.jsp?orderNo=<%=m.get("orderNo")%>"><button class="btn btn-xs btn-primary" id="insertReviewBtn">후기작성</button></a>
							<%
								} else {
							%>
							 	<a href="<%=request.getContextPath()%>/customer/updateReview.jsp?orderNo=<%=m.get("orderNo")%>"><button class="btn btn-xs btn-success" id="insertReviewBtn">후기수정</button></a>
							<%
								}
							 }
							 if (m.get("orderState").equals("주문완료")) {
							 %>
							 <a href="<%=request.getContextPath()%>/customer/updateOrder.jsp?orderNo=<%=m.get("orderNo")%>"><button class="btn btn-xs btn-warning" id="updateOrderBtn">주문수정</button></a>
							<%
							 }
							 if (m.get("orderState").equals("결제대기") || m.get("orderState").equals("주문완료")) {
							 %>
							 <a href="<%=request.getContextPath()%>/customer/deleteOrder.jsp?orderNo=<%=m.get("orderNo")%>"><button class="btn btn-xs btn-danger" id="deleteOrderBtn">주문취소</button></a>
							<%
							 }
							 %>
						</td>
					</tr>
					<%
					}
					}
					%>
				</tbody>
			</table>
		</div>
		<!-- /row -->
	</div>
	<!-- /container -->
</div>
<!-- SECTION -->
<!-- FOOTER -->
<%@include file="./footer.jsp"%>
<!-- /FOOTER -->
</body>
</html>