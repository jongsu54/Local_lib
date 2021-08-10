<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>MyPage</title>
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="/resources/css/main.css" />
	
</head>

<body>
		
		  <header class="p-3 mb-3 border-bottom   ">
		
		    <div class="container span">
		    
		    <form action="" method="GET">
	        <div class="search-bar mx-auto mt-5 rounded-pill input-group mb-3">
	  				<input type="text" class="form-control " placeholder="어떤 도서를 찾으시나요:)" aria-label="Recipient's username" aria-describedby="button-addon2">
	  				<button class="btn btn-outline-secondary" type="button" id="button-addon2">검색</button>
	  							    <span class="text-end">
			   		
			    <c:choose>
						<c:when test="${empty sessionScope.loginId}">
		        		  
		          		  <button type="button" onClick="location.href='/member/joinForm'" class="btn  btn-primary btn-warning font-color-white ">Sign-up</button>
		          		  <button type="button" onClick="location.href='/member/loginForm'" class="btn btn-light text-dark me-2">Login</button>
		          		  <!--  button type="button" onClick="location.href='/member/loginForm'" class="btn btn-light text-dark me-2">Logout</button>-->
		          		</c:when>
						<c:otherwise>
						<button type="button" onClick="location.href='/member/joinForm'" class="btn  btn-primary btn-warning font-color-white ">My Info</button>
						  <button type="button" onClick="location.href='/member/logout'" class="btn btn-light text-dark me-2">Logout</button>
						</c:otherwise>
				</c:choose>
				  	
						 <a href="#" class="link-dark text-decoration-none dropdown-toggle  " id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
				           		<img src="https://github.com/mdo.png" alt="mdo" width="32" height="32" class="rounded-circle ">
				         </a>
				          <ul class="dropdown-menu text-small " aria-labelledby="dropdownUser1">
					            <li><a class="dropdown-item" href="#">New project...</a></li>
					            <li><a class="dropdown-item" href="#">Settings</a></li>
					            <li><a class="dropdown-item" href="#">Profile</a></li>
					            <li><hr class="dropdown-divider"></li>
					            <li><a class="dropdown-item" href="#">Sign out</a></li>
				          </ul> 
			          	  
				        
	        	</span>
			</div> 
	  </form>
		
		    
		    

		          
		    </div>
		     
 	  </header>  
  	  <!--  header class="p-3 mb-3 border-bottom   ">
		    
		    <div class="container">
			    <div class="text-end">
			    	<form action="" method="GET"  >
	        			<div class="search-bar mx-auto mt-5 rounded-pill input-group mb-3">
					    	<p>Local Lib</p>
	  						<input type="text" class="form-control " placeholder="어떤 도서를 찾으시나요:)" aria-label="Recipient's username" aria-describedby="button-addon2">
	  						<button class="btn btn-outline-secondary" type="button" id="button-addon2">검색</button>
	  						<button class="fr" type="button" onClick="location.href='/member/myInfo'">myInfo로 이동</button>
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
		          </ul>
	        	</div>
		          
		          
		    </div>
		     
 	  </header>   
	-->
		
	<div>
		추천도서
		<div>
			추천도서 목록 1. 2. 3.
		</div>
	</div>



</body>
</html>