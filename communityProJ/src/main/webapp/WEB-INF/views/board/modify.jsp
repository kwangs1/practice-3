<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<form method='post' id='modifyForm'>
	  <input type='hidden' id='bno' name='bno' value='${board.bno}'>
<table>
		<tr>
			<td>제목 :</td>
			<td><input type="text" name=title  value="${board.title}"></td>
		</tr>
		
		<tr>
			<td>닉네임 :</td>
			<td><input type="text" name=nickname  value="${board.nickname}" readonly
				style="background-color:silver;"></td>
		</tr>
		
		<tr>
			<td>내용 :</td>
			<td><input type="text" name=content value="${board.content }"></td>
		</tr>
		
</table>
		<button class="upd_chk">수정</button>
		<a href="${path}/board/list">목록으로</a>
		

</form>		
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">	
$(document).ready(function(){
	
	$(".upd_chk").on('click',function(){
		var updform = $('#modfiyForm');
		var update = confirm("수정 하시겠습니까?");
			
		if(update){
			alert("수정 되었습니다");
			updform.attr('action','${path}/board/modify').submit();
		}else{
			alert("취소 되었습니다.");
			return false;
		}
	})
})

</script>
</body>
</html>