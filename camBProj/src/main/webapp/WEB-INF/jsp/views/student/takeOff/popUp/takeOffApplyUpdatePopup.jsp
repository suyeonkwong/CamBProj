<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 
	20210909
	- ajax로 submit을 보낸 후 'ok' 값을 받고 부모창 새로고침, 팝업 닫기 
	-- ajax 설정이 안 돼서 구현을 못 함 
	-- 계속 안 되면 popup 띄우지 말기
-->

<div id="body">

	<div class="card shadow mb-4" style="margin-top: 20px;">
	
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">휴학 신청</h6>
		</div>
		
		<div class="card-body">
			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">

				<form action="/student/takeOff/takeOffApplyUpdate" id="frmUpdate" name="frmUpdate" method="post" enctype="multipart/form-data"><!-- form start -->
					
					<input type="hidden" name="takeOffApplyNum" value="${takeOffVo.takeOffApplyNum}" />
					
					<div class="row">
						<!-- (!) 세션에서 가져온 후 SELECT해 뿌려 줄 학생 정보-->
						<div class="col-sm-3">
							<div class="form-group">
								<label for="stdId">학번</label>
								<input type="text" class="form-control" name="stdId" id="stdId" value="tempId" readonly>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="form-group">
								<label>이름</label>
								<input type="text" class="form-control" readonly>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="form-group">
								<label>전공</label>
								<input type="text" class="form-control" readonly>
							</div>
						</div>
						<div class="col-sm-3">
							<div>
								<label for="input4">학년</label>
								<input type="text" class="form-control" value="1" readonly>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-sm-8">
							<div class="form-group">
								<label>주소</label>
								<input type="text" class="form-control" readonly>
							</div>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<label>전화 번호</label>
								<input type="text" class="form-control" readonly>
							</div>
						</div>
					</div>
					
					<hr>
					
					<div class="row">
						<div class="col-sm-4">
							<div class="form-group">
								<label>기준 학기</label>
								<input type="text" class="form-control" id="semInfo" value="${takeOffVo.year} - ${takeOffVo.semCode} 학기" readonly/>
								<input type="hidden" class="form-control" id="year" name="year" value="${takeOffVo.year}" readonly />
								<input type="hidden" class="form-control" id="semCode" name="semCode" value="${takeOffVo.semCode}" readonly />
							</div>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<label>휴학 기간</label>
								<!-- (!) 학생의 휴학 기록에 따라 옵션 범위가 달라지게 할 방법 -->
								<select class="form-control" style="width: 100%;" name="semCnt">
									<option value="1" <c:if test="${takeOffVo.semCnt=='1'}" >selected</c:if>>1 학기</option>
									<option value="2" <c:if test="${takeOffVo.semCnt=='2'}" >selected</c:if>>2 학기</option>
									<option value="3" <c:if test="${takeOffVo.semCnt=='3'}" >selected</c:if>>3 학기</option>
									<option value="4" <c:if test="${takeOffVo.semCnt=='4'}" >selected</c:if>>4 학기</option>
								</select>
							</div>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<label>휴학 종류</label>
								<select class="form-control" style="width: 100%;" name="takeOffTypeCode">
									<c:forEach items="${codeList}" var="code">
										<option value="${code.codeVal}" <c:if test="${takeOffVo.takeOffTypeCode==code.codeVal}" >selected</c:if>>
											${code.codeName}
										</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-sm-12">
							<div class="form-group">
								<label for="fileList">첨부파일</label>
								<div class="input-group">
									<div class="custom-file">
										<input type="file" class="custom-file-input" id="fileList" name="fileList" multiple> 
										<label class="custom-file-label" for="fileList" id="fileName"></label>
									</div>
								</div>
								<div id="setFileName">
									<c:forEach items="${fileList}" var="getFile">
										<div style="margin-top: 5px;">
											<!-- 파일 다운로드 참고용 (수정 페이지에서는 원래 다운로드 기능 쓰지 않음) -->
											<a href="/fileDownload?filePath=${getFile.filePath}" style="margin-right: 5px;">${getFile.originFileName}</a>
										</div>
									</c:forEach>
								</div>
								<!-- 파일이 들어왔는지 확인 -->
								<div style="display: none;">
				                    <input type="checkbox" name="fileCheck" id="fileCheck">
			                    </div>
							</div>
						</div>
					</div>
					
					<input type="hidden" name="procStatCode" value="01"/>
					
					<hr>
					
					<div class="row">
						<div class="col-sm-12 text-right">
							<button type="button" class="btn btn-primary" id="btnSubmit">수정</button>
							<button type="button" class="btn btn-light" onclick="selfClose();">취소</button>
						</div>
					</div>
							
				</form><!-- // form end -->
						
			</div>
		</div>
		
	</div>

	<div class="row">
		<div class="col-sm-6">
			<div class="card shadow mb-4">
				<!-- Card Header - Accordion -->
				<a href="#collapseCardExample1" class="d-block card-header py-3" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="collapseCardExample">
					<h6 class="m-0 font-weight-bold text-primary">제출 서류 안내</h6>
				</a>
				<!-- Card Content - Collapse -->
				<div class="collapse show" id="collapseCardExample1" style="">
					<div class="card-body">
						개인 사유:제출서류 없음 <br /> 
					       병가:병원 진단서 <br /> 
					       입대:입영통지서 <br /> 
					       창업 : 창업 사유 증빙 서류
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-6">
			<div class="card shadow mb-4">
				<!-- Card Header - Accordion -->
				<a href="#collapseCardExample2" class="d-block card-header py-3" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="collapseCardExample">
					<h6 class="m-0 font-weight-bold text-primary">유의 사항</h6>
				</a>
				<!-- Card Content - Collapse -->
				<div class="collapse show" id="collapseCardExample2" style="">
					<div class="card-body">
						휴학 기간 만료 후 복학하지 않을 시에는 제적 처리 되오니 유의하시기 바랍니다. <br />   
						휴학을 취소하는 경우 대학 행정실의 허가를 받아야 합니다. <br /> 
						신입생은 1학기 휴학이 불가합니다. <br /> 
						기타 휴학 및 복학에 관련된 문의 사항은 대학 행정실로 문의하시기 바랍니다. <br />   
					</div>
				</div>
			</div>
		</div>
	</div>

</div>

<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/ddit.min.js"></script>

<script type="text/javascript">
	$(function() {
		$("#fileList").on("change", function(e) {
			$("#fileCheck").prop("checked", true);
			fileExtnsImgPdf(e); // 확장자 검사 & 파일 이름 출력
		});
		
		// ajax로 시도 - 실패 
		$("#btnSubmit_").on("click", function(e) {
			console.log("in");
			
			// form을 json 객체로 변환
			var formSerializeArray = $('#frmUpdate').serializeArray();
			var object = {};
			for (var i = 0; i < formSerializeArray.length; i++){
			    object[formSerializeArray[i]['name']] = formSerializeArray[i]['value'];
			}
			var frmUpdateJSON = JSON.stringify(object);
			console.log(frmUpdateJSON);
			
			//contentType : 보내는 데이터의 타입
			//dataType : 어떤 타입을 받을 것인지
			$.ajax({
				url:"/student/takeOff/takeOffApplyUpdate"
				,type: "POST"
				,data: frmUpdateJSON
				,dataType: 'text'
				,contentType: "application/json"
				,success: function(data) {
					console.log("data : " + data);
				}
			});
			
		});
		
		$("#btnSubmit").on("click", function() {
			$("#frmUpdate").submit();
		});
	});
	
	function selfClose() {
		opener.parent.location.reload();
		self.close();
	}
</script>
