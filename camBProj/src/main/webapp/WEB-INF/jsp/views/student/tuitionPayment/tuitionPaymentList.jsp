<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 
	- 등록금 납부에서 납부 코드에 따라 '납부' 또는 '환불' 버튼 보여주기
 -->

<style>
	.vertical{
		display: flex;
    	align-items: center;
	}
	.vertical div {
		justify-content: center; 
    	align-items: center;
    	margin: auto;
	}
	.modalBody {
		border: 1px solid #E8E8E8;
		height: 550px;
		text-align: center;
		overflow: auto;
	}
	h5{
		margin-top: 30px;
	}
	.date{
		margin: 0px;
	}
	.billTb{
		width: 90%;
		margin: auto;
		margin-bottom: 10px;
	}
	.billTb th {
		background-color: #F0F0F0;
	}
	#stamp{
		height: 50px;
	}
	label, input {
		margin : 0px;
	}
	label {
		font-size: 0.8em;
		font-weight: bold;
	}
	.upper-card {
		height: 90px;
	}
	.h5 {
		text-align: center;
	}
	.marginTop10 {
		margin-top: 5px;	
	}
	.marginBottom10 {
		margin-bottom: 10px;	
	}
</style>

<div id="body">

	<p class="mb-4">
		<span id="info"></span>	
	</p>
	
	<div class="card shadow mb-4">
	
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">등록 내역</h6>
		</div>
		
		<div class="card-body">
		
			<!-- 안내문 (현 학기, 등록금 수납 기간)시작 --> 
			<div class="row">
				<div class="col-sm-6">
					<div class="card mb-4 py-3 border-left-primary">
						<div class="card-body upper-card" >
							<div class="row vertical">	
								<div class="col-sm-12 h5 mb-0 mr-3 font-weight-bold text-gray-800">
									<i class="fas fa-calendar-check text-gray-300 marginBottom10"></i> <span class="text-info">2021 - 2학기 등록금 납부 기간</span> 
									<br /> -
								</div>
							</div>
						</div>
					</div>
				</div><!-- // 안내문 끝 -->
				<!-- 상태 요약 시작 -->
				<div class="col-sm-6">
					<div class="card mb-4 py-3 border-left-primary">
						<div class="card-body upper-card">
							<div class="row vertical">
								<div class="col-sm-4">
									<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">
										<i class="fas fa-user-alt text-gray-300 marginBottom10"></i> <span class="text-info">학사 상태</span>
										
										<c:if test="${studentVo.acadStatCode == null || studentVo.acadStatCode == ''}">
											<c:set var="acadStatCode" value="미등록 신입생"/>
										</c:if>
										<c:if test="${studentVo.acadStatCode != null && studentVo.acadStatCode != ''}">
											<c:set var="acadStatCode" value="${studentVo.acadStatCode}"/>
										</c:if>
										<br />${acadStatCode}
									</div>
								</div>
								<div class="col-sm-4">
									<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">
										<i class="fas fa-check-square text-gray-300 marginBottom10"></i> <span class="text-info">등록 학기</span> 
										<br />${tuitionPaymentCount.cnt04} 학기
									</div>
								</div>
								<div class="col-sm-4">
									<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">
										<i class="fas fa-exclamation-circle text-gray-300 marginBottom10"></i> <span class="text-info">등록금 미납 건수</span> 
										<br /> ${tuitionPaymentCount.cnt01}건
									</div>
								</div> 
							</div>
						</div>
					</div>
				</div><!-- // 상태 요약 끝 -->
			</div><!-- // 검색, 상태요약 끝 -->
			
			<label>총 <span class="text-info">${tuitionPaymentCount.totalCnt}</span> 개의 등록금 고지서 발급 내역이 있습니다. </label>
			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
				<div class="row">
					<div class="col-sm-12">
						<table class="table" id="dataTable" style="width: 100%;" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%;">
							<colgroup>
								<col width="auto;">
								<col width="auto;">
								<col width="auto;">
								<col width="auto;">
								<col width="150px;">
								<col width="150px;">
							</colgroup>
							<thead>
								<tr role="row">
									<th tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" >등록 학기</th>
									<th tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" >등록금</th>
									<th tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" >실 납부금</th>
									<th tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" >납부 여부</th>
									<th tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" >고지서 출력</th>
									<th tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" >등록금 납부</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${tuitionPaymentList == '[]'}">
									<tr>
										<td colspan="6" class="text-center">등록 내역이 없습니다. </td>
									</tr>
								</c:if>
								
								<c:forEach items="${tuitionPaymentList}" var="row">
									
									<!-- 배지 색깔 결정 시작 -->
									<c:if test='${row.payCode == "미납"}'>
										<c:set var="badgeColor" value="badge-warning"/>
									</c:if> 
									<c:if test='${row.payCode == "부분 납부"}'>
										<c:set var="badgeColor" value="badge-secondary"/>
									</c:if> 
									<c:if test='${row.payCode == "과납"}'>
										<c:set var="badgeColor" value="badge-warning"/>
									</c:if>
									<c:if test='${row.payCode == "완납"}'>
										<c:set var="badgeColor" value="badge-light"/>
									</c:if>
									<!-- // 배지 색깔 결정 끝 -->
								
									<tr class="text-center">
										<td>${row.year}-${row.semCode}</td>
										<td class="text-right">
											<fmt:formatNumber type="number" maxFractionDigits="3" value="${row.tuitFee}" /> 원
										</td>
										<td class="text-right">
											<fmt:formatNumber type="number" maxFractionDigits="3" value="${row.actualPayAmt}" /> 원
										</td>
										<td>
											<label class="badge ${badgeColor}" style="font-size: 1em; font-weight: normal;">${row.payCode}</label>
										</td>
										<td class="text-center"> 
											<button type="button" onclick="printBill('${row.year}${row.semCode}');" class="btn btn-sm btn-light" data-toggle="modal" data-target="#printBillModal">
												고지서 출력
											</button>
										</td>
										<td class="text-center"> 
											<button type="button" onclick="printBill('${row.year}${row.semCode}');" class="btn btn-sm btn-info" data-toggle="modal" data-target="#payBillModal">
												등록금 납부
											</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<!-- paging -->	
				<div class="row">
					<div id="paging" class="col-sm-12 text-center">
		        		<ul class="pagination">
					    	<li style="list-style: none;" class="paginate_button page-item previous <c:if test="${paginationInfo.firstPageNoOnPageList <= 5 }">disabled</c:if>">
					        	<a href="/student/tuitionPayment/tuitionPaymentList?pageNo=${paginationInfo.firstPageNoOnPageList - 5 }" data-dt-idx="0" class="page-link">이전</a>
					        </li>
					       
							<c:forEach var="pageNo" begin="${paginationInfo.firstPageNoOnPageList }" end="${paginationInfo.lastPageNoOnPageList }" varStatus="stat">
					        	<li style="list-style: none;" class="paginate_button page-item <c:if test="${pageNo == param.pageNo || (pageNo==1 && param.pageNo ==null)}">active</c:if>">
					            	<a href="/student/tuitionPayment/tuitionPaymentList?pageNo=${pageNo}" data-dt-idx="${pageNo}" class="page-link">${pageNo}</a>
					            </li>
					        </c:forEach>
					       
					        <li style="list-style: none;" class="paginate_button page-item next <c:if test="${paginationInfo.lastPageNoOnPageList == paginationInfo.totalPageCount}">disabled</c:if>">
					          <a href="/student/tuitionPayment/tuitionPaymentList?pageNo=${paginationInfo.lastPageNoOnPageList + 1 }" data-dt-idx="${paginationInfo.lastPageNoOnPageList + 1 }" class="page-link">다음</a>
					        </li>
						</ul>
		        	</div> <!-- //end paging -->
	        	</div>
	        	<hr>
			</div>
		</div>
	</div>
	
	<!-- printBillModal modal 시작 -->
	<div class="modal fade" id="printBillModal" tabindex="-1" role="dialog" aria-labelledby="printBillModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">등록금 고지서 출력</h6>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body" id="printTarget">
					
					<div class="row">
						<div class="col-sm-6 text-center">
							<div class="modalBody">
								<h5>납입 고지서 (수납은행용)</h5>
								<p><span class="year"></span>학년도  <span class="semCode"></span></p>
								<table class="table table-bordered dataTable billTb">
									<tbody>
										<tr>
											<th>대학</th>
											<td><span class="univNum"></span></td>
											<th>학부</th>
											<td colspan="3"><span class="univDeptNum"></span></td>
										</tr>
										<tr>
											<th>학번</th>
											<td>${sessionScope.memberVo.memId}</td>
											<th>학년</th>
											<td><span class="grade"></span></td>
											<th>성명</th>
											<td>${sessionScope.memberVo.name}</td>
										</tr>
										<tr>
											<th colspan="2">입학금</th>
											<th colspan="2">등록금</th>
											<th colspan="2">장학금</th>
										</tr>
										<tr class="text-right">
											<td colspan="2"><span class="admFee"></span></td>
											<td colspan="2"><span class="tuitFee"></span></td>
											<td colspan="2"><span class="scholaAmt"></span></td>
										</tr>
										<tr>
											<th colspan="2">실 납입 금액</th>
											<td colspan="4" class="text-right"><span class="actualPayAmt"></span></td>
										</tr>
										<tr>
											<th colspan="2">가상 계좌</th>
											<td colspan="4"><span class="bankCode"></span> <span class="vrtAccntNum"></span></td>
										</tr>
										<tr>
											<th colspan="2">납부 일자</th>
											<td colspan="4"><span class="payDate"></span></td>
										</tr>
									</tbody>
								</table>
								<div style="margin-top: 20px;">
									<span style="font-size: 1.5em;">대학교 총장</span>
									<img alt="대학 도장" src="/resources/img/stamp.png" id="stamp">
								</div>
							</div>
						</div>
						<div class="col-sm-6 text-center">
							<div class="modalBody">
								<h5>영수증 (학생보관용)</h5>
								<p><span class="year"></span>학년도   <span class="semCode"></span></p>
								<table class="table table-bordered dataTable billTb">
									<tbody>
										<tr>
											<th>대학</th>
											<td><span class="univNum"></span></td>
											<th>학부</th>
											<td colspan="3"><span class="univDeptNum"></span></td>
										</tr>
										<tr>
											<th>학번</th>
											<td>${sessionScope.memberVo.memId}</td>
											<th>학년</th>
											<td><span class="grade"></span></td>
											<th>성명</th>
											<td>${sessionScope.memberVo.name}</td>
										</tr>
										<tr>
											<th colspan="2">입학금</th>
											<th colspan="2">등록금</th>
											<th colspan="2">장학금</th>
										</tr>
										<tr class="text-right">
											<td colspan="2"><span class="admFee"></span></td>
											<td colspan="2"><span class="tuitFee"></span></td>
											<td colspan="2"><span class="scholaAmt"></span></td>
										</tr>
										<tr>
											<th colspan="2">실 납입 금액</th>
											<td colspan="4" class="text-right"><span class="actualPayAmt"></span></td>
										</tr>
										<tr>
											<th colspan="2">가상 계좌</th>
											<td colspan="4"><span class="bankCode"></span> <span class="vrtAccntNum"></span></td>
										</tr>
										<tr>
											<th colspan="2">납부 일자</th>
											<td colspan="4"><span class="payDate"></span></td>
										</tr>
									</tbody>
								</table>
								<div style="margin-top: 20px;">
									<span style="font-size: 1.5em;">대학교 총장</span>
									<img alt="대학 도장" src="/resources/img/stamp.png" id="stamp">
								</div>
							</div>
						</div>
					</div>
					
				</div>
				<div class="modal-footer">
					<button type="button" onclick="onPrint('printTarget');" class="btn btn-primary">출력</button>
					<button type="button" class="btn btn-light" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- // printBillModal modal 끝 -->
	
	<!-- payBillModal modal 시작 -->
	<div class="modal fade" id="payBillModal" tabindex="-1" role="dialog" aria-labelledby="payBillModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">등록금 납부</h6>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					
					<div class="row">
						<div class="col-sm-12 text-center">
							<div>
								<h5>납부 정보</h5>
								<p><span class="year"></span>학년도   <span class="semCode"></span></p>
								<table class="table table-bordered dataTable billTb">
									<tbody>
										<tr>
											<th colspan="2">입학금</th>
											<th colspan="2">등록금</th>
											<th colspan="2">장학금</th>
										</tr>
										<tr class="text-right">
											<td colspan="2"><span class="admFee"></span></td>
											<td colspan="2"><span class="tuitFee"></span></td>
											<td colspan="2"><span class="scholaAmt"></span></td>
										</tr>
										<tr>
											<th colspan="2">실 납입 금액</th>
											<td class="text-right" colspan="4"><span class="actualPayAmt"></span></td>
										</tr>
										<tr>
											<th colspan="2">가상 계좌</th>
											<td colspan="4"><span class="bankCode"></span> <span class="vrtAccntNum"></span></td>
										</tr>
										<tr>
											<th colspan="2">납부 상태</th>
											<td colspan="4"><span class="payCode"></span></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div style="width: 90%; margin: auto;">
						<form action="/student/tuitionPayment/tuitionPaymentUpdate" method="post" id="frmPay">
							<input type="hidden" name="stdId" value="${sessionScope.memberVo.memId}"/>
							<input type="hidden" name="vrtAccntNum" id="vrtAccntNum"/>
							<input type="hidden" name="year" id="year"/>
							<input type="hidden" name="semCode" id="semCode"/>
							<div class="input-group" id="divPay">
								<input type="text" class="form-control bg-light border-0 small" id="actualPayAmtInput" aria-describedby="basic-addon2" maxlength="20" style="text-align: right" readonly/>
								<input type="hidden" name="actualPayAmt" id="actualPayAmtHidden"/>
								<div class="input-group-append"> 
									<button class="btn btn-primary" type="button" id="btnPay">납부</button>
								</div>
							</div>
							<div class="text-right"  id="divRefund" style="margin-top: 10px;">
								<button type="button" class="btn btn-secondary">환불</button>
							</div>
	                    </form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-light" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- // payBillModal modal 끝 -->

