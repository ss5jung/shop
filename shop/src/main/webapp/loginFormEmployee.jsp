<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="euc-kr">
<head>
<title>Login V2</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/login/images/icons/favicon.ico" />
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/login/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/login/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/login/fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/login/vendor/animate/animate.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/login/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/login/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/login/vendor/select2/select2.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/login/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/login/css/util.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/login/css/main.css">
<!--===============================================================================================-->
</head>
<body>
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100">
				<form class="login100-form validate-form" action="<%=request.getContextPath()%>/customerLoginAction.jsp" method="post" id="customerLogin">
					<fieldset>
						<span class="login100-form-title p-b-48"> <img src="<%=request.getContextPath()%>/login/images/mamazon-black.png" alt="mamazon logo"> <!-- 						<i class="zmdi zmdi-font"></i> -->
						</span>

						<div class="wrap-input100 validate-input">
							<input class="input100" type="text" id="employeeId" name="employeeId">
							<span class="focus-input100" data-placeholder="Employee Id"></span>
						</div>

						<div class="wrap-input100 validate-input">
							<span class="btn-show-pass"> <i class="zmdi zmdi-eye"></i>
							</span>
							<input class="input100" type="password" id=employeePass name="employeePass">
							<span class="focus-input100" data-placeholder="Employee Password"></span>
						</div>

						<div class="container-login100-form-btn">
							<div class="wrap-login100-form-btn">
								<div class="login100-form-bgbtn"></div>
								<button class="login100-form-btn" id="employeeBtn">Login</button>
							</div>
						</div>
						
						<div class="text-center p-t-115">
							<div>
								<a href="<%=request.getContextPath()%>/loginFormCustomer.jsp"><b style="font-size: 20px;color: #f30000;">LOGIN for Customer</b></a>
							</div>
							<span class="txt1"> Don’t have an account? </span> <a class="txt2" href="#"> Sign Up </a>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
	</div>

	<div id="dropDownSelect1"></div>

	<!--===============================================================================================-->
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
	<!--===============================================================================================-->
	<script src="vendor/animsition/js/animsition.min.js"></script>
	<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
	<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
	<!--===============================================================================================-->
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
	<!--===============================================================================================-->
	<script src="vendor/countdowntime/countdowntime.js"></script>
	<!--===============================================================================================-->
	<script src="js/main.js"></script>
</body>
<script>
	/* 쇼핑몰 관리자 로그인 */
	$('#employeeBtn').click(function() {
		if ($('#employeeId').val() == '') {
			alert('관리자의 아이디를 입력하세요');
		} else if ($('#employeePass').val() == '') {
			alert('관리자의 비밀번호를 입력하세요');
		} else {
			$('#employeeLogin').submit();
		}
	});
</script>
</html>