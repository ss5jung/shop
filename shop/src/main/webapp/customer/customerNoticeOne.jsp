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
//noticeNo
int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
System.out.println(noticeNo + "<-- noticeNo - adminNoticeOne.jsp");

//보여줄 공지사항 가져오기
Notice notice = new Notice();
notice = new NoticeService().getNoticeOne(noticeNo);
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
				<tr>
					<th>noticeNo</th>
					<td><%=notice.getNotice_no()%></td>
				</tr>
				<tr>
					<th>noticeTitle</th>
					<td><%=notice.getNotice_title()%></td>
				</tr>
				<tr>
					<th>noticeContent</th>
					<td><%=notice.getNotice_content()%></td>
				</tr>
				<tr>
					<th>updateDate</th>
					<td><%=notice.getUpdate_date()%></td>
				</tr>
				<tr>
					<th>createDate</th>
					<td><%=notice.getCreate_date()%></td>
			</table>
			<!-- 버튼 -->
			<div style="float: right;">
				<a href="<%=request.getContextPath()%>/customer/customerNoticeList.jsp"><button class="btn btn-primary">목록</button></a>
			</div>
		</div>
		<!-- /row -->
	</div>
	<!-- /container -->
</div>
<!-- SECTION -->
<!-- FOOTER -->
<%@include file="/footer.jsp"%>
<!-- /FOOTER -->
</body>
</html>