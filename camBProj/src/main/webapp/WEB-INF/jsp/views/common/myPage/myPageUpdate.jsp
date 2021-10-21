<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
	table {
	  border-collapse: separate;
	  border-spacing: 3rem 1rem;
	}
	input {
		width: 150%
	}
</style>

<div id="body">

	<!-- 카드 시작 -->
	<div class="card shadow mb-4" style="width: 800px;">
		<div class="card-header py-3"><!--마이페이지 글씨 써있는 부분  -->
			<h6 class="m-0 font-weight-bold text-primary" id="myPage">마이페이지 수정</h6>
		</div>
		
			<div class="card-body"><!--내용 흰색 칸  -->
				<form action="/common/myPage/myPageUpdate" method="post" id="mpFrm" method="post" enctype="multipart/form-data">
				<div class="row">
				
					<!-- 사진 수정 -->
					<div class="col-sm-4" style="text-align: center;">
						<div class="mb-2" style="width: 150px; height: 150px; margin: auto; margin-top: 20px;">
							<!-- 사진이 없으면 기본 사진을 보여준다 -->
                       		<c:if test="${mv.fileGrNum != null}">
                       			<c:set var="filePath" value="/${mv.fileGrNum}"/>
                       		</c:if>
                       		<c:if test="${mv.fileGrNum == null}">
                      			<c:set var="filePath" value="/resources/img/temp/profile.png"/>
                       		</c:if>
                       		<img id="memImg" src="${filePath}" style="height:100%; width: 100%; border-radius: 5px;">
                       		<!-- //사진이 없으면 기본 사진을 보여준다 -->
						</div>
						<button type="button" id="memImgBtn" class="btn btn-info" style="width: 150px;">사진 변경</button>
						<input type="file" id="memImgFile" name="fileList" style="display: none;" onchange="fn_changeValue(this)">
						<!-- 파일이 들어왔는지 확인 -->
						<div style="display: none;">
		                    <input type="checkbox" name="fileCheck" id="fileCheck">
	                    </div>
					</div>
					<!-- // 사진 수정 -->
					
					
					<!-- 기본 정보 수정 -->
					<div class="col-sm-8">
						<table>
							<tr> 
								<td class="td1">아이디</td>
								<td><input class="form-control" type="text" name="memId" value="${memberVo.memId}" readonly="readonly"></td>
							</tr>
							<tr> 
								<td class="td1">이름</td>
								<td><input class="form-control" type="text" name="name" value="${memberVo.name}" readonly="readonly"></td>
							</tr>
							<tr> 
								<td class="td1">전화번호</td>
								<td><input class="form-control" id="phNum" name="phNum" value="${memberVo.phNum}" maxlength="30px;"></td>
							</tr>
							<tr> 
								<td class="td1">이메일</td>
								<td><input class="form-control" id="email" name="email" value="${memberVo.email}" maxlength="30px;"></td>
							</tr>
							<tr> 
								<td class="td1">우편번호</td>
								<td>
									<input class="form-control" id="zipcode" name="zipcode" value="${memberVo.zipcode}" style="width: 100px; float: left;"readonly="readonly">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<button type="button"  class="btn btn-info" onclick="postSearch()" id="postSearch" style="width: 120px;">주소 검색</button>
								</td>
								
							</tr>
							<tr> 
								<td class="td1">주소</td>
								<td><input class="form-control" id="addr" name="addr" value="${memberVo.addr}" maxlength="30px;" readonly="readonly"></td>
							</tr>
							<tr> 
								<td class="td1">상세 주소</td>
								<td><input class="form-control" id="addrDetail" name="addrDetail" value="${memberVo.addrDetail}" maxlength="30px;"></td>
							</tr>
							<tr> 
								<td class="td1">은행 명</td>
								<td>
									<select class="form-control" style="width: 100%;" name="bankCode" id="bankCode">
										<c:forEach var="bankList" items="${bankList}" varStatus="stat">
											<option value="${bankList.codeVal}" 
												<c:if test="${bankList.codeVal==memberVo.bankCode}">selected</c:if>>
												${bankList.codeName}
											</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr> 
								<td class="td1">계좌 번호</td>
								<td><input class="form-control" id="bankAccntNum" name="bankAccntNum" value="${memberVo.bankAccntNum}" maxlength="30px;"></td>
							</tr>
						</table>
					</div>
					<!-- //기본 정보 수정 -->
				</div><!-- // 정보 수정 끝 -->
				
				<hr>
				
				<!-- 버튼 -->
				<div class="row">
					<div class="col-sm-12 text-right">
						<button type="button" class="btn btn-primary btn-primary-crud" onclick="location.href='/common/myPage/myPageUpdatePwd'">비밀번호 변경</button> 
						<button type="submit" class="btn btn-primary btn-primary-crud" id="btnUpdate" >수정</button> 
						<a href="/common/myPage/myPageList"><button type="button" class="btn btn-default btn-default-crud">취소</button></a>
					</div> <!-- //end button -->
				</div>
				<!-- // 버튼 -->
			</form>
		</div>
	</div><!-- //카드 끝 -->
	
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
window.onload = function(){
    document.getElementById("postSearch").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
            	 var addr = ''; // 주소 변수
                 var extraAddr = ''; // 참고항목 변수

                 //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                 if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                     addr = data.roadAddress;
                 } else { // 사용자가 지번 주소를 선택했을 경우(J)
                     addr = data.jibunAddress;
                 }

                 // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                 if(data.userSelectedType === 'R'){
                     // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                     // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                     if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                         extraAddr += data.bname;
                     }
                     // 건물명이 있고, 공동주택일 경우 추가한다.
                     if(data.buildingName !== '' && data.apartment === 'Y'){
                         extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                     }
                     // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                     if(extraAddr !== ''){
                         extraAddr = ' (' + extraAddr + ')';
                     }
                 }
                 // 우편번호와 주소 정보를 해당 필드에 넣는다.
                 document.getElementById('zipcode').value = data.zonecode;
                 document.getElementById("addr").value = addr;
                 // 커서를 상세주소 필드로 이동한다.
                 document.getElementById("addrDetail").focus();
             }
         }).open();
    });
}
</script>
<script type="text/javascript">
	
	$(function() {
		
		// 값 자동 입력
		$("#myPage").click(function () {
			$("#addrDetail").val("서희빌라 201호");
		});
		
		// 이미지 미리보기
		$("#memImgBtn").click(function () {
			$('#memImgFile').click();
		});

		$("#memImgFile").change(function (e) {
			$("#fileCheck").prop("checked", true);
			fn_picChange(e);
		});
		
		
		$("#btnUpdate").on("click",function(){
			var input = confirm("수정하시겠습니까?");
			
			if(input == ""){
				return false;
			}
			
			if ($("#phNum").val() == "") {
				alert("전화번호를 입력해주세요.");
				return false;
			}
			if ($("#email").val() == "") {
				alert("이메일을 입력해주세요.");
				return false;
			}
			if ($("#addr").val() == "") {
				alert("주소를 입력해주세요.");
				return false;
			}
			if ($("#addrDetail").val() == "") {
				alert("상세주소를 입력해주세요.");
				return false;
			}
			if ($("#bankAccntNum").val() == "") {
				alert("계좌번호를 입력해주세요.");
				return false;
			}
			
			if(input){
				$("#mpFrm").submit();

			}else{
				return false;
			}
			
		});		
	});
	
	function fn_picChange(e) {
		//e :이미지가 change 된 이벤트
		var files = e.target.files;
		//멀티 파일이라면 배열로 처리
		var filesArr = Array.prototype.slice.call(files);
		
		filesArr.forEach(function(f) {
			if(!f.type.match("image.*")){
				alert("이미지 확장자 파일만 선택할 수 있습니다.");
				return;
			}
			//파일을 sel_file 변수에 넣음
			sel_file = f;
			console.log(f);
			//파일을 읽는 reder 객체 생성
			var reader = new FileReader();
			reader.onload = function(e) {
				//e.target.result : 경로 포함한 파일 이름
				$("#memImg").attr("src", e.target.result);
			}
			//f : filesArr 파일 배열에 들어있는 파일 객체 자체
			reader.readAsDataURL(f); // f를 다 읽으면 onload됐다고 인식해 reader.onload로
		});//end for
	}
	
</script>
