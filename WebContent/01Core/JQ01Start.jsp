<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jQ01Start.jsp</title>
<link rel="stylesheet" href="../common/bootstrap4.5.3/css/bootstrap.css" />
<script src="../common/jquery/jquery-3.5.1.js"></script>
<script>
/*
	$(document).ready( //이 문서가 로딩이 끝났을 때,(자바스크립트의 window onload function 과 동일)
		function(){ //함수를 실행하라		
		}
	);
*/
/*
	jQuery의 시작점을 표현하는 4가지 방식으로
	해당 HTML문서가 모두 로드 된 이후 실행하겠다는 의미를 가지고 있다.  
 	JS의 onload이벤트와 비슷하다.
*/
 
	$(document).ready(function(){
		alert("jQuery 시작하기 1");
	});
	
	$().ready(function(){
		alert("jQuery 시작하기2");
	});
	
	jQuery(function(){
		alert("jQuery 시작하기3");
	});
	
	$(function(){
		alert("jQuery 시작하기4");
	});	//가장 간단한 문구이므로 자주 쓰이는 방식.
	
</script>
</head>
<body>
<div class="container">
	<h2>jQuery 시작하기</h2>
	<script>
		alert("HTML문서의 끝");	
	</script>
</div>
</body>
</html>