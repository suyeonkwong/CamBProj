<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
	#div2{
		width: 600px; 
		height: 560px; 
		background-color: #e9ecef;
		margin-left: 100px; margin-top: 5px; 
		border-radius: 25px;
		float: left;
	}
	 #sec{
	 	font-family: 'Hanna', sans-serif;
	 	font-size: 1.5em;
	 }
	 #myPage{
	 	font-family: 'Hanna', sans-serif;
	 }
	#name{
		margin-top: 15px;
		text-align: center;
		color: black;	
	}
	#memId{
		color: black;
		margin-top: 30px; 
		text-align:right;
	}
	input{
		width: 80%;
		border: 1px solid gray;
	}
	#body, #sec{
		font-size: medium;
	}
</style>

<div id="body">

	<div style="width: 96%;">
	<div class="card shadow mb-4" style="width: 22%; height:250px; margin-left: 20px;">
		<div class="card-header py-3"><!--마이페이지 글씨 써있는 부분  -->
			<h5 class="m-0 font-weight-bold text-primary" id="myPage">
				비밀 번호 확인
			</h5>
		</div>
<div id="sec">
	<form action="/common/myPage/myPageUpdate" method="get" id="mpFrm">
	
		<div class="card-body" style="width: 95%"><!--내용 흰색 칸  -->
			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4"><!--흰색 칸안의칸  -->
				<br>
				<div id="checkPW">
					<h6 style="margin-left: 30px; color: #191970;">기존 비밀번호를 입력 해주세요.</h6>
					<input type="password" class="form-control" placeholder="기존 비밀번호 " id="checkPwd" style="margin-left: 30px; width: 150px; float: left;"> &nbsp;&nbsp;
					<button class="btn btn-primary" type="button" id="btnConfirm" onclick="chkMem(); return false;">확인</button>
					<span id="alert-danger" style="display: none; color: #d92742; font-weight: bold; margin-left: 30px;"><br>비밀번호가 일치하지 않습니다.</span> 
				</div>
			<br>
			</div><!--흰색 칸안의 칸  -->
		</div><!--내용 흰색 칸  -->
	</form>
	</div>
	<br><br>
</div>
</div>

	<script type="text/javascript">
	
	$("#mpFrm").submit(function(e) {

		 chkMem();

	    return false;
	});
	
	  function chkMem(){
			
			var localPwd = $("#hiddenPwd").val(); // 암호화가 되어있음
			var checkPwd = $("#checkPwd").val(); // 아직 암호화 전
	// 		var checkPwd = ""; // 아직 암호화 전
			
			console.log("localPwd : " + localPwd);
			console.log("checkPwd : " + checkPwd);
			
			var checkPwd = $("#checkPwd").val(); // 아직 암호화 전
			
			$.ajax({
				type : "post",
				url : "/common/myPage/checkPwd",
				data : {checkPwd : checkPwd},
				dataType : "json",
				async : false, // 비동기를 푼다. 순서대로 진행되도록 하기 위함
				success : function(result) {
					console.log("result : " + result);
					$("#alert-success").css('display', 'inline-block');
	                $("#alert-danger").css('display', 'none');
					location.href='/common/myPage/myPageUpdate?memId='+"${memberVo.memId}"
				},
				error : function(xhr, status, error) {
					console.log("xhr:"+xhr+", status:"+ status + ", error:"+error);
	                $("#alert-success").css('display', 'none');
	                $("#alert-danger").css('display', 'inline-block');
				}
				
			});
			
	    }
	  
	

	</script>
</div>


