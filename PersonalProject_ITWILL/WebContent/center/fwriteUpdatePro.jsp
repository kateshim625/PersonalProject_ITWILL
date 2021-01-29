<%@page import="board.FileBoardDAO"%>
<%@page import="board.FileBoardBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
String uploadPath = request.getRealPath("/upload");
int maxSize = 5 * 1024 * 1024;

MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());

int num = Integer.parseInt(multi.getParameter("num"));
String id = multi.getParameter("id");
String pass = multi.getParameter("pass");
String subject = multi.getParameter("subject");
String content = multi.getParameter("content");
String file = multi.getFilesystemName("file");
String old_file = multi.getParameter("old_file");

FileBoardBean fbb = new FileBoardBean();
fbb.setNum(num);
fbb.setWriter(id);
fbb.setPass(pass);
fbb.setTitle(subject);
fbb.setContent(content);

if(file!=null){
	fbb.setFile(file);
}else{
	fbb.setFile(old_file);
}
// System.out.println(bb.getPass()); 잘출력되고있는지확인가능

FileBoardDAO fbdao = new FileBoardDAO();
int check = fbdao.updateFileBoard(fbb);

if(check == 1) { 
	%>
	<script type="text/javascript">
		alert("Update Successed");
		location.href="fcontent.jsp?num=<%=num%>"
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