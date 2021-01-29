<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.*"%>
<%@ page import="com.oreilly.servlet.ServletUtils"%>


<%
	request.setCharacterEncoding("utf-8");
//파일 이름가져오기
    String fileName = request.getParameter( "file_name" );
 	System.out.println(fileName);
 //파일 물리적인 경로 가져오기
//     String savePath = "/upload"; //uploadPath
//     ServletContext context = getServletContext(); // //물리적인경로 getRealPath쓰기위해getServletContext 객체생성하는거 
//     String sDownloadPath = context.getRealPath(savePath);//물리적인경로 getRealPath / 
	
// 파일 물리적인 경로 
	String uploadPath = request.getRealPath("/upload"); //request객체가 생성되어있어서 바로사용
//     String sFilePath = sDownloadPath + "\\" + fileName;
 //물리적인 경로 + 파일이름
	String sFilePath = uploadPath + "\\" + fileName;

    System.out.println(sFilePath);
//타입을 인티지등불린바이트등 자바파일로 정의한것 바이트 형태로 데이터를 저장하고싶을때 사용
//배열로 바이트형의 바이트형으로 4096개의 데이터를 저장할수있는 배열 선언한거임
  	byte b[] = new byte[4096];
//파일을 가져오기 => 자바에서 제어하기위해서 실제파일을 가져와서 자바에서 제어하기위해서 file객체 생성
//파일의 정보를 가져다가 파일을 제어할수있는데 파일이 존재하면 삭제, 읽기전용인지 형태가 이미지인지 크기가 얼마인지 정보드릉 다 알수있게하는것
//내장객체 파일의 타입이먼지 가져오기위해
	File oFile = new File(sFilePath);
//자바에서 제공하는 API 파일 입출력에 관련된 자바에서 제공된 API 파일객채를 준비해서 입력을 받은 
//입력에관련됨 oFile입력을 받아서 처리한것 
    FileInputStream in = new FileInputStream(oFile);
//물리적인 경로+ sFilePath+의 
//타입이 이미지인지 확인하는것 
    String sMimeType = getServletContext().getMimeType(sFilePath);
	System.out.println("sMimeType>>>"+sMimeType );
//파일 타입sMimeType이 없는 null경우 기본타입 application/octet-stream으로 설정해논것
    // octet-stream은  8비트로 된 일련의 데이터를 뜻합니다. 지정되지 않은 파일 형식을 의미합니다.
 
    if(sMimeType == null) sMimeType = "application/octet-stream";
//서버에서 response응답할때 알아온타입 확인한타입sMimeType으로 설정
    response.setContentType(sMimeType); // setContentType클라이언트에보낼떄 타입을멀로할지 설정하는것

//브라우저 별로 한글처리 
//User-Agent가 무슨 브라우저스는지 알아오는것 
    String userAgent = request.getHeader("User-Agent");
   //그브라우저가 MSIE거나 Trident거나 = MSIE 익스플로러 브라우저이면 트로 / 나머지는 false 
    boolean ie = (userAgent.indexOf("MSIE") > -1)|| (userAgent.indexOf("Trident") > -1);
    String sEncoding=null;
    if(ie) { //fileName이름만 경로처리한거
    	//익스플로러 브라우저 "\\+", "%20"형태로 정리 > 한글처리
	  sEncoding = URLEncoder.encode(fileName, "utf-8").replaceAll("\\+", "%20");
	  System.out.println(sEncoding);
    }else{
    	//나머지 브라우저 "8859_1"형태로 처리 > 한글처리해서 sEncoding변수에 저장 
	  sEncoding = new String(fileName.getBytes("utf-8"),"8859_1");
	  System.out.println(sEncoding);
   }
     
   //한글 업로드 (이 부분이 한글 파일명이 깨지는 것을 방지해 줍니다.)
//    String sEncoding = new String(fileName.getBytes("utf-8"),"8859_1");
 //  System.out.println(sEncoding);
//서버에서 클라이언트에 보낼때 파일을 브라우저에서 바로 실행하지않고 첨부파일로 다운로드되게끔 설정
   //setHeader 응답할때 해더값을 브라우저에 바로 실행하지말고 attachment다운받게끔 해라고 설정하는것
   response.setHeader("Content-Disposition", "attachment; filename= " + sEncoding);
//response.getOutputStream 출력하는거 = 자바에서 제공API 내장객체로 응답 출력하귀 위한 객체 생성
   ServletOutputStream out2 = response.getOutputStream();
   int numRead;

   // 바이트 배열b의 0번 부터 numRead번 까지 브라우저로 출력
//in 앍오두란개 바이너리파일이라 numRead정수형에 저장하고 입력받아서 위에 FileInputStream에서 입력받은 파일을  = 
// ServletOutputStream 이용해서 출력한거임  

//파일을 다운받아서 형태가먼지확인후 다운로드하고 셋해더값설정해서 첨부파일로 다운로드받겟다하고 한것이 밑에 출력부붖ㄴ

   while((numRead = in.read(b, 0, b.length)) != -1) {
    out2.write(b, 0, numRead);
   }
   out2.flush(); 
   out2.close();
   in.close();

   out.clear();
	out = pageContext.pushBody();
 //  ServletUtils.returnFile( PdsMisc.UPLOAD_DIRECTORY + File.separator + StringMisc.uniToEuc( fileName ), response.getOutputStream() );
 
 
// 업로드폴더이름 만바꾸고 나머지 같게사용하면됨
%>
