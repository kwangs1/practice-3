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
<table>
		<tr>
			<td>제목 :</td>
			<td>${detail.title}</td>
		</tr>
		
		<tr>
			<td>닉네임 :</td>
			<td>${detail.nickname } ;; ${detail.credate }</td>
		</tr>
		
		<tr>
			<td>내용 :</td>
			<td>${detail.content}</td>
		</tr>
		
		<tr>
			<td>조회 : ${detail.hit}
		</tr>
		
</table>
		<a href="${path}/board/list">목록으로</a>
		<a href="${path}/board/remove?bno=${detail.bno}" class="del_chk">삭제</a>
		<a href="${path}/board/modify?bno=${detail.bno}">수정</a>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">	
$('.del_chk').on('click',function(){
	var delconfirm = confirm('삭제 하시겠습니까?');
	
	if(delconfirm){
		alert('삭제 되었습니다.');
	}else{
		alert('삭제 취소되었습니다.');
		return false;
	}
})
</script>
</body>
</html>