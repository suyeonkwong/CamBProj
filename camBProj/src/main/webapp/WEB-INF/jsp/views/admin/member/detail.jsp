<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="body"> 

	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">사용자 상세보기</h6>
		</div>
		<div class="card-body">
			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
				
				<form action="/admin/member/update" method="post" id="memberFrm" enctype="multipart/form-data"><!-- form start -->
					 <input type="hidden" name="memId" value="${memberVo.memId}" />
					 <input type="hidden" name="pwd" value="${memberVo.pwd}" />
					 <input type="hidden" name="firstLoginInsertVal" value="${memberVo.firstLoginInsertVal}" />
					<div class="row">
						<div class="col-sm-6">
							<div class="form-group">
								<label for="memTypeCode">회원유형<span style="color: red;">*</span></label>
								<select class="form-control memberSelect" style="width: 100%;" name="memTypeCode" id="memTypeCode">
									<option value="01" <c:if test="${memberVo.memTypeCode=='01'}" >selected</c:if>
										<c:if test="${memberVo.memTypeCode!='01'}">disabled</c:if>>학생</option>
									<option value="02" <c:if test="${memberVo.memTypeCode=='02'}" >selected</c:if>
										<c:if test="${memberVo.memTypeCode!='02'}">disabled</c:if>>교수</option>
									<option value="03" <c:if test="${memberVo.memTypeCode=='03'}">selected</c:if> 
										<c:if test="${memberVo.memTypeCode!='03'}">disabled</c:if> >직원</option>
								</select>
							</div>
						</div>
					</div>	
					<div class="row">
						<div class="col-sm-6">
							<div class="form-group">
								<label for="name">이름</label>
								<input type="text" class="form-control memberInput" name="name" id="name" value="${memberVo.name}" readonly="readonly">
							</div>
						</div>
						<div class="col-sm-6">
							<div class="form-group">
								<label for="resRgstNum">주민등록번호</label>
								<input type="text" class="form-control memberInput" name="resRgstNum" id="resRgstNum" value="${memberVo.resRgstNum}" readonly="readonly">
							</div>
						</div>
						<div class="col-sm-6">
							<div class="form-group ">
								<label>성별</label>
								<select class="form-control memberSelect" style="width: 100%;" name="gen">
									<option value="M" <c:if test="${memberVo.gen=='M'}">selected</c:if> 
										<c:if test="${memberVo.gen!='M'}">disabled</c:if>>남</option>
									<option value="F" <c:if test="${memberVo.gen=='F'}">selected</c:if> 
										<c:if test="${memberVo.gen!='F'}">disabled</c:if>>여</option>
								</select>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="form-group">
								<label for="phNum">전화번호</label>
								<input type="tel" class="form-control memberInput" name="phNum" id="phNum" value="${memberVo.phNum}" readonly="readonly">
							</div>
						</div>
						<div class="col-sm-6">
							<div class="form-group">
								<label for="email">이메일</label>
								<input type="email" class="form-control memberInput" name="email" id="email" value="${memberVo.email}" readonly="readonly">
							</div>
						</div>
					</div>
					
<!-- 			stdStart	 -->
					<div class="row selectStudent" id="selectStudent">
						<div class="col-sm-6">
							<div class="form-group">
								<label for="admDate">입학 일자</label>
								<input type="text" class="form-control memberInput dt" name="admDate" id="admDate" value="${memberVo.admDate}" placeholder="${memberVo.admDate}">
							</div>
						</div>
						<div class="col-sm-6">
							<div class="form-group">
								<label for="univDeptNumStd">학과</label>
								
								<select class="form-control memberSelect" style="width: 100%;" name="univDeptNumStd" id="univDeptNumStd">
									<option value="${memberVo.univDeptNum}" selected="selected">${memberVo.univDeptNum}</option>
									<c:forEach var="univDev" items="${Vlist}" varStatus="stat">
										<option value="${univDev.codeVal}" 
											<c:if test="${memberVo.univDeptNum==univDev.codeVal}">selected</c:if>>
											${univDev.codeName}
										</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="form-group">
								<label for=" advProf">지도교수</label>
								<select class="form-control memberSelect" style="width: 100%;" name="advProf" id="advProf" disabled="disabled">
									<option value="${memberVo.advProf}" selected="selected">${memberVo.advProf}</option>
									<c:forEach var="univDev" items="${list}" varStatus="stat">
										<option value="${univDev.codeVal}" >${univDev.codeName}</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>
<!-- 			stdEnd	 -->

<!-- 			prfStart	 -->
					<div class="row selectProfessor" id="selectProfessor">
						<div class="col-sm-6">
							<div class="form-group">
								<label for="univDeptNumPrf">학과</label>
								<select class="form-control memberSelect" style="width: 100%;" name="univDeptNumPrf" id="univDeptNumPrf">
									<option value="${memberVo.univDeptNum}" selected="selected">${memberVo.univDeptNum}</option>
									<c:forEach var="univDev" items="${Vlist}" varStatus="stat">
										<option value="${univDev.codeVal}" >${univDev.codeName}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="form-group">
								<label for="apptDatePrf">발령일자</label>
								<input type="text" class="form-control memberInput dt" name="apptDatePrf" id="apptDatePrf" value="${memberVo.apptDate}" placeholder="${memberVo.apptDate}">
							</div>
						</div>
					</div>
<!-- 			prfEnd	 -->

