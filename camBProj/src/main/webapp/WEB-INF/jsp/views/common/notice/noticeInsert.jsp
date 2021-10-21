<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<body>
<c:if test="${sessionScope.admin == '03'}">
		<div class="card shadow mb-4" style="width: 100%;">
		
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">공지사항 등록</h6>
		</div>
		
		<div class="card-body">
		
						<form action="/common/notice/noticeInsert" method="post" enctype="multipart/form-data" id="notFrm">
							<table class="table" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%;">
								<tr>
									<th class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Position: activate to sort column ascending" style="width: 100px; text-align: center; border-right: hidden;">
										제목
									</th>
									<td id="title" colspan="3"><input type="text" class="form-control" name="title" id="title" style="border: 1px solid lightGray;" maxlength="50"></td>
								</tr>
								<tr role="row">
									<th class="sorting sorting_asc" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" style="width: 100px; text-align: center; border-right: hidden;">
										작성자
									</th>
									<td id="memId" class="sorting_1"><input type="text" class="form-control" name="empId" id="empId" value="${memberVo.memId}" readonly="readonly" style="width: 100%;"></td>
									<th class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Age: activate to sort column ascending" style="width: 120px; text-align: center;">
										첨부파일
									</th>
								<td>
								<div class="row">
									<div class="col-sm-12">
										<div class="form-group">
											<div class="input-group">
												<div class="custom-file">
													<input type="file" class="custom-file-input" id="fileList" name="fileList" multiple> 
													<label class="custom-file-label" for="fileList" id="fileName"></label>
												</div>
											</div>
											
											<div id="setFileName"></div>
											<!-- 파일이 들어왔는지 확인 -->
											<div style="display: none;">
							                    <input type="checkbox" name="fileCheck" id="fileCheck">
						                    </div>

										</div>
									</div>
								</div>
								</td>
								</tr>
								<tr class="even">
									<th class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Office: activate to sort column ascending" style="height: 380px; width: 60px; text-align: center;">
										<p style="margin-top: 230px;">내용</p>
									</th>
									<td colspan="3" style="height: 500px;"><textarea id="contentE" name="content" maxlength="1000">본문입니다.</textarea>
									</td>
									
								</tr>
								<tr class="odd">
									<th class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-label="Age: activate to sort column ascending" style="width: 30px; text-align: center;">
										날짜
									</th>
									<td colspan="3"><input type="date" class="form-control" name="writeDate" id="writeDate" disabled="disabled" style="width: 300px;"></td>	
								</tr>
							</table>
					<div class="row">
						<div class="col-sm-12 text-right">
							<button type="submit" class="btn btn-primary btn-primary-crud" id="btnSubmit">등록</button>
							<button type="button" class="btn btn-default btn-default-crud"  onclick="javascript:history.go(-1)">취소</button>
						</div>
					</div>
				</form>
				</div>
			</div>
	</c:if>
</body>
<script type="text/javascript">
$(function() {
	var now = new Date();
	$("#writeDate").val(now.toISOString().substring(0, 10));
	
	$("#fileList").on("change", function(e) { // 파일 입력 유무 및 파일 확장자 검사 & 파일 이름 하단에 출력
		$("#fileCheck").prop("checked", true);
		fileExtnsImgPdf(e); // 확장자 검사 & 파일 이름 출력 공통 함수
	});
	
	CKEDITOR.replace('contentE',{
		height: 360
		,disallowedContent : 'img{width,height}'
	});
	$("#btnSubmit").click(function() {
		
	
	$("#notFrm").submit();
	});
});
</script>
</html>