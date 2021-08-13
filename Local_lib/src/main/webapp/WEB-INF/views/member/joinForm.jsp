<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js" integrity="sha384-eMNCOe7tC1doHpGoWe/6oMVemdAVTMs2xqW4mwXrXsW0L84Iytr2wi5v2QjrP/xp" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.min.js" integrity="sha384-cn7l7gDp0eyniUwwAZgrzD06kc/tftFf19TOAs2zVinnD/C7E91j9yyk5//jjpt/" crossorigin="anonymous"></script>
<script src="/resources/js/jquery-3.6.0.js" type="text/javascript"></script>
<script type="text/javascript">
var flag = false;
/*
$(function(){
	$.ajax({
		url : "/idCheck",
		type : "post",
		data : {
			user_id : user_id
		},
		dataType : "json",
		success : function(data){
			if(data){
				var ck = confirm("사용 가능한 아이디 입니다. 사용하시겠습니까?");
				if(ck){
					$("#user_id").prop("readonly", true);
					flag = true;
				}else{
					$("#user_id").val("").focus();
				}
			}else{
				alert("사용중인 ID 입니다.");
				$("#user_id").val("").focus();
			}
		},
		error : function(e){
			console.log(e);
		}
	});

	
});

*/
function formCheck(){
	var user_id = $("#user_id").val();
	var pw = $("#pw").val();
	var pwCheck = $("#pwCheck").val();
	var phone = $("#phone").val();
	var email = $("#email").val();
	var postcode = $("#sample4_postcode").val();
	
	$("#email_selected").on("change",function(){
		$("#email2").text($(wjsuthis).val());
	});
	
	if(user_id == null || id == ""){
		alert("ID는 반드시 입력해 주세요");
		return false;
	}
	if(pw == null || pw == ""){
		alert("비밀번호는 반드시 입력해 주세요");
		return false;
	}
	if(user_pw != pwCheck ){
		alert("동일한 비밀번호를 입력하세요.");
		return false;
	}
	if(phone == null || phone == ""){
		alert("핸드폰 번호는 반드시 입력해 주세요");
		return false;
	if(postcode == null || postcode == ""){
		alert("주소는 반드시 입력해 주세요");
		return false;
	}
		
	}
	if(email == null || email == ""){
		alert("E-Mail은 반드시 입력해 주세요");
		return false;
	}
	return true;
}

</script>
</head>
<body>
<form action="/member/join" method="post" onsubmit="return formCheck();">
			<fieldset>
				<legend>회원 가입</legend>
				<table>
					<tr>
						<td>ID</td>
						<td>
							<input type="text" id="user_id" name="user_id">
							<input type="button" value="중복 체크" id="idCheckbtn">
						</td>
					</tr>
					<tr>
						<td colspan="2"><span style="color:grey"><small>ID는 8자 이내로 입력해 주세요</small></span></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td>
							<input type="password" id="pw" name="pw" >
						</td>
					</tr>
					<tr>
						<td colspan="2"><span style="color:grey"><small>비밀번호는 10자 이내로 입력해 주세요</small></span></td>
					</tr>
					<tr>
						<td>비밀번호 확인</td>
						<td>
							<input type="password" id="pwCheck">
						</td>
					</tr>
					<tr>
						<td colspan="2"><span style="color:grey"><small>비밀번호 확인을 위해 한번 더 입력 해 주세요</small></span></td>
					</tr>
					<tr>
						<td>휴대폰 번호</td>
					
						<td>010<input type="text" id="phone" name="phone"></td>
					</tr>
					<tr>
						<td colspan="2"><span style="color:grey"><small>010과 '-' 를 제외한 모든 숫자를 입력해주세요</small></span></td>
					</tr>
					<tr>
						<td>주소</td>
						
						<td>
							<input type="text" id="sample4_postcode" placeholder="우편번호" size="5" name="postcode" readonly>
							<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
							<input type="text" id="sample4_roadAddress" placeholder="도로명주소" size="20" name="addr1"readonly>
							<input type="text" id="sample4_jibunAddress" placeholder="지번주소" size="20"readonly><br>
							<span id="guide" style="color:#999;display:none"></span>
							<input type="text" id="sample4_detailAddress" placeholder="상세주소" size="20" name="addr2">
							<input type="text" id="sample4_extraAddress" placeholder="참고항목" size="20" name="addr2"readonly>
						</td>
					</tr>
					<tr>
						<td colspan="2"><span style="color:grey"><small>주소를 검색 해 주세요</small></span></td>
					</tr>
					<tr>
						<td>E-Mail</td>
						<td>
							<input type="text" id="email1" name="email">@
							<input type="text" id="email2" name="email">
							<select id="email_selected">
								<option selected>선택 하세요</option>
								<option id="google" value="gmail.com">gmail.com</option>
								<option id="naver" value="naver.com">naver.com</option>
								<option id="hanmail" value="hanmail.net">hanmail.net</option>
								<option id="selectYourSelf"> 직접 선택 </option>
							</select>
						</td>
					</tr>
					<tr>
						<th colspan="2">
							<input type="submit" value="가입 신청">
							<input type="button" value="창 닫기" id="close_btn">
						</th>
					</tr>
				</table>
			</fieldset>	
		</form>
		
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
</body>
</html>