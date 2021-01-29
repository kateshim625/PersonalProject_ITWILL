<%@page import="board.GalleryBoardDAO"%>
<%@page import="board.GalleryBoardBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Event</title>
<link href="../css/default.css?ver=1" rel="stylesheet" type="text/css">
<link href="../css/subpage.css?ver=1" rel="stylesheet" type="text/css">
<style>
div.gallery {
  margin: 5px;
  border: 1px solid #ccc;
  float: left;
  width: 180px;
}

div.gallery:hover {
  border: 1px solid #777;
}

div.gallery img {
  width: 100%;
/*   height: auto; */
}

div.desc {
  padding: 15px;
  text-align: center;
}
</style>
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
<!-- 헤더가 들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더가 들어가는 곳 -->

<!-- 본문 들어가는 곳 -->
<!-- 서브페이지 메인이미지 -->
<div id="sub_img"></div>
<!-- 서브페이지 메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="../company/welcome.jsp">About us</a></li>
<li><a href="../company/enotice.jsp">Event</a></li>
<!-- <li><a href="#">Newsroom</a></li> -->
<!-- <li><a href="#">Public Policy</a></li> -->
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<%
String id = (String)session.getAttribute("id");

GalleryBoardDAO gbdao = new GalleryBoardDAO();

int count = gbdao.getGalleryBoardCount();
//게시판의 글의갯수가져올거 인트변수 count에저장됟고 그게 전체 글의 갯수임
int pageSize = 9;
//전체 보여줄글 싸이즈
String pageNum = request.getParameter("pageNum");
//페이지 넘버를 안가져왔을때 1로 설정되게
if(pageNum == null){
	pageNum = "1";
}
//페이지 넘버값 문자열을 정수형으로 바꿔줌
int currentPage = Integer.parseInt(pageNum);
//현재 페이지 -1해서 스타트로 게시판에 글이있으면 조회해서 가져오는
int startRow = (currentPage-1)*pageSize+1;
//
int endRow = currentPage*pageSize;
//게시판의 수가 0이아니면 게시판의 리스트 시작하는 행에서 15개 가져올꺼고 화면에 뿌려주는데 
List gboardList = null;
//카운트가 0이아니면 
gboardList = gbdao.getGalleryBoardList(startRow, pageSize);
//날짜를 문자열로 출력해줌  
SimpleDateFormat gsdf = new SimpleDateFormat("yyyy.MM.dd");

%>
<article>
<h1>Event[<%=count %>]</h1>
<table id="notice">
<%
//0~14까지 가져오게되고 0번째꺼꺼내서 보드빈에 저장할거임 보드빈에형에 맞춰서 변환해줌

if(count!=0){
	for(int i = 0; i < gboardList.size(); i++){
		GalleryBoardBean gbb = (GalleryBoardBean)gboardList.get(i);
		%>
		<div class="gallery" onclick="location.href='gcontent.jsp?num=<%=gbb.getNum()%>'">
			<a href="gcontent.jsp?num=<%=gbb.getNum()%>"> <img src="../upload/<%=gbb.getFile()%>" height="100"></a>
		  <div class="desc"><%=gbb.getWriter() %> <br> <%=gsdf.format(gbb.getDate()) %></div>
		</div>
		<%
	}
}

%>
</table>
<%
if(id!=null){
	%>
	<div id="table_search">
	<input type="button" value="Write" class="btn" onclick="location.href='gfwriteForm.jsp'">
	</div>
	<%
}
%>
<div id="table_search">
<form action="noticeSearch.jsp" method="post">
<input type="text" name="search" class="input_box">
<input type="submit" value="search" class="btn">
</form>
</div>
<div class="clear"></div>
<div id="page_control">
<%
int pageCount = count/pageSize+(count % pageSize == 0 ? 0 : 1);
int pageBlock = 10;

int startPage = ((currentPage-1)/pageBlock)*pageBlock +1;

int endPage = (startPage+pageBlock -1);
if(endPage > pageCount){
	endPage = pageCount;
}
if(startPage > pageBlock){
	%>
	<a href="gnotice.jsp?pageNum=<%=startPage-pageBlock%>">Prev</a>
	<%
}

for(int i = startPage; i <= endPage; i++){
	%>
	<a href="gnotice.jsp?pageNum=<%=i %>"><%=i %></a>
	<%
}
	
if(endPage < pageCount){
	%>
	<a href="gnotice.jsp?pageNum=<%=startPage+pageBlock%>">Next</a>
	<%
}
%>
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