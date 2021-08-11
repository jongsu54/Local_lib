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
	
	$("#userPwCheck").hide();
	$("#searchId").hide();
	$("#searchPw").hide();
	
	//아이디 찾기 버튼 클릭시 아이디찾기 폼 보여주기
	$("#findUserId").on("click", function(){
		$("#searchId").show();
		$("#searchPw").hide();
	});
	$("#findUserPw").on("click", function(){
		$("#searchPw").show();
		$("#searchId").hide();
	});
	
	
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
					if(ck){
						$("#userPwCheck").show();
						var context = '<p>'+data.user_id+'</p>';
						
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
	
	//아이디찾기(비밀번호 찾기)
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
					var ck = confirm("비밀번호를 찾으시겠습니까?");
					if(ck){
						var context = '<p>'+data.pw+'</p>';
						$("#returnPw").html(context);
					}
				}
			},
			error : function(e){
				console.log(e);
				alert("입력된 정보가 없습니다. 다시 입력해 주세요");
			}
		});
	});
	
	/*----------------------------------------------------------------------*/
	
	//비밀번호 찾기
	$("#pw_userPwCheck").on("click", function(){
	
		var user_id = $("#pw_user_id").val();
		var name = $("#pw_name").val();
		var email1 = $("#pw_email1").val();
		var email2 = $("#pw_email2").val();
		var email = email1 + "@" + email2;
		
		$.ajax({
			url : "/pw_userPwCheck",
			type : "post",
			data : {
				user_id : user_id,
				name : name,
				email : email
			},
			dataType : "json",
			
			success : function(data){
				if(data){
					var ck = confirm("비밀번호를 찾으시겠습니까?");
					if(ck){
						var context = '<p>'+data.pw+'</p>';
						$("#pw_returnPw").html(context);
					}
				}
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
	
	$("#pw_reEnter").on("click", function(){
		$("#pw_returnPw").remove();
	});
	
});

function auto_select_email(){
	//alert("abc");
	var email2 = document.getElementById("email2");
	var email_selected = document.getElementById("email");
	
	var index = email_selected.options.selectedIndex;
	email2.value = email_selected.options[index].value;
}

function pw_auto_select_email(){
	var pw_email2 = document.getElementById("pw_email2");
	var pw_email_selected = document.getElementById("pw_email");
	
	var index = pw_email_selected.options.selectedIndex;
	pw_email2.value = pw_email_selected.options[index].value;
}

/*
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
*/

</script>
</head>
<body>
<h1>아이디 / 비밀번호 찾기</h1>

<!-- 아이디 찾기 -->
	
		<input type="button" id="findUserId" value="아이디 찾기">
		<input type="button" id="findUserPw" value="비밀번호 찾기"><br>
	<div id="searchId">
		<!-- <div id="returnFindUserId"></div> -->
		<label>이름</label><br>
		<input type="text" id="name" placeholder="Name"><br>
		
		<label>이메일</label><br>
		<input type="text" id="email1" placeholder="Email Id">@
		<input type="text" id="email2" placeholder="Email Address">
		
		<select id="email" onchange="auto_select_email();">
		    <option value>선택하세요</option>
		    <option value>직접입력</option>
		    <option value="naver.com">naver.com</option>
		    <option value="daum.net">daum.net</option>
		    <option value="gmail.com">gmail.com</option> 
		</select><br>
		<input type="button" id="userIdCheck" id="numSubmit" value="아이디확인"><br>
		
		<div id="returnId"></div>
		<div id="returnPw"></div>
		
		<input type="reset" id="reEnter" value="재입력">
		<input type="button" id="userPwCheck" value="비밀번호 찾기">
	</div>
	
	<!-- <p>-------------------------------------------------<p><br><br> -->
	
<!-- 비밀번호 찾기 -->
	<div id="searchPw">
		<label>아이디</label><br>
		<input type="text" id="pw_user_id" placeholder="ID"><br>
		
		<label>이름</label><br>
		<input type="text" id="pw_name" placeholder="Name"><br>
		
		<label>이메일</label><br>
		<input type="text" id="pw_email1" placeholder="Email Id">@
		<input type="text" id="pw_email2" placeholder="Email Address">
		
		<select id="pw_email" onchange="pw_auto_select_email();">
		    <option value>선택하세요</option>
		    <option value>직접입력</option>
		    <option value="naver.com">naver.com</option>
		    <option value="daum.net">daum.net</option>
		    <option value="gmail.com">gmail.com</option> 
		</select><br>
		
		<div id="pw_returnPw"></div>
		
		<input type="reset" id="pw_reEnter" value="재입력">
		<input type="button" id="pw_userPwCheck" value="비밀번호 찾기">
	</div>
	


</body>
</html>