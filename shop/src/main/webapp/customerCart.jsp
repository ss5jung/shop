<%@page import="java.util.Map"%>
<%@page import="vo.Cart"%>
<%@page import="java.util.List"%>
<%@page import="service.CartService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
//장바구니 리스트 가져오기
String customerId = (String) session.getAttribute("id");
List<Map<String, Object>> list = new CartService().getCartList(customerId);
%>
<%@include file="/hearder.jsp"%>

<!-- BREADCRUMB -->
<div id="breadcrumb" class="section">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<div class="col-md-12">
				<h3 class="breadcrumb-header">장바구니</h3>
				<ul class="breadcrumb-tree">
					<li class="active">장바구니</li>
					<li style="color: gray;">주문/결제</li>
					<li style="color: gray;">완료</li>
				</ul>
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
			<!-- 로그인이 되어있지 않으면 장바구니리스트 보여주지 않음 -->
			<%
			if (session.getAttribute("id") == null || list.isEmpty() ) {
			%>
			<div style="text-align: center; margin: 10% 0 10% 0">
				<h3>장바구니에 담긴 상품이 없습니다.</h3>
				<a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp"><button type="button" class="btn btn-dark">홈으로 가기</button></a>
			</div>
			<%
			} else {
			%>
			<!-- 장바구니 리스트-->
			<div>
				<table class="table">
					<thead>
						<tr>
							<th>상품 이미지</th>
							<th>상품명</th>
							<th>상품가격</th>
							<th>수량</th>
							<th>삭제</th>
						</tr>
					</thead>
					<tbody>
						<%
						for (Map<String, Object> map : list) {
						%>
						<tr>
							<td><img src="<%=request.getContextPath() %>/upload/<%=map.get("filename") %>" alt="상품이미지"></td>
							<td><%=map.get("goodsName") %></td>
							<td><%=map.get("goodsPrice") %></td>
							<td>
								<form method="post" action="<%=request.getContextPath()%>/customer/updateQtyInCartAction.jsp">
									<input type="hidden" value=<%=map.get("goodsNo")%> id="goodsNo" name="goodsNo"> 
									<input type="number" value=<%=map.get("cartQuantity")%> min="1" style="width: 40px" id="cartQuantity" name="cartQuantity">
									<button class="btn btn-primary btn-sm" type="submit">수량변경</button>
								</form>
							</td>
							<td><a href="<%=request.getContextPath()%>/customer/deleteCartOneAction.jsp?goodsNo=<%=map.get("goodsNo")%>"><button class="btn btn-danger btn-sm">삭제</button></a></td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
				<a href="<%=request.getContextPath()%>/customer/orderForm.jsp" class="primary-btn order-submit" style="float: right;">주문하기</a>
			</div>
			<!-- /Order Details -->
			<%
			}
			%>

		</div>
		<!-- /row -->
	</div>
	<!-- /container -->
</div>
<!-- /SECTION -->

<%@include file="/footer.jsp"%>

</body>
</html>
