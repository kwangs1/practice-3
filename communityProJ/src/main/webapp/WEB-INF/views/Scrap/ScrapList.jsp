<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageConntext.reqeust.ContextPath }" />
<c:set var = "boardList" value="${scrap.boardList}" />
<c:set var = "ScrapList" value="${scrap.ScrapList}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<style>
table {
    margin-left:auto; 
    margin-right:auto;
    text-align:center;
}
</style>
<body>
<%@include file="../common/sidebar.jsp"%>
<br>
<form method='post' id="form">
	<table>
		<thead>
		<tr>
		<td >구분&nbsp;&nbsp;&nbsp;</td>
			<td>&nbsp;&nbsp;&nbsp;제목</td>
		</tr>
		</thead>
		<tbody>
		<c:forEach var="boardList" items="${boardList}" varStatus="cnt">
			<c:set var="sno" value="${ScrapList[cnt.count-1].sno}" />
		<tr>
			<td><input type='checkbox' value='${boardList.bno}'  name="content"/>&nbsp;&nbsp;&nbsp;</td>
			<td><a href="${path}/board/detail?bno=${boardList.bno}">${boardList.title}</a></td>
			
			<td>&nbsp;&nbsp;&nbsp;<button type='button' class="btn btn-xs btn-warning remove" onClick="removeScrap('${sno}');">삭제</button></td>
		</tr>
		</c:forEach>
		</tbody>
	</table>
</form>
		<c:choose>
			<c:when test="${empty ScrapList}">
				<div style="text-align:center">
					<strong>스크랩 한 게시물이 없습니다.</strong>
				</div>
			</c:when>
		</c:choose>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
function removeScrap(sno){
	var sno=Number(sno);
	var formObj=document.createElement("form");
 	var i_sno = document.createElement("input");
	i_sno.name="sno";
	i_sno.value=sno;
	i_sno.type="hidden";
	
	formObj.appendChild(i_sno); 
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${path}/Scrap/removeScrap";
    
    var item = document.getElementsByName("content").length;
	var ary = [];
	  for(var i=0; i<item;i++){
		  if(document.getElementsByName("content")[i].checked==true){
			  sno = document.getElementsByName("content")[i].value;
			  ary.push(sno);
		  }
	}	  
	  if(ary.length === 0 || ary === null){
		  alert('체크박스를 선택해주세요.!');
	  }else{
		formObj.submit();
	  }
    
    
}
</script>
</body>
</html>