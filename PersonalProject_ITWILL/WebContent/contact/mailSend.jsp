<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="java.util.Properties"%>
<%@page import="javax.mail.Session"%>
<%@page import="mailtest.GoogleAuthentication"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.io.PrintWriter"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//자바 메일 보내기 폼에서 입력한 한글 정보가 깨지지않도록 한다
request.setCharacterEncoding("utf-8");
//클라이언트 페이지에서 메일 전송에 사용하기 위해서 전송되어온 파라미터 값들을 받는 부분이다.
String sender = request.getParameter("sender");
String receiver = "kateshim5683@gmail.com";
String subject = request.getParameter("subject");
String content = request.getParameter("content");

response.setContentType("text/html;charset=UTF-8");

try {
	//서버정보를 PropertPropies객체에 저장한다
    Properties properties = System.getProperties();
	//starttls command를 사용할수있게 설정하는 부분이다. 
    properties.put("mail.smtp.starttls.enable","true");
	//SMTP 서버를 지정하는 부분이다.
    properties.put("mail.smtp.host","smtp.gmail.com");
	//AUTH command를 사용하여 사용자 인증을 할 수 있게 설정하는 부분
    properties.put("mail.smtp.auth","true");
	//서버포트를 지정하는 부분 (지메일포트)
    properties.put("mail.smtp.port","587");
    
	//인증정보를 생성하는 부분
    Authenticator auth = new GoogleAuthentication();
	//메일을 전송하는 역활을 하는 단위인 Session 객체를 생성하는 부분
    Session s = Session.getDefaultInstance(properties, auth);
    
	//생성한 Session객체를 사용하여 전송할 Message 객체를 생성하는 부분
    Message message = new MimeMessage(s);
    
	//메일을 송신할 송신주소를 생성하는 부분
    Address sender_address = new InternetAddress(sender); //
    //메일을 수신할 수신주소를 생성하는 부분
    Address receiver_address = new InternetAddress(receiver); //
    
    //메일전송에 필요한 값들을 설정하는 부분
    message.setHeader("content-type", "text/html;charset=UTF-8");
    message.setFrom(sender_address);
    message.addRecipient(Message.RecipientType.TO, receiver_address);
//     message.setSubject(subject);
    message.setSubject(subject + ": " + sender);
    message.setContent(content, "text/html;charset=UTF-8");

    //변수는 플로스로 해야함  
    message.setSentDate(new java.util.Date());
    
    //메세지를 메일로 전송하는 부분
    Transport.send(message);
    %>
    <script>
    	alert('Your details were sent successfully!');
    	location.href="mailForm.jsp";
    </script>
    <%
} catch (Exception e) {
    out.println("에러발생입니다");
    e.printStackTrace();
}

%>