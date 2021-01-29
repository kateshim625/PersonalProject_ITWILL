<%@page import="mailtest.SendMail"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Contact Us</title>
<link href="../css/default.css?ver=1" rel="stylesheet" type="text/css">
<link href="../css/subpage.css?ver=1" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/sv-n/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
 <%
// String id = (String)session.getAttribute("id");

// MemberDAO mdao = new MemberDAO();
// MemberBean mb = mdao.getMember(id);

// SendMail send = new SendMail();

String id = null;
if(session.getAttribute("id") == null){
	%>
	<script type="text/javascript">
		alert('로그인 후 이용가능합니다.');
		location.href='../member/login.jsp';
	</script>
	<%
} else {
    id = (String)session.getAttribute("id");
}

MemberDAO mdao = new MemberDAO();
MemberBean mb = mdao.getMember(id);

 
 %>
 <script type="text/javascript">
 function fun1(){
	
		if(document.join.subject.value == "") {
			alert("Please insert your subject.");
			document.join.subject.focus();
			return false;
		}
		if(document.join.message.value == "") {
			alert("Please insert your message.");
			document.join.message.focus();
			return false;
		}
		
		document.join.submit();
// 		return false;
	}
</script>
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->



<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_contact"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="../contact/mailForm.jsp">Contact Us</a></li>
<li><a href="../contact/map.jsp">Map</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>Contact Us</h1>
<form action="mailSend.jsp" id="join" method="post" name="fr" onsubmit="return fun1()"> <!-- 리턴해줘서 인풋의 섭믿트로 전달되야함 -->
<fieldset>

<table>
<tr><td>Sender</td><td><input type="text" value="<%=id %>"><td></tr>
<tr><td>E-mail</td><td><input type="text" name="sender" value="<%=mb.getEmail() %>"><td></tr>
<tr><td>Subject</td><td><input type="text" name="subject"><td></tr>
<tr><td>Message</td><td><textarea name="content" cols=50 rows=10></textarea><td></tr>
<tr><td align=center colspan=2><div id="buttons">
<div id="submit"><input type="submit" value="Send" class="submit"></div></td></tr>
</table>


<!-- <legend>Contact Form</legend> -->
<!-- <label>Sender</label> -->
<!-- <input type="text" name=id><br> -->
<!-- <label>Receiver </label> -->
<!-- <input type="text" name="receiver"><br> -->
<!-- <label>Subject *</label> -->
<!-- <input type="text" name="subject"><br> -->
<!-- <label>Message *</label> -->
<!-- <textarea name=" content" cols="70" rows="10"></textarea> -->

</fieldset>

<div class="clear"></div>
<div id="buttons">
<!-- <div id="buttons"><input type="submit" value="Send" class="submit"></div> -->

<!-- <input type="submit" value="Submit" class="submit"> submit기능은 onclick="fun2()"아님 form태그가서 onsubmit="fun1()"해줘야됨 섭믿이 폼에있는내용을 들고 조인프로.제이에스피로 요청하러갈때가 섭믿 -->
<!-- <input type="reset" value="Cancel" class="cancel">   -->
</div>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>