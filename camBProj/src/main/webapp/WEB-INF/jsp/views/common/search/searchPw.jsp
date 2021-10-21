<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<link rel="icon" type="image/png"  href="/jmcnetplug/image/jmclogo.png"/>
	<title> 비밀번호 찾기</title>
	<script type="text/javascript">
		function search(){
			if((pwsearch.memId.value!=null)&&(pwsearch.email.value!=null)){
				pwsearch.submit();
			}else if(pwsearch.memId.value==null) {
				alert("아이디를 입력하세요.")
			}else if(pwsearch.email.value==null) {
				alert("이메일주소를 입력하세요.")
			}
		
		}/*  function showMsg(m){
			
			if(m==0){
				
			}else if(m==1){
				alert("입력하신 정보가 등록하신 정보와 다릅니다.");
				window.open("common/search/searchPw","_self", "" );
			}
		}function login(){
			window.open("login","_self","");
		} */
	
	</script>

</head>
<link rel="stylesheet" type="text/css" href="./style.css">
<style>

.idForm{
  border-bottom: 2px solid #adadad;
  margin: 30px;
  padding: 10px 10px;
}
.emailForm{
  border-bottom: 2px solid #adadad;
  margin: 30px;
  padding: 10px 10px;
}
.id {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.email {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}
	#find {
  position:relative;
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

.#find:hover {
  background-position: right;
}
.bottomText {
  text-align: center;
}
.loginForm {
  position:absolute;
  width:500px;
  height:580px;
  padding: 30px, 20px;
  background-color:#FFFFFF;
  text-align:center;
  top:50%;
  left:50%;
  transform: translate(-50%,-50%);
  border-radius: 15px;
}

.loginForm h2{
  text-align: center;
  margin: 30px;
}

</style>

<body onload="showMsg(${msg})">
<br><br><br><br>
<br><br><br>
<br><br>
<div>
<form action="/common/search/searchPw" name="pwsearch" method="post" class="loginForm" style="margin-left: 100px;">
	   <br><br>
	   		<p style="margin-bottom: 40px; font-size: 1.5em" onclick="fn_setData();">비밀번호 찾기</p>   		
		   		<hr>
	   		<span>아이디와 이메일을 입력해주세요.</span>
	   		<br>
			<div class="idForm">
				<span style="color: gray; margin-right: 350px;">아이디</span> <input class="form-control" type="text" name="memId" style="width: 100%; " placeholder="210000000"/>
			</div>
			<div class="emailForm">
				<span style="color: gray; margin-right: 350px;">이메일</span> <input class="form-control" type="email" name="email" style="width: 100%;" placeholder="asd1234@naver.com"/>
			</div>
		<br>

		<input type="button" id="find" value="찾 기" onclick="search()" style="width: 80px; height: 50px; text-align:center; border-radius: 10px; border: 1px; position: relative; left: 40px;"/>

<p align="center">로그인 페이지로 가시려면 <a href="javascript:location.href='/common/login'" style="font-weight: bold;">여기</a>를 클릭하세요.</p>
	<br>

	</form>
<br><br>
</div> 
</body>

<script type="text/javascript">
	function fn_setData() {
		$("[name='memId']").val("210306004");
		$("[name='email']").val("camb.camb.test@gmail.com");
	}
</script>

</html>