</div> <!-- // body 끝 -->

<script type="text/javascript">
	
	$(function() {
		$("#btnPay").on("click", function () {
			$("#frmPay").submit();
		});
		
	});
	
	function printBill(yearSemCode) {
		var year = yearSemCode.substr(0, 4);
		var semCode = yearSemCode.substr(4, 1);
		var stdId = '${sessionScope.memberVo.memId}'

		// ajax로 요청해서 상세 정보 가져오기
		$.ajax({
			type : "POST",
			url : "/student/tuitionPayment/tuitionPaymentBillDetail",
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify({
				'year' : year,
				'semCode' : semCode,
				'stdId' : stdId
			}),
			dataType : "json",
			success : function(data) {
				makeBill(data);
			}
		});
	}

	function makeBill(map) {
		var studentVo = map.studentVo;
		var tuitionPaymentVo = map.tuitionPaymentVo;
		var universityDepartmentVo = map.universityDepartmentVo;
		var scholarshipRecodeVo = map.scholarshipRecodeVo;
		var scholaAmt = numberWithCommas('0');
		if(scholarshipRecodeVo != null){
			scholaAmt = numberWithCommas(scholarshipRecodeVo.scholaAmt);
		}
		$(".scholaAmt").text(scholaAmt);
		$(".year").text(tuitionPaymentVo.year);
		$(".semCode").text(tuitionPaymentVo.semCode);
		$(".univNum").text(universityDepartmentVo.univNum);
		$(".univDeptNum").text(studentVo.univDeptNum);
		$(".grade").text(setGrade(studentVo.rgstSem));
		var admFee = 0;
		if (tuitionPaymentVo.freshmanYn == 'Y') { // 신입생이면 입학금이 있음
			admFee = universityDepartmentVo.admFee;
		}
		$(".admFee").text(numberWithCommas(admFee));
		$(".tuitFee").text(numberWithCommas(universityDepartmentVo.tuitFee));
		$(".actualPayAmt").text(numberWithCommas(tuitionPaymentVo.actualPayAmt));
		$(".bankCode").text(tuitionPaymentVo.bankCode);
		$(".vrtAccntNum").text(tuitionPaymentVo.vrtAccntNum);
		$(".payDate").text(tuitionPaymentVo.payDate);
		$(".payCode").text(tuitionPaymentVo.payCode);
		
		// 등록금 납부할 때 필요한 input값 
		$("#vrtAccntNum").val(tuitionPaymentVo.vrtAccntNum);
		$("#actualPayAmtInput").val(numberWithCommas(tuitionPaymentVo.actualPayAmt));
		$("#actualPayAmtHidden").val(tuitionPaymentVo.actualPayAmt);
		$("#year").val(tuitionPaymentVo.year);
		$("#semCode").val(tuitionPaymentVo.semCode);
		
		// 등록금 납부 시 납부코드에 따라 납부/환불 메뉴 보여주기
		showHideDiv(tuitionPaymentVo.payCode);
	}
	
	function showHideDiv(payCode) {
		if(payCode == '완납'){
			$("#divPay").hide();
			$("#divRefund").hide();
		}else if (payCode == '과납'){
			$("#divPay").show();
			$("#divRefund").show();
		}else {
			$("#divPay").show();
			$("#divRefund").hide();
		}
	}

	function setGrade(rgstSem) {
		var grade = 0;
		if (rgstSem < 3) {
			grade = 1;
		} else if (rgstSem < 5) {
			grade = 2;
		} else if (rgstSem < 7) {
			grade = 3;
		} else {
			grade = 4;
		}
		return grade;
	}

	function numberWithCommas(number) {
		return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + ' 원';
	}
</script>













