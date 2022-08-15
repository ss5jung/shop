<%@page import="service.NoticeService"%>
<%@page import="vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
//전송받은 값들을 Notice 객체에 셋팅
Notice notice = new Notice();
notice.setNotice_title(request.getParameter("noticeTitle"));
notice.setNotice_content(request.getParameter("noticeContent"));
System.out.println(notice);

int row = new NoticeService().insertNotice(notice);
if(row == 1){
	System.out.println("공지사항 추가에 성공하였습니다");
} else {
	System.out.println("공지사항 추가에 실패하였습니다.");
}
//성공하든지 실패하든지 무조건 리스트로 이동
response.sendRedirect(request.getContextPath()+"/admin/adminNoticeList.jsp");
%>