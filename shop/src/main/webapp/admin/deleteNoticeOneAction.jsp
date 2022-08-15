<%@page import="service.NoticeService"%>
<%@page import="repository.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
//전송받은 값
int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
System.out.println(noticeNo + "<-- noticeNo");
//삭제 실행하기
int row = new NoticeService().deleteNotice(noticeNo);
if (row == 1) {
	System.out.println(noticeNo + "번째 공지가 삭제되었습니다.");
	response.sendRedirect(request.getContextPath() + "/admin/adminNoticeList.jsp");
} else {
	System.out.println("공지사항 삭제에 실패하였습니다.");
	response.sendRedirect(request.getContextPath() + "/admin/adminNoticeOne.jsp?noticeNo=" + noticeNo);
}
%>
