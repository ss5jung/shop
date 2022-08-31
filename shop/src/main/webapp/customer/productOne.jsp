<%@page import="service.OrdersService"%>
<%@page import="java.util.List"%>
<%@page import="service.ReviewService"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="service.GoodsService"%>
<%@page import="vo.Goods"%>
<%@page import="service.EmployeeService"%>
<%@page import="vo.Employee"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
//접근제한 X
//전송받은 값
int goodsNo = 0;
if (request.getParameter("goodsNo") != null) { //전송받은 상품번호가 없으면 상품리스트로 리턴
	goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
} else {
	System.out.println("Error. 요청받은 goodsNo가 없습니다.");
	response.sendRedirect(request.getContextPath() + "/customer/customerGoodsList.jsp");
	return;
}
System.out.println("====" + goodsNo + "번 제품 상세페이지====");
//goodsNo와 관련된 정보 및 이미지 가져오기
Map<String, Object> goodsOne = new GoodsService().getGoodsAndImgOne(goodsNo);
System.out.println(goodsOne);
//리뷰 가져오기
List<Map<String, Object>> list = new ReviewService().getReviewList(goodsNo);
//접속한 아이디
String loginId = (String) session.getAttribute("id");
System.out.println(loginId + "<-- loginId");
//로그인한 계정이 현재 상품을 구매한 적이 있는지 확인
int reviewCk = new ReviewService().getReviewCk(loginId, goodsNo);	//0이면 리뷰 작성가능 
System.out.println(reviewCk + "<-- reviewCk");
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
			<!-- Product main img -->
			<div class="col-lg-7">
				<div id="product-main-img">
					<div class="product-preview">
						<img src="<%=request.getContextPath()%>/upload/<%=goodsOne.get("filename")%>" alt="제품이미지" style="width: 70%">
					</div>
				</div>
			</div>
			<!-- /Product main img -->

			<!-- Product details -->
			<div class="col-lg-5">
				<div class="product-details">
					<h2 class="product-name"><%=goodsOne.get("goodsName")%></h2>
					<div>
						<div class="product-rating">
							<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star-o"></i>
						</div>
						<a class="review-link" href="#">10 Review(s) | Add your review</a>
					</div>
					<div>
						<h3 class="product-price">
							<%=goodsOne.get("goodsPrice")%>원
						</h3>
						<%
						if (goodsOne.get("soldOut") != "N") {
						%>
						<span class="product-available">In Stock</span>
						<%
						} else {
						%>
						<span class="new">품절</span>
						<%
						}
						%>

					</div>
					<div class="add-to-cart">
						<form action="<%=request.getContextPath()%>/customer/addCart.jsp">
							<div class="qty-label">
								수량
								<input type="hidden" id="goodsNo" name="goodsNo" value="<%=goodsOne.get("goodsNo")%>">
								<input type="hidden" id="goodsPrice" name="goodsPrice" value="<%=goodsOne.get("goodsPrice")%>">
								<input type="number" id="goodsQuantity" name="goodsQuantity" min="1">
								<button class="add-to-cart-btn" type="submit">
									<i class="fa fa-shopping-cart"></i> add to cart
								</button>
							</div>
						</form>
					</div>
					<ul class="product-btns">
						<li><a href="<%=request.getContextPath()%>/customer/wishlist.jsp?goodsOne=<%=goodsOne.get("goodsNo")%>"><i class="fa fa-heart-o"></i> add to wishlist</a></li>
					</ul>
				</div>
			</div>
			<!-- /Product details -->
			<!-- Product tab -->
			<div class="row">
				<div id="product-tab">
					<!-- Reviews -->
					<div class="col-md-12">
						<div id="reviews">
							<h3 style="margin-top: 5%">Reviews</h3>
							<ul class="reviews">
								<%
								for (Map<String, Object> m : list) {
								%>
								<li>
									<div class="review-heading">
										<h5 class="name"><%=m.get("customerId")%></h5>
										<p class="date"><%=m.get("updateDate")%></p>
										<div class="review-rating">
											<%
											int star = (int) m.get("star");
											for (int i = 0; i < star; i++) {
											%>
											<i class="fa fa-star"></i>
											<%
											}
											%>
										</div>
									</div>
									<div class="review-body">
										<p><%=m.get("reviewContent")%></p>
									</div>
								</li>
								<%
								}
								%>
							</ul>
						</div>
					</div>
					<!-- /Reviews -->

					<!-- Review Form -->
					<%
					if (reviewCk == 0) { // 로그인을 해야하고 리뷰를 작성한 적이 없어야 한다.
					%>
					<!-- 상품 구매한 사람만 구매가능 -->
					<div class="col-md-12">
						<div id="review-form">
							<form class="review-form">
								<input class="input" type="text" placeholder="Your Name">
								<input class="input" type="email" placeholder="Your Email">
								<textarea class="input" placeholder="Your Review"></textarea>
								<div class="input-rating">
									<span>Your Rating: </span>
									<div class="stars">
										<input id="star5" name="rating" value="5" type="radio">
										<label for="star5"></label>
										<input id="star4" name="rating" value="4" type="radio">
										<label for="star4"></label>
										<input id="star3" name="rating" value="3" type="radio">
										<label for="star3"></label>
										<input id="star2" name="rating" value="2" type="radio">
										<label for="star2"></label>
										<input id="star1" name="rating" value="1" type="radio">
										<label for="star1"></label>
									</div>
								</div>
								<button class="primary-btn">Submit</button>
							</form>
						</div>
					</div>
					<%
					}
					%>
					<!-- /Review Form -->
				</div>
			</div>
			<!-- /product tab -->
		</div>
		<!-- /row -->
	</div>
	<!-- /container -->
</div>
<!-- /SECTION -->

<%@include file="/footer.jsp"%>

</body>
</html>
