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
				<h3 class="breadcrumb-header">완료</h3>
				<ul class="breadcrumb-tree">
					<li style="color: gray;">장바구니</li>
					<li style="color: gray;">주문/결제</li>
					<li class="active">완료</li>
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
			<div style="text-align: center; margin: 10% 0 10% 0">
				<h3>주문이 정상적으로 진행되었습니다</h3>
				<a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp"><button type="button" class="btn btn-dark">홈으로 가기</button></a>
			</div>
		</div>
		<!-- /row -->
	</div>
	<!-- /container -->
</div>
<!-- /SECTION -->

<%@include file="/footer.jsp"%>

</body>
</html>
