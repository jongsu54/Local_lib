<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>MyInfo</title>
	<script src="/resources/js/jquery-3.6.0.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js" integrity="sha384-eMNCOe7tC1doHpGoWe/6oMVemdAVTMs2xqW4mwXrXsW0L84Iytr2wi5v2QjrP/xp" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.min.js" integrity="sha384-cn7l7gDp0eyniUwwAZgrzD06kc/tftFf19TOAs2zVinnD/C7E91j9yyk5//jjpt/" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="/resources/css/main.css" />
	
	<script type="text/javascript">	
	var book_name_temp = "";
	var author_temp = "";
	var publisher_temp = "";
	var isbn_temp = "";
//	var kdc_temp = "";
	
	$(function(){
		/*------------------------------- 내 도서 등록 시작 ------------------------------------*/
		
		//엄마 숨김
		$("#bootstrap_mommy").hide();
		
		//직접 등록 리프레쉬
		$("#refresh").on("click",function(){
			$("#book_name_d").val("");
			$("#author_d").val("");
			$("#publisher_d").val("");
			$("#isbn_d").val("");
		});
		
		//검색으로 등록 <-> 직접 등록하기
		$("#book_insert_direct").hide();
		$("input:radio[name=btnradio]").click(function(){
			var context = null;
			if($("input[name=btnradio]:checked").val() == "1"){
				$("#book_insert_direct").hide();
				$("#book_insert").show();
				$("#result").show();
			}else if($("input[name=btnradio]:checked").val() == "0"){		
				$("#book_insert").hide();
				$("#book_insert_direct").show();
				$("#result").hide();
			}
		});
		
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
						var isbn_long = this.isbn.split(" ");
						context += '<tr onClick="search_book_info('+isbn_long[1]+')"><td>'+this.title+'</td>';
						context += '<td>'+this.author+'</td>';	
						context += '<td>'+isbn_long[1]+'</td>';
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
						context += '<tr><td>'+this.title+'</td>';
						context += '<td>'+this.author+'</td>';	
						var isbn_long = this.isbn.split(" ");
						context += '<td>'+isbn_long[1]+'</td>';
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
//			var kdc = $("#kdc").val();
			
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
				alert("잘못된 isbn 입니다.");
				check = false;
			}
/*
			//도서 종류 체크
			else if(kdc == 0){
				alert("분류를 선택해주세요.");
				check = false;
			}
*/			
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
							var isbn_long = data.items[0].isbn.split(" ");
							
							book_name_temp = data.items[0].title;
							author_temp = data.items[0].author;
							publisher_temp = data.items[0].publisher;
							isbn_temp = isbn_long[1];
/*							
							//카테고리 입력해야함				
							kdc_temp = 
*/							
							context = '<table>'
							context += '<tr><td rowspan="4"><img src='+data.items[0].image+'></td>';
							context += '<td>'+data.items[0].title+'</td></tr>';
							context += '<tr><td>'+data.items[0].author+'</td></tr>';	
							context += '<tr><td>'+isbn_long[1]+'</td></tr>';
							context += '<tr><td>'+data.items[0].publisher+'</td></tr></table>';
						$("#book_show").html(context);
						$("#bootstrap_mommy").trigger("click");
						}
					},
					error : function(e){
						console.log(e);	
					}
				});
				
				if($("#book_show").text().length!=2){
					bookisinNaver = true;
					alert("해당 도서는 검색 가능합니다.");
				}
			}

			// 검사 통과후 책 없을 시, 입력한 정보로 모달창 띄움
			if(check==true && bookisinNaver==false){
				
				book_name_temp = book_name;
				author_temp = author;
				publisher_temp = publisher;
				isbn_temp = isbn;
/*
				//카테고리
				kdc_temp = kdc;
*/
				
				var context = '<table>'
					context += '<tr><td rowspan="4">no image</td>';
					context += '<td>'+book_name+'</td></tr>';
					context += '<tr><td>'+author+'</td></tr>';	
					context += '<tr><td>'+isbn+'</td></tr>';
					context += '<tr><td>'+publisher+'</td></tr></table>';
				$("#book_show").html(context);
				$("#bootstrap_mommy").trigger("click");
			}
		});
		
		// 도서 등록
		$("#insert_book").on("click",function(){
			$.ajax({
				url : "/bookInsert",
				type : "get",
				contentType : "application/json; charset=utf-8",
				data : {
					book_name : book_name_temp,
					author : author_temp,
					isbn : isbn_temp,
					publisher : publisher_temp				
					//카테고리	입력 kdc 생략			

				},
				dataType : "json",
				success : function(data){
					if(data==true){
						alert("등록되었습니다!");
						$("#book_show_exit").trigger("click");
					}else{
						alert("등록에 실패하였습니다.");
					}
					
				},
			    error : function(request,status,error){
			         alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
				}

			});
		});
		/*------------------------------- 내 도서 등록 종료 ------------------------------------*/

		/*------------------------------- 내 도서 표시 시작 ------------------------------------*/
		$.ajax({
			url : "/getMyBooks",
			type : "get",
			dataType : "json",
			success : function(data){
				//items의 i 번째 데이터의 내용
				var context = '<table class="mx-auto">'
					context += '<tr><td>제목</td><td>글쓴이</td><td>출판사</td><td></td></tr>'
				$.each(data, function(i,o){
					var state = "";
					if(this.state_gb==1)
						state = "대여가능";
					else if(this.state_gb==2)
						state = "대여중";
					else if(this.state_gb==3)
						state = "예약중";
					else if(this.state_gb==4)
						state = "비활성화";
					
					//onClick="search_book_info('+isbn_long[1]+')"
					context += '<tr><td>'+this.book_name+'</td>';
					context += '<td>'+this.author+'</td>';	
					//context += '<td>'+this.isbn+'</td>';
					context += '<td>'+this.publisher+'</td>';
					context += '<td>'+state+'</td></tr>';
				});
				context += '<table>';
				$("#show_my_books").html(context);
			},
			error : function(request,status,error){
		         alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
			}
		});
		/*------------------------------- 내 도서 표시 종료 ------------------------------------*/
		
		
	});
	

	/*------------------------------- 내 도서 등록 시작 ------------------------------------*/
	function search_book_info(keyword){
//		location.href="/naverBookSearch?keyword="+keyword;
		$.ajax({
			url : '/naverBookSearch',
			type : 'get',
			//한글로 보내주기 위해선 필요
			contentType : "application/json; charset=utf-8",
			data : {
				keyword : keyword
			},
			dataType : "json",
			async : false,
			success : function(data){
				console.log(data);

				var context = '';
				if(data.items[0]!=null){
					var isbn_long = data.items[0].isbn.split(" ");
					
					book_name_temp = data.items[0].title;
					author_temp = data.items[0].author;
					publisher_temp = data.items[0].publisher;
					var isbn_splited = isbn_long[1].split("");
					isbn_temp = "";
					for(var i=3;i<16;i++){
						isbn_temp += isbn_splited[i];
					}
/*
					//카테고리 생략		
					kdc_temp = "";
					for(var i=0;i<3;i++){
						kdc_temp 
					}
*/					
					context = '<table>'
					context += '<tr><td rowspan="4"><img src='+data.items[0].image+'></td>';
					context += '<td>'+data.items[0].title+'</td></tr>';
					context += '<tr><td>'+data.items[0].author+'</td></tr>';	
					context += '<tr><td>'+isbn_long[1]+'</td></tr>';
					context += '<tr><td>'+data.items[0].publisher+'</td></tr></table>';
				$("#book_show").html(context);
				$("#bootstrap_mommy").trigger("click");
				}
			},
			error : function(e){
				console.log(e);	
			}
		});
	}
	/*------------------------------- 내 도서 등록 종료 ------------------------------------*/
	
	
	</script>
