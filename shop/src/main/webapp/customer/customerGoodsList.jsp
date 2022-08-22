<%@page import="service.CounterService"%>
<%@page import="service.GoodsService"%>
<%@page import="java.util.List"%>
<%@page import="service.CustomerService"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//Controller : java class <-- Serlvet
//페이지당 보여줄 상품의 개수
int rowPerPage = 20;
if (request.getParameter("rowPerPage") != null) {
	rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
}
System.out.println(rowPerPage + "<-- rowPerPage - 화면에 보여줄 상품 갯수");
//sort 방법
String orderSql = "popular";
if (request.getParameter("orderSql") != null) {
	orderSql = request.getParameter("orderSql");
}
System.out.println(orderSql + "<-- orderSql - sort방법");
//현재페이지
int currentPage = 1;
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}
//상품리스트 Service에서 받아오기
List<Map<String, Object>> list = new GoodsService().getCustomerGoodsListByPage(rowPerPage, currentPage, orderSql);
//라스트페이지
int lastPage = new GoodsService().getGoodsLastPage(rowPerPage);
System.out.println(lastPage + "<-- lastPage customerGoodsList");
//오늘 방문자수, 총 방문자수
CounterService counterService = new CounterService();
int totalCounter = counterService.getTotalCount();
int todayCounter = counterService.getTodayCount();
int currentCount = (Integer)(application.getAttribute("currentCounter"));
%>
<!-- 위 아래를 분리하면 serlvet > 연결기술-- forword(request, response) > jsp -->
<!-- View : 태그 -->
<!DOCTYPE html>
<html lang="euc-kr">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<title>Mamazon</title>

<!-- Google font -->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

<!-- Bootstrap -->
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css" />

<!-- Slick -->
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/slick.css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/slick-theme.css" />

<!-- nouislider -->
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/nouislider.min.css" />

<!-- Font Awesome Icon -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/font-awesome.min.css">

