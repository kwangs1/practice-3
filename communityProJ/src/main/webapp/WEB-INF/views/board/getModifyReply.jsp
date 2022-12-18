<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300&display=swap" rel="stylesheet">
<style>
@import url('https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300&display=swap');
button{
	padding: 10px;
	float:right;
	color: #fff;
    background-color:#0a0a23;
    font-family: 'Space Grotesk', sans-serif;
    font-size: 0.9em;
    height:50px;
    cursor:pointer;
}
.cancel_btn{
	background-color:#fff;
	color : black;
}
input{
	width:100px;
	height:40px;
	font-family: 'Space Grotesk', sans-serif;
	width: 50%;
}
textarea{
	width:60%;
	font-family: 'Space Grotesk', sans-serif;
}
.incorrect {
	color: red;
}
</style>
</head>
<body>
	<div>
		<input type="hidden" name="rno" id="rno">
		<input type="hidden" name="bno" id="bno">
		
		<div>
			<input type="password" name="r_pw" id="r_pw" placeholder="비밀번호"/>
			<div><span id="r_pw_check"></span> </div>
		</div>
		<br>
		<div>
			<textarea name='content' id='content' rows='8' placeholder='댓글을 입력해 주세요'></textarea>
			<button class='UpdateBtn'>수 정</button>
			<button class='cancel_btn'>취 소</button>
		</div>			
	
	</div>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
//수정 ajax
$('.UpdateBtn').on('click',function(){
	var rno = ${reply.rno};
	var content = $('#content').val();
	//비번 확인
	var r_pw = '${reply.r_pw}';
	var r_pw2 = $('#r_pw').val();
	var Msg = $('#r_pw_check');
	
	if(r_pw != r_pw2){
		Msg.html("비밀번호가 틀렸습니다.");
		Msg.attr("class","incorrect");
		return false;
	}
	
	
	var paramData = JSON.stringify({
		"rno" : rno,
		"content" : content
	});
	
	var headers = {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "POST"
		};
	
	$.ajax({
		type : 'post',
		url : '${path}/reply/ModifyReply',
		headers : headers,
		data : paramData,
		success : function(result){
			opener.parent.location.reload();
			window.close();
		},
		error : function(error){
			console.log(error);
		}
	});//end ajax
})//end function

//수정 취소
$(".cancel_btn").on("click", function(e) {
	window.close();
});
</script>
</body>
</html>