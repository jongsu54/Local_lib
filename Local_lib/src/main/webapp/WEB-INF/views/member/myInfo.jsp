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
    <link rel="stylesheet" type="text/css" href="/resources/css/main.css" />
    
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js" integrity="sha384-eMNCOe7tC1doHpGoWe/6oMVemdAVTMs2xqW4mwXrXsW0L84Iytr2wi5v2QjrP/xp" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.min.js" integrity="sha384-cn7l7gDp0eyniUwwAZgrzD06kc/tftFf19TOAs2zVinnD/C7E91j9yyk5//jjpt/" crossorigin="anonymous"></script>
	
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js" integrity="sha384-eMNCOe7tC1doHpGoWe/6oMVemdAVTMs2xqW4mwXrXsW0L84Iytr2wi5v2QjrP/xp" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.min.js" integrity="sha384-cn7l7gDp0eyniUwwAZgrzD06kc/tftFf19TOAs2zVinnD/C7E91j9yyk5//jjpt/" crossorigin="anonymous"></script>
	
	<script type="text/javascript">	
	
	$(function(){
		//엄마 숨김
		$("#bootstrap_mommy").hide();
		
		
		
		
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
							var isbn_long = data.items[0].isbn.split(" ");
							context += '<tr><td>'+isbn_long[1]+'</td></tr>';
							context += '<tr><td>'+data.items[0].publisher+'</td></tr>';
							context += '<tr><td><button id="insert_book" type="button">내 책 등록</button></td></tr><table>';
						$("#book_show").html(context);
						}
					},
					error : function(e){
						console.log(e);	
					}
				});
				
				if($("#book_show").text().length!=2){
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
				$("#book_show").html(context);
			}
			
			
		});
		
		//검색으로 등록
		$("input:radio[name=btnradio]").click(function(){
			var context = null;
			if($("input[name=btnradio]:checked").val() == "1"){
			context = '<span><input type="text" id="keyword"></span><input type="button" id="search" value="검색">';
	        console.log(context);
			$("#book_insert").html(context);
			}else if($("input[name=btnradio]:checked").val() == "0"){		
			context = '<table>';
			context += '<tr><td>제목</td>	<td><input type="text" name="book_name" id="book_name_d"></td></tr>';
			context += '<tr><td>저자</td><td><input type="text" name="author" id="author_d"></td></tr>';
			context += '<tr><td>출판사</td><td><input type="text" name="publisher" id="publisher_d"></td></tr>';
			context += '<tr><td>ISBN</td><td><input type="text" name="isbn" id="isbn_d" maxlength="13" oninput="this.value = this.value.replace(/[^0-9]/g,'; 
			context += "''";
			context += ');" ></td></tr>';
			context += '<tr><td>도서분류</td><td>';
			context += '<select id="kdc_first" name="kdc_first">';
			context += '<option value"">선택</option>';
			context += '</select>';
			context += '<select id="kdc_second" name="kdc_second">';
			context += '<option value"">선택</option>';
			context += '</select>';
			context += '</td></tr><tr><td colspan="2"><button id="submit_form" type="button">등록	</button>';
			context += '<button id="refresh" type="button">다시입력</button></td></tr></table>';
	        $("#book_insert").html(context);
	        console.log(context);
			}
		});
	});
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
					// 검색된 첫번째 데이터
					context = '<table>'
					context += '<tr><td rowspan="5"><img src='+data.items[0].image+'></td>';
					context += '<td>'+data.items[0].title+'</td></tr>';
					context += '<tr><td>'+data.items[0].author+'</td></tr>';	
					var isbn_long = data.items[0].isbn.split(" ");
					context += '<tr><td>'+isbn_long[1]+'</td></tr>';
					context += '<tr><td>'+data.items[0].publisher+'</td></tr>';
					context += '<tr><td><button id="insert_book" type="button">내 책 등록</button></td></tr><table>';
				$("#book_show").html(context);
				$("#bootstrap_mommy").trigger("click");
				}
			},
			error : function(e){
				console.log(e);	
			}
		});
		//버튼 강제로 클릭
		
	}
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
		<button type="button" onClick="location.href='/book/bookAdd'">내 도서 등록</button>		
		<!-- Button trigger modal -->
		<a class="btn btn-primary" data-bs-toggle="modal" href="#exampleModalToggle" role="button">내 도서 등록</a>
		<div>
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
			<!-- 토글 -->
			<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
  			<input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" value="1" checked>
  			<label class="btn btn-outline-primary" for="btnradio1">검색으로 등록</label>

			<input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off" value="0">
			<label class="btn btn-outline-primary" for="btnradio2">직접 등록하기</label>
			</div>

        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        
        <div id="book_insert">
        	<span><input type="text" id="keyword" ></span>
        	<input type="button" id="search" value="검색">
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
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        
        <div id="book_show"></div>
        
      </div>
      <div class="modal-footer">
        <!-- <button class="btn btn-primary" data-bs-target="#exampleModalToggle" data-bs-toggle="modal" data-bs-dismiss="modal">Back to first</button> -->
      </div>
    </div>
  </div>
</div>


</html>