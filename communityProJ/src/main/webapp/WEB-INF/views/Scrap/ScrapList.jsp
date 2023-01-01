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

<script src="https://kit.fontawesome.com/aa33559cc0.js" crossorigin="anonymous"></script>
</head>
<style>
table {
    margin-left:auto; 
    margin-right:auto;
    text-align:center;
}
.container{
	margin: 40px auto;
	width: 100%;
}
*{
  padding-right:15px;
  padding-bottom:10px;
  padding-left:15px;
}
</style>
<body>
<%@include file="../common/sidebar.jsp"%>
<br>
<div class="container" >
	<table>
		<thead>
		<tr>
		<td >구분&nbsp;&nbsp;&nbsp;</td>
			<td>&nbsp;&nbsp;&nbsp;제목</td>
			<td>&nbsp;&nbsp;&nbsp;닉네임</td>
			<td>&nbsp;&nbsp;&nbsp;작성날짜</td>
		</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${empty ScrapList}">
					<div style="text-align:center">
						<strong>스크랩 한 게시물이 없습니다.</strong>
					</div>
				</c:when>
			</c:choose>
			
		<c:forEach var="boardList" items="${boardList}" varStatus="cnt">
			<c:set var="sno" value="${ScrapList[cnt.count-1].sno}" />
		<tr>
			<td><input type='checkbox' value='${boardList.bno}'  name="content"/>&nbsp;&nbsp;&nbsp;</td>
			<td>&nbsp;&nbsp;&nbsp;<a href="${path}/board/detail?bno=${boardList.bno}">${boardList.title}</a></td>
			<td>&nbsp;&nbsp;&nbsp;<a href="${path}/board/detail?bno=${boardList.bno}">${boardList.nickname}</a></td>
			<td>&nbsp;&nbsp;&nbsp;<a href="${path}/board/detail?bno=${boardList.bno}">${boardList.credate}</a></td>
			
			<td>&nbsp;&nbsp;&nbsp;<button type='button' class="btn btn-xs btn-warning remove" onClick="removeScrap('${sno}');">삭제</button></td>
		</tr>
		</c:forEach>
		</tbody>
	</table>
	
	<ul class="pagination">
		<c:if test="${pageMaker.prev }">
			 <li>
				<a href='<c:url value="/Scrap/ScrapList?page=${pageMaker.startPage-1 }"/>'><i class="fa-solid fa-chevron-left"></i></a>
			</li>
			</c:if>
				<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
				<li>
				   <a href='<c:url value="/Scrap/ScrapList${pageMaker.makeQuery(pageNum) }"/>'><i class="fa">${pageNum }</i></a>
				</li>
				</c:forEach>
				<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
				<li>
				   <a href='<c:url value="/Scrap/ScrapList${pageMaker.makeQuery(pageMaker.endPage+1) }"/>'><i class="fa-solid fa-chevron-right"></i></a>
				</li>
			</c:if>
	</ul>
	
</div>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
function removeScrap(sno){
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
			  no = document.getElementsByName("content")[i].value;
			  ary.push(no);
		  }
	}	  
	  if(ary.length === 0 || ary === null){
		  alert('체크박스를 선택해주세요.!');
		  return false;
	  }
		  


		formObj.submit();
    
}
</script>
</body>
</html>