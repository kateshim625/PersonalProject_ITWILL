<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id"); 
String pass = request.getParameter("pass"); 
String pass2 = request.getParameter("pass2"); 
String name = request.getParameter("name"); 
String email = request.getParameter("email"); 
String email2 = request.getParameter("email2"); 
String address = request.getParameter("address"); 
String city = request.getParameter("city"); 
String country = request.getParameter("country"); 
String zip = request.getParameter("zip"); 
String phone = request.getParameter("phone"); 
String mobile = request.getParameter("mobile"); 
Timestamp reg_date = new Timestamp(System.currentTimeMillis());

MemberBean mb = new MemberBean();
mb.setId(id);
mb.setPass(pass);
mb.setPass2(pass2);
mb.setName(name);
mb.setEmail(email);
mb.setEmail2(email2);
mb.setAddress(address);
mb.setCity(city);
mb.setCountry(country);
mb.setZip(zip);
mb.setPhone(phone);
mb.setMobile(mobile);
mb.setReg_date(reg_date);

MemberDAO mdao = new MemberDAO();
mdao.insertMember(mb);

%>

<script type="text/javascript">
	alert("회원가입 성공");
	location.href="../contact/mailSendProByAdmin.jsp?email=<%=email%>";
</script>
