<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<style>
	tbody td:hover{
		background-color: #F4F5F9;
	}
	tbody td{
		text-align: left;
	}
</style>
<title></title>
</head>
<body>
	<br/>
	<form style="text-align: center;" method="get" action="/professor/study/popup/lectureRoomList" name="roomSearch" id="roomSearch">
		<span style="float: left; margin-top: 6px; margin-right: 1%; margin-left: 9%;">건물 번호</span>  
		<select id="buildCode" name="buildCode" class="form-control" style="width: 40%; float: left; padding: 0px 0px 0px 10px; ">
			<option value="">전체</option>
			<option value="01" <c:if test="${param.buildCode==01}">selected</c:if>>사범 대학(01)</option>
			<option value="02" <c:if test="${param.buildCode==02}">selected</c:if>>문과 대학(02)</option>
			<option value="03" <c:if test="${param.buildCode==03}">selected</c:if>>경상 대학(03)</option>
			<option value="04" <c:if test="${param.buildCode==04}">selected</c:if>>공과 대학(04)</option>
			<option value="05" <c:if test="${param.buildCode==05}">selected</c:if>>간호학과 강의동(05)</option>
			<option value="06" <c:if test="${param.buildCode==06}">selected</c:if>>생명 나노과학 대학(06)</option>
			<option value="07" <c:if test="${param.buildCode==07}">selected</c:if>>미술 교육관(07)</option>
			<option value="08" <c:if test="${param.buildCode==08}">selected</c:if>>식품 영양학과 공용 강의실(08)</option>
		
		</select>
		
		<span style="float: left; margin-top: 6px; margin-right: 1%; margin-left: 1%;">&nbsp;층 수&nbsp;</span> 	
		<select id="roomNum" name="roomNum" class="form-control" style="width: 15%; float: left; padding: 0px 0px 0px 10px;">
			<option value="">전체</option>
			<c:forEach var="i" begin="1" end="10">
				<c:if test="${i<10}"> 
					<option value="0${i}"
					<c:if test="${param.roomNum=='0'+i}">selected</c:if>
					>0${i}</option>		
				</c:if>
				<c:if test="${i>=10}"> 
					<option value="${i}"
					<c:if test="${param.roomNum==i}">selected</c:if>
					>${i}</option>		
				</c:if>
			</c:forEach>
		</select>
		&nbsp;
		<button type="submit" class="btn btn-secondary" style="float: left; margin-left: 2%;">검색</button>

	</form>
	<div class="card shadow mb-4" style="width: 90%; margin:0px 5%;">
		<div class="card-body">
			<table class="table table-bordered dataTable" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; text-align: center;">

				<tr style="cursor: pointer;">
				<c:forEach var="lectRoom" items="${lectRoom}" varStatus="stat">  <!-- lectRoom을 출력하는데 3의 배수일때 엔터효과 -->
						<td style="width: 50%;" onclick="fn_tdClick('${lectRoom.buildCode}','${lectRoom.roomNum}')" class="childLectRoomNum">${lectRoom.buildName}(${lectRoom.buildCode}) / ${fn:substring(lectRoom.roomNum,0,2) }층 ${fn:substring(lectRoom.roomNum,2,4)}호
						<input type="hidden" value="${lectRoom.buildCode}${lectRoom.roomNum}" name="roomIdn"> 
						<input type="hidden" value="${lectRoom.roomIdnNum}" name="roomIdnNum"> 
						<c:if test="${stat.count % 2 == 0}">
							</tr>
							<tr style="cursor: pointer;">	
						</c:if>
				</c:forEach>
				</tr>
			</table>
		</div>
	</div>
</body>
<script src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">

	$(function () {
	
		$(".childLectRoomNum").click(function() {
			var roomIdnNum = $(this).children('input[name=roomIdnNum]').val();
			var roomIdn = $(this).children('input').val();
			var room = $(this).text();
			var roomNum = room.substr(0,7);
			$("#roomNum",opener.document).val(room);
			$("#roomIdnNum",opener.document).val(roomIdn);		//디테일에서 수정할때 roomIdnNum
			$("#roomIdnNum2",opener.document).val(roomIdnNum);	//인설트할떄  roomIdnNum 
			
			
			self.close();
		});
		
	});

	
</script>
</html>

	