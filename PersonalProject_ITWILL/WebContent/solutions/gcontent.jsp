<%@page import="board.CommentDAO"%>
<%@page import="board.CommentBean"%>
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
//gcontent
int num = Integer.parseInt(request.getParameter("num"));
GalleryBoardDAO gbdao = new GalleryBoardDAO();
gbdao.updateGalleryReadcount(num);
GalleryBoardBean gbb = gbdao.getGalleryBoard(num);

//comment
String id = (String)session.getAttribute("id");
String comment = request.getParameter("comment");
// int bnum = Integer.parseInt(request.getParameter("num"));
CommentDAO cdao = new CommentDAO();
CommentBean cb = new CommentBean();
// cb.setBnum(num);
// cb.setNum(num);
// cb.setId(id);
// cb.setComment(comment);

int ccount = cdao.getCommentCount(num);
//게시판의 글의갯수가져올거 인트변수 count에저장됟고 그게 전체 글의 갯수임
int cpageSize = 10;
//전체 보여줄글 싸이즈
String cpageNum = request.getParameter("compageNum");
//페이지 넘버를 안가져왔을때 1로 설정되게
if(cpageNum == null){
	cpageNum = "1";
}
//페이지 넘버값 문자열을 정수형으로 바꿔줌
int ccurrentPage = Integer.parseInt(cpageNum);
//현재 페이지 -1해서 스타트로 게시판에 글이있으면 조회해서 가져오는
int cstartRow = (ccurrentPage-1)*cpageSize+1;
//
int cendRow = ccurrentPage*cpageSize;
//게시판의 수가 0이아니면 게시판의 리스트 시작하는 행에서 15개 가져올꺼고 화면에 뿌려주는데 
List cboardList = null;

//카운트가 0이아니면 
cboardList = cdao.getCommentBoardList(cstartRow, cpageSize, num);
//날짜를 문자열로 출력해줌  
SimpleDateFormat csdf = new SimpleDateFormat("yyyy.MM.dd");

// System.out.println(num+id+comment);

//커멘드 글 삭제-------------------


%>
<article>
<h1>Gallery Content</h1>
<table id="notice" class="view">
		<tr><td>Num</td><td><%=gbb.getNum() %></td>
			<td>ReadCount</td><td><%=gbb.getReadCount() %></td></tr>
	    <tr><td>Writer</td><td><%=gbb.getWriter() %></td>
			<td>Date</td><td><%=gbb.getDate() %></td></tr>
		<tr><td>Title</td><td colspan="3" ><%=gbb.getTitle() %></td></tr>
		<tr><td>Attached</td><td colspan="3">
		<a href="../upload/<%=gbb.getFile()%>">Preview : <%=gbb.getFile()%></a>
		<a href="gfile_down.jsp?file_name=<%=gbb.getFile() %>"> / Download</a></td></tr>
		<tr><td>Contect</td><td colspan="3" class="con">
		<img src="../upload/<%=gbb.getFile()%>" width="300"><br><br><%=gbb.getContent() %></td></tr>
</table>
<!-- Comment -->
<form action="gcommentPro.jsp" method="post" class="comm" name="comForm">
	<div class="comment">		
	<p>Comments</p>

		<div>
<%-- 			<input type="hidden" name="num" value="<%=num%>"> --%>
			<input type="hidden" name="num" value="<%=num%>"> <!--  게시판 넘버-->
			<input type="hidden" name="id" value="<%=id%>">
			<%

if(id!=null){
	%>
			<textarea name="comment" cols=90 rows=3 ></textarea>
			<input type="submit" value="confirm" class="btn" class="submit">
				<%
}
%>
		</div>

	</div>

<%		
cdao.getComment(num);
if(ccount!=0){
	for(int i = 0; i < cboardList.size(); i++){
		cb = (CommentBean)cboardList.get(i);		
		%>
		<div >
<script>
function update(num,idx){
	
	window.open("update.jsp?num="+num+"&idx="+idx,"wname","width=600,height=300");
}
</script>

		<div class="comment">ID: <%=cb.getId()%> <%-- (<%=cb.getIdx() %>) --%>- <%=cb.getReg_date()%>
				<%
if(id!=null){
	if(id.equals(cb.getId())){
		%>
		<input type="button" value="Delete" onclick="location.href='deleteComment.jsp?num=<%=num %>&idx=<%=cb.getIdx() %>'" class="comButton">
		<input type="button" value="Update" onclick="update('<%=num %>','<%=cb.getIdx() %>')" class="comButton" target="_blank">
						<%
	}
}
%>
		<p> ▶ <%=cb.getComment() %></p></div>

		</div>
		<%
	}
}

%>

<!-- <div id="table_search"> -->
<!-- <form action="../solutions/gnoticeSearch.jsp" method="post"> -->
<!-- <input type="text" name="search" class="input_box"> -->
<!-- <input type="submit" value="search" class="btn"> -->
<!-- </form> -->
<!-- </div> -->

<div class="clear"></div>
<div id="page_control">




</div>

<!-- </table> -->
</form>
<div id="table_search">
<%
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


<div class="clear"></div>
<div id="page_control">

<%
int pageCount = ccount/cpageSize+(ccount % cpageSize == 0 ? 0 : 1);
int pageBlock = 10;

int startPage = ((ccurrentPage-1)/pageBlock)*pageBlock +1;

int endPage = (startPage+pageBlock -1);
if(endPage > pageCount){
	endPage = pageCount;
}
if(startPage > pageBlock){
	%>
	<a href="gcontent.jsp?compageNum=<%=startPage-pageBlock%>&num=<%=num%>">Prev</a>
	<%
}
//겟방식형태주소줄 ? : 파일이름다음에 물음표하나 이름 =값 연결하는건 & 

for(int i = startPage; i <= endPage; i++){
	%>
	<a href="gcontent.jsp?compageNum=<%=i %>&num=<%=num%>"><%=i %></a>
	<%
}
	
if(endPage < pageCount){
	%>
	<a href="gcontent.jsp?compageNum=<%=startPage+pageBlock%>&num=<%=num%>">Next</a>
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