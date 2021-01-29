<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>board/writePro.jsp</h1> 
<%
request.setCharacterEncoding("utf-8");

String name = request.getParameter("name");
String pass = request.getParameter("pass");
String subject = request.getParameter("subject");
String content = request.getParameter("content");

Timestamp date = new Timestamp(System.currentTimeMillis());

BoardBean bb = new BoardBean();
bb.setWriter(name);
bb.setPass(pass);
bb.setTitle(subject);
bb.setContent(content);
bb.setDate(date);

BoardDAO bdao = new BoardDAO();
bdao.insertBoard(bb);

response.sendRedirect("notice.jsp");
%>