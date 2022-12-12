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
</body>
</html>