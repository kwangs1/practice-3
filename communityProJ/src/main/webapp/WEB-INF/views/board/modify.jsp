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
<style>
@import url('https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300&display=swap');
.row1 {
   margin:0px auto;
   width: 700px;
   height: 650px;
   font-family: 'Space Grotesk', sans-serif;
}
h1 {
	text-align:center;
	font-family: 'Space Grotesk', sans-serif;
}
select {
width: 200px; 
padding: .8em .5em; 
border: 1px solid #999;
font-family: inherit;  
border-radius: 10px;
font-family: 'Space Grotesk', sans-serif;
}

select::-ms-expand {
    display: none;
}
</style>
<body>
<form method='post' id='modifyForm'>
	  <input type='hidden' id='bno' name='bno' value='${board.bno}'>
	
	<div class="container">
		<h1>수정</h1>
     <div class="row row1">
      <table class="table">
        <tr>
			<th width=30% class="text-center">
				<select class="option" name="category" id="category">
					<option value="" selected>말머리 선택해주세요</option>
					<option value="1">일반</option>
					<option value="2">질문</option>
					<option value="3">공략</option>
					<option value="4">자랑</option>
				</select>
			</th>
		</tr>
        <tr>
         <th width=20% class="text-center warning">제목</th>
         <td width=30% class="text-center">
         	<input type="text" name="title"  value="${board.title}">
         </td>
         	
         <th width=20% class="text-center warning">작성일</th>
         <td width=30% class="text-center">${board.credate}</td>
        </tr>
        <tr>
         <th width=20% class="text-center warning">닉네임</th>
         <td width=30% class="text-center">${board.nickname}</td>
        </tr>
        <tr>
          <td colspan="4" class="text-left" valign="top" height="200">
          	<textarea name="content"  style="width:100%; height:100%">${board.content}</textarea>
          </td>
        </tr>
        <tr>
          <td colspan="4" class="text-right">
          	<button id="upd_chk" class="btn btn-xs btn-info">수정</button>
			<a href="${path}/board/list" class="btn btn-xs btn-success">목록으로</a>
          </td>
        </tr>
      </table>
     </div>
   </div>

</form>		
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">	
$(document).ready(function(){
	
	$("#upd_chk").on('click',function(){
		var updform = $('#modfiyForm');
		var update = confirm("수정 하시겠습니까?");
			
		if(update){
			alert("수정 되었습니다");
			updform.attr('action','${path}/board/modify').submit();
		}else{
			alert("취소 되었습니다.");
			return false;
		}
	})
})
//select option 값 가져오기!
$(document).ready(function(){

	let rating = '${board.category}';		
	//option 객체에 접근을 하면 배열 형태로 프로퍼티를 가지고 있음
	//jquery의 each메서드 사용해서 option객체가 가지고 있는 모든 요소에 순차적으로 접근하도록 함. 
	$("option").each(function(i,obj){
		if(rating === $(obj).val()){
			$(obj).attr("selected", "selected");
		}
	});		
});
</script>
</body>
</html>