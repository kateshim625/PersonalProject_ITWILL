<%@page import="board.FileBoardDAO"%>
<%@page import="board.FileBoardBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String uploadPath = request.getRealPath("/upload");
System.out.println(uploadPath);
int maxSize = 5 * 1024 * 1024;

MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());
String name = multi.getParameter("name");
String pass = multi.getParameter("pass");
String subject = multi.getParameter("subject");
String content = multi.getParameter("content");
String file = multi.getFilesystemName("file");

Timestamp date = new Timestamp(System.currentTimeMillis());

FileBoardBean fbb = new FileBoardBean();
fbb.setWriter(name);
fbb.setPass(pass);
fbb.setTitle(subject);
fbb.setContent(content);
fbb.setDate(date);
fbb.setFile(file);

FileBoardDAO bdao = new FileBoardDAO();
bdao.insertBoard(fbb);

response.sendRedirect("fnotice.jsp");
%>
</body>
</html>