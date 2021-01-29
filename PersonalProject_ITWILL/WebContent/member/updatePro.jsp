<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
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
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String pass = request.getParameter("pass");
String old_pass = request.getParameter("old_pass");

String name = request.getParameter("name");
String email = request.getParameter("email");
String address = request.getParameter("address");
String city = request.getParameter("city");
String country = request.getParameter("country");
String zip = request.getParameter("zip");
String phone = request.getParameter("phone");
String mobile = request.getParameter("mobile");

MemberBean mb = new MemberBean();
mb.setId(id);
mb.setPass(pass);
mb.setName(name);
mb.setEmail(email);
mb.setAddress(address);
mb.setCity(city);
mb.setCountry(country);
mb.setZip(zip);
mb.setPhone(phone);
mb.setMobile(mobile);

if(pass!=null){
	mb.setPass(pass);
}else{
	mb.setPass(old_pass);
}

MemberDAO mdao = new MemberDAO();

int check = mdao.userCheck(id, pass);
	if(check == 1) {
		mdao.updateMember(mb);
		
		%>
		<script type="text/javascript">
			alert("Updated");
			history.back();
		</script>
		<%
// 		response.sendRedirect("updateForm.jsp"); 시나공 실기 / 요약위주 페이지수작은거
	} else if(check==0){
		%>
		<script type="text/javascript">
			alert("Password is not matched");
			history.back();
		</script>
		<%
	}else if(check==-1){
		%>
		<script type="text/javascript">
			alert("Id is not exsited");
			history.back();
		</script>
		<%
	}
	
%>
</body>
</html>