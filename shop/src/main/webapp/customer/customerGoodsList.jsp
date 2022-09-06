<%@page import="java.text.DecimalFormat"%>
<%@page import="service.CounterService"%>
<%@page import="service.GoodsService"%>
<%@page import="java.util.List"%>
<%@page import="service.CustomerService"%>
<%@page import="java.util.Map"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
//상품 리스트
List<Map<String, Object>> list = null;
//요청받은 검색어의 값
String researchGoodsName = request.getParameter("researchGoodsName");
System.out.println(researchGoodsName + "<--researchGoodsName 검색어");
if (researchGoodsName == null || researchGoodsName.equals("") || researchGoodsName.equals("null")) { //검색어가 없을 경우
	//상품리스트 Service에서 받아오기
	list = new GoodsService().getCustomerGoodsListByPage(rowPerPage, currentPage, orderSql);
} else { //검색어가 있을 경우
	//특정 검색어가 포함된 상품리스트 Service에서 받아오기
	list = new GoodsService().getResearchGoodsList(rowPerPage, currentPage, orderSql, researchGoodsName);
}

//라스트페이지
int lastPage = new GoodsService().getGoodsLastPage(rowPerPage);
System.out.println(lastPage + "<-- lastPage customerGoodsList");
//돈 단위 표시
DecimalFormat df = new DecimalFormat("###,###");
%>
<%@include file="/hearder.jsp"%>
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
							<a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?orderSql=popular&researchGoodsName=<%=researchGoodsName%>">누적판매순</a> &nbsp;|&nbsp; <a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?orderSql=lastest&researchGoodsName=<%=researchGoodsName%>">최신순</a> &nbsp;|&nbsp; <a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?orderSql=lowPrice&researchGoodsName=<%=researchGoodsName%>">낮은가격순</a> &nbsp;|&nbsp; <a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?orderSql=highPrice&researchGoodsName=<%=researchGoodsName%>">높은가격순</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?rowPerPage=20">20개씩</a> &nbsp;|&nbsp; <a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?rowPerPage=40">40개씩</a>
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
								<a href="<%=request.getContextPath()%>/customer/goodsDetail.jsp?goodsNo=<%=m.get("goodsNo")%>"><img src="<%=request.getContextPath()%>/upload/<%=m.get("filename")%>" alt="<%=m.get("goodsName")%>" style="height: 260px"></a>
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
								<h3 class="product-name">
									<a href="<%=request.getContextPath()%>/customer/goodsDetail.jsp?goodsNo=<%=m.get("goodsNo")%>"><%=m.get("goodsName")%></a>
								</h3>
								<h4 class="product-price"><%=df.format(m.get("goodsPrice"))%>원
								</h4>
								<hr>
								<div class="product-btns">
										<%
										if (session.getAttribute("id") == null || session.getAttribute("id").equals("null")) { //로그인이 되지 않은 상태이라면
										%>
										<button class="add-to-cart-btn">
										<i class="fa fa-shopping-cart"></i><span class="tooltipp">로그인이 필요합니다</span>
										<%
										} else if ("Y".equals(m.get("soldOut"))) {	//품절이면 상품을 담을 수 없음
										%>
										<button class="add-to-cart-btn">
										<i class="fa fa-shopping-cart"></i><span class="tooltipp">품절 - 구매불가</span>
										<%
										} else {
										%>
										<button class="add-to-cart-btn" id="add-to-cart-btn">
										<a href="<%=request.getContextPath()%>/customer/addCartAction.jsp?goodsNo=<%=m.get("goodsNo")%>&qty=1"><i class="fa fa-shopping-cart"></i><span class="tooltipp">Add to Cart</span></a>
										<%
										}
										%>
									</button>
									<button class="quick-view" id="detail-View-Btn">
										<a href="<%=request.getContextPath()%>/customer/goodsDetail.jsp?goodsNo=<%=m.get("goodsNo")%>"><i class="fa fa-eye"></i><span class="tooltipp">Detail view</span></a>
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
						<li class="page-item"><a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?currentPage=<%=currentPage - 1%>&researchGoodsName=<%=researchGoodsName%>&orderSql=<%=orderSql%>"><i class="fa fa-angle-left"></i></a></li>
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
						<li class="page-item"><a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp?currentPage=<%=currentPage + 1%>&researchGoodsName=<%=researchGoodsName%>&orderSql=<%=orderSql%>"><i class="fa fa-angle-right"></i></a></li>
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
<script>
	$('#add-to-cart-btn').click(function() {
		alert('장바구니에 추가되었습니다.');
	});

	function numberFormat(inputNumber) {
		return inputNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	};
</script>
</html>