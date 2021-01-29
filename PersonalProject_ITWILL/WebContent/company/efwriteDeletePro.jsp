<%@page import="board.GalleryBoardDAO"%>
<%@page import="board.GalleryBoardBean"%>
<%@page import="board.FileBoardDAO"%>
<%@page import="board.FileBoardBean"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="com.mysql.fabric.xmlrpc.base.Member"%>
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
request.setCharacterEncoding("utf-8");

int enum = Integer.parseInt(request.getParameter("num"));
String epass = request.getParameter("pass");

EventBoardBean gbb = new EventBoardBean();
ebb.setNum(enum);
ebb.setPass(epass);

EventBoardDAO ebdao = new EventBoardDAO();
int gcheck = gbdao.deleteGalleryBoard(gbb);
	if(gcheck == 1){
		gbdao.deleteGalleryBoard(gbb);
		response.sendRedirect("gnotice.jsp");
	} else if(gcheck == 0){
		%>
		<script type="text/javascript">
			alert("Password is not correct")
			history.back();
		</script>
		<%
	}
%>
</body>
</html>