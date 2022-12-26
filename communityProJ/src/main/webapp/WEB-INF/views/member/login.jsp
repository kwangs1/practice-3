<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300&display=swap" rel="stylesheet">
<title>로그인</title>
<!-- 화면css -->
<style>
@import url('https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300&display=swap');
*{
margin:0; 
padding:0;
font-family: 'Space Grotesk', sans-serif;
}
 a:link {color: black; text-decoration: none;}
 a:visited {color: black; text-decoration: none;}
 a:hover { color: black; text-decoration: none;}
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
.loginbox{
width:330px;
height:370px;
border:1px solid #ccc;
margin:0 auto;
padding:0 auto;
bax-sizing:border-box;
}
.loginbox h1{
width:100%;
height:40px;
font-size:28px;
color:skyblue;
border-bottom:1px solid skyblue;
padding-left:40px;
box-sizing:border-box;
}
.search{
width:100%;
height:40px;
box-sizing:border-box;
line-height:40px;
text-align:center;
margin-bottom:20px;
}
.search span{font-size:11px; color:#999;}
.search a{
font-size:12px;
text-decoration:none;
background-color:#333;
color:#fff;
padding:3px 5px;
border-radius:3px;
margin-left:5px;
}
.btnwrap{width:100%; text-align:center;}
.btnwrap label{position:absolute; left:-999em;}
.btnwrap a{
width:129px;
height:35px;
background-color:#999;
text-decoration:none;
display:inline-block;
border-radius:3px;
color:#fff;
font-size:14px;
font-weight:bold;
line-height:35px;
}
.btn {
  position:relative;
  left:10%;
  transform: translateX(-50%);
  margin-bottom: 40px;
  width: 129px;
  height:35px;
  background: linear-gradient(125deg,#81ecec,#6c5ce7,#81ecec);
  background-position: left;
  background-size: 200%;
  color:white;
  font-weight: bold;
  border:none;
  cursor:pointer;
  transition: 0.4s;
  display:inline;
  border-radius:3px;
}

.btn:hover {
  background-position: right;
}
.login_warn{
  color:red;
  font-size: 0.9em;
  text-align: center;
}
.main{
  text-align: center
}
</style>
</head>
<body>
<br><br>
<div class="main">
<a href="${path}/board/lists">
<strong><h1>시끌벅적 커뮤니티</h1></strong>
</a>
</div>
<div class="loginbox">
		<h1>Login</h1>
	<form id="login_form" method="post">
	    <div class="textForm">
            <input type="text"  name="id" id="id" class="id_input" placeholder="아이디">
        </div>
      		
      	<div class="textForm">
            <input type="password"  name="pw" id="pw" class="pw_input" placeholder="비밀번호">
        </div>
		<c:if test="${result == 0 }">
			<div class="login_warn"> ID 또는 비밀번호를 잘못 입력하셨습니다.</div>
		</c:if>
      		
 		<div class="search">
			<span class="text">아이디 또는 비밀번호를 잊으셨나요?</span><br>
			<a href="${path}/member/idSearch" style='cursor:pointer;'>아이디 찾기</a>
			<a href="${path}/member/pwSearch" style='cursor:pointer;'>비밀번호 찾기</a>
		</div>
		
		<br>
		<div class="btnwrap">
			&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="btn" value="로그인" style='cursor:pointer;'/>
			<a href="${path}/member/join">회원가입</a><br>
		</div>
	</form>
</div>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(".btn").click(function(){
	$("#login_form").attr("action", "${path}/member/login");
	$("#login_form").submit();
});
</script>
</body>
</html>