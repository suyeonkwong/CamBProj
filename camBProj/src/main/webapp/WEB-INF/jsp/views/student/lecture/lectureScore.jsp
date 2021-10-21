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
					<h6 class="m-0 font-weight-bold text-primary">성적 확인</h6>
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
											<form:form commandName="lectureOpenFormVO" action="/student/lecture/lectureScore" id="frm" name="frm" class="form-horizontal">
												
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
						<c:if test="${lectureScoreList == '[]'}">
							<div class="col-lg-12 text-center">
								<img alt="빈 페이지" src="/resources/img/page/empty.png" style="height: 490px;">
								<p>신청 내역이 없습니다</p>
							</div>
						</c:if>
						<!-- 이수구분(전공, 교양 등), 분반, 과목명, 학점, 담당교수, 강의시간, 강의실, 수업계획서 -->
						<c:if test="${lectureScoreList != '[]'}">
							<c:forEach var="row" items="${lectureScoreList}" varStatus="stat">
								<div class="col-12" id="accordion${stat.index}">
					                <div class="card text-black shadow">
					                    <div class="card-header">
					                    	 <a class="d-block w-100 collapsed" data-toggle="collapse" href="#ROW${row.lectOpenNum}" aria-expanded="false">
					                            <h5 class="card-title" style="margin-bottom: 0px;">
					                                ${row.lectName} <i class="far fa-angle-down"></i>
					                            </h5>
				                            </a>
				                        </div>
					                    <div id="ROW${row.lectOpenNum}" class="collapse" data-parent="#accordion${stat.index}" style="">
					                        <div class="card-body">
					                           	<table class="table">
					                           		<colgroup>
					                           			<col width="80px;">
					                           			<col width="80px;">
					                           			<col width="80px;">
					                           			<col width="80px;">
					                           			<col width="80px;">
					                           			<col width="80px;">
					                           			<col width="80px;">
					                           			<col width="80px;">
					                           		</colgroup>
					                           		<thead>
						                           		<tr>
						                           			<th></th>
						                           			<th>중간고사</th>
						                           			<th>기말고사</th>
						                           			<th>출석</th>
						                           			<th>과제</th>
						                           			<th>퀴즈</th>
						                           			<th>토론</th>
						                           			<th>기타</th>
						                           		<tr>
					                           		</thead>
					                           		<tbody class="text-center">
						                           		<tr>
						                           			<th class="defaultTh">기준</th>
						                           			<td>${row.midReflectPer}</td>
						                           			<td>${row.finalReflectPer}</td>
						                           			<td>${row.attendReflectPer}</td>
						                           			<td>${row.assignRelectPer}</td>
						                           			<td>${row.quizReflectPer}</td>
						                           			<td>${row.debateReflectPer}</td>
						                           			<td>${row.otherReflectPer}</td>
						                           		<tr>
						                           		<tr>
						                           			<td class="defaultTh">점수</td>
						                           			<td>${row.midSc}</td>
						                           			<td>${row.finalSc}</td>
						                           			<td>${row.attendSc}</td>
						                           			<td>${row.assignSc}</td>
						                           			<td>${row.quizSc}</td>
						                           			<td>${row.debateSc}</td>
						                           			<td>${row.otherSc}</td>
						                           		<tr>
						                           		<tr>
						                           			<th class="defaultTh">계</th>
						                           			<th class="grayTh">등급</th>
						                           			<td>${row.rating}</td>
						                           			<th class="grayTh">평점</th>
						                           			<td>${row.score}</td>
						                           			<th class="grayTh">총점</th>
						                           			<td>${row.totalScore}</td>
						                           			<td colspan="5">
<%-- 						                           				<button type="button" class="btn btn-sm btn-info" data-toggle="modal" data-target="#myModal" onclick="fn_showSyllabus('${row.lectOpenNum}');">이의 신청</button> --%>
						                           			</td>
						                           		<tr>
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
		<!-- // 신청 목록 테이블 끝 -->
	
		<!-- 신청 목록 시간표 시작 -->
		<div class="col-sm-4">
			<div class="card mb-4 py-3 border-left-primary">
				<div class="card-body">
					<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800 text-center" style="padding-bottom: 10px;">성적 그래프</div>
					
					<div style="margin-top: 30px;" id="chartDiv">
						<canvas id="myChart" width="400" height="400"></canvas>
					</div>
					
					<div id="alertDiv" style="display: none;">
						<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800 text-center" style="margin-top: 30px;">
							<span class="text-info">표시할 성적이 존재하지 않습니다</span>
						</div>
					</div>

				</div>
			</div>
		</div>
		<!-- // 신청 목록 시간표 끝 -->
	</div>

</div>

<script>

	var jsonLectureScoreList = ${jsonLectureScoreList};
	
	$(function() {
		
		console.log(jsonLectureScoreList);
		
		// 셀렉트 박스로 선택한 학기 보여주기
		var yearAndSemCode = '${lectureOpenFormVO.searchLectureOpenVO.year}' + '년 ' + '${lectureOpenFormVO.searchLectureOpenVO.semCode}' + '학기';
		$("#yearAndSem option[value='"+yearAndSemCode+"']").prop('selected', true);
		
		
		// 학기의 성적 값 가져오기
		$("#yearAndSem").on("change", function () {
			// year, semCode 입력하기 2021년 1학기
			var year = this.value.substr(0, 4);
			var semCode = this.value.substr(6, 1);
			$("#yearSubmit").val(year);
			$("#semCode").val(semCode);
			$("#frm").submit();
		});
		
		// 차트 그리기
		fn_makeChart();
		
	});
	
	// 차트 그리기
	function fn_makeChart() {
		var lectList = new Array();
		var scoreList = new Array();
		
		for(i in jsonLectureScoreList){
			lectList.push(jsonLectureScoreList[i].lectName);
			scoreList.push(jsonLectureScoreList[i].score);
		}
		
		if(lectList.length == 0){ // 성적이 없으면 
			$("#chartDiv").css("display", "none");
			$("#alertDiv").css("display", "block");
		}else {
			$("#chartDiv").css("display", "block");
			$("#alertDiv").css("display", "none");
		}
		
		var ctx = document.getElementById('myChart');
		
		var myChart = new Chart(ctx, {
		    type: 'radar',
		    data: {
		      labels: lectList,
		      datasets: [
		        {
		          label: '평점',
		          fill: true,
		          backgroundColor: "rgba(255,99,132,0.2)",
		          borderColor: "rgba(255,99,132,1)",
		          pointBorderColor: "#fff",
		          pointBackgroundColor: "rgba(255,99,132,1)",
		          pointBorderColor: "#fff",
		          data: scoreList
		        }
		      ]
		    },
		    options: {
		    	scale: {
	    	      ticks: {
	    	        beginAtZero: true,
	    	        max: 4.5,
	    	        min: 0,
	    	        stepSize: 0.5
	    	      }
		    	}
		    }
		});
	}
	
</script>
