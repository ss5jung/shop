<%@page import="java.util.ArrayList"%>
<%@page import="vo.Customer"%>
<%@page import="service.CustomerService"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="service.OrdersService"%>
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
//페이징 변수
final int rowPerPage = 10;
int currentPage = 1;
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage")); //전달되는 값으로 현재페이지를 설정
	System.out.println(currentPage + "<-- currentPage - adminCustomerList");
}
//리스트에 보여줄 데이터 가져오기
List<Customer> list = null;
list = new CustomerService().getCustomerList(rowPerPage, currentPage);
System.out.println(list);

//lastPage 구하기
int lastPage = new CustomerService().getCustomerLastPage(rowPerPage);
System.out.println(lastPage + "<-- lastPage - adminCustomerList");
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
						<a class="nav-link" href="<%=request.getContextPath()%>/admin/adminOrderList.jsp">
							<div class="sb-nav-link-icon">
								<i class="fas fa-tachometer-alt"></i>
							</div> 주문관리
						</a>
						<!-- 고객목록/강제탈퇴/비밀번호수정(전달구현X) -->
						<a class="nav-link active" href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp">
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
					<h1 class="mt-4">고객관리</h1>
					<hr>
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-table me-1"></i> Customers Data
						</div>
						<div class="card-body">
							<table class="table table-boarder">
								<thead>
									<tr>
										<th>customerId</th>
										<th>customerName</th>
										<th>Join Date</th>
									</tr>
								</thead>
								<tbody>
									<%
									for (Customer c : list) {
									%>
									<tr>
										<td><a href="<%=request.getContextPath()%>/admin/adminCustomerOneOrderList.jsp?customerId=<%=c.getCustomerId()%>"><%=c.getCustomerId()%></a></td>
										<td><%=c.getCustomerName()%></td>
										<td><%=c.getCreateDate()%></td>
									</tr>
									<%
									}
									%>
								</tbody>
							</table>
						</div>
						<!-- 페이징 -->
						<div class="container">
							<ul class="pagination justify-content-center">
								<%
								if (currentPage > 1) {
								%>
								<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp?currentPage=<%=currentPage - 1%>">이전</a></li>
								<%
								} else {
								%>
								<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp?currentPage=<%=currentPage - 1%>">이전</a></li>
								<%
								}
								%>
								<%
								if (currentPage < lastPage) {
								%>
								<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp?currentPage=<%=currentPage + 1%>">다음</a></li>
								<%
								} else {
								%>
								<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp?currentPage=<%=currentPage + 1%>">다음</a></li>
								<%
								}
								%>
								<!-- 
								<li class="page-item"><a class="page-link" href="#">이전</a></li>
								<li class="page-item"><a class="page-link" href="#">1</a></li>
								<li class="page-item"><a class="page-link" href="#">2</a></li>
								<li class="page-item"><a class="page-link" href="#">3</a></li>
								<li class="page-item"><a class="page-link" href="#">다음</a></li> 
								-->
							</ul>
						</div>
						<!-- /페이징 -->
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
</html>
