<%@page import="service.NoticeService"%>
<%@page import="vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//인코딩
request.setCharacterEncoding("utf-8");
//전송받은 값 변수 설정
Notice notice = new Notice();
notice.setNotice_no(Integer.parseInt(request.getParameter("noticeNo")));
notice.setNotice_title(request.getParameter("noticeTitle"));
notice.setNotice_content(request.getParameter("noticeContent"));
//디버깅
System.out.println(notice);
//service로 값 보내기
int row = new NoticeService().setNotice(notice);
if(row == 1){	//수정에 성공한다면
	System.out.println("공지사항 수정 성공!");
} else {	//수정에 실패한다면
	System.out.println("공지사항 수정 실패!");
}
//둘 다 NoticeOne로 이동
response.sendRedirect(request.getContextPath()+"/admin/adminNoticeOne.jsp?noticeNo="+notice.getNotice_no());

%>