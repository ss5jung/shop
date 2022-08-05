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
			<form action="<%=request.getContextPath()%>/idCheckAction.jsp?user=Employee" method="post" id="idCkEmployeeForm">
				<fieldset>
				<legend><b>Employee ID 중복검사</b></legend>
				<table class="table table-bordered">
					<tr>
						<th>ID</th>
						<td>
							<input type="text" id="checkId" name="checkId">
							<button type="button" id="idCkEmployeeBtn">ID중복검사</button> <!-- idCkMsg가 true이면 밑에 입력 false이면 다시 값 입력후 아이디 중복검사해 --> 
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
			<!-- 중복 검사를 통과하면 회원가입 폼 뜬다. -->
			<%
			if (idCkBoolean != null && idCkBoolean.equals("true")) { // 중복검사에 통과한다면 
				employeeId = request.getParameter("checkedId"); //통과한 아이디값 가져오기
				System.out.println(employeeId + "<--employeeId : 중복검사 통과한 아이디");
			%>
			<form action="<%=request.getContextPath()%>/signUpEmployeeAction.jsp" method="post" id="signUpEmployeeForm">
				<fieldset>
				<legend><b>직원 회원가입</b></legend>
				<table>
					<tr>
						<th>ID</th>
						<td><input type="text" id="employeeId" name="employeeId" value="<%=employeeId%>" readonly="readonly"></td>
					</tr>
					<tr>
						<th>Password</th>
						<td><input type="password" id="employeePass" name="employeePass"></td>
					</tr>
					<tr>
						<th>Name</th>
						<td><input type="text" id="employeeName" name="employeeName"></td>
					</tr>
				</table>
				<button type="button" class="btn btn-success" style="float: right;" id="signUpEmployeeBtn">회원가입</button>
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
	$('#idCkEmployeeBtn').click(function() {
		if ($('#checkId').val() == '' || $('#checkId').val() == null) {
			alert('중복검사 받으실 아이디를 입력하세요');
		} else {
			$('#idCkEmployeeForm').submit();
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
