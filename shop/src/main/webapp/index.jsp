<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
//접근제한
if (session.getAttribute("id") == null) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
%>
<%@include file="./hearder.jsp"%>

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
			<table class="table table-bordered">
				<tr>
					<td>USER</td>
					<td><%=session.getAttribute("user")%></td>
				</tr>
				<tr>
					<td>ID</td>
					<td><%=session.getAttribute("id")%></td>
				</tr>
				<tr>
					<td>NAME</td>
					<td><%=session.getAttribute("name")%></td>
				</tr>
			</table>
			<a href="<%=request.getContextPath()%>/signOut.jsp"><button type="button" class="btn btn-primary" style="float: left;">회원 탈퇴</button></a> <a href="<%=request.getContextPath()%>/logout.jsp"><button type="button" class="btn btn-danger" style="float: right;">로그아웃</button></a>
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