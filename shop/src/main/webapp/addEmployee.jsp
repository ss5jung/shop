<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
String employeeId = null;
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
			<!-- 흐름 : 아이디 입력 -> 중복검사 -> 통과하면   -> addEmployee -> 회원가입 폼 입력후 -> addEmployeerAction -->
			<!-- 직원 아이디 중복검사 -->
			<table class="table table-bordered" style="margin-bottom: 3%">
				<tr>
					<th style="font-size: 15px">Employee ID 중복검사</th>
					<td><input type="text" name="idck" id="idck">
						<button type="button" id="idckBtn">ID 중복검사</button></td>
				</tr>
			</table>

			<form action="<%=request.getContextPath()%>/signUpEmployeeAction.jsp" method="post" id="signUpEmployeeForm">
				<fieldset>
					<legend>
						<b>직원 회원가입</b>
					</legend>
					<table class="table table-bordered">
						<tr>
							<th>ID</th>
							<td><input class="form-control" type="text" id="employeeId" name="employeeId" readonly="readonly"></td>
						</tr>
						<tr>
							<th>Password</th>
							<td><input class="form-control" type="password" id="employeePass" name="employeePass"></td>
						</tr>
						<tr>
							<th>Name</th>
							<td><input class="form-control" type="text" id="employeeName" name="employeeName"></td>
						</tr>
					</table>
					<button type="button" class="btn btn-success" style="float: right;" id="signUpEmployeeBtn">회원가입</button>
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
						$('#employeeId').val($('#idck').val());
					} else {
						alert('이미 사용중인 아이디 입니다.');
						$('#employeeId').val('');
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
	$('#signUpEmployeeBtn').click(function() {
		if ($('#employeePass').val() == '') {
			alert('비밀번호를 입력하세요');
		} else if ($('#employeeName').val() == '') {
			alert('이름을 입력하세요');
		} else {
			$('#signUpEmployeeForm').submit();
		}
	});
</script>
</html>
