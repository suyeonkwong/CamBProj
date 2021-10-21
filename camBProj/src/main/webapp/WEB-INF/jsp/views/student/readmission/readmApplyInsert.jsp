<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<style>
	p{
		margin: 0px;
	}
</style>

<div id="body">

	<p class="mb-4">
	</p>
	
	<div class="card shadow mb-4">
	
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">복적 재입학 신청</h6>
		</div>
		
		<div class="card-body">
			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">

				<form action="/student/readmission/readmApplyInsert" id="frm" name="frm"  method="post" enctype="multipart/form-data"><!-- form start -->
					
					<div class="row">
						<div class="col-sm-3">
							<div class="form-group">
								<label for="stdId">학번</label>
								<input type="text" class="form-control" name="stdId" id="stdId" value="${memberVo.memId}" readonly>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="form-group">
								<label>이름</label>
								<input type="text" class="form-control" value="${memberVo.name}" readonly>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="form-group">
								<label>전공</label>
								<input type="text" class="form-control" value="${studentVo.univDeptNum}" readonly>
							</div>
						</div>
						<div class="col-sm-3">
							<div>
								<label for="input4">학기</label>
								<input type="text" class="form-control" value="${studentVo.rgstSem}" readonly>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-sm-3">
							<div class="form-group">
								<label>우편번호</label>
								<input type="text" class="form-control" value="${memberVo.zipcode}" readonly>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="form-group">
								<label>주소</label>
								<input type="text" class="form-control" value="${memberVo.addr}" readonly>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="form-group">
								<label>상세주소</label>
								<input type="text" class="form-control" value="${memberVo.addrDetail}" readonly>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="form-group">
								<label>전화 번호</label>
								<input type="text" class="form-control" value="${memberVo.phNum}" readonly>
							</div>
						</div>
					</div>
					
					<hr>
					
					<div class="row">
						<div class="col-sm-3">
							<div class="form-group">
								<label>기준 학기</label>
								<input type="text" class="form-control" id="semInfo" readonly/>
								<input type="hidden" class="form-control" id="year" name="year" readonly />
								<input type="hidden" class="form-control" id="semCode" name="semCode" readonly />
							</div>
						</div>
					</div>
					
					<input type="hidden" name="procStatCode" value="01"/>
					
					<hr>
					
					<div class="row">
						<div class="col-sm-12 text-right">
							<!-- 중복 방지용 토큰 -->
							<input type="hidden" name="saveToken" value="${readmissionVo.saveToken}"/>
							<!-- 포워드 용 페이지 번호 -->
							<input type="hidden" name="pageNo" value="${readmissionVo.pageNo}"/>
							<button type="button" class="btn btn-primary btn-primary-crud" id="btnSubmit">등록</button>
							<button type="button" class="btn btn-default btn-default-crud" onclick="location.href='/student/readmission/readmApplyList'">목록</button>
						</div>
					</div>
							
				</form><!-- // form end -->
						
			</div>
		</div>
		
	</div>

	<div class="row">
		<div class="col-sm-12">
			<div class="card shadow mb-4">
				<!-- Card Header - Accordion -->
				<a href="#collapseCardExample1" class="d-block card-header py-3" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="collapseCardExample">
					<h6 class="m-0 font-weight-bold text-primary">복적 재입학 안내</h6>
				</a>
				<!-- Card Content - Collapse -->
				<div class="collapse show" id="collapseCardExample1" style="">
					<div class="card-body">
						<p>  ◦ 제적된 학생이 1년 이내에 복적을 신청한 경우에는 정원의 여석이 있을 때에 한하여 복적을 허가할 수 있다.</p>
						<p>  ◦ 자퇴하거나 제적된 학생이 재입학을 신청한 경우에는 정원의 여석이 있을 때에 한하여 재입학을 허가할 수 있다.</p>
						<p>  ◦ 복적 또는 재입학을 신청한 학생의 자퇴·제적 당시 모집단위가 폐지된 경우에는 해당 모집단위의 교과과정과 유사한 교과과정을 운영하는 모집단위로 복적 또는 재입학을 하게 할 수 있다.</p>
						<p>  ◦ 다만, 유사한 교과과정을 운영하는 모집단위가 없는 경우의 복적 및 재입학에 관하여는 총장이 따로 정한다.</p>
						<p>  ◦ 복적 및 재입학은 각각 1회에 한한다.</p>
						<p>  ◦ 복적하거나 재입학한 학생의 이미 이수한 학점과 학적에 관한 사항은 통산한다.</p>
						<p>  ◦ 복적 및 재입학 승인을 받은 학생 중 수업연한(규정학기)을 초과한 학생은 반드시 수강신청 후 등록금을 납부해야 한다.</p>
						<p>  ◦ 복적 및 재입학하는 학기 시작일 전에는 휴학 및 자퇴를 신청할 수 없다.</p>
					</div>
				</div>
			</div>
		</div>
	</div>

</div>


<script type="text/javascript">
	$(function() {
		
		setNextYearSemCode(); // [기준년도, 학기] 정보 입력
		
		$("#btnSubmit").on("click", function() { // 신청
			if(!confirm("복적 재입학을 신청하시겠습니까?")){
				return;
			}
			$("#frm").submit();
		});
		
	});
	
</script>
