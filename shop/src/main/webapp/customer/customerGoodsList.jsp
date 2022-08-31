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
							<a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?orderSql=popular">누적판매순</a> &nbsp;|&nbsp; <a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?orderSql=lastest">최신순</a> &nbsp;|&nbsp; <a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?orderSql=lowPrice">낮은가격순</a> &nbsp;|&nbsp; <a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?orderSql=highPrice">높은가격순</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?rowPerPage=20">20개씩</a> &nbsp;|&nbsp; <a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?rowPerPage=40">40개씩</a>
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
									<a href="<%=request.getContextPath()%>/customer/goodsDetail.jsp?goodsNo=<%=m.get("goodsNo")%>"><%=m.get("goodsName")%></a>
								</h3>
								<h4 class="product-price"><%=m.get("goodsPrice")%>원
								</h4>
								<hr>
								<div class="product-btns">
									<button class="add-to-cart-btn">
										<i class="fa fa-shopping-cart"></i><span class="tooltipp">Add to Cart</span>
									</button>
									<button class="quick-view" id="detailViewBtn">
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
<%@include file="/footer.jsp"%>
</body>
</html>