<!-- Custom stlylesheet -->
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" />
<link rel="icon" href="<%=request.getContextPath()%>/img/mamazonFavicon.svg" type="image/x-icon">
<link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<!-- HEADER -->
	<header>
		<!-- TOP HEADER -->
		<div id="top-header">
			<div class="container">
				<ul class="header-links pull-left">
					<li><i class="fa fa-user-o"></i> 오늘 방문자 수 : <%=todayCounter %></li>
					<li><i class="fa fa-user-o"></i> 총 방문자 수 : <%=totalCounter %></li>
					<li><i class="fa fa-user-o"></i> 현재 접속자 수 : <%=currentCount %></li>
				</ul>
				<ul class="header-links pull-right">
					<li><i class="fa fa-krw" aria-hidden="true"></i> WON</li>
					<li><a href="<%=request.getContextPath()%>/index.jsp"><i class="fa fa-user-circle-o" aria-hidden="true"></i> My Account</a></li>
				</ul>
			</div>
		</div>
		<!-- /TOP HEADER -->
		<!-- MAIN HEADER -->
		<div id="header">
			<!-- container -->
			<div class="container">
				<!-- row -->
				<div class="row">
					<!-- LOGO -->
					<div class="col-md-3">
						<div class="header-logo">
							<a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp" class="logo"> <img src="<%=request.getContextPath()%>/img/mamazon.png" style="width: 170px; margin-top: 16px" alt="">
							</a>
						</div>
					</div>
					<!-- /LOGO -->

					<!-- SEARCH BAR -->
					<div class="col-md-6">
						<div class="header-search">
							<form>
								<select class="input-select">
									<option value="0">All Categories</option>
									<option value="1">Category 01</option>
									<option value="1">Category 02</option>
								</select>
								<input class="input" placeholder="Search here">
								<button class="search-btn">Search</button>
							</form>
						</div>
					</div>
					<!-- /SEARCH BAR -->

					<!-- ACCOUNT -->
					<div class="col-md-3 clearfix">
						<div class="header-ctn">
							<!-- Wishlist -->
							<div>
								<a href="#"> <i class="fa fa-heart-o"></i> <span>Your Wishlist</span>
									<div class="qty">2</div>
								</a>
							</div>
							<!-- /Wishlist -->

							<!-- Cart -->
							<div class="dropdown">
								<a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true"> <i class="fa fa-shopping-cart"></i> <span>Your Cart</span>
									<div class="qty">3</div>
								</a>
								<div class="cart-dropdown">
									<div class="cart-list">
										<div class="product-widget">
											<div class="product-img">
												<img src="./img/product01.png" alt="">
											</div>
											<div class="product-body">
												<h3 class="product-name">
													<a href="#">product name goes here</a>
												</h3>
												<h4 class="product-price">
													<span class="qty">1x</span>$980.00
												</h4>
											</div>
											<button class="delete">
												<i class="fa fa-close"></i>
											</button>
										</div>

										<div class="product-widget">
											<div class="product-img">
												<img src="./img/product02.png" alt="">
											</div>
											<div class="product-body">
												<h3 class="product-name">
													<a href="#">product name goes here</a>
												</h3>
												<h4 class="product-price">
													<span class="qty">3x</span>$980.00
												</h4>
											</div>
											<button class="delete">
												<i class="fa fa-close"></i>
											</button>
										</div>
									</div>
									<div class="cart-summary">
										<small>3 Item(s) selected</small>
										<h5>SUBTOTAL: $2940.00</h5>
									</div>
									<div class="cart-btns">
										<a href="#">View Cart</a> <a href="#">Checkout <i class="fa fa-arrow-circle-right"></i></a>
									</div>
								</div>
							</div>
							<!-- /Cart -->

							<!-- Menu Toogle -->
							<div class="menu-toggle">
								<a href="#"> <i class="fa fa-bars"></i> <span>Menu</span>
								</a>
							</div>
							<!-- /Menu Toogle -->
						</div>
					</div>
					<!-- /ACCOUNT -->
				</div>
				<!-- row -->
			</div>
			<!-- container -->
		</div>
		<!-- /MAIN HEADER -->
	</header>
	<!-- /HEADER -->
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

	<!-- SECTION -->
	<div class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<!-- STORE -->
				<div id="store" class="col-lg-12">
					<!-- store top filter -->
					<div class="row">
						<div class="store-filter clearfix" style="float: right;">
							<div class="store-sort">
								<%-- <a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?orderSql=hits">인기순</a> &nbsp;|&nbsp;  --%>
								<a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?orderSql=popular">누적판매순</a> &nbsp;|&nbsp; 
								<a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?orderSql=lastest">최신순</a> &nbsp;|&nbsp; 
								<a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?orderSql=lowPrice">낮은가격순</a> &nbsp;|&nbsp; 
								<a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?orderSql=highPrice">높은가격순</a> 
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
								<a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?rowPerPage=20">20개씩</a> &nbsp;|&nbsp; 
								<a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?rowPerPage=40">40개씩</a>
							</div>
						</div>
					</div>
					<!-- /store top filter -->
					<!-- store products -->
					<div class="row">
						<%
						int i = 1;
						for (Map<String, Object> m : list) {
						%>
						<div class="col-lg-3">
							<div class="product">
								<div class="product-img">
									<img src="<%=request.getContextPath()%>/upload/<%=m.get("filename")%>" alt="<%=m.get("goodsName")%>">
									<%
									if ("Y".equals(m.get("soldOut"))) {
									%>
									<div class="product-label">
										<span class="new">품절</span>
									</div>
									<%
									}
									%>
								</div>
								<div class="product-body">
									<p class="product-category">Category</p>
									<h3 class="product-name">
										<a href="#"><%=m.get("goodsName")%></a>
									</h3>
									<h4 class="product-price"><%=m.get("goodsPrice")%>원
									</h4>
									<div class="product-rating">
										<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i>
									</div>
									<div class="product-btns">
										<button class="add-to-wishlist">
											<i class="fa fa-heart-o"></i><span class="tooltipp">add to wishlist</span>
										</button>
										<button class="quick-view">
											<i class="fa fa-eye"></i><span class="tooltipp">Detail view</span>
										</button>
									</div>
								</div>
							</div>
						</div>
						<%
						if (i % 4 == 0) {
						%>
						<div class=row>
							<br> <br>
						</div>
						<%
						}
						i++;
						}
						%>
					</div>
					<!-- /store products -->
					<!-- store bottom filter -->
					<!-- 페이징 -->
					<div class="store-filter clearfix">
						<ul class="store-pagination">
							<%
							if (currentPage > 1) { //1보다 크다면
							%>
							<li class="page-item"><a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?currentPage=<%=currentPage - 1%>"><i class="fa fa-angle-left"></i></a></li>
							<%
							} else { //1보다 작으면
							%>
							<li class="page-item disabled"><i class="fa fa-angle-left"></i></li>
							<%
							}
							%>
							<%
							if (currentPage < lastPage) {
							%>
							<li class="page-item"><a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?currentPage=<%=currentPage + 1%>"><i class="fa fa-angle-right"></i></a></li>
							<%
							} else {
							%>
							<li class="page-item disabled"><i class="fa fa-angle-right"></i></li>
							<%
							}
							%>
						</ul>
					</div>
					<!-- /페이징 -->
					<!-- /store bottom filter -->
				</div>
				<!-- /STORE -->
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- /SECTION -->


	<!-- FOOTER -->
	<footer id="footer" style="margin-top: 10%">
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
	<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/slick.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/nouislider.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery.zoom.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/main.js"></script>
</body>
</html>