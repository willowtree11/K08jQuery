<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JQ04Ajax.jsp</title>
<link rel="stylesheet" href="../common/bootstrap4.5.3/css/bootstrap.css" />
<script src="../common/jquery/jquery-3.5.1.js"/></script>
<script>
$(function(){ //load 메소드와 동일
	/*
		해당 메소드는 문서의 로드가 끝난 직후 js파일을 
	*/
	$.ajax({
		url: './common/04JsData.js',
		type: 'get',
		dataType: 'script',
		//요청 성공시 콜백메소드: 무기명 함수 형태로 정의됨
		success: function(resData){
			MyAlert("Hello", " AJAX");
		},
		//요청 실패시 콜백메소드: 외부함수 형태로 정의됨(호출시 함수명만 명시)
		error: errFunc
	});
	
	$('#ajaxBtn').click(function(){
		$.ajax({
			//요청할 서버의 경로 Url
			url: './common/02PrintToday.jsp',
			//요청시 전송방식
			type: 'get',
			//콜백 데이터의 타입
			dataType: 'html',
			//전송방식에 따른 컨텐츠 타입
			contentType: "text/html;charset:utf-8",
			//파라미터 여려개의 값이므로 JSON형식
			data:{
				msg: $(this).text(),
				varStr: "$.ajax()메소드 좋아요 via_02PrintToday.jsp"
			},
			//성공 / 실패시 콜백메소드. sucFunc(매개변수) 같은 형태로 쓰면 안됨. '함수명'만 명시한다
			success: sucFunc,
			error: errFunc
		});
	});
});

function errFunc(){ //실패 콜백메소드
	alert("에러 발생, 디버깅 필요");
}
/*
	요청 성공시 호출할 콜백메소드로 jQuery외부에 정의되었다.
	함수명만으로 지정하더라도 콜백데이터는 파라미터로 전달받을 수 있다.
 */
function sucFunc(resData){ //성공 콜백메소드
	alert("$.ajax()메소드 요청 성공");
	$('#ajaxDisplay').html(resData);
}

</script>
</head>
<body>
	<h2>$.ajax() 메소드 사용하기</h2>
	
	<button id="ajaxBtn">ajax()메소드실행하기</button>
	
	<div id="ajaxDisplay">
		ajax결과를 여기에 디스플레이
	</div>
</body>
</html>