<%@page import="java.sql.Date"%>
<%@page import="board.GalleryBoardBean"%>
<%@page import="board.GalleryBoardDAO"%>
<%@page import="board.FileBoardBean"%>
<%@page import="board.FileBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css?ver=1" rel="stylesheet" type="text/css">
<link href="../css/front.css?ver=1" rel="stylesheet" type="text/css">
<style>
div.gallery {
  margin: 5px;
  border: 1px solid #ccc;
  float: left;
  width: 215px;
}

div.gallery:hover {
  border: 1px solid #777;
}

div.gallery img {
  width: 100%;
  height: 80px;;
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
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더파일들어가는 곳 -->

<!-- 메인이미지 들어가는곳 -->
<div class="clear"></div>
<div id="main_img"><img src="../images/main_img.png" width="971" height="282"></div>
<!-- 메인이미지 들어가는곳 -->
<!-- 메인 콘텐츠 들어가는 곳 -->
<article id="front">

<div>
<jsp:include page="../inc/time.jsp"/>


</div>

<div id="news_notice">
<h3> <span class="orange">New </span>pictures</h3>
<div id="solution" class="orange">

<%
GalleryBoardDAO gbdao = new GalleryBoardDAO();
int gcount = gbdao.getGalleryBoardCount();
int gpageSize = 4;
int gstartRow = 1;
List gboardList = null;
gboardList = gbdao.getGalleryBoardList(gstartRow, gpageSize);
SimpleDateFormat gsdf = new SimpleDateFormat("yyyy.MM.dd");
if(gcount!=0){
	for(int i = 0; i < gboardList.size(); i++){
		GalleryBoardBean gbb = (GalleryBoardBean)gboardList.get(i);
		%>
		<div class="gallery">
		<a href="../solutions/gcontent.jsp?num=<%=gbb.getNum()%>"><img src="../upload/<%=gbb.getFile()%>" height="100"></a>
<%-- 		  <p><%=gbb.getWriter() %> / <%gbb.getReadCount(); %></p> --%>
		   
<%-- 		    <p><%gbb.getTitle(); %></p> --%>
		  <div class="desc"><%=gbb.getWriter() %> <br><%=gsdf.format(gbb.getDate()) %></div>
		  
		</div>
		<%
	}
}
%>
</div>
</div>

<div class="clear"></div>
<div id="news_notice">
<h3><span class="orange">New</span> Download</h3>
<table>

<%
FileBoardDAO fbdao = new FileBoardDAO();
int fcount = fbdao.getFileBoardCount();
int fpageSize = 5;
int fstartRow = 1;
List fileBoardList = null;
fileBoardList = fbdao.getFileBoardList(fstartRow, fpageSize);
SimpleDateFormat fsdf = new SimpleDateFormat("yyyy.MM.dd");
if(fcount!=0){
	for(int i = 0; i < fileBoardList.size(); i++){
		FileBoardBean fbb = (FileBoardBean)fileBoardList.get(i);
		%>
		<tr>
			<td class="contxt"><a href="../center/fcontent.jsp?num=<%=fbb.getNum()%>"><%=fbb.getTitle() %></a></td>
			<td><%=fsdf.format(fbb.getDate()) %></td>
		</tr>
		<%
	}
}
%>
</table>
</div>

<div id="news_notice">
<h3> <span class="orange">New </span>Notice</h3>
<table>
<%
BoardDAO bdao = new BoardDAO();
int count = bdao.getBoardCount();
int pageSize = 5;
int startRow = 1;
List boardList = null;
boardList = bdao.getBoardList(startRow, pageSize);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
if(count!=0){
	for(int i = 0; i < boardList.size(); i++){
		BoardBean bb = (BoardBean)boardList.get(i);
		%>
		<tr>
			<td class="contxt"><a href="../center/content.jsp?num=<%=bb.getNum()%>"><%=bb.getTitle() %></a></td>
			<td><%=sdf.format(bb.getDate()) %></td>
		</tr>
		<%
	}
}
%>

</table>
</div>
</article>
<!-- 메인 콘텐츠 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>