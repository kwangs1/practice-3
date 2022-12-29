<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300&display=swap" rel="stylesheet">
	
<script src="https://kit.fontawesome.com/aa33559cc0.js" crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<style>
@import url('https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300&display=swap');
textarea{
	width:100%;
	font-family: 'Space Grotesk', sans-serif;
}
input{
	width:100px;
	height:25px;
	font-family: 'Space Grotesk', sans-serif;
}
#button{
	padding: 16px 31px ;
	float:right;
	color: #fff;
    background-color:#0a0a23;
    font-family: 'Space Grotesk', sans-serif;
    font-size: 0.9em;
    width: 100px;
  	height: 40px;
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
.user-info__img img {
	margin-right: 15px;
	height: 55px;
	width: 55px;
	border-radius: 45px;
	border: 3px solid #fff;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}
.dropdown{
	position : relative;
	left : 600px;
	top : -120px;
}
a{
	color : black;
    font-family: 'Space Grotesk', sans-serif;
}
.ReplyLike{
	border:none; 
	background-color:white; 
	color:black;
}
.ReplyBad{
	border:none; 
	background-color:white; 
	color:black;
}
</style>
<body>
		<h3>댓글</h3>	
	<div>
		<input type="hidden" name="bno" id="bno">
	<c:if test="${empty member }">	
		<div>
			<input type="text" name="nickname" id="nickname" placeholder="닉네임"/>
			<input type="password" name="r_pw" id="r_pw" placeholder="비밀번호"/>
		</div>
	</c:if>
	<c:if test="${not empty member }">	
		<div>
			<input type="text" name="nickname" id="nickname" value="${member.nickname}" placeholder="닉네임"/>
			<input type="password" name="r_pw" id="r_pw" placeholder="비밀번호"/>
		</div>
	</c:if>
			<textarea name="content" id="content" placeholder="댓글을 입력해 주세요"></textarea>
			<input type="button" class="btnReplyAdd" id="button" value="등 록"/>
			
	</div>
	
		<div id="replyList"></div>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
//댓글 목록
$(document).ready(function(){
	ReplyList();
});

function ReplyList(){
	var url = "${path}/reply/ReplyList";
	var paramData = {"bno" : ${detail.bno}};
	
	
	$.ajax({
		type : 'post',
		url : url,
		data : paramData,
		dataType : 'json',
		success: function(data){
			
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
				let reply_like = data[i].reply_like;
				let reply_bad = data[i].reply_bad;
				
				
				//댓글
				if(r_depth == 0){
 					htmls += '<div id="rno' + rno + '">';
					htmls += '<div class="user-info__img">';
					htmls += '<button id="badImg'+ rno +'" class="ReplyBad"  rno="' + rno +'"><i class="fa-regular fa-thumbs-down"></i>'+reply_bad+'</button>'
					htmls += '<button class="ReplyLike" rno="' + rno +'"><i class="fa-regular fa-thumbs-up"></i>'+reply_like+'</button>';
					htmls += '<img src=${path}/resources/img/사용자.png>'		
					htmls += nickname + '</div>';
					htmls += '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'; 
					htmls += content;
					htmls += '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'; 
					htmls += credate
					//대댓글 버튼
					htmls += " <a href='#' data-bs-toggle='collapse' data-bs-target='#addRe_Reply"+ rno +"' aria-expanded='false' aria-controls='collapseExample'>답 글</a>"; 
					//수정 삭제 버튼
					htmls += '<div class="dropdown">';
					htmls += '<a href="#" class="px-2" id="triggerId3" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">';
					htmls += '<i class="fa fa-ellipsis-v"></i>';
					htmls += '</a>';
					htmls += '<div class="dropdown-menu" aria-labelledby="triggerId3">';
					htmls += '<a class="dropdown-item ModifyReply" href="#" data-rno='+rno+'><i class="fa fa-pencil mr-1"></i> 수정</a>';
					htmls += '<a class="dropdown-item text-danger" href="#"  onClick="DeleteReply('+rno+')"><i class="fa fa-trash mr-1"></i> 삭제</a>';
					htmls += '</div>';
					htmls += '</div>';
				}else{//대댓글
						htmls += '<div id="rno' + rno + '">';
						htmls += '<div class="user-info__img">';
						htmls += '<button id="badImg" class="ReplyBad" rno="' + rno +'"><i class="fa-regular fa-thumbs-down"></i>'+reply_bad+'</button>';
						htmls += '<button class="ReplyLike" rno="' + rno +'"><i class="fa-regular fa-thumbs-up"></i>'+reply_like+'</button>';
						htmls += '⤷<img src=${path}/resources/img/사용자.png>'		
						htmls += nickname + '</div>'
						htmls += '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'; 
						htmls += content;
						htmls += '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'; 
						htmls += credate;
						//수정 삭제 버튼
						htmls += '<div class="dropdown">';
						htmls += '<a href="#" class="px-2" id="triggerId3" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">';
						htmls += '<i class="fa fa-ellipsis-v"></i>';
						htmls += '</a>';
						htmls += '<div class="dropdown-menu" aria-labelledby="triggerId3">';
						htmls += '<a class="dropdown-item ModifyReply" href="#" data-rno='+rno+'><i class="fa fa-pencil mr-1"></i> 수정</a>';
					 	htmls += '<a class="dropdown-item text-danger" href="#"  onClick="DeleteReply('+rno+')"><i class="fa fa-trash mr-1"></i> 삭제</a>';
						htmls += '</div>';
						htmls += '</div>';
						htmls += '</div>';
					}
					
					//대댓글 입력란, 로그인 안한 상태
					if(nickname == null){
		 				htmls += "<div class='collapse addRe_Reply' id='addRe_Reply"+ rno +"'>";
						htmls += "<div>"
						htmls += "<input type='text' id='nickname"+ rno +"' name='nickname' placeholder='닉네임'>";
					  	htmls += "<input type ='password' id='r_pw"+ rno +"' name='r_pw' placeholder='비밀번호'>";
						htmls += "</div>";
						htmls += "<textarea name='content' id='content"+ rno +"' placeholder='댓글을 입력해 주세요'></textarea>"
						//동적으로 넣은 html 태그에서 발생하는 이벤트는 동적으로 처리해줘야 함
						//동적으로 넣은 html 태그에서 발생하는 click 이벤트는 html 태그 안에서 onclick 처리하면 안되고 , jquery에서 클래스명 이나 id값을 받아서 처리하도록 해야함
						htmls += "<button type='button' class='addRe_Reply' rno='" + rno +"' bno= '" + bno +"'>작 성</button>";
						htmls += "</div>";
					}else{
						//로그인 한 상태
		 				htmls += "<div class='collapse addRe_Reply' id='addRe_Reply"+ rno +"'>";
						htmls += "<div>"
						htmls += "<input type='text' id='nickname"+ rno +"' name='nickname' value='${member.nickname}' placeholder='닉네임'>";
					  	htmls += "<input type ='password' id='r_pw"+ rno +"' name='r_pw' placeholder='비밀번호'>";
						htmls += "</div>";
						htmls += "<textarea name='content' id='content"+ rno +"' placeholder='댓글을 입력해 주세요'></textarea>"
						//동적으로 넣은 html 태그에서 발생하는 이벤트는 동적으로 처리해줘야 함
						//동적으로 넣은 html 태그에서 발생하는 click 이벤트는 html 태그 안에서 onclick 처리하면 안되고 , jquery에서 클래스명 이나 id값을 받아서 처리하도록 해야함
						htmls += "<button type='button' class='addRe_Reply' rno='" + rno +"' bno= '" + bno +"'>작 성</button>";
						htmls += "</div>";
					}
					
					};//end for
					
						$("#replyList").html(htmls);
					
						//대댓글 작성 스크립트 실행문
						$('.addRe_Reply').on('click',function(){				
							addRe_Reply($(this).attr('bno'), $(this).attr('rno'));
						});
						
						//댓글 좋아요
		 				$('.ReplyLike').on('click',function(){			
							ReplyLike($(this).attr('rno'));
						});
		 				//댓글 싫어요
		 				$('.ReplyBad').on('click',function(){			
		 					ReplyBad($(this).attr('rno'));
						});
			}//end success
			,error : function(error){
				console.log(error);
			}
	});//end ajax
}

