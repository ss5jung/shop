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
//접근제한
//로그인하지 않은 상태이거나 고객일 경우에 접근차단하기
if (session.getAttribute("id") == null || session.getAttribute("user").equals("Customer")) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
//전송받은 값
int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
System.out.println("----" + goodsNo + " 상세 수정하기----");
//goodsNo와 관련된 정보 및 이미지 가져오기
Map<String, Object> goodsOne = new GoodsService().getGoodsAndImgOne(goodsNo);
%>
<!DOCTYPE html>
<html lang="euc-kr">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Admin</title>
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
<link href="<%=request.getContextPath()%>/adminIndexBoot/css/styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body class="sb-nav-fixed">
	<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
		<!-- Navbar Brand-->
		<a class="navbar-brand ps-3" href="<%=request.getContextPath()%>/adminIndex.jsp"> <img alt="mamazon" src="<%=request.getContextPath()%>/img/mamazon.png" style="margin-top: 15px">
		</a>
		<!-- Sidebar Toggle-->
		<button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!">
			<i class="fas fa-bars"></i>
		</button>
		<span style="color: white;"><%=session.getAttribute("name")%>님</span>
		<!-- Navbar Search-->
		<form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
			<div class="input-group">
				<input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
				<button class="btn btn-primary" id="btnNavbarSearch" type="button">
					<i class="fas fa-search"></i>
				</button>
			</div>
		</form>
		<!-- Navbar-->
		<ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
			<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"> <i class="fas fa-user fa-fw"></i>
			</a>
				<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
					<li><a class="dropdown-item" href="#!">Settings</a></li>
					<li><a class="dropdown-item" href="#!">Activity Log</a></li>
					<li><hr class="dropdown-divider" /></li>
					<li><a class="dropdown-item" href="<%=request.getContextPath()%>/logout.jsp">Logout</a></li>
				</ul></li>
		</ul>
		<!-- /Navbar-->
	</nav>
	<!-- Left Nav -->
	<div id="layoutSidenav">
		<div id="layoutSidenav_nav">
			<nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
				<div class="sb-sidenav-menu">
					<div class="nav">
						<div class="sb-sidenav-menu-heading">Admin Mode</div>
						<a class="nav-link" href="<%=request.getContextPath()%>/admin/adminEmployeeList.jsp">
							<div class="sb-nav-link-icon ">
								<i class="fas fa-user-tie"></i>
							</div> 사원관리
						</a>
						<!-- 상품목록/등록/수정(품절)/석재(장바구니,주문이 없는 경우) -->
						<a class="nav-link active" href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp">
							<div class="sb-nav-link-icon">
								<i class="fas fa-list-alt"></i>
							</div> 상품관리
						</a>
						<!-- 주문목록/수정 -->
						<a class="nav-link" href="<%=request.getContextPath()%>/admin/adminOrderList.jsp">
							<div class="sb-nav-link-icon">
								<i class="fas fa-tachometer-alt"></i>
							</div> 주문관리
						</a>
						<!-- 고객목록/강제탈퇴/비밀번호수정(전달구현X) -->
						<a class="nav-link" href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp">
							<div class="sb-nav-link-icon">
								<i class="fas fa-users"></i>
							</div> 고객관리
						</a>
						<!-- 공지 CRUD -->
						<a class="nav-link" href="<%=request.getContextPath()%>/admin/adminNoticeList.jsp">
							<div class="sb-nav-link-icon">
								<i class="fas fa-bell"></i>
							</div> 공지관리
						</a>
					</div>
					<!-- /nav -->
				</div>
			</nav>
		</div>
		<!-- /Left Nav -->

		<!-- Main page -->
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">제품 정보 수정</h1>
					<hr>
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-table me-1"></i> GoodsOne
						</div>
						<div class="card-body">
							<!-- 수정할 데이터  -->
							<form action="<%=request.getContextPath()%>/admin/adminGoodsOneUpdateAction.jsp" method="post" id="adminGoodsOneUpdate" enctype="multipart/form-data">
								<fieldset>
									<table class="table table-bordered">
										<tr>
											<th>goodsNo</th>
											<td><input type="text" class="form-control" name="goodsNo" id="goodsNo" readonly="readonly" value="<%=goodsOne.get("goodsNo")%>"></td>
										</tr>
										<tr>
											<th>goodsName</th>
											<td><input type="text" class="form-control" name="goodsName" id="goodsName"></td>
										</tr>
										<tr>
											<th>goodsPrice</th>
											<td><input type="text" class="form-control" name="goodsPrice" id="goodsPrice"></td>
										</tr>
										<tr>
											<th>soldOut</th>
											<td>품절<input type="radio" id="soldOut" name="soldOut" value="Y"> 재고있음<input type="radio" id="soldOut" name="soldOut" value="N">
											</td>
										</tr>
										<tr>
											<th>이미지 파일:</th>
											<td><input type="file" name="goodsImg" id="goodsImg"></td>
										</tr>
									</table>
									<button type="button" class="btn btn-primary" id="btn">수정</button>
								</fieldset>
							</form>
						</div>
					</div>
				</div>
			</main>

			<!-- footer -->
			<footer class="py-4 bg-light mt-auto">
				<div class="container-fluid px-4">
					<div class="d-flex align-items-center justify-content-between small">
						<div class="text-muted">Copyright &copy; PARKSJ Website 2022</div>
						<div>
							<a href="#">Privacy Policy</a> &middot; <a href="#">Terms &amp; Conditions</a>
						</div>
					</div>
				</div>
			</footer>
			<!-- footer -->
		</div>
		<!-- /Main page -->
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
	<script src="<%=request.getContextPath()%>/adminIndexBoot/js/scripts.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
	<script src="<%=request.getContextPath()%>/adminIndexBoot/assets/demo/chart-area-demo.js"></script>
	<script src="<%=request.getContextPath()%>/adminIndexBoot/assets/demo/chart-bar-demo.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
	<script src="<%=request.getContextPath()%>/adminIndexBoot/js/datatables-simple-demo.js"></script>
</body>
<script>
	$('#btn').click(function(){
		if ( $('#goodsName').val().length < 1){
			alert('상품명을 입력하세요');
		} else if( $('#goodsPrice').val().length < 3){
			alert('상품의 가격을 입력하세요');
		} else if( $('#soldOut').val().length < 1){
			alert('품절여부를 확인해주세요');
		} else if ( $('#goodsImg').val().length < 1){
			alert('파일을 선택하세요');
		} else {
			$('#adminGoodsOneUpdate').submit();
		}
	});
</script>
</html>
