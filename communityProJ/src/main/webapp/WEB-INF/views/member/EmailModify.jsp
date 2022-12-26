<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
#btn {
  position:relative;
  left:6%;
  transform: translateX(-50%);
  margin-bottom: 40px;
  width:15%;
  height:40px;
  background: linear-gradient(125deg,#81ecec,#6c5ce7,#81ecec);
  background-position: left;
  background-size: 200%;
  color:white;
  font-weight: bold;
  border:none;
  cursor:pointer;
  transition: 0.4s;
  display:inline;
}

#btn:hover {
  background-position: right;
}
</style>
<!-- 이메일 css -->
<style>
.mail_wrap{
  position:relative;
  left:32%;
  border-bottom: 2px solid #adadad;
  width: 30%;
  margin: 30px;
  padding: 10px 10px;
}
.mail_input{
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}
.mail_check_input{
  width: 500%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
}
.mail_check_button{
  position:relative;
  left:40%;
  transform: translateX(-50%);
  margin-bottom: 40px;
  width:100%;
  height:40px;
  background: linear-gradient(125deg,#81ecec,#6c5ce7,#81ecec);
  background-position: left;
  background-size: 200%;
  color:white;
  font-weight: bold;
  border:none;
  cursor:pointer;
  display:inline;
}
.mail_check_button:hover {
  background-position: right;
}
/* 인증번호 입력란 */
#mail_check_input_box_false {
	background-color: #ebebe4;
	width:10%;
}

#mail_check_input_box_true {
	background-color: white;
}
.mail_check_button{
    border: 1px solid black;
    width: 10%;
    text-align: center;
    background-color: #ececf7;
    cursor: pointer;
}
/* 이메일 인증 문구 */
.correct {
	color: green;
}

.incorrect {
	color: red;
}
</style>
</head>
<body>
<%@include file="../common/sidebar.jsp"%>
<br><br>
<div style = "text-align:center;">
<form method="post" id="form">
<input type="hidden" name="id" value="${member.id}">
		<div class="mail_wrap">이메일
			<div class="mail_input_box">
				<input type="text" name="email" id="email" class="mail_input" value="${member.email}" placeholder="이메일을 입력해주세요."/> 	
				<div class="mail_check_button">전송</div>
			</div>
			<!-- email 형식이 올바르지 않을때 경고글을 나오게하기위해 -->
			<span class="mail_input_box_warn"></span>
			<br>
			인증번호
			<div class="mail_check_input_box" id="mail_check_input_box_false" >
				<input class="mail_check_input"  id="mail_check_input" placeholder="인증번호">
			</div>
			<!-- 인증번호 일치여부 -->
			<div class="clearfix"></div>
			<span id="mail_check_input_box_warn"></span>
		</div>
		
		<button type="button" class="modify" id="btn" >수 정</button>
</form>
</div>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
//email 정규표현식
function mailFormCheck(email){
	 var mailExp = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
	 return mailExp.test(email);
}


<!-- 이메일 스크립트 -->

var code ="";
var mailnumCheck =false; //이메일 인증번호

//메일 보내기 버튼
$('.mail_check_button').click(function(){
	var email = $('.mail_input').val();
	//인증번호 입력란
	var checkBox = $('.mail_check_input');
	//정규표현식에 어긋났을경우
	var warnMsg = $('.mail_input_box_warn');
	
	if(mailFormCheck(email)){
		warnMsg.html("이메일이 전송되었습니다.");
		warnMsg.css("display",'inline-block');
		warnMsg.css("color",'green');
	}else{
		warnMsg.html("이메일 형식이 올바르지 않습니다.");
		warnMsg.css("display",'inline-block');
		warnMsg.css("color",'red');
		return false;
	}
	
	$.ajax({
		type : 'post',
		url : '${path}/member/MailCheck?email='+email,
		success : function(data){
			code = data;
		}
	})//end ajax
})

//이메일 인증코드 비교
$('.mail_check_input').blur(function(){
	//사용자가 입력한 코드
	var inputCode = $('.mail_check_input').val();
	//결과 메시지
	var checkResult = $('#mail_check_input_box_warn');
	
	if(inputCode == code){
		checkResult.html("인증번호가 일치합니다.");
		checkResult.attr("class", "correct");
		mailnumCheck = true;
	}else{
		checkResult.html("인증번호를 다시 확인해주세요.");
		checkResult.attr("class","incorrect");
		mailnumCheck = false;
	}
})

//수정 버튼
$('.modify').on('click',function(){
	var formObj = $('#form');
	
	var email = $('.mail_input').val();
	var inputCode = $(".mail_check_input").val();
	
	if(email == "" || !mailFormCheck(email)){
		alert("이메일을 재확인 해주세요.");
		document.getElementById("email").focus();
		return false;		
	}else if(inputCode == "" || inputCode != code){
		alert("인증코드를 재확인 해주세요.");
		document.getElementById("mail_check_input").focus();
		return false;	
	}

	 
	 formObj.submit();
})
</script>
</body>
</html>