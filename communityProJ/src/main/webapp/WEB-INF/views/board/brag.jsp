<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
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
  
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300&display=swap" rel="stylesheet">

<script src="https://kit.fontawesome.com/aa33559cc0.js" crossorigin="anonymous"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300&display=swap');
*{
  padding-right:15px;
  padding-bottom:10px;
  padding-left:15px;
}
h1 {
	text-align:center;
	font-family: 'Space Grotesk', sans-serif;
}

.container {
	margin: 40px auto;
	width: 100%;
}


.add{
	font-family: 'Space Grotesk', sans-serif;
	text-align:center;
}
</style>
<title>게시판</title>
</head>
<body>
<a href="${path}/board/lists">
<h1>시끌벅적 커뮤니티</h1>
</a>

<div class="add">
	<a href="${path}/board/register">글 쓰기</a>		
</div>

<input type="hidden" id="category" name="category"> 
<div class="container" >

<%@include file="../common/nav.jsp"%>

		<div>
			<table class="table">
				<thead>
					<tr>
						<td>말머리</td>
						<td>제목</td>
						<td>닉네임</td>
						<td>작성일</td>
						<td>조회</td>
						<td>추천</td>
					</tr>
					</thead>
					<tbody>
						<c:forEach var="list" items="${brag}">
						<tr>
							<td>
							<c:choose>
								<c:when test="${list.category == 1}">자유</c:when>
								<c:when test="${list.category == 2}">질문</c:when>
								<c:when test="${list.category == 3}">공략</c:when>
								<c:when test="${list.category == 4}">자랑</c:when>
							</c:choose>
							</td>
							<td><a href='<c:url value='/board/detail?bno=${list.bno}
										&page=${scri.page}
	      	 							&perPageNum=${scri.perPageNum}
	      	 							&searchType=${scri.searchType}
	      	 							&keyword=${scri.keyword}'/>'>${list.title}</a>
								<c:if test="${list.reply_count != 0 }">
									<strong>[<c:out value="${list.reply_count}"/>]</strong>
								</c:if>
							</td>
							<td>${list.nickname}</td>
							<td>${list.credate}</td>
							<td>${list.hit }</td>
							<td></td>
						</tr>
						</c:forEach>
					</tbody>
			</table>
				<ul class="pagination">
				    <c:if test="${pageMaker.prev }">
				    <li>
				        <a href='<c:url value="/board/brag?page=${pageMaker.startPage-1 }"/>'><i class="fa-solid fa-chevron-left"></i></a>
				    </li>
				    </c:if>
				    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
				    <li>
				        <a href='<c:url value="/board/brag${pageMaker.makeSearch(pageNum) }"/>'><i class="fa">${pageNum }</i></a>
				    </li>
				    </c:forEach>
				    <c:if test="${pageMaker.next && pageMaker.endPage >0 }">
				    <li>
				        <a href='<c:url value="/board/brag${pageMaker.makeSearch(pageMaker.endPage+1) }"/>'><i class="fa-solid fa-chevron-right"></i></a>
				    </li>
				    </c:if>
				</ul>
	</div>

</div>

</body>
</html>