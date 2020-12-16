<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--파일명: 07GoodsSelect1.jsp --%>
<%
	request.setCharacterEncoding("utf-8");
	String gName=request.getParameter("goodsOptionName");
	if(gName.equals("op01")){
%>
	<table class="table table-bordered">
		<tr>
			<td>옵션명: </td>
			<td>옵션 선택1(AAA추가)</td>
		</tr>
		<tr>
			<td colspan="2" class="danger">추가비용: +5,000원</td>
		</tr>
	</table>
<% }else if(gName.equals("op02")){ %>
	<table class="table table-bordered">
		<tr>
			<td>옵션명: </td>
			<td>옵션 선택2(BBB추가)</td>
		</tr>
		<tr>
			<td colspan="2" class="danger">추가비용: +5,000원</td>
		</tr>
	</table>
<% }else if(gName.equals("op03")){ %>
	<table class="table table-bordered">
		<tr>
			<td>옵션명: </td>
			<td>옵션 선택3(CCC추가)</td>
		</tr>
		<tr>
			<td colspan="2" class="danger">추가비용: +10,000원</td>
		</tr>
	</table>
<%} %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>07GoodsSelect1</title>
<link rel="stylesheet" href="../common/bootstrap4.5.3/css/bootstrap.css" />
<script src="../common/jquery/jquery-3.5.1.js"/></script>
</head>
<body>

</body>
</html>