<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
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
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String title = request.getParameter("subject");
String content = request.getParameter("content");

BoardBean bb = new BoardBean();
bb.setNum(num);
bb.setWriter(id);
bb.setPass(pass);
bb.setTitle(title);
bb.setContent(content);

// System.out.println(bb.getPass()); 잘출력되고있는지확인가능

BoardDAO bdao = new BoardDAO();
int check = bdao.updateBoard(bb);

if(check == 1) { 
	
	%><script type="text/javascript">
		alert("Update Successed");
		location.href="content.jsp?num=<%=num%>"
	</script>
<%
	
}else if (check == 0){
	%>
	<script type="text/javascript">
		alert("Password is not matched");
		history.back();
	</script>
	<%
}


%>
</body>
</html>