<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div id="body">

	<p class="mb-4">
	</p>
	
	<div class="card shadow mb-4">
	
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">결재 선 관리</h6>
		</div>
		
		<div class="card-body">
			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">

				<form action="/auth/authLineStepInsert" id="frm" name="frm"  method="post"><!-- form start -->
					
					<div class="row">
						<input type="hidden" name="creator" value="${sessionScope.memberVo.memId}"/>
						
						<div class="col-sm-6">
							<div class="form-group">
								<label>결재 선 이름</label>
								<input type="text" class="form-control" id="authLineName" name="authLineName" maxlength="50" />
							</div>
						</div>
						<div class="col-sm-6">
							<div class="form-group">
								<label>결재 선 업무 유형</label>
								<select class="form-control" name="authLineTypeCode">
									<c:forEach items="${codeList}" var="code">
										<option value="${code.codeVal}">${code.codeName}</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>

					<hr>
					
					
					<!-- service로 전달되야 하는 값은 memIdStep 뿐이고, 나머지 값은 보여주기 용 -->
					<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
						
						<!-- 순번 기준 -->
						<input type="hidden" id="stepSequence" value="0" />
						
						<div class="row">
							<div class="col-sm-12">
								<table class="table">
									<thead>
										<tr>
											<th>순번</th>
											<th>아이디</th>
											<th>이름</th>
											<th>소속</th>
											<th>직무</th>
											<th>삭제</th>
										</tr>
									</thead>
									<tbody id="steps" class="text-center">
									</tbody>
								</table>
							</div>
						</div>
					</div>
					
					<div class="row" style="margin-bottom: 10px;">
						<div class="col-sm-12">
							<button type="button" class="btn btn-block btn-light" id="authStepSearch">결재자 추가</button>
							<input type="hidden" class="form-control" name="memIdList" id="memIdList" />
						</div>
					</div>
					
					<hr>
					
					<div class="row">
						<div class="col-sm-12 text-right">
							<button type="button" class="btn btn-default btn-default-crud" id="btnSubmit">등록</button>
							<button type="button" class="btn btn-primary btn-primary-crud" onclick="location.href='/auth/authLineList'">취소</button>
						</div>
					</div>
							
				</form><!-- // form end -->
						
			</div>
		</div>
		
	</div>

</div>

<script type="text/javascript">
	
	$(function() {
		
		// step 검색 팝업
		$("#authStepSearch").on("click", function () {
			window.open("/auth/authStepSearchPopup", "owin", "width=950, height=600");
		});
		
		// step을 입력하기 위한 memIdList 값 입력 후 submit
		$("#btnSubmit").on("click", function () {
			var stepList = $("#steps").children()
			var memIdList = "";
			for(var i=0; i<stepList.length; i++){
				var memId = $(stepList[i]).children()[1].innerHTML;
				memIdList += "-" + memId;
			}
			memIdList = memIdList.substring(1);
			$("#memIdList").val(memIdList);
			
			if(!validate()){ // 값 검증
				return;
			}
			
			$("#frm").submit(); // 폼 제출
		});
		
	});
	
	// ** step 삭제
	function deleteTd(btnObj) {
		
		var tr = $(btnObj).parents("tr");
		var sequence = $(tr).children()[0].innerHTML;
		
		// 선택한 요소 삭제
		$("#steps").children()[sequence-1].remove();
		
		// 순번 기준 -1
		var oldVal = $("#stepSequence").val();
		$("#stepSequence").val(oldVal-1);
		
		// 순번 다시 입력
		var stepList = $("#steps").children()
		for(var i=0; i<stepList.length; i++){
			$(stepList[i]).children()[0].innerHTML=i+1;
		}
	}
	
	
	// ** 값 검증
	function validate() {
		if($("#authLineName").val() == '' || $("#authLineName").val() == null){
			alert("결재 선 이름을 입력해주세요.");
			$("#authLineName").focus();
			return false;
		}
		
		if($("#steps").children().length == 0){
			alert("결재자를 추가해주세요.");
			return false;
		}
		
		return true;
		
	}
</script>
