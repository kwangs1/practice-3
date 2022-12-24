<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
/* 비밀번호 확인 일치 유효성검사 */
.pwck_input_re_1{
    color : green;
    display : none;    
}
.pwck_input_re_2{
    color : red;
	display : none;    
}
/* 비번 정규표현식 검사 */
.pw_input_re_1{
    color : green;
    display : none;    
}
.pw_input_re_2{
    color : red;
	display : none;    
}
.pw_input_re_3{
    color : red;
	display : none;    
}
#btn {
  position:relative;
  left:50%;
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
.textForm {
  position:relative;
  left:32%;
  border-bottom: 2px solid #adadad;
  width: 30%;
  margin: 30px;
  padding: 10px 10px;
}
.pw_input {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.pwck_input {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}
</style>
</head>
<body>
<%@include file="../common/sidebar.jsp"%>
<form method="post" id="form">
<input type="hidden" name="id" value="${member.id}">


        <div class="textForm">비밀번호
            <input type="password" name="pw" id="pw" class="pw_input" placeholder="비밀번호를 입력해주세요">
            <span class="pw_input_re_1">올바르게 입력되었습니다.</span>
            <span class="pw_input_re_2">영문,숫자,특수문자 사용해서 생성해주세요.</span>
            <span class="pw_input_re_3">8-16자 로 입력해주세요.</span>
        </div>
        <div class="textForm">비밀번호 확인
            <input type="password" class="pwck_input" id="pwck_input" placeholder="비밀번호 재확인">
			<span class="pwck_input_re_1">비밀번호가 일치합니다.</span>
            <span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
        </div>
        <button type="button" class="modify" id="btn" >수 정</button>
        
        
 </form>      
        
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
//비밀번호 정규표현식(8-16자 영문,숫자,특수문자 최소 하나씩 포함)
function pwFormCheck(pw){
	var pwExp = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
	return pwExp.test(pw);
}

var pwCheck = false;
var pwckCheck = false;

//비밀번호 정규표현식에 맞는가 확인
$('.pw_input').on('propertychange change keyup paste input',function(){
	var pw = $('.pw_input').val();
	
	if(pwFormCheck(pw)){
        $('.pw_input_re_1').css('display','block');
        $('.pw_input_re_2').css('display','none');
        $('.pw_input_re_3').css('display','none');
        pwCheck = true;
	}else{
        $('.pw_input_re_1').css('display','none');
        $('.pw_input_re_2').css('display','block');
        $('.pw_input_re_3').css('display','none');
        pwCheck = false;
	}
	
	if(pw.length < 8 || pw.length > 16){
        $('.pw_input_re_1').css('display','none');
        $('.pw_input_re_2').css('display','none');
        $('.pw_input_re_3').css('display','block');
        pwCheck = false;
	}
});

//비밀번호 확인 유효성검사
$('.pwck_input').on('propertychange change keyup paste input',function(){
	var pw = $('.pw_input').val();
	var pwck = $('.pwck_input').val();
	
	if(pw == pwck){
        $('.pwck_input_re_1').css('display','block');
        $('.pwck_input_re_2').css('display','none');
        pwckCheck = true;
	}else{
        $('.pwck_input_re_1').css('display','none');
        $('.pwck_input_re_2').css('display','block');
        pwckCheck = false;
    }    
})

$('.modify').on('click',function(){
	var formObj = $('#form');
	
	var pw = $('.pw_input').val();
	var pwck = $('.pwck_input').val();
	
	 if(pw == "" || !pwFormCheck(pw)){
		alert("비밀번호를 재확인 해주세요.");
		document.getElementById("pw").focus();
		return false;		
	}else if(pwck != pw){
		alert("비밀번호를 재확인 해주세요.");
		document.getElementById("pwck_input").focus();
		return false;	
	}

	 
	 formObj.submit();
})
</script>
</body>
</html>