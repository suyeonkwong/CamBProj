<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<body>
	<div class="card shadow mb-4" style="width: 98%;">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary" style="cursor: pointer;" onclick="javascript:location.href='/professor/consulting/possibleTimeList'">상담 시간 관리</h6>
		</div>
		
		<div class="card-body">
			<div class="table-responsive">
				<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4" style="width: 99%">
				
					<div class="row">
						<div class="col-sm-12">
						<!-- 게시글 수 -->
						<div style="float:left; margin-top: 5%;">
						<span style="color: black; font-weight: bold; float: left;">총 <span style="color: #C02B55"><fmt:formatNumber value="${paginationInfo.totalRecordCount}" pattern="#,###" /></span>건의 게시물이 있습니다.</span>
						<span style="color: black; font-weight: bold;">[미입력 <span style="color: #C02B55"><fmt:formatNumber value="${consultZeroCount}" pattern="#,###" /></span>건]</span>
						</div>
						
						<form method="get" action="/professor/consulting/possibleTimeList" name="frmSearch" id="frmSearch">
									<input type="hidden" name="inputStatus" value="${param.inputStatus}" id="inputStatus2">
									<button type="submit" class="btn btn-secondary btn-icon-split" style="padding: 3px 8px 3px 8px; float: right; margin-top: 4.3%; margin-left: 1%;" >검색</button>
									<label for="selectAll" style="float: right; margin-top: 4.5%;">전체</label><input type="checkbox" id="selectAll" name="selectAll" style="float: right; margin-top: 4.9%; margin-left: 1%;">
									<input class="form-control" id="endDate" name="endDate" type="date" style="float: right; width: 20%; margin-top: 4%;" value="${param.endDate}">
									<span style="float: right; margin-top: 4.5%; font-weight: bold;">&nbsp;&nbsp; - &nbsp;&nbsp;</span>
									<input class="form-control" type="date" id="startDate" name="startDate" style="float: right; width: 20%; margin-top: 4%;" value="${param.startDate}">
									
							</form>
						<form action="/professor/consulting/timeDelete" method="post" id="timeDelete" name="timeDelete">
							
							<input type="hidden" name="pageNo" value="${param.pageNo}"> 
							<input type="hidden" id="startDateDel" name="startDate" value=""> 
							<input type="hidden" id="endDateDel" name="endDate" value=""> 
							<input type="hidden" id="inputStatusDel" name="inputStatus" value=""> 
							<input type="hidden" id="consultSchdlNum" name="consultSchdlNum" value=""> 
							<table class="table" id="dataTable" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%;  text-align: center;">
								<thead>
									<tr role="row">
										<th class="sorting sorting_asc" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" style="width: 10%;">
											순번
										</th>
										<th class="sorting sorting_asc" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" style="width: 10%;">
											상담 일자
										</th>
										<th class="sorting sorting_asc" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" style="width: 10%;">
											시간
										</th>
										<th class="sorting sorting_asc" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" style="width: 10%;">
											상담 신청 여부
										</th>
										<th class="sorting sorting_asc" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" style="width: 25%;">
											신청 학생
										</th>
										<th class="sorting sorting_asc" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" style="width: 10%;">

										</th>
									</tr>
								</thead>
								
								<tbody>
								<c:forEach var="consultList" items="${consultList}">
									<tr class="trClick">
										<td style="text-align: center;">${consultList.rnum}</td>
										<td style="text-align: center;">${fn:substring(consultList.consultAvlDate,0,10)}</td>
										<td style="text-align: center;">${consultList.startTime}~${consultList.endTime}</td>
										<td style="text-align: center;">
											<c:if test="${!empty consultList.consultNum}">신청</c:if>
											<c:if test="${empty consultList.consultNum}">미신청</c:if>
										</td>
										<td style="text-align: left;">
										<c:if test="${consultList.stdName == '()'}"></c:if> 
										<c:if test="${consultList.stdName != '()'}">${consultList.stdName}</c:if>
										</td>
										<td style="padding: 0px 15px 0px 0px ;">
											<button type="button" class="form-control" style="margin-top: 5px; width: 60%; float: right;" onclick="delTime(${consultList.consultSchdlNum})">삭제</button>
										</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
							</form>
						</div>
					</div>
					<form method="get" action="/professor/consulting/possibleTimeList" name="inputStatusSearch" id="inputStatusSearch">
						<input type="hidden" name="startDate" value="${param.startDate}" id="">
						<input type="hidden" name="endDate" value="${param.endDate}" id="">
						<select id=inputStatus class="form-control" name="inputStatus" style="text-align: center; width: 150px; float: right; margin-bottom: 2px;  padding: 0px;" >
							<option id="checkAll" value="">전체 상담</option>
							<option value="ok"
							<c:if test="${param.inputStatus=='ok'}">selected</c:if>
							>신청 상담</option>
							<option value="no"
							<c:if test="${param.inputStatus=='no'}">selected</c:if>
							>미신청 상담</option>
						</select>
					</form>
					<div class="row">
						<div class="col-sm-12 col-md-5">

						</div>
						<div id="paging" class="col-sm-12-text-center" style="margin-left: 4.3%;">
								<ul class="pagination">
								<!-- previous 시작 -->
						            <c:if test="${paginationInfo.firstPageNoOnPageList > 5 }">
						              <li style="list-style: none;" class="paginate_button page-item previous" id="example2_previous"> 
						            </c:if>
						            <c:if test="${paginationInfo.firstPageNoOnPageList <= 5 }">
						              <li style="list-style: none;" class="paginate_button page-item previous disabled" id="example2_previous"> 
						            </c:if>      
						              <a href="/professor/consulting/possibleTimeList?pageNo=${paginationInfo.firstPageNoOnPageList - 5 }&startDate=${param.startDate}&endDate=${param.endDate}&inputStatus=${param.inputStatus}" aria-controls="example2" data-dt-idx="0" tabindex="0" class="page-link">이전</a>
						            </li>      
						            <!-- previous 끝 -->
						            
									<!-- page번호 시작 -->
									<c:forEach var="pageNo" begin="${paginationInfo.firstPageNoOnPageList }" end="${paginationInfo.lastPageNoOnPageList }" varStatus="stat">
										  <li style="list-style: none;" class="paginate_button page-item <c:if test="${pageNo == param.pageNo || (empty param.pageNo && pageNo == 1)}">active</c:if>">
							                <a href="/professor/consulting/possibleTimeList?pageNo=${pageNo}&startDate=${param.startDate}&endDate=${param.endDate}&inputStatus=${param.inputStatus}" aria-controls="example2" data-dt-idx="${pageNo }" tabindex="0" class="page-link">${pageNo }</a>
							              </li>        
						            </c:forEach> 
						            <!-- page번호 끝 -->
						            
						            <!-- next시작 -->
						            <li style="list-style: none;" class="paginate_button page-item next 
						            <c:if test="${paginationInfo.lastPageNoOnPageList == paginationInfo.totalPageCount}">disabled</c:if> " id="example2_next">
						              <a href="/professor/consulting/possibleTimeList?pageNo=${paginationInfo.lastPageNoOnPageList + 1 }&startDate=${param.startDate}&endDate=${param.endDate}&inputStatus=${param.inputStatus}" aria-controls="example2" data-dt-idx="${paginationInfo.lastPageNoOnPageList + 1 }" tabindex="0" class="page-link">다음</a>
						            </li>       
						            <!-- next끝 -->       
		            			</ul>
	            			</div>
					</div>
					<hr/>
					
						<div class="row" style=" float: right; margin-right: 5px;">
							<a href="/professor/consulting/possibleTimeInsert" class="btn btn-primary btn-icon-split" > 
								<span class="text">상담일 등록</span>
							</a>
					
						
					</div>
							
				</div>
			</div>
		</div>		
	</div>

