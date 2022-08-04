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
				<h3 class="breadcrumb-header">멤버탈퇴</h3>
				<!-- 					
					<ul class="breadcrumb-tree">
						<li><a href="#">Home</a></li>
						<li class="active">Blank</li>
					</ul>
					-->
			</div>
		</div>
		<!-- /row -->
	</div>
	<!-- /container -->
</div>
<!-- /BREADCRUMB -->

<!-- SIGNOUT  -->
<!-- SECTION -->
<div class="section">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<!-- signout form -->
			<form method="post" action="<%=request.getContextPath()%>/signOut<%=session.getAttribute("user")%>Action.jsp" id="signOutForm">
				<fieldset>
					<label for="signOutId">ID:</label>
					<input type="text" id="signOutId" name="signOutId" value="<%=session.getAttribute("id")%>" readonly="readonly">
					<label for="signOutPw">Password:</label>
					<input type="password" id="signOutPw" name="signOutPw">
					<button type="button" id="signOutBtn" class="btn btn-danger" style="float: right;">탈퇴</button>
					<a href="<%=request.getContextPath()%>/index.jsp"><button type="button" class="btn btn-primary" style="float: right;">이전</button></a>
				</fieldset>
			</form>
			<!-- signout form -->
		</div>
		<!-- /row -->
	</div>
	<!-- /container -->
</div>
<!-- SECTION -->
<!-- SIGNOUT  -->

<!-- FOOTER -->
<%@include file="./footer.jsp"%>
<!-- /FOOTER -->
</body>
<script>
	/* 탈퇴 비밀번호 빈칸검사 */
	$('#signOutBtn').click(function() {
		if ($('#signOutPw').val() == '') {
			alert('비밀번호를 입력하세요');
		} else {
			$('#signOutForm').submit();
		}
	});
</script>
</html>