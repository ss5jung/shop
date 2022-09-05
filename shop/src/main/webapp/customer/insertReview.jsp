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
int orderNo = Integer.parseInt(request.getParameter("orderNo"));
%>
<%@include file="/hearder.jsp"%>

<!-- BREADCRUMB -->
<div id="breadcrumb" class="section">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<div class="col-md-12">
				<h3>후기 작성
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
			<!-- Review Form -->
			<div id="review-form">
				<form class="review-form" action="<%=request.getContextPath()%>/customer/insertReviewAction.jsp" method="post">
					주문번호 : 
					<input class="input" type="text" id="orderNo" name="orderNo" value="<%=orderNo%>" readonly="readonly">
					주문 고객 ID :
					<input class="input" type="text" value="<%=session.getAttribute("id")%>" readonly="readonly">
					내용 : 
					<textarea class="input" id="reviewContent" name="reviewContent" placeholder="상품 후기를 작성해주세요"></textarea>
					<button class="primary-btn" id="insertReviewActionBtn" style="float: right;">Submit</button>
				</form>
			</div>
			<!-- /Review Form -->
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
<script>
$('#insertReviewActionBtn').click(function() {
	if($('#reviewContent').val() == ''){
		alert('내용을 입력하세요');
	}
});
</script>
</html>