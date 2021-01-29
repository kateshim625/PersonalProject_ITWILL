<%@page import="java.sql.Timestamp"%>
<%@page import="board.CommentDAO"%>
<%@page import="board.CommentBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
request.setCharacterEncoding("utf-8");

int idx = Integer.parseInt(request.getParameter("idx"));
String wcomment = request.getParameter("wcomment");

Timestamp reg_date = new Timestamp(System.currentTimeMillis());

CommentBean cb = new CommentBean();
cb.setIdx(idx);
cb.setComment(wcomment);
cb.setReg_date(reg_date);

CommentDAO cdao = new CommentDAO();
cdao.updateComment(cb);


%>
<script type="text/javascript">
opener.location.reload();
window.close();
</script>