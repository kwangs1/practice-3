<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<style>
textarea{
	width:100%;
	font-family: 'Space Grotesk', sans-serif;
}
input{
	width:100px;
	height:25px;
	font-family: 'Space Grotesk', sans-serif;
}
button{
	padding: 16px 31px ;
	float:right;
	color: #fff;
    background-color:#0a0a23;
    font-family: 'Space Grotesk', sans-serif;
    font-size: 0.9em;
    width: 100px;
  	height: 40px;
}
</style>
<body>
	<div class="Reply" style="padding-top: 10px">			
		<h3 class= "ReplyList">댓글</h3>
		<div id="replyList"></div>				
	</div>
	
 	<form action="${path}/reply/addReply" method="post" name="form">
		<input type="hidden" name="bno" id="bno">
		
		<div>
			<input type="text" name="nickname" id="nickname" placeholder="닉네임"/>
			<input type="password" name="r_pw" id="r_pw" placeholder="비밀번호"/>
		</div>
			<textarea name="content" id="content" placeholder="댓글을 입력해 주세요"></textarea>
			<button id="btnReplyAdd">등 록</button>
	</form>
	
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	ReplyList();
});

function ReplyList(){
	var url = "${path}/reply/ReplyList";
	var paramData = {"bno" : '${boardVO.bno}' };
	
	$.ajax({
		type : 'post',
		url : url,
		data : paramData,
		dataType : 'json',
		success: function(data){
			console.log("댓글 목록 불러옴.");
			
			var htmls = "";
			
			for(const i in data){
				let rno = data[i].rno;
				let bno = data[i].bno;
				let nickname = data[i].nickname;
				let r_pw = data[i].r_pw;
				let content = data[i].content;
				let credate = data[i].credate;
				let r_depth = data[i].r_depth;
				let r_group = data[i].r_group;
				
				//댓글
				if(r_depth == 0){
					htmls += '<div id="rno' + rno + '">';
					htmls += '<span>'
					htmls += '<p>' + nickname + '</p>';
					htmls += '&nbsp;&nbsp;' + credate ; 
					htmls += '<br>'
					htmls += content;
					htmls += '</span>'
				}//end if
			}//end for
		}//end success
	});//end ajax
}

//댓글 저장
$(document).on('click','#btnReplyAdd',function(){
	var content = $('#content').val();
	var nickname = $('#nickname').val();
	var r_pw = $('#r_pw').val();
	
	if(nickname == ""){
		alert("닉네임을 입력해주세요.");
		document.getElementById("nickname").focus();
		return false;
	}else if(r_pw == ""){
		alert("비밀번호를 입력해주세요.");
		document.getElementById("r_pw").focus();
		return false;
	}else if(content == ""){
		alert("내용을 입력해주세요.");
		document.getElementById("content").focus();
		return false;
	}
	
	var paramData = JSON.stringify({
		"content" : content,
		"nickname" : nickname,
		"r_pw" : r_pw,
		"bno" : '${boardVO.bno}'
	});
	
	var headers = {"Content-Type":"application/json"
		,"X-HTTP-Method-Override":"POST"};
	
	$.ajax({
		url : '${path}/reply/addReply', 
		
		data : paramData,
		headers : headers,
		type : 'post',
		dataType : 'json',
		success : function(result){
			console.log(result);
			ReplyList();
		},
		error : function(error){
			console.log('에러' + error);
		}
	})//end ajax
})//end function
</script>
</body>
</html>