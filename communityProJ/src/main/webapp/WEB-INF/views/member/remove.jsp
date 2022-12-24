<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
#btn {
  position:relative;
  left:8%;
  transform: translateX(-50%);
  margin-bottom: 40px;
  width:15%;
  height:40px;
  background: linear-gradient(125deg,#81ecec,#6c5ce7,#81ecec);
  background-position: left;
  background-size: 200%;
  color:white;
  font-weight: bold;
  border:none;
  cursor:pointer;
  transition: 0.4s;
  display:inline;
}

#btn:hover {
  background-position: right;
}
</style>
<title>회원 탈퇴</title>
</head>
<body>
<%@include file="../common/sidebar.jsp"%>
<br><br>
<div style = "text-align:center;">
<form method="post" id="form">
<input type="hidden" name="id" value="${member.id}">
	<strong>정말로 삭제 할꺼야?</strong>
	<p>삭제하면 모든 정보는 삭제 될꺼야....<i class="fa-sharp fa-solid fa-face-sad-tear"></i></p>
	<br>
	<button type="button" data-oper='remove' class="remove" id="btn">탈 퇴</button>
</form>
</div>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
var formObj = $('#form');
	$('.remove').click(function(){
		 var operation = $(this).data("oper");
		 
		 if(operation === 'remove'){
		      formObj.attr("action", "${path}/member/remove");		      
		    }
		 formObj.submit();
	})
</script>
</body>
</html>