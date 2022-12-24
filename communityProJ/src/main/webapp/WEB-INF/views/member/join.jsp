<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300&display=swap" rel="stylesheet">
<meta charset="utf-8">
<!-- 가입테이블 css -->
<style>
@import url('https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300&display=swap');
a{
 color:black;
}
a:hover{
  text-decoration-line: underline;
  color:black;
}
* {
  margin: 0px;
  padding: 0px;
  text-decoration: none;
  font-family: 'Space Grotesk', sans-serif;
}

.join {
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
}

.join h2 {
  text-align: center;
  margin: 30px;
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

.nickname_input {
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

.zipcode {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.tel_input {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}
.btn {
  position:relative;
  left:40%;
  transform: translateX(-50%);
  margin-bottom: 40px;
  width:80%;
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

.btn:hover {
  background-position: right;
}
</style>
<!-- 유효성 css -->
<style>
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
/* 중복아이디 존재하지 않는경우 */
.id_input_re_1 {
	color: green;
	display: none;
}
/* 중복아이디 존재하는 경우 */
.id_input_re_2 {
	color: red;
	display: none;
}
/* 아이디 정규표현식에 안맞는경우 */
.id_input_re_3 {
	color: red;
	display: none;
}
/* 아이디 길이가 안맞는경우 */
.id_input_re_4 {
	color: red;
	display: none;
}
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
/* 중복닉네임 존재하지 않는경우 */
.nick_input_re_1 {
	color: green;
	display: none;
}
/* 중복닉네임 존재하는 경우 */
.nick_input_re_2 {
	color: red;
	display: none;
}
/* 닉네임 정규표현식 안맞는경우 */
.nick_input_re_3 {
	color: red;
	display: none;
}
/* 닉네임 길이에 안맞는경우 */
.nick_input_re_4 {
	color: red;
	display: none;
}
/* 휴대번호 정규표현식 알맞는지 */
.tel_input_re_2{
	color: red;
	display: none;
}
/* 이메일 인증 문구 */
.correct {
	color: green;
}

.incorrect {
	color: red;
}
</style>
<!-- 이메일 css -->
<style>
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
</style>
</head>
<body>
	<form action="${path}/member/join" method="post" class="join">
	   <div class="header">
            <h1>회원가입</h1>
        </div>
       
        <div class="textForm">아이디
            <input type="text"  name="id" id="id" class="id_input" placeholder="아이디를 입력해주세요.">
            <span class="id_input_re_1">사용 가능한 아이디입니다.</span>
			<span class="id_input_re_2">아이디가 이미 존재합니다.</span>
			<span class="id_input_re_3">한글로는 생성 불가능 합니다.</span>
			<span class="id_input_re_4">5~15자 사이로 가능합니다.</span>

        </div>
			
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
        <div class="textForm">닉네임
            <input type="text" name="nickname" id="nickname" class="nickname_input" placeholder="닉네임을 입력해주세요.">
            <span class="nick_input_re_1">사용 가능한 닉네임입니다.</span>
			<span class="nick_input_re_2">닉네임이 이미 존재합니다.</span>
			<span class="nick_input_re_3">특수문자를 사용하실 수 없습니다.</span>
			<span class="nick_input_re_4">2~10자 사이로 가능합니다.</span>
        </div>
 
		<div class="mail_wrap">이메일
			<div class="mail_input_box">
				<input type="text" name="email" id="email" class="mail_input" placeholder="이메일을 입력해주세요."/> 	
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
        
        <div class="textForm">휴대전화
            <input type="text" name="tel" id="tel" class="tel_input" placeholder="전화번호를 입력해주세요." >
            <span class="tel_input_re_1"></span>
            <span class="tel_input_re_2">올바르지 않은 번호입니다.</span>
        </div>
    
        <div class="textForm">
			<input  type="text" name="zipcode" id="zipcode" class="zipcode" size="10" > <a
				href="javascript:execDaumPostcode()" >우편번호검색</a> <br>
				<input type="text" id="roadAddress" name="roadAddress" class="zipcode" placeholder="지번"><br>
				<input type="text" id="jibunAddress" name="jibunAddress" class="zipcode" placeholder="도로명"><br>
				<input type="text" name="namujiAddress" class="zipcode" id="namujiAddress" placeholder="나머지 주소" />
				<span id="guide" style="color: #999"></span>
		</div>
        
        <input type="submit" class="btn" value="J O I N"/>
        
</form>	
<!-- 다음 주소 api를 사용하기 위해 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- 정규표현식 스크립트 -->
<script>
//id 정규표현식(5~15자의 영문자와 숫자를 조합)
function idFormCheck(id){
	var idExp = /^(?=.*[a-z0-9])[a-z0-9]{5,15}$/;
	return idExp.test(id);
}
//닉네임 정규표현식(한글,영어,숫자 2~16자)
function nickFormCheck(nickname){
	var nickExp = /^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,10}$/;
	return nickExp.test(nickname);
}
//email 정규표현식
function mailFormCheck(email){
	 var mailExp = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
	 return mailExp.test(email);
}
//휴대폰번호 정규표현식(01로 시작하며(0)문자 추가 - 숫자만들어가며 3-4자 - 숫자만들어가면서 4자), '-?' 하이픈은 있을수도 없을수도
function telFormCheck(tel){
	var telExp = /^01([0])-?([0-9]{3,4})-?([0-9]{4})$/;
	return telExp.test(tel);
}
//비밀번호 정규표현식(8-16자 영문,숫자,특수문자 최소 하나씩 포함)
function pwFormCheck(pw){
	var pwExp = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
	return pwExp.test(pw);
}

</script>

<!-- 회원가입 유효성 검사 -->
<script>
//유효성 검사 변수
var idCheck = false; 
var nickCheck = false; 
var pwCheck = false;
var pwckCheck = false;
var telCheck = false;
//id 중복검사
$('.id_input').on('propertychange change keyup paste input',function(){
	var id = $('.id_input').val();
	
	$.ajax({
		type : 'post',
		url : '${path}/member/IdCheck',
		data : {id : id},
		success : function(result){
			if(result != 'fail'){
				$('.id_input_re_1').css("display","block");
				$('.id_input_re_2').css("display","none");	
				$('.id_input_re_3').css("display","none");	
				$('.id_input_re_4').css("display","none");	
				idCheck = true;
			}else{
				$('.id_input_re_1').css("display","none");	
				$('.id_input_re_2').css("display","block");
				$('.id_input_re_3').css("display","none");	
				$('.id_input_re_4').css("display","none");	
				idCheck = false;
			}
			if(idFormCheck(id) == false){
				$('.id_input_re_1').css("display","none");	
				$('.id_input_re_2').css("display","none");	
				$('.id_input_re_3').css("display","block");
				$('.id_input_re_4').css("display","none");	
				idCheck = true;
			}
			 if(id.length < 4 || id.length > 20){
				$('.id_input_re_1').css("display","none");	
				$('.id_input_re_3').css("display","none");	
				$('.id_input_re_2').css("display","none");	
				$('.id_input_re_4').css("display","block");
				idCheck = true;
			}

		},
		error : function(error){
			console.log(error);
		}
	});//end ajax
});

//닉네임 중복검사
$('.nickname_input').on('propertychange change keyup paste input',function(){
	var nickname = $('.nickname_input').val();
	
	$.ajax({
		type : 'post',
		url : '${path}/member/NickCheck',
		data : {nickname : nickname},
		success : function(result){
			if(result != 'fail'){
				$('.nick_input_re_1').css("display","block");
				$('.nick_input_re_2').css("display","none");	
				$('.nick_input_re_3').css("display","none");	
				$('.nick_input_re_4').css("display","none");	
				nickCheck = true;
			}else{
				$('.nick_input_re_1').css("display","none");	
				$('.nick_input_re_2').css("display","block");
				$('.nick_input_re_3').css("display","none");	
				$('.nick_input_re_4').css("display","none");	
				nickCheck = false;
			}
			if(nickFormCheck(nickname) == false){
				$('.nick_input_re_1').css("display","none");	
				$('.nick_input_re_2').css("display","none");	
				$('.nick_input_re_3').css("display","block");
				$('.nick_input_re_4').css("display","none");	
				nickCheck = true;
			}
			if(nickname.length < 2 || nickname.length > 10){
				$('.nick_input_re_1').css("display","none");	
				$('.nick_input_re_2').css("display","none");	
				$('.nick_input_re_3').css("display","none");	
				$('.nick_input_re_4').css("display","block");
				nickCheck = true;
			}
		},
		error : function(error){
			console.log(error);
		}
	});//end ajax
})

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

//휴대번호 정규표현식 검사
$('.tel_input').on('propertychange change keyup paste input',function(){
	var tel = $('.tel_input').val();
	
	if(!telFormCheck(tel)){
        $('.tel_input_re_2').css('display','block');  
        $('.tel_input_re_1').css('display','none');
        telCheck = false;
	}else{
        $('.tel_input_re_1').css('display','block');
        $('.tel_input_re_2').css('display','none');
        telCheck = true;
	}
})

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

<!-- 회원가입 완료 및 빈칸 확인 -->

$('input[type="submit"]').on('click',function(){
	
	var id = $('.id_input').val();
	var pw = $('.pw_input').val();
	var nickname = $('.nickname_input').val();
	var email = $('.mail_input').val();
	var tel = $('.tel_input').val();
	var zipcode = $('.zipcode').val();
	var namujiAddress = $('#namujiAddress').val();
	//이메일 인증코드
	var inputCode = $(".mail_check_input").val();
	//비밀번호 확인코드
	var pwck = $('.pwck_input').val();
	
	if(id == "" || !idFormCheck(id)){
		alert("아이디를 재확인 해주세요.");
		document.getElementById("id").focus();
		return false;
	}else if(pw == "" || !pwFormCheck(pw)){
		alert("비밀번호를 재확인 해주세요.");
		document.getElementById("pw").focus();
		return false;		
	}else if(pwck != pw){
		alert("비밀번호를 재확인 해주세요.");
		document.getElementById("pwck_input").focus();
		return false;	
	}else if(nickname == "" || !nickFormCheck(nickname)){
		alert("닉네임을 재확인 해주세요.");
		document.getElementById("nickname").focus();
		return false;		
	}else if(email == "" || !mailFormCheck(email)){
		alert("이메일을 재확인 해주세요.");
		document.getElementById("email").focus();
		return false;		
	}else if(inputCode == "" || inputCode != code){
		alert("인증코드를 재확인 해주세요.");
		document.getElementById("mail_check_input").focus();
		return false;	
	}else if(tel == "" || !telFormCheck(tel)){
		alert("전화번호를 재확인 해주세요.");
		document.getElementById("tel").focus();
		return false;			
	}else if(zipcode == ""){
		alert("주소를 재확인 해주세요.");
		document.getElementById("zipcode").focus();
		return false;	
	}else if(namujiAddress == ""){
		alert("주소를 재확인 해주세요.");
		document.getElementById("namujiAddress").focus();
		return false;	
	}
    
})
</script>

<!-- 다음 주소 -->
<script>
/* 우편번호 검색API */
function execDaumPostcode() {
  new daum.Postcode({
    oncomplete: function(data) {
      // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

      // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
      var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
      var extraRoadAddr = ''; // 도로명 조합형 주소 변수

      // 법정동명이 있을 경우 추가한다. (법정리는 제외)
      // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
      if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
        extraRoadAddr += data.bname;
      }
      // 건물명이 있고, 공동주택일 경우 추가한다.
      if(data.buildingName !== '' && data.apartment === 'Y'){
        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
      }
      // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
      if(extraRoadAddr !== ''){
        extraRoadAddr = ' (' + extraRoadAddr + ')';
      }
      // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
      if(fullRoadAddr !== ''){
        fullRoadAddr += extraRoadAddr;
      }

      // 우편번호와 주소 정보를 해당 필드에 넣는다.
      document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
      document.getElementById('roadAddress').value = fullRoadAddr;
      document.getElementById('jibunAddress').value = data.jibunAddress;

      // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
      if(data.autoRoadAddress) {
        //예상되는 도로명 주소에 조합형 주소를 추가한다.
        var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
        document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

      } else if(data.autoJibunAddress) {
          var expJibunAddr = data.autoJibunAddress;
          document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
      } else {
          document.getElementById('guide').innerHTML = '';
      }  
    }
  }).open();

}

</script>
</body>
</html>