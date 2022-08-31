<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="vo.Review"%>
<%@page import="service.ReviewService"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="service.GoodsService"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
//페이지 확인
System.out.println("--------------------------/customer/goodsDetail.jsp");
//링크를 통한 접근 제한 
if (request.getParameter("goodsNo") == null) { //전송받은 goodsNo값이 null일 때
	//디버깅
	System.out.println("전송받은 goodsNo가 없습니다.");
	//customerGoodsList로 redirect하기
	response.sendRedirect(request.getContextPath() + "/customer/customerGoodsList.jsp");
	return; //
}
//전송받은 goodsNo 저장
int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
System.out.println(goodsNo + "<-- goodsNo");
//상품 상세정보 가져오기
Map<String, Object> goodsOne = new GoodsService().getGoodsAndImgOne(goodsNo);
//정보 들어온게 없으면 다시 리스트로 복귀
if (goodsOne.isEmpty()) {
	System.out.println("상품의 상세정보가 없습니다.");
	response.sendRedirect(request.getContextPath() + "/customer/customerGoodsList.jsp");
	return;
}
//리뷰 가져오기
List<Map<String, Object>> list = new ReviewService().getReviewList(goodsNo);
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
			<div class="col-md-5 col-md-push-1">
				<div id="product-main-img">
					<div class="product-preview">
						<img src="<%=request.getContextPath()%>/upload/<%=goodsOne.get("filename")%>" alt="상품이미지">
					</div>
				</div>
			</div>
			<!-- /Product main img -->

			<!-- Product thumb imgs -->
			<div class="col-md-1  col-md-pull-5">
				<div id="product-imgs">
					<div class="product-preview">
						<img src="<%=request.getContextPath()%>/upload/<%=goodsOne.get("filename")%>" alt="상품이미지">
					</div>
				</div>
			</div>
			<!-- /Product thumb imgs -->

			<!-- Product details -->
			<div class="col-md-6">
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
							<%=goodsOne.get("goodsPrice")%>
							원
						</h3>
						<%
						if (goodsOne.get("soldOut").equals("N")) {
						%>
						<span class="product-available">In Stock</span>
						<%
						} else {
						%>
						<span class="product-available">Sold out</span>
						<%
						}
						%>

					</div>
					<p>상품 설명</p>
					<!-- 장바구니/바로구매 -->
					<form name="qtyForm" id="qtyForm" method="post">
						<fieldset>
							<div class="add-to-cart">
								<div class="qty-label">
									Qty
									<div class="input-number">
										<input type="hidden" value="<%=goodsOne.get("goodsNo")%>" name="goodsNo">
										<input type="hidden" value="<%=goodsOne.get("goodsName")%>" name="goodsName">
										<input type="number" min="1" value="1" name="qty">
										<span class="qty-up">+</span> <span class="qty-down">-</span>
									</div>
								</div>
							</div>
							<div class="add-to-cart">
								<button class="add-to-cart-btn" id="add-to-cart-btn">
									<i class="fa fa-shopping-cart"></i> Add to Cart
								</button>
								<button class="buy-now-btn" id="buy-now-btn">
									<i class="fa fa-shopping-cart"></i> Buy Now
								</button>
							</div>
						</fieldset>
					</form>
					<!-- /장바구니/바로구매 -->
				</div>
			</div>
			<!-- /Product details -->

			<!-- Product tab -->
			<div class="col-md-12">
				<div id="product-tab">
					<!-- product tab nav -->
					<ul class="tab-nav">
						<li><a data-toggle="tab" href="#tab1">Reviews</a></li>
					</ul>
					<!-- /product tab nav -->

					<!-- product tab content -->
					<div class="tab-content">
						<!-- tab1  -->
						<div id="tab1" class="tab-pane fade in active">
							<div class="row">
								<!-- Rating -->
								<div class="col-md-3">
									<div id="rating">
										<div class="rating-avg">
											<span>4.5</span>
											<div class="rating-stars">
												<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star-o"></i>
											</div>
										</div>
										<ul class="rating">
											<li>
												<div class="rating-stars">
													<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i>
												</div>
												<div class="rating-progress">
													<div style="width: 80%;"></div>
												</div> <span class="sum">3</span>
											</li>
											<li>
												<div class="rating-stars">
													<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star-o"></i>
												</div>
												<div class="rating-progress">
													<div style="width: 60%;"></div>
												</div> <span class="sum">2</span>
											</li>
											<li>
												<div class="rating-stars">
													<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star-o"></i> <i class="fa fa-star-o"></i>
												</div>
												<div class="rating-progress">
													<div></div>
												</div> <span class="sum">0</span>
											</li>
											<li>
												<div class="rating-stars">
													<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> <i class="fa fa-star-o"></i>
												</div>
												<div class="rating-progress">
													<div></div>
												</div> <span class="sum">0</span>
											</li>
											<li>
												<div class="rating-stars">
													<i class="fa fa-star"></i> <i class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> <i class="fa fa-star-o"></i> <i class="fa fa-star-o"></i>
												</div>
												<div class="rating-progress">
													<div></div>
												</div> <span class="sum">0</span>
											</li>
										</ul>
									</div>
								</div>
								<!-- /Rating -->

								<!-- Reviews -->
								<div class="col-md-6">
									<div id="reviews">
										<ul class="reviews">
											<%
											if (list.isEmpty()) {
											%>
											<li>No Review</li>
											<%
											} else {
											for (Map<String, Object> m : list) {
											%>
											<li>
												<div class="review-heading">
													<h5 class="customerId"><%=m.get("customerId")%></h5>
													<p class="updateDate"><%=m.get("updateDate")%></p>
													<div class="review-rating">
														<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star-o empty"></i>
													</div>
												</div>
												<div class="review-body">
													<p><%=m.get("reviewContent")%></p>
												</div>
											</li>
											<%
											}
											}
											%>
										</ul>
									</div>
								</div>
								<!-- /Reviews -->

								<!-- Review Form -->
								<div class="col-md-3">
									<div id="review-form">
										<form class="review-form">
											<input class="input" type="text" value="<%=session.getAttribute("id")%>" readonly="readonly">
											<textarea class="input" placeholder="Your Reviewㄴㄹㅇㄹㄴㅇㄹ"></textarea>
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
								<!-- /Review Form -->
							</div>
						</div>
						<!-- /tab1  -->
					</div>
					<!-- /product tab content  -->
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
<script>
$('#add-to-cart-btn').click(function() {
	$("#qtyForm").attr("action", "<%=request.getContextPath()%>/customer/customerCart.jsp");
})
$('#buy-now-btn').click(function() {
	$("#qtyForm").attr("action", "<%=request.getContextPath()%>/customer/checkout.jsp");
})
</script>
</body>
</html>