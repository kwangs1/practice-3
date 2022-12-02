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
  padding-top:20px;
  padding-right:15px;
  padding-bottom:10px;
  padding-left:15px;
}
h1 {
	text-align:center;
	font-family: 'Space Grotesk', sans-serif;
}

.tab_content {
	background: rgb(255, 255, 255); 
	width: 120%; 
	clear: both; 
	border-top-color: currentColor; 
	border-top-width: medium; 
	border-top-style: none; 
	float: left;
}
.tab_content {
	padding: 10px 10px 20px; 
	line-height: 1.8em; 
	font-size: 0.9em;
	font-family: 'Space Grotesk', sans-serif;
	min-height: 400px;
}
#container {
	margin: 40px auto;
	width: 100%;
}
a {
	color:black;
	text-decoration: none;
}
a:hover {
	color:sliver; 
	text-decoration: none;
}
.clear {
	clear: both;
}
.active {
	 color: blue;
	 font-weight: bold;
	 font-size: 0.9em;
	 font-family: 'Space Grotesk', sans-serif;
}
ul.tabs {
	list-style: none; 
	margin: 0px; 
	padding: 0px; 
	width: 79%; 
	height: 32px; 
	float: right;
}
ul.tabs li {
	border-width: 1px; 
	margin: 0px 1px; 
	padding: 0px; 
	height: 31px; 
	line-height: 31px; 
	overflow: hidden; 
	float: left; 
}
ul.tabs li a {
	padding: 0px 20px;
	color: rgb(0, 0, 0); 
	font-size: 0.9em; 
	font-weight: bold; 
	font-family: 'Space Grotesk', sans-serif;
	text-decoration: none; 
	display: block;
}
ul.tabs li a:hover {
	background-color: rgb(202, 228, 255);
}
.add{
	font-family: 'Space Grotesk', sans-serif;
	text-align:center;
}
</style>
<title>게시판</title>
</head>
<body>
<h1>시끌벅적 커뮤니티</h1>

<div class="add">
	<a href="${path}/board/register">글 쓰기</a>		
</div>