</head>
<body>

  	  <header class="p-3 mb-3 border-bottom   ">
		    
		    <div class="container">
			    <div class="text-end">
			    	<form action="" method="GET">
	        			<div class="search-bar mx-auto mt-5 rounded-pill input-group mb-3">
					    	<p>Local Lib</p>
	  						<input type="text" class="form-control " placeholder="어떤 도서를 찾으시나요:)" aria-label="Recipient's username" aria-describedby="button-addon2">
	  						<button class="btn btn-outline-secondary" type="button" id="button-addon2">검색</button>
	  						<button type="button" onClick="location.href='/member/myInfo'">myInfo로 이동</button>
						</div>	        
	  				</form>       		  
	          	  <!--  a href="#" class=" d-block link-dark text-decoration-none dropdown-toggle  " id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
		           		<img src="https://github.com/mdo.png" alt="mdo" width="32" height="32" class="rounded-circle ">
		          </a>
		          <ul class="dropdown-menu text-small fr" aria-labelledby="dropdownUser1">
			            <li><a class="dropdown-item" href="#">New project...</a></li>
			            <li><a class="dropdown-item" href="#">Settings</a></li>
			            <li><a class="dropdown-item" href="#">Profile</a></li>
			            <li><hr class="dropdown-divider"></li>
			            <li><a class="dropdown-item" href="#">Sign out</a></li>
		          </ul>-->
	        	</div>
		          
		          
		    </div>
		     
 	  </header>   
	
		
	<div>
		내 정보
		<div>
			이름: 코딩좋아<br>
			남성<br>
			나이 20세
		</div>
	</div>
	<div>
		나의 도서 목록
		<!-- <button type="button" onClick="location.href='/book/bookAdd'">내 도서 등록</button>	-->	
		<!-- Button trigger modal -->
		<a class="btn btn-warning font-color-white" data-bs-toggle="modal" href="#exampleModalToggle" role="button">내 도서 등록</a>
		<div id="show_my_books">
			1.<br>
			2.<br>
			3.<br>
		</div>
	</div>
	<div>
		대여한 도서 목록
		<div>
			1.<br>
			2.<br>
			3.<br>
		</div>
	</div>
	<div>
		반납할 도서 목록
		<div>
			1.<br>
			2.<br>
			3.<br>
		</div>
	</div>


