<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bookAdd</title>
	<script src="/resources/js/jquery-3.6.0.js"></script>
	<script type="text/javascript">
	$(function(){
		//도서 검색
		$("#search").on("click",function(){
			var keyword = $("#keyword").val();

			$.ajax({
				url : '/naverBookSearch',
				type : 'get',
				//한글로 보내주기 위해선 필요
				contentType : "application/json; charset=utf-8",
				data : {
					keyword : keyword
				},
				dataType : "json",
				success : function(data){
					console.log(data);
					
					//items의 i 번째 데이터의 내용
					var context = '<table>'
					$.each(data.items, function(i,o){
						context += '<tr><td><img src='+this.image+'></td>';
						context += '<td>'+this.title+'</td>';
						context += '<td>'+this.author+'</td>';	
						context += '<td>'+this.isbn+'</td>';
						context += '<td>'+this.publisher+'</td></tr>';
					});
					context += '<table>';
					$("#result").html(context);
				},
				error : function(e){
					console.log(e);	
				}
			});
			
		});
		
		//도서 상세 검색
		$("#search_adv").on("click",function(){
			var book_name = $("#book_name").val();
			var author = $("#author").val();
			var isbn = $("#isbn").val();
			var publisher = $("#publisher").val();

			$.ajax({
				url : '/naverBookSearch',
				type : 'get',
				//한글로 보내주기 위해선 필요
				contentType : "application/json; charset=utf-8",
				data : {
					book_name : book_name
					,author : author
					,isbn : isbn
					,publisher : publisher
				},
				dataType : "json",
				success : function(data){
					console.log(data);
					
					//items의 i 번째 데이터의 내용
					var context = '<table>'
					$.each(data.items, function(i,o){
						context += '<tr><td><img src='+this.image+'></td>';
						context += '<td>'+this.title+'</td>';
						context += '<td>'+this.author+'</td>';	
						context += '<td>'+this.isbn+'</td>';
						context += '<td>'+this.publisher+'</td></tr>';
					});
					context += '<table>';
					$("#result").html(context);
				},
				error : function(e){
					console.log(e);	
				}
			});
			
		});
		
		// 도서 직접 제출 시 유효성 검사 & isbn 체크
		$("#submit_form").on("click",function(){
			var check = true;
			var bookisinNaver = false;
			
			var book_name = $("#book_name_d").val();
			var author = $("#author_d").val();
			var publisher = $("#publisher_d").val();
			var isbn = $("#isbn_d").val();
			var isbn_chk = 	parseInt(isbn/1000000000000)
							+ parseInt((isbn%1000000000000)/100000000000)*3
							+ parseInt((isbn%100000000000)/10000000000)
							+ parseInt((isbn%10000000000)/1000000000)*3
							+ parseInt((isbn%1000000000)/100000000)
							+ parseInt((isbn%100000000)/10000000)*3
							+ parseInt((isbn%10000000)/1000000)
							+ parseInt((isbn%1000000)/100000)*3
							+ parseInt((isbn%100000)/10000)
							+ parseInt((isbn%10000)/1000)*3
							+ parseInt((isbn%1000)/100)
							+ parseInt((isbn%100)/10)*3
							+ parseInt((isbn%10)/1);
			
			if(book_name.length == 0){
				alert("제목을 입력해주세요.");
				check = false;
			}
			else if(author.length == 0){
				alert("저자를 입력해주세요.");
				check = false;
			}
			else if(publisher.length == 0){
				alert("출판사를 입력해주세요.");
				check = false;
			}
			else if(isbn.length < 13 || isbn < 9780000000000 || isbn > 9799999999999 || isbn_chk % 10 != 0 ){
				alert("isbn을 잘못 입력하셨습니다.");
				check = false;
			}
			
			// 유효성 검사 통과 시
			if(check==true){
			// 네이버 api로 isbn으로 검색 가능한지 체크
			// check_isbn_from_naver(isbn);
				$.ajax({
					url : '/naverBookSearch',
					type : 'get',
					//한글로 보내주기 위해선 필요
					contentType : "application/json; charset=utf-8",
					data : {
						isbn : isbn
					},
					dataType : "json",
					success : function(data){
						console.log(data);
						
						var context = '';
						if(data.items[0]!=null){
							// 검색된 첫번째 데이터
							context = '<table>'
							context += '<tr><td rowspan="5"><img src='+data.items[0].image+'></td>';
							context += '<td>'+data.items[0].title+'</td></tr>';
							context += '<tr><td>'+data.items[0].author+'</td></tr>';	
							context += '<tr><td>'+data.items[0].isbn+'</td></tr>';
							context += '<tr><td>'+data.items[0].publisher+'</td></tr>';
							context += '<tr><td><button id="insert_book" type="button">내 책 등록</button></td></tr><table>';
						$("#insert_form_final").html(context);
						}
					},
					error : function(e){
						console.log(e);	
					}
				});
				console.log($("#insert_form_final").text().length);
				if($("#insert_form_final").text().length!=2){
					bookisinNaver = true;
					alert("해당 isbn은 검색 가능합니다.");
				}
			}
			
			//도서 종류 체크
			//if(kdc){}

			// 검사 통과후 책도 없을 시, 입력한 정보로 모달창 띄움
			if(check==true && bookisinNaver==false){
				var context = '<table>'
					context += '<tr><td rowspan="5">no image</td>';
					context += '<td>'+book_name+'</td></tr>';
					context += '<tr><td>'+author+'</td></tr>';	
					context += '<tr><td>'+isbn+'</td></tr>';
					context += '<tr><td>'+publisher+'</td></tr>';
					context += '<tr><td><button id="insert_book" type="button">내 책 등록</button></td></tr><table>';
				$("#insert_form_final").html(context);
			}
			
		});

		/*
		// isbn으로 도서 검색하여 정보 추출
		function check_isbn_from_naver(data){
			$.ajax({
				url : '/naverBookSearch',
				type : 'get',
				//한글로 보내주기 위해선 필요
				contentType : "application/json; charset=utf-8",
				data : {
					isbn : isbn
				},
				dataType : "json",
				success : function(data){
					console.log(data);
					
					// 검색된 첫번째 데이터
					var context = '<table>'
						context += '<tr><td rowspan="5"><img src='+data.items[0].image+'></td>';
						context += '<td>'+data.items[0].title+'</td></tr>';
						context += '<tr><td>'+data.items[0].author+'</td></tr>';	
						context += '<tr><td>'+data.items[0].isbn+'</td></tr>';
						context += '<tr><td>'+data.items[0].publisher+'</td></tr>';
						context += '<tr><td>내 책 등록</td></tr><table>';
					$("#insert_form_final").html(context);
				},
				error : function(e){
					console.log(e);	
				}
			});
		};
		*/
		
	});
	
	/*
	function check_form(){
		var book_name = document.getElementById("book_name_d").value;
		var author = document.getElementById("author_d").value;
		var publisher = document.getElementById("publisher_d").value;
		var isbn = document.getElementById("isbn_d").value;
		var isbn_chk = 	parseInt(isbn/1000000000000)
						+ parseInt((isbn%1000000000000)/100000000000)*3
						+ parseInt((isbn%100000000000)/10000000000)
						+ parseInt((isbn%10000000000)/1000000000)*3
						+ parseInt((isbn%1000000000)/100000000)
						+ parseInt((isbn%100000000)/10000000)*3
						+ parseInt((isbn%10000000)/1000000)
						+ parseInt((isbn%1000000)/100000)*3
						+ parseInt((isbn%100000)/10000)
						+ parseInt((isbn%10000)/1000)*3
						+ parseInt((isbn%1000)/100)
						+ parseInt((isbn%100)/10)*3
						+ parseInt((isbn%10)/1);
		
		if(book_name.length == 0){
			alert("제목을 입력해주세요.");
			return false;
		}
		if(author.length == 0){
			alert("저자를 입력해주세요.");
			return false;
		}
		if(publisher.length == 0){
			alert("출판사를 입력해주세요.");
			return false;
		}
		if(isbn.length < 13 || isbn < 9780000000000 || isbn > 9799999999999 || isbn_chk % 10 != 0 ){
			alert("isbn을 잘못 입력하셨습니다.");
			return false;
		}
		//api에서 isbn검색으로 검색으로 등록이 가능한지 체크
		//if(가능) 
		// 자동으로 상세 검색창에 isbn 검색해서 결과출력 
		//document.book_insert_form.submit;
		return true;
	}
	*/
	</script>
