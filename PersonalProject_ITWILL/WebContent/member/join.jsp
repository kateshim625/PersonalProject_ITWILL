<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css?ver=1" rel="stylesheet" type="text/css">
<link href="../css/subpage.css?ver=1" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
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
 <script type="text/javascript">
 
 function zipOpen(){
	 window.open("zip.jsp","wname","width=700,height=200");
 
	}

 function winOpen(){
	 if(document.fr.id.value==""){ //아이디상자가 비어있는지 확인 
	 	alert("Please insert Id");
		document.fr.id.focus();
		return
	}			
	var id = document.fr.id.value;
 	window.open("idcheck.jsp?wid="+id,"","width=700,height=200");
		
	}
 function fun1(){
		
		if(document.fr.id.value.length < 4 || document.fr.id.value.length > 10) {
			alert("Please insert your Id");
			document.fr.id.focus();
			return false; //섭믿하지말게 하기위해서 펄스를 줌 joinPro.jsp못보내게해서 return fun1가고 최종 섭밑버튼으로 가서 멈춤 
		}
		
		if(document.fr.pass.value.length < 4 || document.fr.pass.value.length > 10) {
			alert("the length password should be 4 to 10.");
			document.fr.pass.focus();
			return false;
		}
		
			
		if(document.fr.pass2.value != document.fr.pass.value) {
			alert("The password is not matched. Please insert the passward again.");
			document.fr.pass2.focus();
			return false;
		}
		
		if(document.fr.name.value == "") {
			alert("Please insert your name.");
			document.fr.name.focus();
			return false;
		}
		
	}
 function fun2(){
		location.href="login.jsp";
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
<div id="sub_img_join"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="#">Join us</a></li>
<!-- <li><a href="#">Privacy policy</a></li> -->
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>Join Us</h1>
<form action="joinPro.jsp" id="join" method="post" name="fr" onsubmit="return fun1()"> <!-- 리턴해줘서 인풋의 섭믿트로 전달되야함 -->
<fieldset>
<legend>Basic Info</legend>
<label>User ID *</label>
<input type="text" name="id" class="id">
<input type="button" value="dup. check" class="dup" name="check" onclick="winOpen()"><br>
<label>Password *</label>
<input type="password" name="pass"><br>
<label>Retype Password</label>
<input type="password" name="pass2"><br>
<label>Name *</label>
<input type="text" name="name"><br>
<label>E-Mail</label>
<input type="email" name="email"><br>
<label>Retype E-Mail</label>
<input type="email" name="email2"><br>
</fieldset>

<fieldset>
<legend>Optional</legend>
<label>도로명주소</label>
<input type="text" name="address"><br>
<label>지번주소</label>
<input type="text" name="city"><br>
<label>상세주소</label>
<input type="text" name="country"><br>
<label>우편번호</label>
<input type="text" name="zip" class="id">
<input type="button" value="dup. check" class="dup" name="check" onclick="zipOpen()"><br>
<label>Phone Number</label>
<input type="text" name="phone"><br>
<label>Mobile Phone Number</label>
<input type="text" name="mobile"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="Submit" class="submit"> <!-- submit기능은 onclick="fun2()"아님 form태그가서 onsubmit="fun1()"해줘야됨 섭믿이 폼에있는내용을 들고 조인프로.제이에스피로 요청하러갈때가 섭믿-->
<input type="reset" value="Cancel" class="cancel">  
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