<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 디자인 css -->
<style>
.textForm {
  position:relative;
  left:32%;
  border-bottom: 2px solid #adadad;
  width: 30%;
  margin: 30px;
  padding: 10px 10px;
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
</style>
<!-- 유효성 css -->
<style>
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
</style>

</head>
<body>
<%@include file="../common/sidebar.jsp"%>
<br><br>

<form method="post" id="form">
<input type="hidden" name="id" value="${member.id}">

        <div class="textForm">닉네임
            <input type="text" name="nickname" id="nickname" class="nickname_input" value="${member.nickname}" placeholder="닉네임을 입력해주세요.">
            <span class="nick_input_re_1">사용 가능한 닉네임입니다.</span>
			<span class="nick_input_re_2">닉네임이 이미 존재합니다.</span>
			<span class="nick_input_re_3">특수문자를 사용하실 수 없습니다.</span>
			<span class="nick_input_re_4">2~10자 사이로 가능합니다.</span>
        </div>
        
        <div class="textForm">휴대전화
            <input type="text" name="tel" id="tel" class="tel_input" value="${member.tel}" placeholder="전화번호를 입력해주세요." >
            <span class="tel_input_re_1"></span>
            <span class="tel_input_re_2">올바르지 않은 번호입니다.</span>
        </div>
    
        <div class="textForm">
			<input  type="text" name="zipcode" id="zipcode" value="${member.zipcode}" class="zipcode" size="10" > <a
				href="javascript:execDaumPostcode()" >우편번호검색</a> <br>
				<input type="text" id="roadAddress" name="roadAddress" value="${member.roadAddress}" class="zipcode" placeholder="지번"><br>
				<input type="text" id="jibunAddress" name="jibunAddress" value="${member.jibunAddress}" class="zipcode" placeholder="도로명"><br>
				<input type="text" name="namujiAddress" class="zipcode" id="namujiAddress" value="${member.namujiAddress}" placeholder="나머지 주소" />
				<span id="guide" style="color: #999"></span>
		</div>
		
		<button type="button" class="modify" id="btn" >수 정</button>
</form>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
//닉네임 정규표현식(한글,영어,숫자 2~16자)
function nickFormCheck(nickname){
	var nickExp = /^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,10}$/;
	return nickExp.test(nickname);
}
//휴대폰번호 정규표현식(01로 시작하며(0)문자 추가 - 숫자만들어가며 3-4자 - 숫자만들어가면서 4자), '-?' 하이픈은 있을수도 없을수도
function telFormCheck(tel){
	var telExp = /^01([0])-?([0-9]{3,4})-?([0-9]{4})$/;
	return telExp.test(tel);
}
//유효성 검사 변수
var nickCheck = false; 
var telCheck = false;
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

//수정 버튼
$('.modify').on('click',function(){
	var formObj = $('#form');
	
	var nickname = $('.nickname_input').val();
	var tel = $('.tel_input').val();
	var zipcode = $('.zipcode').val();
	var namujiAddress = $('#namujiAddress').val();
	
	if(nickname == "" || !nickFormCheck(nickname)){
		alert("닉네임을 재확인 해주세요.");
		document.getElementById("nickname").focus();
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

	 
	 formObj.submit();
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