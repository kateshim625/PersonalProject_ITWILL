<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link href="../css/default.css" rel="stylesheet" type="text/css"> -->
<link href="../css/subpage.css?ver=1" rel="stylesheet" type="text/css">
<link href="../css/front.css?ver=1" rel="stylesheet" type="text/css">
<script type="text/javascript">
function idselect() {
// 	alert(document.wfr.wid.value);
	opener.document.fr.id.value = document.wfr.wid.value;
	window.close();
}
</script>

</head>
<body>
<article class="pos">

<h1>Checking Id</h1>
<fieldset>
<legend>Searching ID</legend>
<form id="idcheck.jsp" method="get" name="wfr" class="idche">

<%
String wid = request.getParameter("wid");

out.println(wid);

MemberDAO mado = new MemberDAO();
int check = mado.idCheck(wid);

%>
<%
if(check==1){
	out.println("is exsited");
}else {
	out.println("is usable");
	%>	
	<input type="button" class="submit" value="Choose ID" onclick="idselect()">
	<%
}
%>
<br>
<br>
<label>ID</label>
<input type="text" name="wid" value="<%=wid%>">
<input type="submit" value="ID check" class="dup" name="check" onclick=""><br>

</form>
</fieldset>

</article>
</body>
</html>