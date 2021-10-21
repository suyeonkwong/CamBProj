<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<style>
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
	.marginTop20 {
		margin-top: 20px;	
	}
	.marginTop10 {
		margin-top: 12px;	
	}
</style>

<div id="body">

	<p class="mb-4">
	</p>
	
	<div class="card shadow mb-4">
	
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">결재 내역</h6>
		</div>
		
		<div class="card-body">
		
			<!-- 검색, 상태요약 시작 -->
			<div class="row">
				<!-- 상태 요약 시작 -->
				<div class="col-sm-12">
					<div class="card mb-4 py-3 border-left-primary">
						<div class="card-body upper-card">
							<div class="row marginTop10">
								<div class="col-sm-4">
									<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">
										<i class="fas fa-spinner text-gray-300"></i> 접수 <span class="text-info">${authDocInfoCountForStep.cnt01}</span> 건
									</div>
								</div>
								<div class="col-sm-4">
									<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">
										<i class="fas fa-check-circle text-gray-300"></i> 승인 <span class="text-info">${authDocInfoCountForStep.cnt02}</span> 건
									</div>
								</div>
								<div class="col-sm-4">
									<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">
										<i class="fas fa-times-circle text-gray-300"></i> 미승인 <span class="text-info">${authDocInfoCountForStep.cnt03}</span> 건
									</div>
								</div>
							</div>
						</div>
					</div>
				</div><!-- // 상태 요약 끝 -->
			</div><!-- // 검색, 상태요약 끝 -->
			
			<div class="row">
				<div class="col-sm-8" style="padding-top: 40px;">
					<label>총 <span class="text-info">${totalCount}</span> 개의 결재 문서가 있습니다. </label>
				</div>
				<div class="col-sm-4 text-right">
					<form class="" action="/auth/authDocListForSteps" method="post" id="frmSearch">
						<div class="row marginTop20">
							<div class="form-group col-sm-4">
								<select class="form-control" name="searchCondition" id="searchCondition">
									<option value="authDocNum" <c:if test="${authDocVo.searchCondition=='authDocNum'}">selected</c:if>>결재번호</option>
									<option value="authDocFormNum" <c:if test="${authDocVo.searchCondition=='authDocFormNum'}">selected</c:if>>결재종류</option>
									<option value="procStatCode" <c:if test="${authDocVo.searchCondition=='procStatCode'}">selected</c:if>>처리상태</option>
								</select>
							</div>
							<div class="form-group col-sm-6 " id="inputType1" style="padding: 0px;">
								<input type="text" class="form-control bg-light small" id="keyword1"/>
							</div>
							<div class="form-group col-sm-6" id="inputType2" style="display: none; padding: 0px;">
								<select class="form-control" id="keyword2">
									<c:forEach var="code" items="${codeList}">
										<option value="${code.codeVal}" <c:if test="${authDocVo.searchKeyword==code.codeVal}">selected</c:if>>${code.codeName}</option>
									</c:forEach>	                	
			                	</select>
							</div>
							<div class="form-group col-sm-2">
								<input type="hidden" name="searchKeyword" id="searchKeyword"/>
			                	<button type="button" class="btn btn-primary" id="btnSearch">검색</button>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
				<div class="row">
					<div class="col-sm-12">
						<table class="table" id="dataTable" style="width: 100%;" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%;">
							<thead>
								<tr role="row">
									<th tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" >결재번호</th>
									<th tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" >결재종류</th>
									<th tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" >수신일자</th>
									<th tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" >처리일자</th>
									<th tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" >처리상태</th>
									<th tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" >결재상태</th>
								</tr>
							</thead>
							<tbody class="text-center">
								<c:if test="${authDocList=='[]'}">
									<tr class="text-center">
										<td colspan="6">결재 내역이 없습니다. </td>
									</tr>
								</c:if>
								
								<c:forEach items="${authDocList}" var="row">
								
									<!-- procStatCode 배지 색깔 결정 시작 -->
									<c:if test='${row.procStatCode == "접수"}'>
										<c:set var="badgeColor1" value="badge-warning"/>
									</c:if> 
									<c:if test='${row.procStatCode == "승인"}'>
										<c:set var="badgeColor1" value="badge-light"/>
									</c:if> 
									<c:if test='${row.procStatCode == "미승인"}'>
										<c:set var="badgeColor1" value="badge-secondary"/>
									</c:if>
									<!-- // procStatCode 배지 색깔 결정 끝 -->
									
									<!-- authStatCode 배지 색깔 결정 시작 -->
									<c:if test='${row.authStatCode == "접수"}'>
										<c:set var="badgeColor2" value="badge-warning"/>
									</c:if> 
									<c:if test='${row.authStatCode == "상신"}'>
										<c:set var="badgeColor2" value="badge-light"/>
									</c:if> 
									<c:if test='${row.authStatCode == "결재 완료"}'>
										<c:set var="badgeColor2" value="badge-secondary"/>
									</c:if>
									<!-- // authStatCode 배지 색깔 결정 끝 -->
									
									<tr onclick="location.href='/auth/authDocDetailForSteps?authDocNum=${row.authDocNum}'" class="trClick">
										<td>${row.authDocNum}</td>
										<td>${row.authDocFormNum}</td>
										<td>${row.updateDate}</td>
										<td>
											<c:if test="${row.authDate == null}"> - </c:if>
											<c:if test="${row.authDate != null}">${row.authDate}</c:if>
										</td>
										<td>
											<label class="badge ${badgeColor1}" style="font-size: 1em; font-weight: normal;">${row.procStatCode}</label>
										</td>
										<td>
											<label class="badge ${badgeColor2}" style="font-size: 1em; font-weight: normal;">${row.authStatCode}</label>
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
					        	<a href="/auth/authDocListForSteps?pageNo=${paginationInfo.firstPageNoOnPageList - 5 }" data-dt-idx="0" class="page-link">이전</a>
					        </li>
					       
							<c:forEach var="pageNo" begin="${paginationInfo.firstPageNoOnPageList }" end="${paginationInfo.lastPageNoOnPageList }" varStatus="stat">
					        	<li style="list-style: none;" class="paginate_button page-item <c:if test="${pageNo == param.pageNo || (pageNo==1 && param.pageNo ==null)}">active</c:if>">
					            	<a href="/auth/authDocListForSteps?pageNo=${pageNo}" data-dt-idx="${pageNo}" class="page-link">${pageNo }</a>
					            </li>
					        </c:forEach>
					       
					        <li style="list-style: none;" class="paginate_button page-item next <c:if test="${paginationInfo.lastPageNoOnPageList == paginationInfo.totalPageCount}">disabled</c:if>">
					          <a href="/auth/authDocListForSteps?pageNo=${paginationInfo.lastPageNoOnPageList + 1 }" data-dt-idx="${paginationInfo.lastPageNoOnPageList + 1 }" class="page-link">다음</a>
					        </li>
						</ul>
		        	</div> <!-- //end paging -->
	        	</div>
	        	
			</div>
					
		</div>
		
	</div>

