<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JQ02Get.jsp</title>
<link rel="stylesheet" href="../common/bootstrap4.5.3/css/bootstrap.css" />
<script src="../common/jquery/jquery-3.5.1.js"/></script>
<script>
/*
  jQuery에서 제공하는 Ajax관련 메소드(총 4가지)
  2. $.get()
  		: HTTP get방식응ㄹ 통해 서버로부터 데이터를 받을 때 사용하는 메소드
  		형식] $.get(url, param, callback);
  				-url: 정보를 요청할 경로 및 파일명
  				-param: 서버로 전송할 파라미터로 JSON형태로 기술
  				-callback: 요청이 성공했을 때 실행되는 콜백(Callback)메소드.
  				콜백 메소드가 호출될 때 전달되는 파라미터를 통해  성공 및 실패 여부 판단가능
  		※ 서버로 요청 시 파라미터가 없는 경우 생략 가능함.
 
 */
	$(function(){
		$('#btnXml').click(function(){ //btnXml를 click했을 때
			$.get( //가져온다
				'./common/02NameCard.xml', 
				function(data){ //콜백 메소드, 내용을 전달받는다
					console.log(data);
					//이 경로로 요청을 보내 성공시 xml파일의 내용을 파라미터를 통해 전달
					//xml의 내용을 parsing 하는 작업
					//each는 반복하기 위한 메소드. 태그 여러개를 읽어들여야 하므로 읽어들이는 행위를 반복
					//콜백해준 내용을 대상으로 파싱(Parsing)을 진행한다
					/*
						find()를 통해 xml파일의 엘리먼트를 찾는다
						attr()을 통해 엘리먼트의 속성에 접근한다
						text()를 통해 태그사이의값에 접근한다
					*/
					$(data).find("명함").each(function(){
						var html="<div>이름: "+$(this).find("성명").attr("이름")+"</div>";
						html+="<div>주소: "+$(this).find("주소").text()+"</div>";
						html+="<div>직위: "+$(this).find("직위").text()+"</div>";
						html+="<div>이메일: "+$(this).find("e-mail").text()+"</div>";
						html+="<div>핸드폰: "+$(this).find("Mobile").text()+"</div>";
						html+="<div>전화번호: "+$(this).find("TEL").text()+"</div>";
						html+="<div>Copyright: "+$(this).find("copyright").text()+"</div>";
						
						//html()로 기존의 내용을 갱신한다.
						$('#xmlDisplay').html(html);
					/*
						해당영역의 내용을 empty()로 삭제한 후
						append()로 내용을 추가. html()과 동일한 기능 수행
						$('#xmlDisplay').empty();
						$('#xmlDisplay').append(html);
					*/
					});
				}
			)
		});
		
		/*
			서버로 요청시 파라미터가 필요한 경우 JSON으로 만들어서
			사용하게 된다. 만약 폼값이 많아서 기술이 힘든 경우에는
			serialize()를 통해 자동으로 JSON형태로 만들어준다.
		*/
		$('#btnJSP').click(function(){
			$.get(
				'./common/02PrintToday.jsp',{
					'msg': $(this).text(), //해당 버튼 텍스트 읽어오기
					'varStr': 'jQuery 좋아요'
				},
				function(data){
					alert(data);
					$('#jspDisplay').html(data);
				}			
			);
		});
	});
  		
  	function locationGo(link){
		window.open(link, '', 'width=500, height=500');
	}
	
</script>
</head>
<body>
<div>	
	<h2>$.get() 메소드 사용하기</h2>
	
	<h3>xml파일 읽어오기</h3>
	<button onclick="locationGo('./common/02NameCard.xml');">
		NameCard.xml바로가기
	</button>
	
	<button id="btnXml">
		XML데이터 읽어오기
	</button>
	
	<div class="displayDiv" id="xmlDisplay">
		XML데이터 정보를 디스플레이합니다.
	</div>
		
	<h3>jsp파일에서 읽어오기</h3>
	<button onclick="locationGo('common/02PrintToday.jsp?msg=안녕하세요&varStr=jQuery조아효');">
		PrintToday.jsp바로가기
	</button>
	<button id="btnJSP">
		JSP결과 읽어오기
	</button>
	<div class="disDisplay" id="jspDisplay">
		JSP결과를 디스플레이 합니다.
	</div>	
</div>
</body>

</html>