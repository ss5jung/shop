<%@page import="service.CustomerService"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
//접근제한
if (session.getAttribute("id") == null) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
//로그인한 유저의 정보 가져오기
String customerId = (String)session.getAttribute("id");
Customer loginUser = new CustomerService().getCustomerOne(customerId);
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
			<a href="<%=request.getContextPath()%>/signOut.jsp"><button type="button" class="btn btn-danger" style="float: left;">회원탈퇴</button></a> 
			<a href="<%=request.getContextPath()%>/logout.jsp"><button type="button" class="btn btn-primary" style="float: right; margin-left: 5px">로그아웃</button></a>
			<a href="<%=request.getContextPath()%>/customer/updateCustomerOne.jsp"><button type="button" class="btn btn-success" style="float: right;">정보수정</button></a>
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