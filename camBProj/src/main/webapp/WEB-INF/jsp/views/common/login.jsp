<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
<head>
	<link rel="stylesheet" type="text/css" href="./style.css">
	<style type="text/css">
		*{
  margin: 0px;
  padding: 0px;
  text-decoration: none;
  font-family:sans-serif;

}
/* Simple CSS3 Fade-in Animation */
@-webkit-keyframes fadeIn { from { opacity:0; } to { opacity:1; } }
@-moz-keyframes fadeIn { from { opacity:0; } to { opacity:1; } }
@keyframes fadeIn { from { opacity:0; } to { opacity:1; } }

.fadeIn {
  opacity:0;
  -webkit-animation:fadeIn ease-in 1;
  -moz-animation:fadeIn ease-in 1;
  animation:fadeIn ease-in 1;

  -webkit-animation-fill-mode:forwards;
  -moz-animation-fill-mode:forwards;
  animation-fill-mode:forwards;

  -webkit-animation-duration:1s;
  -moz-animation-duration:1s;
  animation-duration:1s;
}

.fadeIn.first {
  -webkit-animation-delay: 0.4s;
  -moz-animation-delay: 0.4s;
  animation-delay: 0.4s;
}            

.fadeIn.second {
  -webkit-animation-delay: 0.6s;
  -moz-animation-delay: 0.6s;
  animation-delay: 0.6s;
}

.fadeIn.third {
  -webkit-animation-delay: 0.8s;
  -moz-animation-delay: 0.8s;
  animation-delay: 0.8s;
}

.fadeIn.fourth {
  -webkit-animation-delay: 1s;
  -moz-animation-delay: 1s;
  animation-delay: 1s;
}

body {
  background-image: #34495e;
}

