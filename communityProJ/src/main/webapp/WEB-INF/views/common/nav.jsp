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
</head>
<body>

<c:if test="${member == null}">
<a href="${path}/member/join">회원가입</a>
<a href="${path}/member/login">로그인</a>
</c:if>

<c:if test="${member != null}">
<a href="${path}/member/logout">로그아웃</a>
</c:if>

<div class="search" align="center">
    <select name="searchType">
      <option value="t"<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
      <option value="c"<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
      <option value="w"<c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
      <option value="tc"<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>
    </select>

    <input type="text" name="keyword" id="keywordInput" value="${scri.keyword}"/>

    <button id="searchBtn" type="button">검색</button>

  </div>
  
  <ul class="nav">
  	<li class="nav-item">
      <a class="nav-link" href="${path}/board/lists">전체</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${path}/board/free">자유</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${path}/board/qna">질문</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${path}/board/tip">공략</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${path}/board/brag">자랑</a>
    </li>
  </ul>
  
  
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
 <script type="text/javascript">
 $(function(){
	    $('#searchBtn').click(function() {
	      self.location = "lists" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val());
	    });
	  });
 </script>
</body>
</html>