<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<script src="\resources\js\jquery.min.js"></script>
<style>
	#empId{
		width: 13%;
		border: 1px solid white;	
	}
	#title{
		width: 99%;
		border: 1px solid lightGray;
	}
	#content{
		width: 99%;
		border: 1px solid lightGray;
	}
</style>
<body>
<c:if test="${sessionScope.admin == '03'}">
	<div class="card shadow mb-4" style="width: 100%;">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">공지사항 수정</h6>
		</div>
		<div class="card-body">
			<form action="/common/notice/noticeUpdate" method="post" id="updateFrm" enctype="multipart/form-data">
				<input name="artcNum" type="hidden" value="${nv.artcNum}">
				<div class="row">
					<div class="col-sm-12">  
						<table class="table" id="dataTable"
							 cellspacing="0" role="grid"
							aria-describedby="dataTable_info" style="width: 100%;">
							<tr role="row">
								<th class="sorting sorting_asc" tabindex="0"
									aria-controls="dataTable" rowspan="1" colspan="1"
									aria-sort="ascending"
									aria-label="Name: activate to sort column descending"
									style="width: 50px;">작성자</th>
								<td class="sorting_1"><input type="text"  class="form-control" id="empId" name="empId" value="${nv.empId}" readonly="readonly"></td>
							</tr>
							<tr>
								<th class="sorting" tabindex="0" aria-controls="dataTable"
									rowspan="1" colspan="1"
									aria-label="Position: activate to sort column ascending"
									style="width: 100px;">제목</th>
								<td><input type="text" id="title" name="title" class="form-control" value="${nv.title}" maxlength="50"></td>
							</tr>
							<tr class="even">
								<th class="sorting" tabindex="0" aria-controls="dataTable"
									rowspan="1" colspan="1"
									aria-label="Office: activate to sort column ascending"
									style="width: 60px; height: 190px">내용</th>
								<td><textarea  id="contentE" name="content" maxlength="1000">${nv.content}</textarea>
							</td>
							</tr>
							<tr>
								<th class="sorting" tabindex="0" aria-controls="dataTable"
									rowspan="1" colspan="1"
									aria-label="Position: activate to sort column ascending"
									style="width: 110px;">최종 수정일</th>
								<td><input type="date" id="modDate" name="modDate" class="form-control" value="${nv.modDate}" disabled="disabled"></td>
							</tr>
							<tr>
								<th class="sorting" tabindex="0" aria-controls="dataTable"
									rowspan="1" colspan="1"
									aria-label="Position: activate to sort column ascending"
									style="width: 110px;">첨부파일</th>

									<td>
										<div class="input-group">
											<div class="custom-file">
												<input type="file" class="custom-file-input" id="fileList"
													name="fileList" multiple> <label
													class="custom-file-label" for="fileList" id="fileName"></label>
											</div>
										</div>
										<div id="setFileName">
											<c:forEach items="${fileList}" var="getFile">
											<br>
												<div style="margin-top: 5px;">
													<!-- 파일 다운로드 참고용 (수정 페이지에서는 원래 다운로드 기능 쓰지 않음) -->
													<a href="/fileDownload?filePath=${getFile.filePath}"
														style="margin-right: 5px;">${getFile.originFileName}</a> <input
														type="hidden" name="fileGrNum" value="${getFile.fileGrNum}" />
												</div>
											</c:forEach>
										</div> <!-- 파일이 들어왔는지 확인 -->
										<div style="display: none;">
											<input type="checkbox" name="fileCheck" id="fileCheck">
										</div>
									</td>
								</tr>
						</table>
							
							
						</div>

				</div>
				&nbsp;&nbsp;&nbsp;
				<div class="row" style="float: right; margin-right: 1px;">				 
				    <button type="submit" id="btnUpdate" class="btn btn-primary btn-primary-crud" id="btnSubmit">등록</button>&nbsp;&nbsp;
					<button type="button" class="btn btn-default btn-default-crud"  onclick="javascript:history.go(-1)">취소</button>
				</div>

			</form>
		</div>
	</div>
</c:if>
	<script type="text/javascript">
	$(function() {
		
		var now = new Date();
		$("#modDate").val(now.toISOString().substring(0, 10));
		
		$("#fileList").on("change", function(e) { 
			$("#fileCheck").prop("checked", true);
			fileExtnsImgPdf(e);
		});
		
		CKEDITOR.replace("contentE");
		
		$("#btnUpdate").on("click",function(){
			
			var input = confirm("수정하시겠습니까?");
			if(input == ""){
				return false;
			}
			if(input){//true
				$("#updateFrm").submit();

			}else{//false
				return;
			}
		});		
	});

	</script>

</body>
</html>