.loginForm {
  position:absolute;
  width:500px;
  height:550px;
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

.idForm{
  border-bottom: 2px solid #adadad;
  margin: 30px;
  padding: 10px 10px;
}

.passForm{
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

.pw {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.btnLogin {
  position:relative;
  left:40%;
  transform: translateX(-50%);
  margin-bottom: 25px;
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

.btnLogin:hover {
  background-position: right;
}

.bottomText {
  text-align: center;
}

.quick {
	display: inline;
}
	</style>
	<script type="text/javascript">
		$(function() {
			$("#quickLogin select").on("change", function() {
				  var selectedId = $(this).find('option:selected').val(); 
// 				  console.log(selectedId);
				  $("#login").val(selectedId);
				  
				  $.ajax({
						type: "post", //요청 메소드 방식
						url:"/searchPwd",
						data : {selectedId: selectedId},
						dataType:"json", //서버가 요청 URL을 통해서 응답하는 내용의 타입
						success : function(result){
							console.log("result : " + result.pwd);
							result = result.pwd;
			 				$("#password").val(result);
			 				$("#loginFrm").attr("action", "/quickLogin").submit();
						},
						error : function(xhr, status, error){
							//통신 실패시 발생하는 함수(콜백)
							console.log("xhr:"+xhr+", status:"+ status + ", error:"+error);
							alert("통신실패");
						}
					});

			})
			
		});
	</script>
</head>
<body class="fadeIn">
	<div style="text-align: center; position: relative; left: 90px;">
		<img alt="back" src="/resources/img/cambBack.png">
	</div>
    <!-- 로그인-->
    <form action="/common/login" method="post" class="loginForm" style="margin-left: 603px;" id="loginFrm">
    <br>
      <h2 style="font-family: serif; color: #A6A9AA; font-weight: bolder; ;">CAMB UNIVERSITY</h2>
      <h1 style="font-family: serif; color: #A6A9AA	; font-weight: bold; ">LOGIN</h1>
      <div class="idForm">
         <input class="form-control" type="text" id="login" name="memId" placeholder="아이디">
      </div>
      <div class="passForm">
         <input class="form-control" type="password" id="password" name="pwd" placeholder="비밀번호">
      </div>
      <input type="submit" value="로그인" class="btnLogin">
      
      <div id="quickLogin" class="form-group"> 
      	<label for="jobCode">학생</label>
		<select class="form-control quick" style="width: 20%;" name="student" id="student">
			<option value="">-선택-</option>
			<option value="210101008" >김지수 (210101008)</option>
			<option value="210101001" >김학생 (210101001)</option>
			<option value="210101021" >김한기 (210101021)</option>
			<option value="210101031" >이여강 (210101031)</option>
			<option value="210101002" >김소희 (210101002)</option>
		</select>
      	<label for="jobCode">교수</label>
		<select class="form-control quick" style="width: 20%;" name="professor" id="professor">
			<option value="">-선택-</option>
			<option value="210201001" >김교수 (210201001)</option>
			<option value="1" >박병주 (1)</option>
			<option value="">---전기전자공학과---</option>
			<option value="210210001" >정인식 (210210001)</option>
			<option value="210210002" >안창호 (210210002)</option>
			<option value="210210003" >권아름 (210210003)</option>
			<option value="210210004" >주하영 (210210004)</option>
			<option value="210210005" >장준희 (210210005)</option>
			<option value="">---멀티미디어공학과---</option>
			<option value="210211001" >김철수 (210211001)</option>
			<option value="210211002" >이민순 (210211002)</option>
			<option value="210211003" >정미혜 (210211003)</option>
			<option value="210211004" >조윤재 (210211004)</option>
			<option value="210211005" >윤정민 (210211005)</option>
			<option value="">---경영학과---</option>
			<option value="210220001" >박경영 (210220001)</option>
			<option value="210220002" >한미숙 (210220002)</option>
			<option value="210220003" >문영재 (210220003)</option>
			<option value="210220004" >정민준 (210220004)</option>
			<option value="210220005" >신동욱 (210220005)</option>
			<option value="">---컴퓨터공학과---</option>
			<option value="210257001" >오영수 (210257001)</option>
			<option value="210257002" >유태민 (210257002)</option>
			<option value="210257003" >권민주 (210257003)</option>
			<option value="210257004" >강한나 (210257004)</option>
			<option value="210257005" >오상훈 (210257005)</option>
		</select>
      	<label for="jobCode">직원</label>
		<select class="form-control quick" style="width: 20%;" name="employee" id="employee">
			<option value="">-선택-</option>
			<option value="210301001" >김직원 (210301001)</option>
			<option value="210302001" >학사직원1 (210302001)</option>
			<option value="210302002" >학사직원2 (210302002)</option>
			<option value="210302003" >학사직원3 (210302003)</option>
			<option value="210304001" >강의직원1 (210304001)</option>
			<option value="210304002" >강의직원2 (210304002)</option>
			<option value="210304003" >강의직원3 (210304003)</option>
			<option value="210305001" >구현수 (210305001)</option>
			<option value="210306004" >최소은 (210306004)</option>
		</select>
      </div>
 
      <p align="center">비밀번호를 잊으셨다면<a href="javascript:location.href='search/searchPw'" style="font-weight: bold;"> 여기</a>를 클릭하세요.</p>
    </form>
    

<c:set var="msg" value="${msg}" />

<c:if test="${msg eq 'delete'}">
    <script>
    	alert("사용할 수 없는 유저정보 입니다.")
    </script>
</c:if>

<c:if test="${msg eq 'errCnt'}">
    <script>
    	alert("로그인 오류횟수가 5회를 초과하여 계정이 잠겼습니다. \n 관리자에게 문의하세요");
    </script>
</c:if>

<c:if test="${msg eq 'fail'}">
    <script>
    alert("아이디 또는 비밀번호가 일치하지 않습니다.\n " + ${cnt} + "회 오류. "+ (5-${cnt})  + " 회 남았습니다.");
    
    </script>
</c:if>


</body>
</html>

