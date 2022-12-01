<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<form action="${path}/board/register" method="post" id="frm">
<table>
		<tr>
			<td>
				<select class="option" name="b_group" id="b_group">
					<option value="" selected>말머리 선택해주세요</option>
					<option value="1">일반</option>
					<option value="2">질문</option>
					<option value="3">공략</option>
					<option value="4">자랑</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>제목</td>
			<td><input type="text" name="title" /></td>
		</tr>
		
		<tr>
			<td>닉네임</td>
			<td><input type="text" name="nickname" /></td>
		</tr>
		
		<tr>
			<td>내용</td>
			<td><input type="text" name="content" /></td>
		</tr>
		
		<tr>
			<td><input type="button" value="작성" onClick="check()"/></td>
		</tr>
</table>
</form>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function check(){
		var b_group = $(".option").val();
		
		if(b_group == 0){
			alert("말머리 선택해주세요.");
			return document.getElementById("b_group").focus();
		}else{
			document.getElementById("frm").submit()
		}
	}
</script>
</body>
</html>