<div class="tab_container" id="container">
		<ul class="tabs">
			<li><a href="#tab1">전체</a></li>
			<li><a href="#tab2">일반</a></li>
			<li><a href="#tab3">질문</a></li>
			<li><a href="#tab4">공략</a></li>
			<li><a href="#tab5">자랑</a></li>
		</ul>
		<!-- tab1 -->
	<div class="container">
		<div class="tab_content" id="tab1">
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
							<td><a href="${path}/board/detail?bno=${list.bno}">${list.title}</a></td>
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
				        <a href='<c:url value="/board/list?page=${pageMaker.startPage-1 }"/>'><i class="fa-solid fa-chevron-left"></i></a>
				    </li>
				    </c:if>
				    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
				    <li>
				        <a href='<c:url value="/board/list${pageMaker.makeQueryPage(pageNum) }"/>'><i class="fa">${pageNum }</i></a>
				    </li>
				    </c:forEach>
				    <c:if test="${pageMaker.next && pageMaker.endPage >0 }">
				    <li>
				        <a href='<c:url value="/board/list${pageMaker.makeQueryPage(pageMaker.endPage+1) }"/>'><i class="fa-solid fa-chevron-right"></i></a>
				    </li>
				    </c:if>
				</ul>
	</div>
	
	<!-- tab2 -->
	<div class="tab_content" id="tab2">
			<table class="table">
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
						<c:forEach var="list" items="${Nomal}">
						<tr>
							<td>
							<c:choose>
								<c:when test="${list.b_group == 1}">일반</c:when>
								<c:when test="${list.b_group == 2}">질문</c:when>
								<c:when test="${list.b_group == 3}">공략</c:when>
								<c:when test="${list.b_group == 4}">자랑</c:when>
							</c:choose>
							</td>
							<td><a href="${path}/board/detail?bno=${list.bno}">${list.title}</a></td>
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
				        <a href='<c:url value="/board/list?page=${pageMaker.startPage-1 }"/>'><i class="fa-solid fa-chevron-left"></i></a>
				    </li>
				    </c:if>
				    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
				    <li>
				        <a href='<c:url value="/board/list${pageMaker.makeQueryPage(pageNum)}"/>'><i class="fa">${pageNum }</i></a>
				    </li>
				    </c:forEach>
				    <c:if test="${pageMaker.next && pageMaker.endPage >0 }">
				    <li>
				        <a href='<c:url value="/board/list${pageMaker.makeQueryPage(pageMaker.endPage+1)}"/>'><i class="fa-solid fa-chevron-right"></i></a>
				    </li>
				    </c:if>
				</ul>
	</div>
	
	<!-- tab3 -->
	<div class="tab_content" id="tab3">
			<table class="table">
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
						<c:forEach var="list" items="${QnA}">
						<tr>
							<td>
							<c:choose>
								<c:when test="${list.b_group == 1}">일반</c:when>
								<c:when test="${list.b_group == 2}">질문</c:when>
								<c:when test="${list.b_group == 3}">공략</c:when>
								<c:when test="${list.b_group == 4}">자랑</c:when>
							</c:choose>
							</td>
							<td><a href="${path}/board/detail?bno=${list.bno}">${list.title}</a></td>
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
				        <a href='<c:url value="/board/list?page=${pageMaker.startPage-1 }"/>'><i class="fa-solid fa-chevron-left"></i></a>
				    </li>
				    </c:if>
				    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
				    <li>
				        <a href='<c:url value="/board/list${pageMaker.makeQueryPage(pageNum) }"/>'><i class="fa">${pageNum }</i></a>
				    </li>
				    </c:forEach>
				    <c:if test="${pageMaker.next && pageMaker.endPage >0 }">
				    <li>
				        <a href='<c:url value="/board/list${pageMaker.makeQueryPage(pageMaker.endPage+1) }"/>'><i class="fa-solid fa-chevron-right"></i></a>
				    </li>
				    </c:if>
				</ul>
	</div>
	
	<!-- tab4 -->
	<div class="tab_content" id="tab4">
			<table class="table">
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
						<c:forEach var="list" items="${Attack}">
						<tr>
							<td>
							<c:choose>
								<c:when test="${list.b_group == 1}">일반</c:when>
								<c:when test="${list.b_group == 2}">질문</c:when>
								<c:when test="${list.b_group == 3}">공략</c:when>
								<c:when test="${list.b_group == 4}">자랑</c:when>
							</c:choose>
							</td>
							<td><a href="${path}/board/detail?bno=${list.bno}">${list.title}</a></td>
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
				        <a href='<c:url value="/board/list?page=${pageMaker.startPage-1 }"/>'><i class="fa-solid fa-chevron-left"></i></a>
				    </li>
				    </c:if>
				    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
				    <li>
				        <a href='<c:url value="/board/list${pageMaker.makeQueryPage(pageNum) }"/>'><i class="fa">${pageNum }</i></a>
				    </li>
				    </c:forEach>
				    <c:if test="${pageMaker.next && pageMaker.endPage >0 }">
				    <li>
				        <a href='<c:url value="/board/list${pageMaker.makeQueryPage(pageMaker.endPage+1) }"/>'><i class="fa-solid fa-chevron-right"></i></a>
				    </li>
				    </c:if>
				</ul>
	</div>
	
	<!-- tab5 -->
	<div class="tab_content" id="tab5">
			<table class="table">
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
						<c:forEach var="list" items="${Boast}">
						<tr>
							<td>
							<c:choose>
								<c:when test="${list.b_group == 1}">일반</c:when>
								<c:when test="${list.b_group == 2}">질문</c:when>
								<c:when test="${list.b_group == 3}">공략</c:when>
								<c:when test="${list.b_group == 4}">자랑</c:when>
							</c:choose>
							</td>
							<td><a href="${path}/board/detail?bno=${list.bno}">${list.title}</a></td>
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
				        <a href='<c:url value="/board/list?page=${pageMaker.startPage-1}"/>'><i class="fa-solid fa-chevron-left"></i></a>
				    </li>
				    </c:if>
				    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
				    <li>
				        <a href='<c:url value="/board/list${pageMaker.makeQueryPage(pageNum)}"/>'><i class="fa">${pageNum }</i></a>
				    </li>
				    </c:forEach>
				    <c:if test="${pageMaker.next && pageMaker.endPage >0 }">
				    <li>
				        <a href='<c:url value="/board/list${pageMaker.makeQueryPage(pageMaker.endPage+1)}"/>'><i class="fa-solid fa-chevron-right"></i></a>
				    </li>
				    </c:if>
				</ul>
	</div>
</div>
</div>


<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
//게시판 탭 기능(게시판 종류 별로 글 보이게)
$(document).ready(function() {
	
	//class 이름이 tab_content 숨김
	$(".tab_content").hide(); 
	//addclass 사용으로 선택한 요소에 클래스 값 추가 /tab 클릭시 .active css효과 나타남 
	$("ul.tabs li:first").addClass("active").show();
	//tab1 번 부터 보이게 함
	$(".tab_content:first").show();

	//On Click Event
	$("ul.tabs li").click(function() {
		
		//tab 클릭시 이전 탭 부분은 기본 css로 돌아오고 클릭한 부분은 .active css로 바뀜
		$("ul.tabs li").removeClass("active"); 
		$(this).addClass("active"); 
		//이전 tab 부분 숨김
		$(".tab_content").hide(); 
		
		//tab태그를 클릭 시 a태그의 href 속성값을 찾기위해 선언
		var activeTab = $(this).find("a").attr("href");
		//tab태그를 클릭한 값을 서서히 나타나게 하는 메서드 .fadeIn()
		$(activeTab).fadeIn();
		return false;
	});

});
</script>
</body>
</html>