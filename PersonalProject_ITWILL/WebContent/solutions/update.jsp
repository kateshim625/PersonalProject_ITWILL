<%@page import="java.sql.Timestamp"%>
<%@page import="board.CommentBean"%>
<%@page import="board.CommentDAO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link href="../css/default.css" rel="stylesheet" type="text/css"> -->
<link href="../css/subpage.css?ver=1" rel="stylesheet" type="text/css">
<link href="../css/front.css?ver=1" rel="stylesheet" type="text/css">
<script type="text/javascript">
function idselect() {
// 	alert(document.wfr.wid.value);
// 	opener.document.comForm.comment.value = document.wcomForm.wcomment.value;
	window.close();
}
</script>

</head>
<%

String wcomment = request.getParameter("wcomment");

// out.println(wcomment);

int num = Integer.parseInt(request.getParameter("num"));
int idx = Integer.parseInt(request.getParameter("idx"));
String id = (String)session.getAttribute("id");
Timestamp reg_date = new Timestamp(System.currentTimeMillis());

// int bnum = Integer.parseInt(request.getParameter("num"));
CommentDAO cdao = new CommentDAO();
CommentBean cb = cdao.getCommentIdx(idx);
// System.out.println(idx);
%>
<body>
<article class="pos">

<h1>Comment Update</h1>
<fieldset>
<legend>Comments</legend>
<form action="updatePro.jsp" method="post" class="wcomForm">
	<div>		
	
		<div>ID: <%=cb.getId()%> (<input type="hidden" name="idx" value="<%=idx %>">)- <%=cb.getReg_date()%>
		<input type="submit" value="Update" class="comButton">
		<p><textarea name="wcomment" cols=90 rows=3><%=cb.getComment() %></textarea></p></div>
	</div>	
<!-- </table> -->
</form>
</fieldset>

</article>
</body>
</html>