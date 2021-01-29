<%@page import="board.CommentDAO"%>
<%@page import="board.CommentBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
request.setCharacterEncoding("utf-8");

int idx = Integer.parseInt(request.getParameter("idx"));
String gpass = request.getParameter("pass");

cb.setIdx(idx);
cb.setComment(comment);
int comCheck = cdao.deleteComment(cb);
cdao.deleteComment(cb);
response.sendRedirect("gcontent.jsp");

<%
request.setCharacterEncoding("utf-8");

int idx = Integer.parseInt(request.getParameter("idx"));
String comment = request.getParameter("comment");

CommentBean cb = new CommentBean();
cb.setIdx(idx);
cb.setComment(comment);

CommentDAO cdao = new CommentDAO();
int gcheck = cdao.deleteComment(cb);
	if(gcheck == 1){
		cdao.deleteComment(cb);
		response.sendRedirect("gnotice.jsp");
	} else if(gcheck == 0){
		
	}
%>