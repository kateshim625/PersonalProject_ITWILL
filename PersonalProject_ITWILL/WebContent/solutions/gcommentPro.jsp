<%@page import="board.GalleryBoardBean"%>
<%@page import="board.CommentDAO"%>
<%@page import="board.CommentBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

int num = Integer.parseInt(request.getParameter("num"));
String id = request.getParameter("id");
// int idx = Integer.parseInt(request.getParameter("idx"));

String comment = request.getParameter("comment");

System.out.println(num+id+comment);


Timestamp reg_date = new Timestamp(System.currentTimeMillis());

CommentBean cb = new CommentBean();
cb.setNum(num);
cb.setId(id);
cb.setComment(comment);
cb.setReg_date(reg_date);

CommentDAO cdao = new CommentDAO();
cdao.insertComment(cb);
// int count = cdao.getCommentCount(idx);

// response.sendRedirect("gcontent.jsp");

%>
<script type="text/javascript">
<%-- 	location.href='gcontent.jsp?num=<%=num%>&idx=<%=count%>'; --%>
	location.href='gcontent.jsp?num=<%=num%>';
</script>
