<%@page import="service.OrdersService"%>
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
//전송받은 변수
int orderNo = Integer.parseInt(request.getParameter("orderNo"));
System.out.println(orderNo + "<-- orderNo - adminOrderOne.jsp");

//orderNo의 상세정보 가져오기
Map<String, Object> map = new OrdersService().getOrdersOne(orderNo);
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
						<a class="nav-link" href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp">
							<div class="sb-nav-link-icon">
								<i class="fas fa-list-alt"></i>
							</div> 상품관리
						</a>
						<!-- 주문목록/수정 -->
						<a class="nav-link  active" href="<%=request.getContextPath()%>/admin/adminOrderList.jsp">
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
					<h1 class="mt-4">주문 상세내역</h1>
					<hr>
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-table me-1"></i> OrdersOne
						</div>
						<div class="card-body">
							<table class="table table-bordered">
								<tr>
									<th>orderNo</th>
									<td><%=map.get("orderNo")%></td>
								</tr>
								<tr>
									<th>customerId</th>
									<td><%=map.get("customerId")%></td>
								</tr>
								<tr>
									<th>customerName</th>
									<td><%=map.get("customerName")%></td>
								</tr>
								<tr>
									<th>customerTelephone</th>
									<td><%=map.get("customerTelephone")%></td>
								</tr>
								<tr>
									<th>orderAddr</th>
									<td><%=map.get("orderAddr")%></td>
								</tr>
								<tr>
									<th>orderState</th>
									<td><%=map.get("orderState")%></td>
								</tr>
								<tr>
									<th>updateDate</th>
									<td><%=map.get("updateDate")%></td>
								</tr>
								<tr>
									<th>createDate</th>
									<td><%=map.get("createDate")%></td>
								</tr>
								<tr>
									<th>goodsName</th>
									<td><%=map.get("goodsName")%></td>
								</tr>
								<tr>
									<th>orderQuantity</th>
									<td><%=map.get("orderQuantity")%></td>
								</tr>
								<tr>
									<th>orderPrice</th>
									<td><%=map.get("orderPrice")%></td>
								</tr>
								<tr>
									<th>orderTotal</th>
									<td><%=map.get("orderTotal")%></td>
								</tr>
							</table>
							<!-- 버튼  -->
							<div style="padding: 10px;">
								<a href="<%=request.getContextPath()%>/admin/adminOrderOneUpdate.jsp?orderNo=<%=map.get("orderNo")%>"><button class="btn btn-primary" style="float: right; margin-left: 3px">수정</button></a> 
								<a href="<%=request.getContextPath()%>/admin/adminOrderList.jsp"><button class="btn btn-secondary" style="float: right; margin-left: 3px">이전</button></a> 
							</div>
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
	
</script>
</html>
