<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
.table th {
	padding: 0.50rem;
	vertical-align: middle;
}

.table td {
	padding: 0.40rem;
	vertical-align: middle;
}

label, input {
	margin: 0px;
}

label {
	font-size: 0.8em;
	font-weight: bold;
}

.upper-card {
	height: 90px;
}

.down-card {
	height: 300px;
	overflow: auto;
}

#btnDiv {
	display: flex;
	align-items: center;
	padding-top: 8px;
}

.checkbox-inline {
	margin-right: 30px;
}

.grayTr {
	background-color: #F0F0F0;
	color: #505050;
}

.btnSns {
	width: 46px;
}

</style>

<div id="body">

	<p class="mb-4">
		<span id="info"></span>
	</p>


	<div class="row">
		<!-- 신청 목록 테이블 시작 -->
		<div class="col-sm-8">
		
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">강의 평가</h6>
				</div>
				
				<div class="card-body">

					<!-- 검색, 상태요약 시작 -->
					<div class="row">
						<!-- 검색 시작 -->
						<div class="col-sm-12">
							<div class="card mb-4 py-3 border-left-primary">
								<div class="card-body upper-card" style="padding: 4px 30px;">
									<div class="row">
										<!--  form -->
										<div class="form-group col-sm-3">
											<form:form commandName="lectureOpenFormVO" action="/student/lecture/lectureEval" id="frm" name="frm" class="form-horizontal">
												
												<form:label path="lectureOpenVO.year">학기</form:label>
												<form:select path="lectureOpenVO.year" class="form-control" id="yearAndSem">
								                    <form:options items="${yearAndSemList}" itemLabel="yearAndSem" itemValue="yearAndSem"/>
								                </form:select>
								                
												<form:hidden path="searchLectureOpenVO.year" id="yearSubmit" />
												<form:hidden path="searchLectureOpenVO.semCode" id="semCode" />
												<form:hidden path="searchLectureOpenVO.pageNo" id="pageNo" />
												<form:hidden path="lectureOpenVO.lectOpenNum" id="lectOpenNum" />
												<form:hidden path="lectureOpenVO.saveToken" id="saveToken" />
											</form:form>
										</div><!-- // 검색 끝 -->
										<!-- 상태 요약 -->
										<div class="col-sm-9">
											<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800" style="margin-top: 30px;">
												<span class="text-info">${registrationLectureCount}</span> 과목
												<span class="text-info">${credSum}</span> 학점을 수강하였습니다 
											</div>
										</div>
									</div>
								</div>
							</div>
						</div><!-- // 상태 요약 끝 -->
					</div><!-- // 검색, 상태요약 끝 -->

					<div class="row">
						<c:if test="${registrationLectureList == '[]'}">
							<div class="col-lg-12 text-center">
								<img alt="빈 페이지" src="/resources/img/page/empty.png" style="height: 490px;">
								<p>신청 내역이 없습니다</p>
							</div>
						</c:if>
						<c:if test="${registrationLectureList != '[]'}">
							<c:forEach var="row" items="${registrationLectureList}" varStatus="stat">
								<div class="col-12" id="accordion${stat.index}">
					                <div class="card text-black shadow">
					                    <div class="card-header">
					                    	 <a class="d-block w-100 collapsed" data-toggle="collapse" href="#ROW${row.lectOpenNum}" aria-expanded="false">
					                            <h5 class="card-title" style="margin-bottom: 0px;" id="${row.lectOpenNum}">
					                                ${row.lectName}
					                                <span style="margin-left: 20px; font-weight: normal; display: none;" class="badge badge-primary">평가 완료</span> 
					                                <span style="margin-left: 20px; font-weight: normal;" class="badge badge-warning">평가 미완료</span> 
					                            </h5>
					                            
				                            </a>
				                        </div>
					                    <div id="ROW${row.lectOpenNum}" class="collapse" data-parent="#accordion${stat.index}" style="">
					                        <div class="card-body">
					                           	<table class="table">
					                           		<colgroup>
					                           			<col width="50px;">
					                           			<col width="80px;">
					                           			<col width="50px;">
					                           			<col width="80px;">
					                           			<col width="50px;">
					                           			<col width="80px;">
					                           		</colgroup>
					                           		<tbody>
						                           		<tr>
						                           			<th class="defaultTh">강의 명</th>
						                           			<td>${row.lectName}</td>
						                           			<th class="defaultTh">강의 번호</th>
						                           			<td>${row.lectOpenNum}</td>
						                           			<th class="defaultTh">분반</th>
						                           			<td>${row.divideNum}</td>
						                           		<tr>
						                           		<tr>
						                           			<th class="defaultTh">담당 교수</th>
						                           			<td>${row.name}</td>
						                           			<th class="defaultTh">학과</th>
						                           			<td>${row.univDeptName}</td>
						                           			<th class="defaultTh">이수 구분</th>
						                           			<td>${row.subjTypeCodeName}</td>
						                           		<tr>
						                           		<tr>
						                           			<th class="defaultTh">강의 시간</th>
						                           			<td>${row.lectTime}</td>
						                           			<th class="defaultTh">강의실</th>
						                           			<td>${row.roomIdnName}</td>
						                           			<th class="defaultTh">학점</th>
						                           			<td>${row.cred}</td>
						                           		<tr>
						                           		<tr>
						                           			<th class="defaultTh">강의 계획서</th>
						                           			<td><button type="button" class="btn btn-sm btn-info" data-toggle="modal" data-target="#myModal" onclick="fn_showSyllabus('${row.lectOpenNum}');">강의 계획서</button></td>
						                           			<th class="defaultTh">강의 평가</th>
						                           			<td><button type="button" class="btn btn-sm btn-info" data-toggle="modal" data-target="#lectureEvalForm" onclick="fn_showEvalForm(${stat.index})">강의 평가</button></td>
						                           			<th class="defaultTh" >강의 평가 일자</th>
						                           			<td id="DATE${row.lectOpenNum}"> - </td>
						                           		</tr>
					                           		</tbody>
					                          	</table>
					                        </div>
					                    </div>
					                </div>
					            </div>
				            </c:forEach>
                         </c:if>
					</div>
				</div>
			</div>
		</div>
		<!-- //  목록 테이블 끝 -->
		
		<!-- 차트 시작 -->
		<div class="col-sm-4">
			<div class="card mb-4 py-3 border-left-primary">
				<div class="card-body">
					<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800 text-center" style="padding-bottom: 10px;"><span class="text-info" id="lectEvalCnt"></span> 개의 강의 평가를 완료하였습니다 </div>
					<div id="chartDiv">
						<canvas id="myChart" width="400" height="400"></canvas>
					</div>
				</div>
			</div>
		</div>
		<!-- // 차트 시간표 끝 -->
	</div>

	<jsp:include page="../registrationLecture/syllabus.jsp"></jsp:include>
	<jsp:include page="lectureEvalForm.jsp"></jsp:include>