</body>
<script src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
$("#startDate").change(function () {
	//오늘날짜 20211008 형식으로 구하기
// 	var date = new Date();						
// 	var year = date.getFullYear(); 
// 	var month = (1 + date.getMonth());          
// 		month = month >= 10 ? month : '0' + month; 
// 	var day = date.getDate();                 
// 		day = day >= 10 ? day : '0' + day;
// 	date = year+""+ month+""+day;		
// 	console.log("date : " + date);
// 	var dateInt = parseInt(date);
	
	//종료일자가 비어있는 상태에서 시작일자를 선택시 자동으로 종료일자에 시작일자가 들어가도록 설정
	if($("#endDate").val()==""){
		$("#endDate").val($("#startDate").val());
	}
	var startDateVal = $("#startDate").val();
	startDateVal = startDateVal.replace(/-/gi, ""); 
	
	var endDateVal = $("#endDate").val();
	endDateVal = endDateVal.replace(/-/gi, ""); 
	
	
	var startDateInt = parseInt(startDateVal);
	var endDateValInt = parseInt(endDateVal);
	if((endDateVal-startDateInt)<0 && endDateValInt){
		alert("시작 일자가 종료 일자 이후입니다.");
		$("#endDate").val($("#startDate").val());
		return;
	}
	
	
});
$("#endDate").change(function () {
	//종료일자가 비어있는 상태에서 시작일자를 선택시 자동으로 종료일자에 시작일자가 들어가도록 설정
	if($("#startDate").val()==""){
		$("#startDate").val($("#endDate").val());
	}
	
	var startDateVal = $("#startDate").val();
	startDateVal = startDateVal.replace(/-/gi, ""); 
	
	var endDateVal = $("#endDate").val();
	endDateVal = endDateVal.replace(/-/gi, ""); 
	
	
	var startDateInt = parseInt(startDateVal);
	var endDateValInt = parseInt(endDateVal);
	if((endDateVal-startDateInt)<0 && endDateValInt){
		alert("시작 일자가 종료 일자 이후입니다.");
		$("#startDate").val($("#endDate").val());
		return;
	}
	
	
});
$(function () {
	$('#inputStatus').on('change', function() {
		$("#inputStatusSearch").submit();
	});
	
	$("#selectAll").click(function() {
		var checkTest = $("input:checkbox[id=selectAll]").is(":checked");
		if(checkTest == true){
			$("#startDate").prop("disabled",true);
			$("#endDate").prop("disabled",true);
			$("#startDate").val("");
			$("#endDate").val("");
			$("#inputStatus2").val("");
		}else{
			$("#startDate").prop("disabled",false);
			$("#endDate").prop("disabled",false);
			$("#inputStatus").prop("disabled",false);
		}
	});
	
	
});
var consultList2Length =0;
var arrConTime = [];
<c:forEach var="consultList2" items="${consultList2}" varStatus="stat">
 	consultList2Length = "${stat.index}";
 	arrConTime[consultList2Length] = "${consultList2.consultSchdlNum}";
</c:forEach>

function delTime(consultSchdlNum) {
	var result = confirm('시간을 삭제하시겠습니까?');
	console.log(arrConTime);
	if(result){
		for(var i=0; i<=consultList2Length; i++){
			if(consultSchdlNum == arrConTime[i]){
				alert("이미 상담이 접수된 상담 시간은 삭제가 불가능합니다");
				return;
			}
		}
		
		
		
		$("#consultSchdlNum").val(consultSchdlNum);
		$("#startDateDel").val($("#startDate").val());
		$("#endDateDel").val($("#endDate").val());
		$("#inputStatusDel").val($("#inputStatus").val());
		$("#timeDelete").submit();					
	}else{ //if(result) 끝 		
		return;
	}
}
</script>


</html>