</head>

<body>
	<div id="book_insert_search">
		<div id="search_form">
			<span><input type="text" id="keyword"></span>	
			<input type="button" id="search" value="검색">		 
		</div>
		
		<div id="search_adv_form">
			<table>
				<tr>
					<td>책제목<input type="text" id="book_name"></td>
					<td>저 자<input type="text" id="author"></td>
				</tr>
				<tr>
					<td>ISBN<input type="text" id="isbn"></td>
					<td>출판사<input type="text" id="publisher"></td>
				</tr>
			</table>
			<input type="button" id="search_adv" value="상세검색">
		</div>
		
		<div>
			<span>검색 결과</span>
			<div id="result"></div>
		</div>
		
	<div id="book_insert_direct">
		<form action="/bookInsert" name="book_insert_form" method="get" onsubmit="return check_form();">
			<table>
				<tr>
					<td>제목</td>
					<td><input type="text" name="book_name" id="book_name_d"></td>
				</tr>
				<tr>
					<td>저자</td>
					<td><input type="text" name="author" id="author_d"></td>
				</tr>
				<tr>
					<td>출판사</td>
					<td><input type="text" name="publisher" id="publisher_d"></td>
				</tr>
				<tr>
					<td>ISBN</td>
					<td><input type="text" name="isbn" id="isbn_d" maxlength="13" oninput="this.value = this.value.replace(/[^0-9]/g, '');" ></td>
				</tr>
				<tr>
					<td>도서분류</td>
					<td>
						<select id="kdc_first" name="kdc_first">
							<option value"">선택</option>
						</select>
						<select id="kdc_second" name="kdc_second">
							<option value"">선택</option>
						</select>
					 </td>
				</tr>
				<tr>
					<td colspan="2">
					<button id="submit_form" type="button">		
						등록
					</button>
					<button id="refresh" type="button">
						다시입력
					</button>
					</td> 
				</tr>
			</table>
		</form>
	</div>
	
	<!-- 모달로 띄울 부분 -->
	<div id="insert_form_final">
	</div>
	
</body>
</html>