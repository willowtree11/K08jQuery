<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JQ05AjaxSetup</title>
<link rel="stylesheet" href="../common/bootstrap4.5.3/css/bootstrap.css" />
<script src="../common/jquery/jquery-3.5.1.js"/></script>
<script>
	/*
		$.ajaxSetup()
			: 동일하게 반복되는 $.ajax()의 인자를 설정하여
			반복되는 인자를 생략할 수 있다. 오버라이딩과 비슷하다
			type, dataType등 기본적으로 사용되는 인자들을
			묶어서 setup쪽에 넣어두면 편리.
	*/
	$(function(){
		
		$.ajaxSetup({
			url: "./common/05JSONData.json",
			dataType: "json"
		});
		
		$('#btn').click(function(){
			$.ajax({
				success:function(responseData){
					/*
						콜백데이터는 JSON배열이므로 each()를 통해 인자의 갯수만큼 반복
						이때 각 반복시 JSON객체를 파싱하게 된다
						파싱시에는 .(온점)과 [](대괄호) 두가지 형태를 사용할 수 있다
						키값, 밸류값은 영문이 아니어도 된다.
					*/
					$.each(responseData, function(index, value){
						var htmlStr="<tr>";
						htmlStr += "	<td>"+(index+1)+"</td>";
						htmlStr += "	<td>"+value.name+"</td>";
						htmlStr += "	<td>"+value["age"]+"</td>";
						htmlStr += "	<td>"+value["주소"]+"</td>";
						htmlStr += "</tr>";
						
						//해당 테이블 뒷부분에 컨텐츠를 추가하게 된다.
						$('#tbl1').append(htmlStr);
					});
				},
				error:errFunc
			});
		});
	});
/*
	실패시 호출되는 콜백메소드도 콜백데이터를 가지고 있으며
	아래와 같이 매개변수를 통해 전달받을 수 있다.
*/
	function errFunc(errData){
		alert("실패: "+errData.status+": "+errData.statusText);
	}
</script>
</head>
<body>
<div class="container">
	<h2>$.ajaxSetup() 메소드 사용하기</h2>
	
	<table class="table table-bordered" id="tbl1">
		<tr>
			<td>NO</td>
			<td>이름</td>
			<td>나이</td>
			<td>출신지역</td>
		</tr>
	</table>
	
	<button id="btn">JSON데이터 가져오기</button>	
</div>
</body>
</html>