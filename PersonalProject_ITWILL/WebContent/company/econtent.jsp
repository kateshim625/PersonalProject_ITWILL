<%@page import="board.GalleryBoardBean"%>
<%@page import="board.GalleryBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css?ver=1" rel="stylesheet" type="text/css">
<link href="../css/subpage.css?ver=1" rel="stylesheet" type="text/css">

<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- <header> top으로 보냄
<div id="login"><a href="../member/login.jsp">login</a> | <a href="../member/join.jsp">join</a></div>
<div class="clear"></div>
로고들어가는 곳
<div id="logo"><img src="../images/logo.gif" width="265" height="62" alt="Fun Web"></div>
로고들어가는 곳
<nav id="top_menu">
<ul>
	<li><a href="../main/main.jsp">HOME</a></li>
	<li><a href="../company/welcome.jsp">COMPANY</a></li>
	<li><a href="#">SOLUTIONS</a></li>
	<li><a href="../center/notice.jsp">CUSTOMER CENTER</a></li>
	<li><a href="#">CONTACT US</a></li>
</ul>
</nav>
</header> -->
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="gnotice.jsp">Gallery</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<%
int num = Integer.parseInt(request.getParameter("num"));

GalleryBoardDAO gbdao = new GalleryBoardDAO();
gbdao.updateGalleryReadcount(num);
GalleryBoardBean gbb = gbdao.getGalleryBoard(num);

%>
<article>
<h1>Gallery Content</h1>
<form method="post">
<table id="notice" class="view">
		<tr><td>Num</td><td><%=gbb.getNum() %></td>
			<td>ReadCount</td><td><%=gbb.getReadCount() %></td></tr>
	    <tr><td>Writer</td><td><%=gbb.getWriter() %></td>
			<td>Date</td><td><%=gbb.getDate() %></td></tr>
		<tr><td>Title</td><td colspan="3"><%=gbb.getTitle() %></td></tr>
		<tr><td>Attached</td><td colspan="3">
		<a href="../upload/<%=gbb.getFile()%>">Preview : <%=gbb.getFile()%></a>
		<a href="gfile_down.jsp?file_name=<%=gbb.getFile() %>"> / Download</a></td></tr>
		<tr class="con"><td>Contect</td><td colspan="3">
		<img src="../upload/<%=gbb.getFile()%>" width="300"><br><%=gbb.getContent() %></td></tr>
		
		<tr><td colspan="4">Comment[51]</td></tr>
		
		<tr><td colspan="4">
		<div><textarea name="content" cols=90 rows=3></textarea>
		<input type="button" value="confirm" class="btn" onclick=""></div></td></tr>
		
		<tr><td colspan="4"><div><%=gbb.getWriter() %> : <%=gbb.getContent() %></div></td>
		</tr>
</table>

<div id="table_search">
<%
String id = (String)session.getAttribute("id");

if(id!=null){
	if(id.equals(gbb.getWriter())){
		%>
		<input type="button" value="Update" class="btn" onclick="location.href='gfwriteUpdateForm.jsp?num=<%=gbb.getNum()%>'">
		<input type="button" value="Delete" class="btn" onclick="location.href='gfwriteDeleteForm.jsp?num=<%=gbb.getNum()%>'">
		<%
	}
}
%>
<input type="button" value="List" class="btn" onclick="location.href='gnotice.jsp'">
</div>
</form>

<div class="clear"></div>
<div id="page_control">

</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- <footer> bottom으로 보냄 
<hr>
<div id="copy">All contents Copyright 2011 FunWeb 2011 FunWeb 
Inc. all rights reserved<br>
Contact mail:funweb@funwebbiz.com Tel +82 64 123 4315
Fax +82 64 123 4321</div>
<div id="social"><img src="../images/facebook.gif" width="33" 
height="33" alt="Facebook">
<img src="../images/twitter.gif" width="34" height="34"
alt="Twitter"></div>
</footer> -->
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>