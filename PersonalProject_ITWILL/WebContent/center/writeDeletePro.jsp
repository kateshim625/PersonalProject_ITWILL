<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
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

int num = Integer.parseInt(request.getParameter("num"));
String pass = request.getParameter("pass");

BoardBean bb = new BoardBean();
bb.setNum(num);
bb.setPass(pass);

BoardDAO bdao = new BoardDAO();
int check = bdao.deleteBoard(bb);
	if(check == 1){
		bdao.deleteBoard(bb);
		response.sendRedirect("notice.jsp");
	} else if(check == 0){
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