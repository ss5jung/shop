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
			<form action="<%=request.getContextPath()%>/idCheckAction.jsp?user=Customer" method="post" id="idCkCustomerForm">
				<fieldset>
					<legend>
						<b>Customer ID 중복검사</b>
					</legend>
					<table class="table table-bordered">
						<tr>
							<th>ID</th>
							<td><input type="text" name="idck" id="idck">
								<button type="button" id="idckBtn">ID 중복검사</button></td>
						</tr>
					</table>
				</fieldset>
			</form>


			<form action="<%=request.getContextPath()%>/signUpCustomerAction.jsp" method="post" id="signUpCustomerForm">
				<fieldset>
					<legend>
						<b>고객 회원가입</b>
					</legend>
					<table>
						<tr>
							<th>ID</th>
							<td><input type="text" name="customerId" id="customerId" readonly="readonly"></td>
						</tr>
						<tr>
							<th>Password</th>
							<td><input type="password" id="customerPass" name="customerPass"></td>
						</tr>
						<tr>
							<th>Name</th>
							<td><input type="text" id="customerName" name="customerName"></td>
						</tr>
						<tr>
							<th>Address</th>
							<td><input type="text" id="customerAddress" name="customerAddress"></td>
						</tr>
						<tr>
							<th>Telephone</th>
							<td><input type="text" id="customerTelephone" name="customerTelephone"></td>
						</tr>
					</table>
					<button type="button" class="btn btn-success" style="float: right;" id="signUpCustomerBtn">회원가입</button>
				</fieldset>
			</form>
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
	$('#idckBtn').click(function() {
		if ($('#idck').val().length < 4) {
			
			alert('id는 4자이상!');
		} else {
		
			// 비동기 호출	
			$.ajax({
				url : '/shop/idckController',
				type : 'post',
				data : {
					idck : $('#idck').val()
				},
				success : function(json) {
					// alert(json);
					if (json == 'y') {
						$('#customerId').val($('#idck').val());
					} else {
						alert('이미 사용중인 아이디 입니다.');
						$('#customerId').val('');
					}
				},
				//요청실패시 실행될 콜백함수
				error : function(err) {
					alert('요청 실패');
					console.log(err);
				}
			});
		}
	});

	/* 회원가입 빈칸 검사*/
	$('#signUpCustomerBtn').click(function() {
		if ($('#customerPass').val() == '') {
			alert('고객님의 비밀번호를 입력하세요');
		} else if ($('#customerName').val() == '') {
			alert('고객님의 이름을 입력하세요');
		} else if ($('#customerAddress').val() == '') {
			alert('고객님의 주소를 입력하세요');
		} else if ($('#customerTelephone').val() == '') {
			alert('고객님의 전화번호를 입력하세요');
		} else {
			$('#signUpCustomerForm').submit();
		}
	});
</script>
</html>