<!-- Modal1 -->
<div class="modal fade" id="exampleModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
  <div class="modal-dialog modal-xl modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalToggleLabel"></h5>
			<!-- 토글 btn btn-warning font-color-white -->
			<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
  			<input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" value="1" checked>
  			<label class="btn btn-outline-warning" for="btnradio1">검색으로 등록</label>

			<input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off" value="0">
			<label class="btn btn-outline-warning" for="btnradio2">직접 등록하기</label>
			</div>

        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        
<!--
        <div id="book_insert" class="search-bar mx-auto mt-5 rounded-pill input-group mb-3">
        	<span><input type="text" id="keyword" ></span>
        	<button type="button" id="search" class="btn btn-warning font-color-white btn-sm">검색</button> 
        </div>
-->
        	<div id="book_insert" class="search-bar mx-auto mt-2 rounded-pill input-group mb-3">
	  				<input type="text" id="keyword" class="form-control " placeholder="내 도서를 등록해주세요:)" aria-label="Recipient's username" aria-describedby="button-addon2">
	  				<button class="btn btn-outline-secondary" type="button" id="search">검색</button>
			</div> 
        
        <div id="book_insert_direct" class="search-bar mx-auto mt-2 rounded-pill input-group mb-3">
			<table class="mx-auto">
				<tr>
					<td><input type="text" name="book_name" id="book_name_d" class="form-control " placeholder="제목"></td>
				</tr>
				<tr>
					<td><input type="text" name="author" id="author_d" class="form-control " placeholder="글쓴이"></td>
				</tr>
				<tr>
					<td><input type="text" name="publisher" id="publisher_d" class="form-control " placeholder="출판사"></td>
				</tr>
				<tr>
					<td><input type="text" name="isbn" id="isbn_d" class="form-control " placeholder="ISBN" maxlength="13" oninput="this.value = this.value.replace(/[^0-9]/g, '');" ></td>
				</tr>
				<!-- 
				<tr>
					<td>도서분류</td>
					<td>
						<select id="kdc_d" name="kdc">
							<option value="0">선택</option>
							<option value="100">소설</option>
							<option value="110">시/에세이</option>
							<option value="120">인물</option>
							<option value="130">가정/생활/요리</option>
							<option value="140">건강</option>
							<option value="150">취미</option>
							<option value="160">경제</option>
							<option value="170">자기계발</option>
							<option value="180">사회</option>
							<option value="190">역사/문화</option>
							<option value="200">종교</option>
							<option value="210">예술/대중문화</option>
							<option value="220">학습/참고서</option>
							<option value="230">국어/외국어</option>
							<option value="240">사전</option>
							<option value="250">과학/공학</option>
							<option value="260">취업/수험서</option>
							<option value="270">여행/지도</option>
							<option value="280">컴퓨터/IT</option>
							<option value="290">잡지</option>
							<option value="300">청소년</option>
							<option value="310">유아</option>
							<option value="320">어린이</option>
							<option value="330">만화</option>
							<option value="340">해외도서</option>							
						</select>

					 </td>
				</tr>
				 -->
				<tr>
					<td>
					<div class="row-vw d-flex">
					<button id="refresh" type="button" class ="btn btn-warning btn-sm font-color-white mx-auto">
						다시입력
					</button>
					<button id="submit_form" type="button" class ="btn btn-warning btn-sm font-color-white mx-auto">		
						&nbsp;&nbsp;등&nbsp;&nbsp;록&nbsp;&nbsp;
					</button>
					</div>
					</td> 
				</tr>
			</table>
		</div>
        
      </div>
      <div class="modal-footer">
		<div id="result"></div>
        <button class="btn btn-primary" id="bootstrap_mommy" data-bs-target="#exampleModalToggle2" data-bs-toggle="modal" data-bs-dismiss="modal">Open second modal</button>
      </div>
    </div>
  </div>
</div>


<!-- Modal2 -->
<div class="modal fade" id="exampleModalToggle2" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalToggleLabel2">도서 상세보기</h5>
        <button type="button" id="book_show_exit" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        
        <div id="book_show"></div>
        
      </div>
      <div class="modal-footer">
      	<div id="button_for_insert">
      		<button id="insert_book" type="button" class ="btn btn-warning btn-sm font-color-white mx-auto">내 책 등록</button>
        </div>
        <!-- <button class="btn btn-primary" data-bs-target="#exampleModalToggle" data-bs-toggle="modal" data-bs-dismiss="modal">Back to first</button> -->
      </div>
    </div>
  </div>
</div>


</html>