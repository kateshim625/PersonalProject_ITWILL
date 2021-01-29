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
 
</head>
<body>
<div id="wrap">
<!-- 헤더가 들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더가 들어가는 곳 -->

<!-- 본문 들어가는 곳 -->
<!-- 서브페이지 메인이미지 -->
<div id="sub_img"></div>
<!-- 서브페이지 메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="../company/welcome.jsp">About us</a></li>
<li><a href="../company/enotice.jsp">Event</a></li>
<!-- <li><a href="#">Newsroom</a></li> -->
<!-- <li><a href="#">Public Policy</a></li> -->
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 내용 -->
<article>
<h1>Welcome</h1>
<figure class="ceo"><img src="../images/company/CEO.jpg" width="196" height="226" 
alt="CEO"><figcaption>SOJUSQ CEO JR</figcaption>
</figure>

<p>Where does it come from?

Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of <br>
classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, <br>
a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure <br>
Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word <br>
in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 <br>
and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written <br>
in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. <br>
The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.<br>
<br>
The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. <br>
Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced <br>
in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.<br>
<br>
Koreans and Americans meeting up! <br>
We go for coffee, food & Soju together in NYC and exchange American and Korean culture.<br>
<br>
This group is for International students, interns, tourists, <br>
English language learners and Koreans that want to make American friends. <br>
We explore NYC together and have language exchanges!<br> </p>
<br>

<!-- <p>Koreans and Americans meeting up! <br> -->
<!-- We go for coffee, food & Soju together in NYC and exchange American and Korean culture.<br> -->

<!-- This group is for International students, interns, tourists, <br> -->
<!-- English language learners and Koreans that want to make American friends. <br> -->
<!-- We explore NYC together and have language exchanges!<br> -->
<!-- <br> -->
<!-- 한국인과 미국인이 만나요! <br> -->
<!-- 우리는 뉴욕에서 커피, 음식 및 소주를 함께 찾아 미국과 한국 문화를 교환합니다.<br> -->

<!-- 이 그룹은 미국 친구들을 사귀고 싶어하는 유학생, 인턴, 관광객, 영어 학습자 및 한국인을위한 그룹입니다. <br> -->
<!-- 우리는 함께 뉴욕을 탐험하고 언어 교환을합니다!</p> -->
</article>
<!-- 내용 -->
<!-- 본문 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>