<%@page import="service.CartService"%>
<%@page import="service.CounterService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//오늘 방문자수, 총 방문자수, 현재 접속자수 
CounterService counterService = new CounterService();
counterService.count();
int todayCounter = counterService.getTodayCount();
int totalCounter = counterService.getTotalCount();
int currentCount = (Integer) (application.getAttribute("currentCounter"));
//장바구니에 들어있는 상품의 수 불러오기
int qty = new CartService().getCartGoodsCnt((String) session.getAttribute("id"));
%>
<!DOCTYPE html>
<html lang="ko">
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
		<%-- <!-- TOP HEADER -->
		<div id="top-header">
			<div class="container">
				<ul class="header-links pull-left">
					<li><i class="fa fa-user-o"></i> 현재 접속자 수 : <%=currentCount%></li>
					<li><i class="fa fa-user-o"></i> 오늘 방문자 수 : <%=todayCounter%></li>
					<li><i class="fa fa-user-o"></i> 총 방문자 수 : <%=totalCounter%></li>
				</ul>
				<ul class="header-links pull-right">
					<li><a href="<%=request.getContextPath()%>/index.jsp"><i class="fa fa-user-o"></i>내 정보</a></li>
				</ul>
			</div>
		</div>
		<!-- /TOP HEADER --> --%>
		<!-- MAIN HEADER -->
		<div id="header">
			<!-- container -->
			<div class="container">
				<!-- row -->
				<div class="row">
					<!-- LOGO -->
					<div class="col-md-3">
						<div class="header-logo">
							<a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp" class="logo"> <img src="<%=request.getContextPath()%>/img/mamazon.png" style="width: 170px; margin-top: 13px" alt="마마존 로고">
							</a>
						</div>
					</div>
					<!-- /LOGO -->

					<!-- SEARCH BAR -->
					<!-- 검색창 -->
					<div class="col-md-6">
						<div class="header-search">
							<form action="<%=request.getContextPath()%>/customer/customerGoodsList.jsp" method="get">
								<%
								if (request.getParameter("researchGoodsName") == null || request.getParameter("researchGoodsName").equals("") || request.getParameter("researchGoodsName").equals("null")) {
								%>
								<input class="input-select" style="width: 75%" type="text" name="researchGoodsName" placeholder="검색어를 입력해주세요">
								<%
								} else {
								%>
								<input class="input-select" style="width: 75%" type="text" name="researchGoodsName" value="<%=request.getParameter("researchGoodsName")%>">
								<%
								}
								%>
								<button class="search-btn">Search</button>
							</form>
						</div>
					</div>
					<!-- /SEARCH BAR -->

					<!-- ACCOUNT -->
					<div class="col-md-3 clearfix">
						<div class="header-ctn">
							<!-- Cart -->
							<div class="dropdown">
								<a href="<%=request.getContextPath()%>/customer/customerCart.jsp"> <i class="fa fa-shopping-cart"></i> <span>Your Cart</span>
									<div class="qty"><%=qty%></div>
								</a>
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
					<li><a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp">Home</a></li>
					<li><a href="<%=request.getContextPath()%>/customer/customerNoticeList.jsp">Notice</a></li>
				</ul>
				<ul class="main-nav nav navbar-nav" style="float: right;">
					<li><a href="<%=request.getContextPath()%>/index.jsp"><i class="fa fa-user-o"></i><%=session.getAttribute("id")%>님</a></li>
				</ul>
				<!-- /NAV -->
			</div>
			<!-- /responsive-nav -->
		</div>
		<!-- /container -->
	</nav>
	<!-- /NAVIGATION -->