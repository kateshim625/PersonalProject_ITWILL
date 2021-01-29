<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 

String id = request.getParameter("id");
String pass = request.getParameter("pass");

MemberDAO mdao = new MemberDAO(); 

int check = mdao.userCheck(id, pass);

if(check==1) {
	session.setAttribute("id", id);
	response.sendRedirect("../main/main.jsp");
} else if(check==0){
	%>
	<script type="text/javascript">
		alert("The password is not matched.")
		history.back();
	</script>
	<%
} else if(check==-1){
	%>
	<script type="text/javascript">
		alert("The Id is not existed.")
		history.back();
	</script>
	<%
}

%>