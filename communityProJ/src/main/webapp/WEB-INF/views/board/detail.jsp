<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300&display=swap" rel="stylesheet">
<meta charset="UTF-8">
</head>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300&display=swap');
.row1 {
   margin:0px auto;
   width: 700px;
   height: 650px;
   font-family: 'Space Grotesk', sans-serif;
}
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
</style>
<body>

   <div class="container">
   	 <h1>상세보기</h1>
     <div class="row row1">
      <table class="table">
        <tr>
         <th width=20% class="text-center warning">제목</th>
         <td width=30% class="text-center">${detail.title}</td>
         <th width=20% class="text-center warning">작성일</th>
         <td width=30% class="text-center">${detail.credate}</td>
        </tr>
        <tr>
         <th width=20% class="text-center warning">닉네임</th>
         <td width=30% class="text-center">${detail.nickname}</td>
         <th width=20% class="text-center warning">조회수</th>
         <td width=30% class="text-center">${detail.hit}</td>
        </tr>
        <tr>
          <td colspan="4" class="text-left" valign="top" height="200">
           <pre style="white-space: pre-wrap;border:none;background-color: white;">${detail.content}</pre>
          </td>
        </tr>
        <tr>
          <td colspan="4" class="text-right">
			<a href="#" class="btn btn-xs btn-success" onclick="back()">목록으로</a>
			<a href="${path}/board/remove?bno=${detail.bno}" id="del_chk" class="btn btn-xs btn-warning">삭제</a>
			<a href="${path}/board/modify?bno=${detail.bno}" class="btn btn-xs btn-info">수정</a>
          </td>
        </tr>
      </table>
     </div>
   </div>


<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">	
$('#del_chk').on('click',function(){
	var delconfirm = confirm('삭제 하시겠습니까?');
	
	if(delconfirm){
		alert('삭제 되었습니다.');
	}else{
		alert('삭제 취소되었습니다.');
		return false;
	}
})

function back(){
	history.back();
}
</script>
</body>
</html>