<%@page import="service.OrdersService"%>
<%@page import="java.util.Map"%>
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
int orderNo = Integer.parseInt(request.getParameter("orderNo"));
//orderNo 연관된 주문가져오기 
Map<String, Object> order = new OrdersService().getOrdersOne(orderNo);
%>
<%@include file="/hearder.jsp"%>

<!-- BREADCRUMB -->
<div id="breadcrumb" class="section">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<div class="col-md-12">
				<h3 class="breadcrumb-header">주문 수정</h3>
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
			<form action="<%=request.getContextPath()%>/customer/updateOrderAction.jsp?orderNo=<%=orderNo%>" method="post">
				<table class="table table-hover">
					<tr>
						<th>상품명</th>
						<td><%=order.get("goodsName")%></td>
					</tr>
					<tr>
						<th>수량</th>
						<td><input type="number" name="orderQuantity" min="1" value="<%=order.get("orderQuantity")%>"></td>
					</tr>
				</table>
				<button class="btn btn-primary" id="updateOrderBtn" type="submit" style="float: right;">주문수정</button>
			</form>
		</div>
		<!-- /row -->
	</div>
	<!-- /container -->
</div>
<!-- SECTION -->
<!-- FOOTER -->
<%@include file="/footer.jsp"%>
<!-- /FOOTER -->
</body>
</html>