</div>

<script>

	var jsonRegistrationLectureList = ${jsonRegistrationLectureList};
	var lectureEvalInfoList = ${lectureEvalInfoList};
	
	
	$(function() {
		
		// 셀렉트 박스로 선택한 학기 보여주기
		var yearAndSemCode = '${lectureOpenFormVO.searchLectureOpenVO.year}' + '년 ' + '${lectureOpenFormVO.searchLectureOpenVO.semCode}' + '학기';
		$("#yearAndSem option[value='"+yearAndSemCode+"']").prop('selected', true);
		
		$("#yearAndSem").on("change", function () {
			// year, semCode 입력하기 2021년 1학기
			var year = this.value.substr(0, 4);
			var semCode = this.value.substr(6, 1);
			$("#yearSubmit").val(year);
			$("#semCode").val(semCode);
			$("#frm").submit();
		});
		
		// 평가 정보 보여주기 
		showEvalInfo();
		
		// 차트 보여주기
		var ctx = document.getElementById('myChart');
		var lectEvalCnt = parseInt(lectureEvalInfoList[0].countAnswer);
		var lectCnt = parseInt("${registrationLectureCount}");
		
		if(lectCnt == 0){
			$("#chartDiv").css("display", "none");
		}else{
			$("#chartDiv").css("display", "block");
		}
		
		var myChart = new Chart(ctx, {
		    type: 'doughnut',
		    data: {
		      labels: ['완료', '미완료']
		      ,datasets: [{
		          label: '완료도',
		          data: [lectEvalCnt, lectCnt-lectEvalCnt],
		          backgroundColor: [
		            'rgb(54, 162, 235)',
		            'rgb(255, 205, 86)'
		          ],
		          hoverOffset: 4
		       }]
		    }
		});
		
		
		// 직렬화 함수
		jQuery.fn.serializeObject = function() {
		    var obj = null;
		    try {
		        if (this[0].tagName && this[0].tagName.toUpperCase() == "FORM") {
		            var arr = this.serializeArray();
		            if (arr) {
		                obj = {};
		                jQuery.each(arr, function() {
		                    obj[this.name] = this.value;
		                });
		            }//if ( arr ) {
		        }
		    } catch (e) {
		        alert(e.message);
		    } finally {
		    }
		 
		    return obj;
		};
		
	});
	
	function showEvalInfo() {
		var lectEvalCnt = lectureEvalInfoList[0].countAnswer;
		$("#lectEvalCnt").text(lectureEvalInfoList[0].countAnswer);
		
		if(lectEvalCnt == '0'){ // 비어있다면 진행하지 않는다.
			return;							
		}
		
		// 비어있지 않으면 진행한다.
		for(i in jsonRegistrationLectureList){
			
			for(j in lectureEvalInfoList){
			
				if(lectureEvalInfoList[j].lectOpenNum == jsonRegistrationLectureList[i].lectOpenNum){
					// 존재하면 배지를 바꾸고 평가 일자를 입력
					$("#" + jsonRegistrationLectureList[i].lectOpenNum).children()[0].style.display = "inline-block";
					$("#" + jsonRegistrationLectureList[i].lectOpenNum).children()[1].style.display = "none";
					$("#DATE" + jsonRegistrationLectureList[i].lectOpenNum).text(lectureEvalInfoList[j].evalDate);
				}
			}
		}
	}
	
	function fn_showEvalForm(index) {
		var lectOpenNum = jsonRegistrationLectureList[index].lectOpenNum;
		var stdId = '${memberVo.memId}';
		var subjTypeCode = jsonRegistrationLectureList[index].subjTypeCode;
		var lectOpenName = jsonRegistrationLectureList[index].lectName;
		$("#evalLectName").text(lectOpenName);
		
		// 모달 창 초기화
		$("input[type=radio]").prop("checked", false);
		
		$.ajax({
			type:"POST"
			,url:"/student/lecture/getLectureEvalForm"
			,contentType: "application/json; charset=UTF-8"
			,data: JSON.stringify({'lectOpenNum' : lectOpenNum
									, 'stdId' : stdId 
									, 'subjTypeCode' : subjTypeCode})
			,dataType: "json"
			,success: function(data) {
				makeEvalForm(data, lectOpenNum, lectOpenName);
			}
		});	
	}
	
	// 선택한 강의 평가 정보 가져오기
	function makeEvalForm(data, lectOpenNum, lectOpenName) {
		
		
		
		
		var jsonEvalList = JSON.parse(data);
		
		for(i in jsonEvalList){
			$('#Q' + i).text(jsonEvalList[i].evalItemQst);	
			$('#lectEvalItemNum' + i).val(jsonEvalList[i].lectEvalItemNum);			
			$("input[name='lectOpenNum']").val(lectOpenNum);		
			
			// 제출한 값으로 check
			if(jsonEvalList[i].evalItemCode == "01" && jsonEvalList[i].answer != null){ // 객관식이고 제출한 답이 있는 경우
				var answer = jsonEvalList[i].answer; // 값은 1~5까지 되어 있음 
				$("#A" + answer + i).prop("checked", true);
			}else if(jsonEvalList[i].evalItemCode == "02"){
				$("#A6" + i).val(jsonEvalList[i].answer);
			}
		}
		
		// 값이 있으면 수정 불가
		if(jsonEvalList[0].answer != null){
			$("#evalSubmitBtn").css("display", "none");
			$("[name='answer']").prop("disabled", true);
		}else {
			$("#evalSubmitBtn").css("display", "inline-block");
			$("[name='answer']").prop("disabled", false);
		}
		
	}
	
	// 평가 제출
	var formList = new Array();
	function fn_submit() {
		
		if(!fn_validate()){ // validate
			return;
		}
		
		$.ajax({
			type:"POST"
			,url:"/student/lecture/lectureEvalInsert"
			,contentType: "application/json; charset=UTF-8"
			,data: JSON.stringify(formList)
			,dataType: "json"
			,success: function(data) {
				if(data == 'success'){
					alert("강의 평가가 제출되었습니다.");	
					$('#lectureEvalForm').modal("hide");
					location.reload(true);
				}
			}
		});	
	}
	
	function fn_validate() {
		
		var flag = true;
		
		$(".evalForm").each(function(idx, item) {
			if(idx != 6){
				if(!$(item).find('input:radio[name="answer"]').is(':checked')){
					alert("객관식 평가는 필수 입력 항목입니다.");
					flag = false;
					return false;
				}
			}
			formList.push($(item).serializeObject());
		});
		
		return flag;
	}
</script>

