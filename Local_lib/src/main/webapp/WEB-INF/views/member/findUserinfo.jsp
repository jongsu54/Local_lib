<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>findUserinfo</title>

<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript">
//var dpcheck = false;

$(function(){
	
	//아이디 찾기
	$("#userIdCheck").on("click", function(){
	
		var name = $("#name").val();
		var email1 = $("#email1").val();
		var email2 = $("#email2").val();
		var email = email1 + "@" + email2;
		
		$.ajax({
			url : "/userIdCheck",
			type : "post",
			data : {
				name : name,
				email : email
			},
			dataType : "json",
			success : function(data){
				if(data){
					var ck = confirm("아이디를 찾으시겠습니까?");
					alert(ck);
					if(ck){
						var context = '<p>'+data.user_id+'</p>';
						context += '<input type="button" id="userPwCheck" value="비밀번호 찾기">';
						$("#returnId").html(context);
					}
				}
			},
			error : function(e){
				console.log(e);
				alert("입력된 정보가 없습니다. 다시 입력해 주세요");
				$("#name").val("");
				$("#email1").val("");
				$("#email2").val("");
			}
		});
	});
	
	//비밀번호 찾기
	$("#userPwCheck").on("click", function(){
	
		var name = $("#name").val();
		var email1 = $("#email1").val();
		var email2 = $("#email2").val();
		var email = email1 + "@" + email2;
		
		$.ajax({
			url : "/userPwCheck",
			type : "post",
			data : {
				name : name,
				email : email
			},
			dataType : "json",
			success : function(data){
				if(data){
					confirm("비밀번호를 찾으시겠습니까?");
				}
				var context = '<p>'+data.pw+'</p>';
				$("#returnPw").html(context);
			},
			error : function(e){
				console.log(e);
				alert("입력된 정보가 없습니다. 다시 입력해 주세요");
			}
		});
	});
	
	$("#reEnter").on("click", function(){
		$("#returnId").remove();
		$("#returnPw").remove();
	});
	
});

function auto_select_email(){
	var email2 = document.getElementById("email2");
	var email_selected = document.getElementById("email");
	
	var index = email_selected.options.selectedIndex;
	email2.value = email_selected.options[index].value;
}


function formCheck1(){
	
	var name = $("#name").val();
	var email1 = $("#email1").val();
	var email2 = $("#email2").val();

	//이름
	if(name==""){
		alert("이름을 입력해 주세요");
		return false;
	}
	
	//이메일
	if(email1==""){
		alert("이메일 아이디를 입력해주세요");
		return false;
	}
	//이메일 주소 확인
	if(email2==""){
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
	<form action="/member/findId" method="post" onsubmit="return formCheck1();">
		<input type="button" id="findUserid" value="아이디 찾기">
		<input type="button" id="findUserpw" value="비밀번호 찾기"><br>
		
		<label>이름</label><br>
		<input type="text" id="name" placeholder="name"><br>
		
		<!-- <input type="button" id="nameCheck" value="이름 확인"> -->
		
		<label>이메일</label><br>
		<input type="text" id="email1" placeholder="email id">@
		<input type="text" id="email2" placeholder="email address">
		
		<select id="email" onchange="auto_select_email();">
		    <option value>선택하세요</option>
		    <option value>직접입력</option>
		    <option value="naver.com">naver.com</option>
		    <option value="daum.net">daum.net</option>
		    <option value="gmail.com">gmail.com</option> 
		</select>
		<input type="button" id="userIdCheck" id="numSubmit" value="확인"><br>
		
		<div id="returnId"></div>
		<div id="returnPw"></div>
		
		<input type="reset" id="reEnter" value="재입력">
		<input type="button" id="userPwCheck" value="비밀번호 찾기">
	</form>


</body>
</html>