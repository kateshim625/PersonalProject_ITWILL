<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더들어가는 곳 -->
<header>
<%
String id = (String)session.getAttribute("id");
if(id == null) {
	%>
	<div id="login"><a href="../member/login.jsp">login</a> | <a href="../member/join.jsp">join</a></div>
	<%	
}else {
	%>
	<div id="login">Hi, <%=id %> | <a href="../member/updateForm.jsp">My Account</a> | <a href="../member/logout.jsp">logout</a></div>
	<%	
}
%>

<div class="clear"></div>
<!-- 로고들어가는 곳 -->
<div id="logo"><a href="../main/main.jsp"><img src="../images/logo1.png" width="150" height="38" alt="sojusqlogo"></a></div>
<!-- 로고들어가는 곳 -->
<nav id="top_menu">
<ul>
	<li><a href="../main/main.jsp">HOME</a></li>
	<li><a href="../company/enotice.jsp">EVENTS</a></li>
	<li><a href="../solutions/gnotice.jsp">GALLERY</a></li>
	<li><a href="../center/notice.jsp">CUSTOMER CENTER</a></li>
	<li><a href="../contact/mailForm.jsp">CONTACT US</a></li>
</ul>
</nav>
</header>
<!-- 헤더들어가는 곳 -->