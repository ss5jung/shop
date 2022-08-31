<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
System.out.println(request.getParameter("goodsNo"));
System.out.println(request.getParameter("goodsName"));
%>
<%@include file="/hearder.jsp"%>

<!-- NAVIGATION -->
<nav id="navigation">
	<!-- container -->
	<div class="container">
		<!-- responsive-nav -->
		<div id="responsive-nav">
			<!-- NAV -->
			<ul class="main-nav nav navbar-nav">
				<li class="active"><a href="#">Home</a></li>
				<li><a href="#">Hot Deals</a></li>
				<li><a href="#">Categories</a></li>
				<li><a href="#">Laptops</a></li>
				<li><a href="#">Smartphones</a></li>
				<li><a href="#">Cameras</a></li>
				<li><a href="#">Accessories</a></li>
			</ul>
			<!-- /NAV -->
		</div>
		<!-- /responsive-nav -->
	</div>
	<!-- /container -->
</nav>
<!-- /NAVIGATION -->

<!-- BREADCRUMB -->
<div id="breadcrumb" class="section">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<div class="col-md-12">
				<h3 class="breadcrumb-header">주문</h3>
				<ul class="breadcrumb-tree">
					<li><a href="#">Home</a></li>
					<li class="active">Checkout</li>
				</ul>
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
			<%
			if (session.getAttribute("user") == null) {
			%>
			<div style="text-align: center;">
				<h3>장바구니에 담긴 상품이 없습니다.</h3>
				<a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp"><button type="button" class="btn btn-dark">홈으로 가기</button></a>
			</div>
			<%
			} else {
			%>
			<div class="col-md-5">
				<!-- Billing Details -->
				<div class="billing-details">
					<div class="section-title">
						<h3 class="title">Billing address</h3>
					</div>
					<div class="form-group">
						<label for="customerName">고객명 : </label>
						<input class="input" type="text" name="customerName" id="customerName" value="<%=session.getAttribute("id")%>">
					</div>
					<div class="form-group">
						<input class="input" type="text" name="last-name" placeholder="Last Name">
					</div>
					<div class="form-group">
						<input class="input" type="email" name="email" placeholder="Email">
					</div>
					<div class="form-group">
						<input class="input" type="text" name="address" placeholder="Address">
					</div>
					<div class="form-group">
						<input class="input" type="text" name="city" placeholder="City">
					</div>
					<div class="form-group">
						<input class="input" type="text" name="country" placeholder="Country">
					</div>
					<div class="form-group">
						<input class="input" type="text" name="zip-code" placeholder="ZIP Code">
					</div>
					<div class="form-group">
						<input class="input" type="tel" name="tel" placeholder="Telephone">
					</div>
				</div>
				<!-- /Billing Details -->
			</div>

			<!-- Order Details -->
			<div class="col-md-7 order-details">
				<div class="section-title text-center">
					<h3 class="title">Your Order</h3>
				</div>
				<div class="order-summary">
					<div class="order-col">
						<div>
							<strong>PRODUCT</strong>
						</div>
						<div>
							<strong>TOTAL</strong>
						</div>
					</div>
					<div class="order-products">
						<div class="order-col">
							<div>1x Product Name Goes Here</div>
							<div>$980.00</div>
						</div>
						<div class="order-col">
							<div>2x Product Name Goes Here</div>
							<div>$980.00</div>
						</div>
					</div>
					<div class="order-col">
						<div>Shiping</div>
						<div>
							<strong>FREE</strong>
						</div>
					</div>
					<div class="order-col">
						<div>
							<strong>TOTAL</strong>
						</div>
						<div>
							<strong class="order-total">$2940.00</strong>
						</div>
					</div>
				</div>
				<div class="payment-method">
					<div class="input-radio">
						<input type="radio" name="payment" id="payment-1">
						<label for="payment-1"> <span></span> Direct Bank Transfer
						</label>
						<div class="caption">
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
						</div>
					</div>
					<div class="input-radio">
						<input type="radio" name="payment" id="payment-2">
						<label for="payment-2"> <span></span> Cheque Payment
						</label>
						<div class="caption">
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
						</div>
					</div>
					<div class="input-radio">
						<input type="radio" name="payment" id="payment-3">
						<label for="payment-3"> <span></span> Paypal System
						</label>
						<div class="caption">
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
						</div>
					</div>
				</div>
				<div class="input-checkbox">
					<input type="checkbox" id="terms">
					<label for="terms"> <span></span> I've read and accept the <a href="#">terms & conditions</a>
					</label>
				</div>
				<a href="#" class="primary-btn order-submit">Place order</a>
			</div>
			<!-- /Order Details -->
			<%
			}
			%>

		</div>
		<!-- /row -->
	</div>
	<!-- /container -->
</div>
<!-- /SECTION -->

<%@include file="/footer.jsp"%>

</body>
</html>
