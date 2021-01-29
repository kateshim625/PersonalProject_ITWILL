<%@page import="board.CommentDAO"%>
<%@page import="board.CommentBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8");

int idx = Integer.parseInt(request.getParameter("idx"));
int num = Integer.parseInt(request.getParameter("num"));

String comment = request.getParameter("comment");

CommentBean cb = new CommentBean();
cb.setIdx(idx);
cb.setComment(comment);

CommentDAO cdao = new CommentDAO();
cdao.deleteComment(cb);
response.sendRedirect("gcontent.jsp?num="+num);

%>