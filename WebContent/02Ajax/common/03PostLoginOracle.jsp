<%@page import="controller.OracleDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%--파일명: 03PostLogin.jsp --%>
<%
	//폼 값을 받음
	String id=request.getParameter("user_id");
	String pw=request.getParameter("user_pw");
	
	OracleDAO dao=new OracleDAO();
	boolean isMember=dao.isMember(id, pw);
	JSONObject json=new JSONObject();	
	
	if(isMember==true){
		json.put("result", 1);
		json.put("message", "로그인 성공");
		
		String html="";
		html +="<table class='table table-bordered' style='width:300px;'>";
		html +="	<tr>";
		html +="		<td>회원님 반갑습니다</td>";
		html +="	</tr>";
		html +="</table>";
		
		json.put("html", html);
	}
	else{
		//로그인 실패시 다른 정보없이 result만 0으로 생성한다.
		json.put("result", 0);
		json.put("message", "로그인 실패");
	}
	
	dao.close(); //커넥션풀에 자원 반납
	
	//JSON객체를 String으로 변환한 후 화면에 출력한다.
	String jsonStr=json.toJSONString();
	out.println(jsonStr);
%>