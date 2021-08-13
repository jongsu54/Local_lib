<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page isELIgnored="false" %>
<!--  %@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>-->
<!--  %@ page session="false" %> 세션 받아오지 않는 기능-->
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Local Lib</title>
   
   
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="resources/css/main.css" />
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js" integrity="sha384-eMNCOe7tC1doHpGoWe/6oMVemdAVTMs2xqW4mwXrXsW0L84Iytr2wi5v2QjrP/xp" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.min.js" integrity="sha384-cn7l7gDp0eyniUwwAZgrzD06kc/tftFf19TOAs2zVinnD/C7E91j9yyk5//jjpt/" crossorigin="anonymous"></script>
<script>

</script>
</head>

<body>

  	  <header class="p-3 mb-3 border-bottom   ">
		
		    <div class="container">
		    
			    <div class="text-end">
			   		
			    <c:choose>
						<c:when test="${empty sessionScope.loginId}">
		        		  
		          		  <button type="button" onClick="location.href='/member/joinForm'" class="btn  btn-primary btn-warning font-color-white ">Sign-up</button>
		          		  <button type="button" onClick="location.href='/member/loginForm'" class="btn btn-light text-dark me-2">Sign-in</button>
		          		  <!--  button type="button" onClick="location.href='/member/loginForm'" class="btn btn-light text-dark me-2">Logout</button>-->
		          		</c:when>
						<c:otherwise>
						<button type="button" onClick="location.href='/member/joinForm'" class="btn  btn-primary btn-warning font-color-white ">My Info</button>
						  <button type="button" onClick="location.href='/member/logout'" class="btn btn-light text-dark me-2">Sign-out</button>
						<!--  a href="#" class="link-dark text-decoration-none dropdown-toggle  " id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
				           		<img src="https://github.com/mdo.png" alt="mdo" width="32" height="32" class="rounded-circle ">
				         </a>
				           
				          <ul class="dropdown-menu text-small " aria-labelledby="dropdownUser1">
					            <li><a class="dropdown-item" href="#">MyPage</a></li>
					            <!--  li><a class="dropdown-item" href="#">Profile</a></li>
					            <li><hr class="dropdown-divider" href="#"></li>
					            <li><a class="dropdown-item" href="/member/logout">Sign out</a></li>
				          </ul> 
						-->
						
						
						</c:otherwise>
				</c:choose>
				  	
						 
			          	  
				        
	        	</div>
		          
		    </div>
		     
 	  </header>   
	 	
	  <h1 class="center logo fw-bold">
	        Local Lib
	  </h1>

	  <form action="" method="GET">
	        <div class="search-bar mx-auto mt-5 rounded-pill input-group mb-3">
	  				<input type="text" class="form-control " placeholder="어떤 도서를 찾으시나요:)" aria-label="Recipient's username" aria-describedby="button-addon2">
	  				<button class="btn btn-outline-secondary" type="button" id="button-addon2">검색</button>
	  </div>
	        
	        
	        
	  </form>
		
	
</body>
</html>
