<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
String customerId = null;
//중복검사 확인 
String idCkBoolean = request.getParameter("idCkBoolean"); //true 또는 false
String idCkMsg = request.getParameter("idCkMsg");
%>
<%@include file="./hearder.jsp"%>
<!-- BREADCRUMB -->
<div id="breadcrumb" class="section">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<div class="col-md-12">
				<h3 class="breadcrumb-header">회원가입</h3>
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
			<!-- 흐름 : 아이디 입력 -> 중복검사 -> 통과하면   -> addCustomer -> 회원가입 폼 입력후 -> addCustomerAction -->
			<!-- 고객 아이디 중복검사 -->
			<form action="<%=request.getContextPath()%>/idCheckAction.jsp" method="post" id="idCkForm">
				<fieldset>
				<legend>ID 중복검사</legend>
				<table class="table table-bordered">
					<tr>
						<td>ID</td>
						<td>
							<input type="text" id="customerId" name="customerId">
							<button type="button" id="idCkBtn">ID중복검사</button> <!-- idCkMsg가 true이면 밑에 입력 false이면 다시 값 입력후 아이디 중복검사해 --> 
							<%
							 if (idCkMsg != null) {
							 %> 
							 <span style="color: red;"><%=idCkMsg%></span> <%
							 }
							 %>
						 </td>
					</tr>
				</table>
				</fieldset>
			</form>
			<hr>
			<!-- 중복 검사를 통과하면 회원가입 폼 뜬다. -->
			<%
			if (idCkBoolean != null && idCkBoolean.equals("true")) { // 중복검사에 통과한다면 
				customerId = request.getParameter("checkedId"); //통과한 아이디값 가져오기
				System.out.println(customerId + "<--customerId : 중복검사 통과한 아이디");
			%>
			<form action="<%=request.getContextPath()%>/signUpAction.jsp" method="post" id="signUpForm">
				<fieldset>
				<legend>회원가입</legend>
				<table>
					<tr>
						<td>ID</td>
						<td><input type="text" id="customerId" name="customerId" value="<%=customerId%>" readonly="readonly"></td>
					</tr>
					<tr>
						<td>Password</td>
						<td><input type="password" id="customerPass" name="customerPass"></td>
					</tr>
					<tr>
						<td>Name</td>
						<td><input type="text" id="customerName" name="customerName"></td>
					</tr>
					<tr>
						<td>Address</td>
						<td><input type="text" id="customerAddress" name="customerAddress"></td>
					</tr>
					<tr>
						<td>Telephone</td>
						<td><input type="text" id="customerTelephone" name="customerTelephone"></td>
					</tr>
				</table>
				<button type="button" class="btn btn-success" style="float: right;" id="signUpBtn">회원가입</button>
				</fieldset>
			</form>
			<%
			}
			%>
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
<script>
	/* 아이디 중복 검사 빈칸 검사 */
	$('#idCkBtn').click(function() {
		if ($('#customerId').val() == '') {
			alert('중복검사 받으실 아이디를 입력하세요');
		} else {
			$('#idCkForm').submit();
		}
	});
	/* 회원가입 빈칸 검사*/
	$('#signUpBtn').click(function() {
		if ($('#customerPass').val() == '') {
			alert('고객님의 비밀번호를 입력하세요');
		} else if ($('#customerName').val() == '') {
			alert('고객님의 이름을 입력하세요');
		} else if ($('#customerAddress').val() == '') {
			alert('고객님의 주소를 입력하세요');
		} else if ($('#customerTelephone').val() == '') {
			alert('고객님의 전화번호를 입력하세요');
		} else {
			$('#signUpForm').submit();
		}
	});
</script>
</html>
