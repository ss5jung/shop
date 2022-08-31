<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
System.out.println(request.getParameter("goodsNo"));
System.out.println(request.getParameter("goodsName"));
%>
<%@include file="/hearder.jsp"%>

<!-- BREADCRUMB -->
<div id="breadcrumb" class="section">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<div class="col-md-12">
				<h3 class="breadcrumb-header">장바구니</h3>
				<ul class="breadcrumb-tree">
					<li class="active">장바구니</li>
					<li style="color: gray;">주문/결제</li>
					<li style="color: gray;">완료</li>
				</ul>
			</div>
		</div>
		<!-- /row -->
	</div>
	<!-- /container -->
</div>
<!-- /BREADCRUMB -->
<!-- 장바구니 전체 선택 -->
<!-- <nav style="border-bottom: 1px solid #E4E7ED">
	container
	<div class="container">
		row
		<div class="row">
			<div class="input-checkbox">
				<input type="checkbox" id="terms">
				<label for="terms"> <span></span>전체선택 </label>
			</div>
		</div>
	</div>
</nav> -->
<!-- 장바구니 전체 선택 -->
<!-- SECTION -->
<div class="section">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<!-- 로그인이 되어있지 않으면 장바구니리스트 보여주지 않음 -->
			<%
			if (session.getAttribute("user") == null) {
			%>
			<div style="text-align: center; margin: 10% 0 10% 0">
				<h3>장바구니에 담긴 상품이 없습니다.</h3>
				<a href="<%=request.getContextPath()%>/customer/customerGoodsList.jsp"><button type="button" class="btn btn-dark">홈으로 가기</button></a>
			</div>
			<%
			} else {
			%>
			<!-- 장바구니 리스트-->
			<div>
				<table class="table">
					<thead>
						<tr>
							<th></th>
							<th>이미지</th>
							<th>상품명</th>
							<th>상품가격</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="checkbox" class="form-check-input" value=""></td>
							<td><img src="" alt="tkdvna"></td>
							<td>상품명</td>
							<td>상품가격</td>
						</tr>
						<tr>
							<td><input type="checkbox" class="form-check-input" value=""></td>
							<td>이미지</td>
							<td>상품명</td>
							<td>상품가격</td>
						</tr>
						<tr>
							<td><input type="checkbox" class="form-check-input" value=""></td>
							<td>이미지</td>
							<td>상품명</td>
							<td>상품가격</td>
						</tr>
						<tr>
							<td><input type="checkbox" class="form-check-input" value=""></td>
							<td>이미지</td>
							<td>상품명</td>
							<td>상품가격</td>
						</tr>
					</tbody>
				</table>
				<a href="#" class="primary-btn order-submit">주문하기</a>
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
