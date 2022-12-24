<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    
  <script src="https://kit.fontawesome.com/aa33559cc0.js" crossorigin="anonymous"></script>
</head>
<body>
<div class="container mt-3">
  <h2> <a class="nav-link active" href="${path}/member/info">마이 페이지</a></h2>
  <a class="nav-link active" href="${path}/board/lists"><i class="fa-solid fa-house"></i>HOME</a>
  
 	
  <br>
  <!-- Nav tabs -->
  <ul class="nav nav-tabs">
    <li class="nav-item">
      <a class="nav-link" href="${path}/member/remove">회원 탈퇴</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${path}/member/PwModify">비밀번호 수정</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${path}/member/modify">정보 수정</a>
    </li>
  </ul>
</div>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document).ready(function(){
	  $(".nav-tabs a").click(function(){
	    $(this).tab('show');
	  });
	});
</script>
</body>
</html>