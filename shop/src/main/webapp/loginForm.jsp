<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
%>
<%@include file="./hearder.jsp"%>

	<!-- BREADCRUMB -->
	<div id="breadcrumb" class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<div class="col-md-12">
					<h3 class="breadcrumb-header">Login</h3>
				</div>
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- /BREADCRUMB -->


	<!-- errorMsg -->
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<%
			String errorMsg = request.getParameter("errorMsg");
			if (errorMsg != null) {
			%>
			<span style="color: red;"><%=errorMsg%></span>
			<%
			}
			%>
		</div>
	</div>
	<!-- errorMsg -->

	<!-- SECTION -->
	<div class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<div class="col-lg-6">
					<form action="<%=request.getContextPath()%>/customerLoginAction.jsp" method="post" id="customerLogin">
						<fieldset>
							<legend>
								<b>Customer Login</b>
							</legend>
							<table class="table table-bordered">
								<tr>
									<td>ID</td>
									<td><input type="text" class="form-control" id="customerId" name="customerId"></td>
								</tr>
								<tr>
									<td>Password</td>
									<td><input type="password" class="form-control" id=customerPass name="customerPass"></td>
								</tr>
							</table>
							<button type="button" id="customerBtn" class="btn btn-primary" style="float: right;">고객 로그인</button>
						</fieldset>
					</form>
					<a href="<%=request.getContextPath()%>/addCustomer.jsp"><span style="color: #0F1111;">Not a customer? Sign up</span></a>
				</div>
				<div class="col-lg-6">
					<form action="<%=request.getContextPath()%>/employeeLoginAction.jsp" method="post" id="employeeLogin">
						<fieldset>
							<legend>
								<b>Employee Login</b>
							</legend>
							<table class="table table-bordered">
								<tr>
									<td>ID</td>
									<td><input type="text" class="form-control" id="employeeId" name="employeeId"></td>
								</tr>
								<tr>
									<td>Password</td>
									<td><input type="password" class="form-control" id="employeePass" name="employeePass"></td>
								</tr>
							</table>
							<button type="button" id="employeeBtn" class="btn btn-primary" style="float: right;">관리자 로그인</button>
						</fieldset>
					</form>
					<a href="<%=request.getContextPath()%>/addEmployee.jsp"><span style="color: #0F1111;">Sign up for EMPLOYEE</span></a>
				</div>
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- SECTION -->

	<!-- FOOTER -->
	<footer id="footer">
		<!-- top footer -->
		<div class="section">
			<!-- container -->
			<div class="container">
				<!-- row -->
				<div class="row">
					<div class="col-md-3 col-xs-6">
						<div class="footer">
							<h3 class="footer-title">About Us</h3>
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut.</p>
							<ul class="footer-links">
								<li><a href="#"><i class="fa fa-map-marker"></i>1734 Stonecoal Road</a></li>
								<li><a href="#"><i class="fa fa-phone"></i>+021-95-51-84</a></li>
								<li><a href="#"><i class="fa fa-envelope-o"></i>email@email.com</a></li>
							</ul>
						</div>
					</div>

					<div class="col-md-3 col-xs-6">
						<div class="footer">
							<h3 class="footer-title">Categories</h3>
							<ul class="footer-links">
								<li><a href="#">Hot deals</a></li>
								<li><a href="#">Laptops</a></li>
								<li><a href="#">Smartphones</a></li>
								<li><a href="#">Cameras</a></li>
								<li><a href="#">Accessories</a></li>
							</ul>
						</div>
					</div>

					<div class="clearfix visible-xs"></div>

					<div class="col-md-3 col-xs-6">
						<div class="footer">
							<h3 class="footer-title">Information</h3>
							<ul class="footer-links">
								<li><a href="#">About Us</a></li>
								<li><a href="#">Contact Us</a></li>
								<li><a href="#">Privacy Policy</a></li>
								<li><a href="#">Orders and Returns</a></li>
								<li><a href="#">Terms & Conditions</a></li>
							</ul>
						</div>
					</div>

					<div class="col-md-3 col-xs-6">
						<div class="footer">
							<h3 class="footer-title">Service</h3>
							<ul class="footer-links">
								<li><a href="#">My Account</a></li>
								<li><a href="#">View Cart</a></li>
								<li><a href="#">Wishlist</a></li>
								<li><a href="#">Track My Order</a></li>
								<li><a href="#">Help</a></li>
							</ul>
						</div>
					</div>
				</div>
				<!-- /row -->
			</div>
			<!-- /container -->
		</div>
		<!-- /top footer -->

		<!-- bottom footer -->
		<div id="bottom-footer" class="section">
			<div class="container">
				<!-- row -->
				<div class="row">
					<div class="col-md-12 text-center">
						<ul class="footer-payments">
							<li><a href="#"><i class="fa fa-cc-visa"></i></a></li>
							<li><a href="#"><i class="fa fa-credit-card"></i></a></li>
							<li><a href="#"><i class="fa fa-cc-paypal"></i></a></li>
							<li><a href="#"><i class="fa fa-cc-mastercard"></i></a></li>
							<li><a href="#"><i class="fa fa-cc-discover"></i></a></li>
							<li><a href="#"><i class="fa fa-cc-amex"></i></a></li>
						</ul>
						<span class="copyright"> <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --> Copyright &copy;<script>
							document.write(new Date().getFullYear());
						</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a> <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
						</span>


					</div>
				</div>
				<!-- /row -->
			</div>
			<!-- /container -->
		</div>
		<!-- /bottom footer -->
	</footer>
	<!-- /FOOTER -->
	<!-- jQuery Plugins -->
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/slick.min.js"></script>
	<script src="js/nouislider.min.js"></script>
	<script src="js/jquery.zoom.min.js"></script>
	<script src="js/main.js"></script>

</body>
<script>
	/* 쇼핑몰 고객 로그인 */
	$('#customerBtn').click(function() {
		if ($('#customerId').val() == '') {
			alert('고객님의 아이디를 입력하세요');
		} else if ($('#customerPass').val() == '') {
			alert('고객님의 비밀번호를 입력하세요');
		} else {
			$('#customerLogin').submit();
		}
	});
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