//댓글 저장
$(document).on('click','.btnReplyAdd',function(){
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
		"bno" : ${detail.bno}
	});
	
	var headers = {"Content-Type":"application/json"
		,"X-HTTP-Method-Override":"POST"};
	
	$.ajax({
		url : '${path}/reply/addReply', 
		data : paramData,
		headers : headers,
		type : 'post',
		success : function(result){
			ReplyList();
			 $('#content').val('');
		},
		error : function(error){
			console.log(error);
		}
	})//end ajax
})//end function

//댓글 수정 팝업
$(document).on('click', '.ModifyReply', function(){  
	var rno = $(this).attr('data-rno');
	var bno = ${detail.bno}
	
	let popUrl = "${path}/board/getModifyReply?rno=" + rno + "&bno=" + bno ;
	let popOption = "width = 350px, height= 250px, top=300px, left=-1000px ";

		window.open(popUrl,"리뷰 수정",popOption);
});

//댓글 삭제
function DeleteReply(rno){
	var Delconfirm = confirm('삭제 하시겠습니까?');
	
 	if(Delconfirm){
		alert('삭제 되었습니다.');
	}else{
		alert('삭제 취소 되었습니다.');
		return false;
	}
	
	$.ajax({
		url : '${path}/reply/DeleteReply',
		type : 'post',
		data : {"rno" : rno},
		success : function(result){
			ReplyList();
		},
		error : function(error){
			console.log(error);
		}
	});//end ajax
	
};

