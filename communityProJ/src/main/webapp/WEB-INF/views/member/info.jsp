<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>마이 페이지</title>
</head>
<body>
<%@include file="../common/sidebar.jsp"%>
<div>
<h1><p style="text-align:center">${member.nickname}안녕?<i class="fa-sharp fa-solid fa-ghost"></i></p></h1>
<img alt="사진" src="${path}/resources/img/A.png">
</div>
</body>
</html>