<!-- 			empStart	 -->
					<div class="row selectAdmin" id="selectAdmin">
						<div class="col-sm-6">
							<div class="form-group">
								<label for="deptCode">부서코드</label>
								<select class="form-control memberSelect" style="width: 100%;" name="deptCode" id="deptCode">
									<option value="${memberVo.deptCode}" selected="selected">${memberVo.deptCode}</option>
									<c:forEach var="dept" items="${Dlist}" varStatus="stat">
										<option value="${dept.codeVal}" >${dept.codeName}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="form-group">
								<label for="jobCode">직무코드</label>
								<select class="form-control memberSelect" style="width: 100%;" name="jobCode" id="jobCode">
									<option value="${memberVo.jobCode}" selected="selected">${memberVo.jobCode}</option>
									<c:forEach var="job" items="${Jlist}" varStatus="stat">
										<option value="${job.codeVal}" >${job.codeName}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="form-group">
								<label for="apptDateEmp">발령일자</label>
								<input type="text" class="form-control memberInput dt" name="apptDateEmp" id="apptDateEmp" value="${memberVo.apptDate}" placeholder="${memberVo.apptDate}">
							</div>
						</div>
					</div>
<!-- 			empEnd	 -->

					<hr>
					
					<div class="row">
						<div class="col-sm-12 text-right" id="divFooter1" style="display:none;">
							<button type="button" class="btn btn-primary" id="btnSubmit" style="width: 120px;">저장</button>
							<button type="button" class="btn btn-default" onclick="location.href='/admin/member/detail?memId=${param.memId}'" 
								style="background-color: white; border-color: gray; width: 120px;">취소</button>
							<button type="button" class="btn btn-default" id="btnList" onclick="location.href='/admin/member/list'"
								style="background-color: white; border-color: gray; width: 120px;">목록</button>
		                </div>
						<div class="col-sm-12 text-right" id="divFooter2">
							<button type="button" class="btn btn-primary" id="btnEdit" style="width: 120px;">수정</button>
							<button type="button" class="btn btn-default" id="btnDelete" style="background-color: white; border-color: gray; width: 120px;">삭제</button>
							<button type="button" class="btn btn-default" id="btnList" onclick="location.href='/admin/member/list'"
								style="background-color: white; border-color: gray; width: 120px;">목록</button>
						</div>
					</div>
					
							
				</form><!-- // form end -->
			</div>
		</div>
		
	</div>

</div>
	
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	
	//처음 상세보기 화면일 경우 입력란을 읽기전용으로 처리
	$(".memberInput").prop("readonly",true);
	$(".memberSelect").prop("disabled",true);
	
	 var result = $('#memTypeCode option:selected').val();
// 	 alert (result);
	    if (result == '03') {
	      $('.selectAdmin').show();
	      $('.selectProfessor').hide();
	      $('.selectStudent').hide();
	    } else if (result == '02'){
	      $('.selectAdmin').hide();
	      $('.selectProfessor').show();
	      $('.selectStudent').hide();
	    } else{
	      $('.selectAdmin').hide();
	      $('.selectProfessor').hide();
	      $('.selectStudent').show();
	    }
	
	//수정버튼 클릭 시 처리
	$("#btnEdit").on("click",function(){
		//입력란의 읽기전용을 해제
		$(".memberInput").prop("readonly",false);
		$(".memberSelect").prop("disabled",false);
		//버튼 영역 처리
		$("#divFooter1").css("display","block");	//확인 취소
		$("#divFooter2").css("display","none");		//수정 삭제 목록
		//날짜영역처리
		$(".dt").prop("type","date");
		
	});
	
	$('#univDeptNumStd').on("change",function() {
		  
		  var codeVal = $('#univDeptNumStd').val();
		  alert(codeVal);
		  
		  $.ajax({
				type: "post", //요청 메소드 방식
				url:"/admin/member/selectAdvProf",
				data : {codeVal: codeVal},
				dataType:"json", //서버가 요청 URL을 통해서 응답하는 내용의 타입
				success : function(result){
					// 컨트롤로에서 받아온 데이터는 result 에 담겼습니다. 
					//result 는 임의로 변경해서 써도 됩니다. 
					// result 는 json 형태의 데이가로 담겨 있습니다.
					//  우선 alert(result); 나 로그로 데이터를 가져오는지 확인 합니다.
					console.log("result : " + result);
					
					$('#advProf').attr("disabled", false);
					$('#advProf').empty();
					
					var str = "";
					for(var i=0 in result){
						str +="<option value="+result[i].memId+" >"+result[i].name+"</option>";
                   }    
					
					$('#advProf').append(str);
				},
				error : function(xhr, status, error){
					//통신 실패시 발생하는 함수(콜백)
					console.log("xhr:"+xhr+", status:"+ status + ", error:"+error);
				}
			});
		  
		  
	  });//univDeptNum
	
	$("#btnSubmit").click(function() {
		
		if($("#name").val()==""){
			alert("이름을 입력하세요.");
			$("#name").focus();
			return;
		}
		if($("#resRgstNum").val()==""){
			alert("주민등록번호를 입력하세요.");
			$("#resRgstNum").focus();
			return;
		}
		if($("#phNum").val()==""){
			alert("연락처를 입력하세요.");
			$("#phNum").focus();
			return;
		}
		
		$("#memberFrm").submit();
	});//end btnSubmit
	
	//삭제 버튼 클릭 후 멤버 삭제 처리
	$("#btnDelete").on("click",function(){
		
		var input = confirm("삭제하시겠습니까?");
		
		if(input){//true
			$("#memberFrm").attr("action", "/admin/member/delete").submit();
		}else{//false
			return;
		}
	});
	
});




</script>
