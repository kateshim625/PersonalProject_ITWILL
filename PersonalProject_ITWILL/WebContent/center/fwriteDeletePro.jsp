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

int num = Integer.parseInt(request.getParameter("num"));
String pass = request.getParameter("pass");

FileBoardBean fbb = new FileBoardBean();
fbb.setNum(num);
fbb.setPass(pass);

FileBoardDAO fbdao = new FileBoardDAO();
int check = fbdao.deleteFileBoard(fbb);
	if(check == 1){
		fbdao.deleteFileBoard(fbb);
		response.sendRedirect("fnotice.jsp");
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