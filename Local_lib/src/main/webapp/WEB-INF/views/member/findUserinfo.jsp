<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>findUserinfo</title>

<script type="text/javascript" src="/resources/js/jquary-3.6.0.js"></script>
<script type="text/javascript">
var dpcheck = false;

	$(function(){
		$("#nameCheck").on("click", function(){
			
			var name = $("#name").val();
			//이름
			if(name == ""){
				alert("이름을 입력해 주세요");
				return false;
			}
			$.ajax({
				url : "/nameCheck",
				type : "post",
				data : {
					name : name
				},
				dataType : "json",
				success : function(data){
					if(data){
						var ck = confirm("등록되어있는 이름입니다. 이 정보로 검색하시겠습니까?");
						if(ck){
							$("#name").prop("readonly", true);
							dpcheck = true;
						}
					}else{
						alert("입력하신 정보가 없습니다. 회원가입을 진행해 주세요");
						$("#name").val("").focus();
					}
				},
				error : function(e){
					console.log(e);
				}
			});
			
		});
	});

	function formCheck1(){
		var name = $("#name").val();
		var user_id = $("#user_id").val();
		var email1 = $("#email1").val();
		var email2 = $("#email2").val();
		
		//이름확인버튼
		if(!dpCheck){
			alert("이름확인 버튼을 눌러주세요");
			return false;
		}
		//아이디
		if(user_id == ""){
			alert("아이디를 입력해주세요");
			return false;
		}

		//이메일
		if(email1 == ""){
			alert("이메일 아이디를 입력해주세요");
			return false;
		}
		if(email2 == ""){
			alert("이메일 주소를 입력해 주세요");
			return false;
		}
		return true;
	}
</script>
</head>
<body>
<h1>아이디 찾기/비밀번호 찾기 폼</h1>

<!-- 아이디 찾기 -->
<div id="findDiv">
	<form action="/find" method="post" onsubmit="return formCheck1();">
		<input type="button" id="findId" value="아이디 찾기">
		<input type="button" id="findPw" value="비밀번호 찾기"><br>
		
		<label>이름</label><br>
		<input type="text" id="name" value="name" onfocus="this.value='';"><br>
		<input type="button" id="nameCheck" value="이름 확인"><br>
		
		
		<label>이메일</label><br>
		<input type="text" name="email1" value="email" onfocus="this.value='';">@
		<input type="text" name="email2">
		<select id="email" onchange="email_change()">
		    <option value>선택하세요</option>
		    <option value>직접입력</option>
		    <option value="naver.com">naver.com</option>
		    <option value="daum.net">daum.net</option>
		    <option value="gmail.com">gmail.com</option> 
		</select>
		<input type="button" id="numSubmit" value="인증번호 전송">
	</form><br><br><br>
</div>

<!-- 비밀번호 찾기 -->
<div id="find2">
	<form action="">
	
		<label>아이디</label><br>
		<input type="text" id="user_id" value="아이디" onfocus="this.value='';"><br>
		<input type="button" id="idCheck" value="아이디 확인"><br>
		
		<label>이메일</label><br>
		<input type="text" name="email1" value="이메일" onfocus="this.value='';">   @
		<input type="text" name="email2" value="" disabled >
		<select name="email" onchange="email_change()">
		    <option value="0" >선택하세요</option>
		    <option value="9">직접입력</option>
		    <option value="naver.com">naver.com</option>
		    <option value="daum.net">daum.net</option>
		    <option value="gmail.com">gmail.com</option> 
		</select>
		<input type="button" id="numSubmit" value="인증번호 전송">
	</form>
</div><br><br><br>


<input type="button" id="reEnter" value="재입력">
<input type="submit" id="next" value="다음">

</body>
</html>