<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	#docDiv {
		overflow: auto;
	}
</style>

<div id="body">

	<p class="mb-4">
	</p>
	
	<div class="row">
		<div class="col-sm-8">
			<!-- 결재 문서 -->
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">결재 기안 문서</h6>
				</div>
				
				<div class="card-body" id="docDiv">
					<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4 text-center" >
						<jsp:include page="${authDocVo.authDocFormPath}">
							<jsp:param name="authDocVo" value="${authDocVo}"/>
							<jsp:param name="applyVo" value="${applyVo}"/>
							<jsp:param name="authDetailInfoVoList" value="${authDetailInfoVoList}"/>
						</jsp:include>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-4">
			<!-- 결재 정보 및 승인 처리 -->
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">결재</h6>
				</div>
				
				
				<div class="card-body">
					<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
						<form action="/auth/authDocUpdate" method="post" id="frm">
							<!-- 결재자만 설정할 수 있고, 나머지 결재 스탭 교직원은 열람만 가능 -->
							<!-- 결재선 고르기 -->
							<div class="form-group">
								<div class="text-center" style="margin-bottom: 10px;">
								
									<c:if test="${authDocVo.authDocFormNum != '강의 개설'}">
										<!-- 학사 결재의 학생 전용 결재선 생성 위해 학번 저장 -->
										<input type="hidden" id="stdIdForSearch" <c:if test="${applyVo.stdId != null && applyVo.stdId != ''}">value="${applyVo.stdId}"</c:if> />
									</c:if>
									
									<c:if test="${authLineList[0].authLineNum == '' || authLineList[0].authLineNum == null}">
										<button type="button" class="btn btn-block btn-light disabledProp" id="authLineSearch">결재 선 검색</button>
									</c:if>
									
								</div>
								<div id="authLineStep" class='card bg-info text-white shadow' style="height: 65px;">
									<div class='card-body'>
										<p class="text-center" style="margin: 0px;"> 
											<span id="authLineNumSpan" class='badge badge-light'>${authLineList[0].authLineNum}</span>
											<span id="authLineName">${authLineList[0].authLineName}</span>
										</p>
										<input type="hidden" id="authLineNum" name="authLineNum" />
									</div>
								</div>
							</div>
							
							<hr>
							
							<!-- 결재 진행 -->
							<div>
								<div class="form-group">
									<div class="row">
										<div class="col-sm-6 text-center">
											<div class="custom-control custom-radio">
												<c:set var="authStat" value="${authDocVo.authStatCode}" /> 
												<input class="custom-control-input disabledProp" type="radio" value="02" id="authStatCode02" name="authStatCode" 
													<c:if test="${authDocVo.authStatCode==authStat}">checked</c:if>> 
												<label for="authStatCode02" class="custom-control-label">${authStat}</label>
											</div>
										</div>
										<div class="col-sm-6 text-center">
											<div class="custom-control custom-radio">
												<input class="custom-control-input disabledProp" type="radio" value="03" id="authStatCode03" name="authStatCode" 
													<c:if test="${authDocVo.authStatCode=='반려'}">checked</c:if>> 
												<label for="authStatCode03" class="custom-control-label">반려</label>
											</div>
										</div>
									</div>
								</div>
								
								<div class="form-group">
									<div class="row" id="rcpCode" style="margin-top: 40px;">
										<div class="col-sm-6 text-center" >
											<div class="custom-control custom-radio">
												<input class="custom-control-input disabledProp" type="radio" value="01" name="rcpCode" id="rcpCode01"  
													<c:if test="${authDocVo.rcpCode=='내부 결재'}">checked</c:if> /> 
												<label for="rcpCode01" class="custom-control-label">내부 결재</label> 
											</div>
										</div>
										<div class="col-sm-6 text-center">
											<div class="custom-control custom-radio">
												<input class="custom-control-input disabledProp" type="radio" value="02" name="rcpCode" id="rcpCode02"
													<c:if test="${authDocVo.rcpCode=='협조 공문'}">checked</c:if> /> 
												<label for="rcpCode02" class="custom-control-label">협조 공문</label>
											</div>
										</div>
									</div>
								</div>

								<hr>
								<div class="text-right">
									<input type="hidden" name="authDocNum" value="${authDocVo.authDocNum}"/>
									<input type="hidden" id="checkAuthStatCode" value="${authDocVo.authStatCode}" /> 
									<button type="button" id="btnSubmit" class="btn btn-primary btn-primary-crud disabledProp">결재</button>								
									<button type="button" class="btn btn-default btn-default-crud" onclick="location.href='/auth/authDocList?'">
										<c:if test="${authDocVo.authStatCode == '접수'}">
											취소
										</c:if>
										<c:if test="${authDocVo.authStatCode != '접수'}">
											확인
										</c:if>
									</button>								
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 붙임 파일 -->
	<div class="card shadow mb-4">
		<!-- Card Header - Accordion -->
		<a href="#collapseCardExample1" class="d-block card-header py-3" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="collapseCardExample">
			<h6 class="m-0 font-weight-bold text-primary">붙 임</h6>
		</a>
		<!-- Card Content - Collapse -->
		<div class="collapse show" id="collapseCardExample1" style="">
			<div class="card-body">
				<!-- 파일 다운로드 -->
				<c:forEach items="${fileList}" var="getFile">
					<div style="margin-top: 5px;">
						<a href="/fileDownload?filePath=${getFile.filePath}" style="margin-right: 5px;">${getFile.originFileName}</a>
						<input type="hidden" name="fileGrNum" value="${getFile.fileGrNum}"/>
					</div>
				</c:forEach>
				<c:if test="${fileList==null}">붙임 파일이 존재하지 않습니다.</c:if>
			</div>
		</div>
	</div>
	

</div>

<script type="text/javascript">

	$(function() {
		
		if($("#checkAuthStatCode").val()!='접수'){
			$(".disabledProp").prop("disabled", true);
		}
		
		$("#authLineSearch").on("click", function() {
			var authDocFormNum = "${authDocVo.authDocFormNum}";
			
			var stdId = $("#stdIdForSearch").val();
			window.open("/auth/authLineSearchPopup?stdId=" + stdId + "&authDocFormNum=" + authDocFormNum, "owin", "width=900, height=700");
		});
		
		// 미승인 사유 슬라이드 기능
		$("#authStatCode02").on("click", function() {
			$("#rcpCode").slideDown(500);	
		});
		$("#authStatCode03").on("click", function() {
			$("#rcpCode").slideUp(500);	
		});
		
		// 제출
		$("#btnSubmit").on("click", function () {
			// 값 검증
			if($("#authLineNum").val() == null || $("#authLineNum").val() == ''){
				alert("결재 선을 선택해주세요.");
				return;
			}  
			
			if($("input[name='rcpCode']").val() == null || $("input[name='rcpCode']").val() == ''){
				alert("수신 유형을 선택해주세요.");
				return;
			}
			
			$("#frm").submit();
		});
		
	});
	
</script>