</div>

<script>
	$(function() {
		searchConditionCheck(); // 화면이 로딩될 때마다 select 옵션 변경
		
		// select 옵션 바뀔 때마다 변경
		$("#searchCondition").on("change", function() {
			searchConditionCheck();
		});
		
		// 검색 
		$("#btnSearch").on("click", function() {
			var selectedOpt = $('#searchCondition option:selected').val();
			 
			 if(selectedOpt=='authDocNum'){
				 $("#searchKeyword").val($("#keyword1").val());
			 }else{
				 $("#searchKeyword").val($("#keyword2").val());
			 }
			 
			 console.log("1. " + $("#searchKeyword").val());
			 console.log("2. " + selectedOpt);
			 $("#frmSearch").submit();
		});
		
		// 검색 키워드 넣어주기
		searchKeywordCheck();
	});
	
	// 검색 조건에 검색 키워드 select 옵션 변경
	function searchConditionCheck () {
		var selectedOpt = $('#searchCondition option:selected').val();
		 if(selectedOpt=='authDocNum'){
			 $("#inputType1").css("display", "block");
			 $("#inputType2").css("display", "none");
		 }else{
			 $("#inputType1").css("display", "none");
			 $("#inputType2").css("display", "block");
			 // 셀렉트 박스에 코드 리스트 넣기
			 setCodeList(selectedOpt);
		 }
	}
	
	function searchKeywordCheck() {
		var selectedOpt = $('#searchCondition option:selected').val();
		 if(selectedOpt=='authDocNum'){
			 $("#keyword1").val('${authDocVo.searchKeyword}');
		 }
	}
	
	function setCodeList(selectedOpt) {
		
		var optionHtml = "<option value='' <c:if test='${authDocVo.searchKeyword==code.codeVal}'>selected</c:if>>전체</option>";
		if(selectedOpt=='authDocFormNum'){	
			<c:forEach items='${authDocFormNumCodeList}' var='code'>
				optionHtml += "<option value='${code.codeVal}' <c:if test='${authDocVo.searchKeyword==code.codeVal}'>selected</c:if>>${code.codeName}</option>";
			</c:forEach>
		 }else if(selectedOpt=='procStatCode'){
			 <c:forEach items='${procStatCodeList}' var='code'>
			 	optionHtml += "<option value='${code.codeVal}' <c:if test='${authDocVo.searchKeyword==code.codeVal}'>selected</c:if>>${code.codeName}</option>";
			</c:forEach>
		 }else{
			 <c:forEach items='${authStatCodeList}' var='code'>
			 	optionHtml += "<option value='${code.codeVal}' <c:if test='${authDocVo.searchKeyword==code.codeVal}'>selected</c:if>>${code.codeName}</option>";
			</c:forEach>
		 }
		
		$("#keyword2").empty();
		$("#keyword2").append(optionHtml);
	}
</script>
