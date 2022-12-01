<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
h1 {
	text-align:center;
}
strong{
	text-align:right;
}
</style>
<title>게시판</title>
</head>
<body>
<h1>시끌벅적 커뮤니티</h1>
<a href="${path}/board/register">
	<strong>글 쓰기</strong></a>
<div class="container">
	<table class="table table-dark table-hover">
		<thead>
			<tr>
				<td>말머리</td>
				<td>제목</td>
				<td>글쓴이</td>
				<td>작성일</td>
				<td>조회</td>
				<td>추천</td>
			</tr>
			</thead>
			<tbody>
				<c:forEach var="list" items="${list}">
				<tr>
					<td>
					<c:choose>
						<c:when test="${list.b_group == 1}">일반</c:when>
						<c:when test="${list.b_group == 2}">질문</c:when>
						<c:when test="${list.b_group == 3}">공략</c:when>
						<c:when test="${list.b_group == 4}">자랑</c:when>
					</c:choose>
					</td>
					<td><a href="../board/detail?bno=${list.bno}">${list.title}</a></td>
					<td>${list.nickname}</td>
					<td>${list.credate}</td>
					<td>${list.hit }</td>
					<td></td>
				</tr>
				</c:forEach>
			</tbody>
	</table>
</div>

</body>
</html>