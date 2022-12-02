<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300&display=swap" rel="stylesheet">
</head>
<style>
@import url('https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300&display=swap');
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
</style>
<body>
<form action="${path}/board/register" method="post" id="frm">
   <div class="container">
   	<h1>작성</h1>
     <div class="row row1">
      <table class="table">
      	<tr>
			<th width=30% class="text-center">
				<select class="option" name="b_group" id="b_group">
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
         	<textarea name="title"  id="title" style="width:100%; height:100%" class="title"></textarea>
         </td>
        </tr>
        <tr>
         <th width=20% class="text-center warning">닉네임</th>
         <td width=30% class="text-center">
         	<textarea name="nickname" id="nickname" style="width:100%; height:100%" class="nickname"></textarea>
         </td>
        </tr>
        <tr>
          <td colspan="4" class="text-left" valign="top" height="200">
           <textarea name="content" id="content" style="width:100%; height:100%" class="content"></textarea>
          </td>
        </tr>
        <tr>
          <td colspan="4" class="text-right">
			<a href="${path}/board/list" class="btn btn-xs btn-success">목록으로</a>
			<input type="button" value="작성" onClick="check()" class="btn btn-xs btn-info"/>
          </td>
        </tr>
      </table>
     </div>
   </div>

</form>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function check(){
		var b_group = $(".option").val();
		var title = $(".title").val();
		var nickname = $(".nickname").val();
		var content = $(".content").val();
		
		if(b_group == 0){
			alert("말머리 선택해주세요.");
			return document.getElementById("b_group").focus();
		}else if(title == ""){
			alert("제목을 적어주세요.");
			return document.getElementById("title").focus();
		}else if(nickname == ""){
			alert("닉네임 적어주세요.");
			return document.getElementById("nickname").focus();
		}else if(content == ""){
			alert("내용을 적어주세요.");
			return document.getElementById("content").focus();
		}
		else{
			document.getElementById("frm").submit()
		}
	}

</script>
</body>
</html>