//대댓글 작성
addRe_Reply = function(bno, rno){
		
var nickname = $('#nickname' + rno).val();
var r_pw = $('#r_pw' + rno).val();
var content = $('#content' + rno).val();
		
if(nickname == ""){
	alert("닉네임을 입력해주세요.");
	document.getElementById("nickname" + rno).focus();
	return false;
}else if(r_pw == ""){
	alert("비밀번호를 입력해주세요.");
	document.getElementById("r_pw" + rno).focus();
	return false;
}else if(content == ""){
	alert("내용을 입력해주세요.");
	document.getElementById("content" + rno).focus();
	return false;
}

var paramData = JSON.stringify({
		"bno" : bno,
		"rno" : rno,
		"content" : content,
		"r_pw" : r_pw,
		"nickname" : nickname
	});

var headers = {
	"Content-Type" : "application/json",
	"X-HTTP-Method-Override" : "POST"
	};

	$.ajax({
		url : "${path}/reply/addReReply"
		,headers : headers
		,data : paramData
		,type : 'POST'
		,dataType : 'text'
		,success:function(){
			ReplyList();
		},
		error:function(error){
			console.log(error);
		}
	});//end ajax			
};//end function
</script>

<!-- 댓글 좋아요 -->
<script>
//좋아요
ReplyLike = function(rno){
	var like_type = 1;
		
					
	$.ajax({
			type : 'post',
			url : '${path}/Like/ReplyLike',
			data : {
				'rno':rno ,
				'like_type' : like_type},
				
			success : function(Likecheck){
				if(Likecheck == 0){
					ReplyList();
					console.log('좋아요');
				}
				else if(Likecheck == 1){	
					ReplyList();
					console.log('좋아요 취소');
				}
			},
			error : function(error){
				console.log(error);
			}
		});//end ajax	
	}//end function
	
//싫어요
ReplyBad = function(rno){
	var bad_type = 1;	
	
	$.ajax({
		type : 'post',
		url : '${path}/Like/ReplyBad',
		data : {
			'rno':rno ,
			'bad_type' : bad_type},				
				
		success : function(Badcheck){
 			if(Badcheck == 0){
				ReplyList(); 
				}
			else if(Badcheck == 1){	
				ReplyList();
				}
			},
			error : function(error){
				console.log(error);
			}
		});//end ajax
	}//end function
</script>
</body>
</html>