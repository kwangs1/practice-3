<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<style>
@import url('https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300&display=swap');
.container {
  position:absolute;
  width:400px;
  height:400px;
  padding: 30px, 20px;
  background-color:#FFFFFF;
  text-align:center;
  top:40%;
  left:50%;
  transform: translate(-50%,-50%);
  border-radius: 15px;
  font-family: 'Space Grotesk', sans-serif;
}
.textForm {
  border-bottom: 2px solid #adadad;
  margin: 30px;
  padding: 10px 10px;
}
.id_input {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.mail_input {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}
.mail_wrap{
  border-bottom: 2px solid #adadad;
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
p{
  color:#808080;
  font-size:0.7em;
}
/* 이메일 인증 문구 */
.correct {
	color: green;
}

.incorrect {
	color: red;
}
button{
  position:relative;
  left:15%;
  transform: translateX(-50%);
  margin-bottom: 40px;
  width:100px;
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
button:hover {
  background-position: right;
}
</style>
</head>
<body>

<div class="container">
	   <div class="header">
            <h1>PW 찾기</h1>
        </div>
        <p>조회 할 계정의 등록된 아이디, 이메일이 같아야 합니다.</p>
        
	<div class='search'>
        <div class="textForm">아이디
            <input type="text" name="id"  class="id_input" placeholder="아이디를 입력해주세요.">
        </div>
        
        <div class="mail_wrap">이메일
			<div class="mail_input_box">
				<input type="text" name="email"  class="mail_input" placeholder="이메일을 입력해주세요."/> 	
				<div class="mail_check_button">전송</div>
			</div>
			<!-- email 형식이 올바르지 않을때 경고글을 나오게하기위해 -->
			<span class="mail_input_box_warn"></span>
			<br>
			인증번호
			<div class="mail_check_input_box" id="mail_check_input_box_false" >
				<input class="mail_check_input"  id="mail_check_input" placeholder="인증번호">
			<!-- 인증번호 일치여부 -->
			<div class="clearfix"></div>
			<span id="mail_check_input_box_warn"></span>
			</div>
		</div>
		<br>
		<button type='button' class='id_search' onClick='offDisplay()'>조 회</button>
		&nbsp;&nbsp;
		<button type='button'  onClick='history.go(-1)'>이전 화면</button>
	</div>
		<div class="result"></div>
		<br>
		
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

$(document).on('click','.id_search',function(){
	var id = $('.id_input').val();
	var email = $('.mail_input').val();
	
	$.ajax({
		type : 'post',
		url : '${path}/member/pwSearch',
		data : {'id' : id,
				'email' : email},
		success : function(data){
			if(data == 0){
				$('.result').html('<strong>정보가 존재하지 않습니다.</strong>' 
						+ '<br><br><button type="button" onClick="window.location.reload()">이전 화면으로</button>');
			}else{
				$('.result').html('조회 결과 :<br> <strong>' + data +  '</strong>'
						+ '<br><br><button type="button" onClick="login()">로그인 하기</button>');
			}
		},
		error : function(error){
			console.log(error);
		}
	})//end ajax
})

function offDisplay(){
	$('.search').hide();
}
function login(){
	location.href = '${path}/member/login'
}

</script>
</body>
</html>