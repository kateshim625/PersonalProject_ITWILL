<%@page import="board.GalleryBoardDAO"%>
<%@page import="board.GalleryBoardBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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

GalleryBoardBean gbb = new GalleryBoardBean();
gbb.setNum(num);
gbb.setWriter(id);
gbb.setPass(pass);
gbb.setTitle(subject);
gbb.setContent(content);
gbb.setFile(file);

if(file!=null){
	gbb.setFile(file);
}else{
	gbb.setFile(old_file);
}
// System.out.println(bb.getPass()); 잘출력되고있는지확인가능

GalleryBoardDAO gbdao = new GalleryBoardDAO();
int check = gbdao.updateGalleryBoard(gbb);

if(check == 1) { 
	%>
	<script type="text/javascript">
		alert("Update Successed");
		location.href="gnotice.jsp"
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