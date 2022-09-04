<%@page import="service.OrdersService"%>
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
//리뷰를 작성한지 있는 확인
String loginId = (String)session.getAttribute("id");
int reviewCk = new ReviewService().getReviewCk(loginId, goodsNo);
%>
<%@include file="/hearder.jsp"%>
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
					<hr>
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
					<!-- 장바구니/바로구매 -->
					<form name="qtyForm" id="qtyForm" method="post">
						<fieldset>
							<div class="add-to-cart">
								<div class="qty-label">
									Qty
									<div class="input-number">
										<input type="hidden" value="<%=goodsOne.get("goodsNo")%>" name="goodsNo">
										<input type="number" min="1" value="1" name="qty">
										<span class="qty-up">+</span> <span class="qty-down">-</span>
									</div>
								</div>
							</div>
							<div class="add-to-cart">
								<%
								if (goodsOne.get("soldOut").equals("Y")) {
								%>
								<button class="add-to-cart-btn">
									<i class="fa fa-shopping-cart"></i> 구매불가
								</button>
								<%
								} else {
								%>
								<button class="add-to-cart-btn" id="add-to-cart-btn" type="button">
									<i class="fa fa-shopping-cart"></i> Add to Cart
								</button>
								<button class="buy-now-btn" id="buy-now-btn" type="button">
									<i class="fa fa-shopping-cart"></i> Buy Now
								</button>
								<%
								}
								%>
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
						<div class="row">
							<!-- Review Form -->
							<div class="col-md-4">
								<div id="review-form">
									<form class="review-form">
										<input class="input" type="text" value="<%=session.getAttribute("id")%>" readonly="readonly">
										<textarea class="input" placeholder="상품 후기를 작성해주세요"></textarea>
										<button class="primary-btn">Submit</button>
									</form>
								</div>
							</div>
							<!-- /Review Form -->
							<!-- Reviews -->
							<div class="col-md-8">
								<div id="reviews">
									<ul class="reviews">
										<%
										if (list.isEmpty()) {
										%>
										<li style="text-align: center;">작성된 리뷰가 없습니다</li>
										<%
										} else {
										for (Map<String, Object> m : list) {
										%>
										<li>
											<div class="review-heading">
												<h5 class="customerId"><%=m.get("customerId")%></h5>
												<p class="updateDate"><%=m.get("updateDate")%></p>
											</div>
											<div class="review-body">
												<p><%=m.get("reviewContent")%></p>
												<a href="<%=request.getContextPath()%>/customer/deleteReviewAction.jsp?orderNo=<%=m.get("orderNo")%>&goodsNo=<%=goodsNo%>">
													<button class="btn btn-danger btn-sm" style="float: right; margin-left: 5px">삭제</button>
												</a>
												<a href="<%=request.getContextPath()%>/customer/updateReviewForm.jsp?orderNo=<%=m.get("orderNo")%>&goodsNo=<%=goodsNo%>">
													<button class="btn btn-primary btn-sm" style="float: right;">수정</button>
												</a>
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


						</div>
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
	alert('장바구니에 추가하였습니다.');
	$("#qtyForm").attr("action", "<%=request.getContextPath()%>/customer/addCartAction.jsp").submit();
});
</script>
</body>
</html>