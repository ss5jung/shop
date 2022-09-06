<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Map"%>
<%@page import="vo.Cart"%>
<%@page import="java.util.List"%>
<%@page import="service.CartService"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
//장바구니 리스트 가져오기
String customerId = (String) session.getAttribute("id");
List<Map<String, Object>> list = new CartService().getCartList(customerId);
int total = 0;
//돈 단위 표시
DecimalFormat df = new DecimalFormat("###,###");
%>
<%@include file="/hearder.jsp"%>

<!-- BREADCRUMB -->
<div id="breadcrumb" class="section">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<div class="col-md-12">
				<h3 class="breadcrumb-header">주문하기</h3>
				<ul class="breadcrumb-tree">
					<li style="color: gray;">장바구니</li>
					<li class="active">주문/결제</li>
					<li style="color: gray;">완료</li>
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
			if (session.getAttribute("id") == null) {
			%>
			<div style="text-align: center; margin: 10% 0 10% 0">
				<h3>로그인이 필요한 서비스입니다</h3>
				<a href="<%=request.getContextPath()%>/loginForm.jsp"><button type="button" class="btn">로그인하기</button></a>
			
			</div>
			<%
			} else {
			%>
			<div class="col-md-4">
				<!-- Billing Details -->
				<div class="billing-details">
					<div class="section-title">
						<h3 class="title">Shiping address</h3>
					</div>
					<form action="<%=request.getContextPath()%>/customer/orderAction.jsp" method="post" id="orderForm">
						<div class="form-group">
							<input class="input" type="text" value="<%=customerId%>" readonly="readonly">
						</div>
						<div class="form-group">
							<b>배송지 :</b>
							<button type="button" class="btn btn-sm btn-primary" id="addrBtn2" style="margin-bottom: 5px">
								<b>주소검색</b>
							</button>
							<input style="margin-bottom: 5px" class="input" id="customerAddress" name="customerAddress" type="text" readonly="readonly" placeholder="주소" />
							<input class="input" id="customerDetailAddr" name="customerDetailAddr" type="text" placeholder="상세주소" />
						</div>
						<div class="form-group">
							<b>은행명 :</b> <select id="bank" name="bank" class="input">
								<option value="default">---은행선택---</option>
								<option value="국민은행 269851-09-1988754">국민은행 269851-09-1988754</option>
								<option value="신한은행 5480-085-147-8945">신한은행 5480-085-147-8945</option>
								<option value="우리은행 987-5574-4488">우리은행 987-5574-4488</option>
								<option value="농협은행 1569-874-1574">농협은행 1569-874-1574</option>
							</select>
						</div>
					</form>
					<!-- /////////////////////////////////////// -->
					<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
					<div id="layer" style="display: none; position: fixed; overflow: hidden; z-index: 1; -webkit-overflow-scrolling: touch;">
						<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor: pointer; position: absolute; right: -3px; top: -3px; z-index: 1" onclick="closeDaumPostcode()" alt="닫기 버튼">
					</div>
					<!-- /////////////////////////////////////// -->
				</div>
				<!-- /Billing Details -->
			</div>

			<!-- Order Details -->
			<div class="col-md-8 order-details">
				<div class="section-title text-center">
					<h3 class="title">Your Order</h3>
				</div>
				<div class="order-summary">
					<div class="order-col">
						<table class="table table-hover">
							<tr>
								<th><strong>상품명</strong></th>
								<th><strong>상품가격</strong></th>
								<th><strong>수량</strong></th>
								<th><strong>TOTAL</strong></th>
							</tr>
							<%
							for (Map<String, Object> map : list) {
							%>
							<tr>
								<td><%=map.get("goodsName")%></td>
								<td><%=df.format(map.get("goodsPrice"))%>원</td>
								<td><%=map.get("cartQuantity")%>개</td>
								<%
								total += (int) map.get("goodsPrice") * (int) map.get("cartQuantity");
								%>
								<td><%=df.format((int) map.get("goodsPrice") * (int) map.get("cartQuantity"))%>원</td>
							</tr>
							<%
							}
							%>
						</table>
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
							<strong class="order-total"><%=df.format(total)%>원</strong>
						</div>
					</div>
				</div>
				<a href="#" class="primary-btn order-submit" id="orderBtn">Place order</a>
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
<script>
	$('#orderBtn').click(function() {
		$('#orderForm').submit();
	});
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	//
	$('#addrBtn2').click(function() {
		sample2_execDaumPostcode();
	});
</script>
<script>
	// 우편번호 찾기 화면을 넣을 element
	var element_layer = document.getElementById('layer');

	function closeDaumPostcode() {
		// iframe을 넣은 element를 안보이게 한다.
		element_layer.style.display = 'none';
	}

	function sample2_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var addr = ''; // 주소 변수
						var extraAddr = ''; // 참고항목 변수

						//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							addr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							addr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
						if (data.userSelectedType === 'R') {
							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraAddr !== '') {
								extraAddr = ' (' + extraAddr + ')';
							}
							// 조합된 참고항목을 해당 필드에 넣는다.
							//document.getElementById("sample2_extraAddress").value = extraAddr;

						} else {
							//document.getElementById("sample2_extraAddress").value = '';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						//document.getElementById('sample2_postcode').value = data.zonecode;
						//document.getElementById("sample2_address").value = addr;

						//$('#addr').val(data.zonecode + ' '+ addr)
						document.getElementById('customerAddress').value = data.zonecode
								+ ' ' + addr;

						// 커서를 상세주소 필드로 이동한다.
						//document.getElementById("sample2_detailAddress") .focus();

						// iframe을 넣은 element를 안보이게 한다.
						// (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
						element_layer.style.display = 'none';
					},
					width : '100%',
					height : '100%',
					maxSuggestItems : 5
				}).embed(element_layer);

		// iframe을 넣은 element를 보이게 한다.
		element_layer.style.display = 'block';

		// iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
		initLayerPosition();
	}

	// 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
	// resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
	// 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
	function initLayerPosition() {
		var width = 300; //우편번호서비스가 들어갈 element의 width
		var height = 400; //우편번호서비스가 들어갈 element의 height
		var borderWidth = 5; //샘플에서 사용하는 border의 두께

		// 위에서 선언한 값들을 실제 element에 넣는다.
		element_layer.style.width = width + 'px';
		element_layer.style.height = height + 'px';
		element_layer.style.border = borderWidth + 'px solid';
		// 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
		element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width) / 2 - borderWidth)
				+ 'px';
		element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height) / 2 - borderWidth)
				+ 'px';
	}
</script>
</html>
