<%@page import="service.NoticeService"%>
<%@page import="service.ReviewService"%>
<%@page import="service.CustomerService"%>
<%@page import="java.util.List"%>
<%@page import="service.OrdersService"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="service.GoodsService"%>
<%@page import="vo.*"%>
<%@page import="service.EmployeeService"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
//접근제한
if (session.getAttribute("id") == null) {
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	return;
}
//전송받은 값
String customerId = (String) session.getAttribute("id");
Customer loginUser = new CustomerService().getCustomerOne(customerId);
//회원 정보 가져오기
Customer customer = new CustomerService().getCustomerOne(customerId);
//페이징 변수
final int rowPerPage = 10;
int currentPage = 1;
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage")); //전달되는 값으로 현재페이지를 설정
	System.out.println(currentPage + "<-- currentPage - adminCustomerList");
}
//리스트에 보여줄 공지사항 가져오기
List<Notice> list = null;
list = new NoticeService().getNoticeList(rowPerPage, currentPage);
System.out.println(list);

//lastPage 구하기
int lastPage = new NoticeService().getNoticeLastPage(rowPerPage);
System.out.println(lastPage + "<-- lastPage - adminNoticeList");
%>
<%@include file="/hearder.jsp"%>

<!-- BREADCRUMB -->
<div id="breadcrumb" class="section">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<div class="col-md-12">
				<h3 class="breadcrumb-header">공지사항</h3>
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
			<table class="table table-boarder">
				<thead>
					<tr>
						<th>noticeNo</th>
						<th>noticeTitle</th>
						<th>createDate</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Notice n : list) {
					%>
					<tr>
						<td style="width: 200px"><%=n.getNotice_no()%></td>
						<td><a href="<%=request.getContextPath()%>/customer/customerNoticeOne.jsp?noticeNo=<%=n.getNotice_no()%>"><%=n.getNotice_title()%></a></td>
						<td style="width: 300px"><%=n.getCreate_date()%></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
			<!-- 페이징과 버튼 -->
			<!-- row  -->
			<div class="row" style="text-align: center;">
				<ul class="pagination" >
					<%
					if (currentPage > 1) {
					%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/customer/customerNoticeList.jsp?currentPage=<%=currentPage - 1%>">이전</a></li>
					<%
					} else {
					%>
					<li class="page-item disabled"><a class="page-link" href="#">이전</a></li>
					<%
					}
					%>
					<%
					if (currentPage < lastPage) {
					%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/customer/customerNoticeList.jsp?currentPage=<%=currentPage + 1%>">다음</a></li>
					<%
					} else {
					%>
					<li class="page-item disabled"><a class="page-link" href="#">다음</a></li>
					<%
					}
					%>
				</ul>
				<!-- /페이징 -->
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
</div>
<!-- SECTION -->
<!-- FOOTER -->
<%@include file="/footer.jsp"%>
<!-- /FOOTER -->
</body>
</html>