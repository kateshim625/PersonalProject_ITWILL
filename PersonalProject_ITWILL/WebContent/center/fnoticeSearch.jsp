<%@page import="board.FileBoardBean"%>
<%@page import="board.FileBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
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
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<jsp:include page="../inc/menu.jsp"/>

<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<%
request.setCharacterEncoding("utf-8");
String fsearch = request.getParameter("search");

String fid = (String)session.getAttribute("id");

FileBoardDAO fbdao = new FileBoardDAO();

int fcount = fbdao.getFileBoardCount(fsearch);
//게시판의 글의갯수가져올거 인트변수 count에저장됟고 그게 전체 글의 갯수임
int fpageSize = 10;
//전체 보여줄글 싸이즈
String fpageNum = request.getParameter("pageNum");
//페이지 넘버를 안가져왔을때 1로 설정되게
if(fpageNum == null){
	fpageNum = "1";
}
//페이지 넘버값 문자열을 정수형으로 바꿔줌
int fcurrentPage = Integer.parseInt(fpageNum);
//현재 페이지 -1해서 스타트로 게시판에 글이있으면 조회해서 가져오는
int fstartRow = (fcurrentPage-1)*fpageSize+1;
//
int fendRow = fcurrentPage*fpageSize;
//게시판의 수가 0이아니면 게시판의 리스트 시작하는 행에서 15개 가져올꺼고 화면에 뿌려주는데 
List fboardList = null;
//카운트가 0이아니면 
fboardList = fbdao.getFileBoardList(fstartRow, fpageSize, fsearch);
//날짜를 문자열로 출력해줌  
SimpleDateFormat fsdf = new SimpleDateFormat("yyyy.MM.dd");

%>
<article>
<h1>File Notice[<%=fcount %>]</h1>
<table id="notice">
<tr><th class="tno">No.</th>
    <th class="ttitle">Title</th>
    <th class="twrite">Writer</th>
    <th class="tdate">Date</th>
    <th class="tread">Read</th></tr>
<%
//0~14까지 가져오게되고 0번째꺼꺼내서 보드빈에 저장할거임 보드빈에형에 맞춰서 변환해줌
if(fcount!=0){
	for(int i = 0; i < fboardList.size(); i++){
		FileBoardBean fbb = (FileBoardBean)fboardList.get(i);
		%>
		<tr onclick="location.href='fcontent.jsp?num=<%=fbb.getNum()%>'">
		<td><%=fbb.getNum() %></td>
		<td class="left"><%=fbb.getTitle() %></td>
	    <td><%=fbb.getWriter() %></td>
	    <td><%=fsdf.format(fbb.getDate()) %></td>
	    <td><%fbb.getReadCount(); %></td>
	    </tr>   
		<%
	}
}

%>

</table>
<%
if(fid!=null){
	%>
	<div id="table_search">
	<input type="button" value="Write" class="btn" onclick="location.href='fwriteForm.jsp'">
	</div>
	<%
}
%>
<div id="table_search">
<form action="fnoticeSearch.jsp" method="post">
<input type="text" name="search" class="input_box">
<input type="submit" value="search" class="btn">
</form>
</div>
<div class="clear"></div>
<div id="page_control">
<%
int fpageCount = fcount/fpageSize+(fcount % fpageSize == 0 ? 0 : 1);
int fpageBlock = 3;

int fstartPage = ((fcurrentPage-1)/fpageBlock)*fpageBlock +1;

int fendPage = (fstartPage+fpageBlock -1);
if(fendPage > fpageCount){
	fendPage = fpageCount;
}
if(fstartPage > fpageBlock){
	%>
	<a href="fnoticeSearch.jsp?pageNum=<%=fstartPage-fpageBlock%>&search=<%=fsearch%>">Prev</a>
	<%
}

for(int i = fstartPage; i <= fendPage; i++){
	%>
	<a href="fnoticeSearch.jsp?pageNum=<%=i %>&search=<%=fsearch%>"><%=i %></a>
	<%
}
	
if(fendPage < fpageCount){
	%>
	<a href="fnoticeSearch.jsp?pageNum=<%=fstartPage+fpageBlock%>&search=<%=fsearch%>">Next</a>
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