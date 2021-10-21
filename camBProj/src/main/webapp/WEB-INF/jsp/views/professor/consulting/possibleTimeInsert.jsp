<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<body>
	<div class="card shadow mb-4" style="width: 98%;">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary" style="cursor: pointer;" onclick="javascript:location.href='/professor/consulting/possibleTimeList'">상담 시간 관리</h6>
		</div>
		<div class="card mb-4 py-3 border-left-primary" style="border-radius: 15px; width: 80%; height: 150px; margin: 50px 0px 20px 150px; padding: 65px 65px 65px 250px;">
		<div style="float: left; width: 90%; margin-top: 5%;">
			<span style="float: left; margin-top: 6px;">상담일&nbsp;&nbsp;&nbsp;</span>
			<input type="date" id="consultingDate" class="form-control" style="float: left; padding: 0px; width: 20%; text-align: center;">
			
			<span style="float: left; margin-top: 6px; margin-left: 3%;">시간&nbsp;&nbsp;&nbsp;</span> 
					<select id="consultingTime" class="form-control" style="float: left; padding: 0px; width: 11%; text-align: center;">
						<option>-- 시간 --</option>
						<option>09:00</option>
						<option>10:00</option>
						<option>11:00</option>
						<option>12:00</option>
						<option>13:00</option>
						<option>14:00</option>
						<option>15:00</option>
						<option>16:00</option>
						<option>17:00</option>
					</select>&nbsp;&nbsp;
			<span style="float: left; margin-top: 6px; margin-left: 2%;">부터&nbsp;&nbsp;&nbsp;</span>
					<select id="continuityTime" class="form-control" style="float: left; padding: 0px; width: 11%; text-align: center;">
						<option value="1">1시간</option>
						<option value="2">2시간</option>
						<option value="3">3시간</option>
						<option value="4">4시간</option>
						<option value="5">5시간</option>
						<option value="6">6시간</option>
						<option value="7">7시간</option>
						<option value="8">8시간</option>
						<option value="9">9시간</option>
					</select>&nbsp;&nbsp; 
			<span style="float: left; margin-top: 6px; margin-left: 2%;">인원수 &nbsp;&nbsp;</span>					
			<select id=cap class="form-control" style="float: left; padding: 0px; width: 11%; text-align: center;">
				<option>1</option>
				<option>2</option>
				<option>3</option>
			</select>
			<button type="button" class="btn btn-secondary btn-icon-split" style="padding: 3px 8px 3px 8px; float: left; margin-top: 3px; margin-left: 1%;" onclick="fn_insert()">추가</button>
			</div>
		</div>
		<div class="card-body">
			<div class="table-responsive">
				<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4" style="width: 99%">
					<div class="row">
						<div class="col-sm-12">
						<form action="/professor/consulting/insert" method="post" id="consultUpdate" name="consultUpdate">
							<table class="table table-bordered dataTable" id="dataTable" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 40%; margin-left: 450px;">
								<thead>
									<tr role="row">
										<th class="sorting sorting_asc" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" style="width: 30%;">
											년도/월/일
										</th>
										<th class="sorting sorting_asc" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" style="width: 30%;">
											시간
										</th>
										<th class="sorting sorting_asc" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" style="width: 20%;">
											인원수
										</th>
										<th class="sorting sorting_asc" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" style="width: 20%;">
											삭제
										</th>
									</tr>
								</thead>
								
								<tbody id="consultingTable">
																		
								</tbody>
							</table>
						</form>							
						</div>
					</div>
						<div class="row" style=" float: right; margin-right: 8.5%;">
							<button type="button" class="btn btn-primary" id="btnSubmit" style="margin-right: 2px; width: 120px;">저장</button>
							<c:if test="${empty param.pageNo}"> 
<%--                  		    	<button type="button" class="btn btn-secondary" id="btnCancel" onclick="location.href='/professor/consulting/list?pageNo=1&startDate=${param.startDate}&endDate=${param.endDate}&inputStatus=${param.inputStatus}'">취소</button> --%>
                 		    	<button type="button" class="btn btn-default" style="background-color: white; border-color: gray; width: 120px;" id="btnCancel" onclick="location.href='/professor/consulting/possibleTimeList?pageNo=1'">취소</button>
                 		    </c:if>
							<c:if test="${!empty param.pageNo}"> 
                 		    	<button type="button" class="btn btn-default" style="background-color: white; border-color: gray; width: 120px;" id="btnCancel" onclick="location.href='/professor/consulting/possibleTimeList?pageNo=${pageNo}'">취소</button>
                 		    </c:if>
						</div>		
				</div>
			</div>
		</div>		
	</div>

</body>
<script src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
$("#consultingDate").change(function () {	
	var selectDate = document.getElementById("consultingDate").value;    // 검색창에서 선택한 날짜

	selectDate2 = selectDate.replace(/-/gi, "");	
	
	// 선택날이 오늘보다 이전인 경우 시작
	var date = new Date();						
	var year = date.getFullYear(); 
	var month = (1 + date.getMonth());          
		month = month >= 10 ? month : '0' + month; 
	var day = date.getDate();                 
		day = day >= 10 ? day : '0' + day;
	date = year+""+ month+""+day;				
	// 선택날이 오늘보다 이전인 경우 끝
	
	
		
	var time = document.getElementById("consultingTime").value;
	console.log("time : "+ time);
	
	if(parseInt(date) > parseInt(selectDate2)){
		console.log("선택날짜 - 오늘날짜 = ",parseInt(selectDate2)-parseInt(date));
		alert("과거는 선택할 수 없습니다.");
		$("#consultingDate").val(null);  	// 야매식 날짜 선택 풀리게 하기
	}
	
	// 7일후인 경우 시작
	var afterWeekDate = new Date();						//오늘 날짜 시작
	afterWeekDate.setDate(afterWeekDate.getDate() + 7);
	
	var afterWeekYear = afterWeekDate.getFullYear(); 
	console.log(afterWeekYear);
	var afterWeekMonth = (1 + afterWeekDate.getMonth());          
	afterWeekMonth = afterWeekMonth >= 10 ? afterWeekMonth : '0' + afterWeekMonth; 
	console.log(afterWeekMonth);	
	var day2 = afterWeekDate.getDate();                 
		day2 = day2 >= 10 ? day2 : '0' + day2;
	console.log(day2);	
	afterWeekDate = afterWeekYear+""+ afterWeekMonth+""+ day2;				
	console.log("7일 후 날짜 : " + afterWeekDate);
	// 7일후인 경우 끝
	if((parseInt(afterWeekDate) - parseInt(selectDate2)) <0 ){
		alert("7일 후는 선택할 수 없습니다.");
		$("#consultingDate").val(null);  	// 야매식 날짜 선택 풀리게 하기
	}
	
})

var count =0;
 function fn_insert() {
	var selectDate = document.getElementById("consultingDate").value;    // 검색창에서 선택한 날짜
	
	
	var time = document.getElementById("consultingTime").value;		//검색창에서 선택한 시간
	
	var continuityTime = $("#continuityTime").val(); 	//검색창에서 몇시간 연속인지  숫자
	var continuityTimeInt = parseInt(continuityTime);
	
// 	console.log("time : "+ time);
	
	var substrTime = time.substr(0,2);	//Time : 12:00 형태를 	12 형태로 자름
	substrTime = parseInt(substrTime);
	
	var date = $("#consultingDate").val();
	var cap = $("#cap").val();
	
	
	if(selectDate == ""||time =="-- 시간 --"){
		alert("빈 항목 없이 입력해주세요.");
	}else{
		if(count == 0){
		//중복검사
		for(var i = 0; i<continuityTimeInt; i++){
			if(parseInt(substrTime+i) <18){
				if((substrTime+i)<10){
					var str = "<tr role='row'>"
						 +"<td style='text-align: center;'>"+selectDate+"</td>"
						 +"<td style='text-align: center;'>0"+(substrTime+i)+":00 - "+(substrTime+(i+1))+":00"
						 +"<input type='hidden' id='startTime"+count+"' name='consultVOList["+count+"].startTime' value='0"+(substrTime+i)+":00'>"
						 +"<input type='hidden' id='endTime"+count+"' name='consultVOList["+count+"].endTime' value='"+(substrTime+(i+1))+":00'>"
						 +"<input type='hidden' id='profId"+count+"' name='consultVOList["+count+"].profId' value='${sessionScope.memberVo.memId}'>"
						 +"<input type='hidden' id='consultAvlDate"+count+"' name='consultVOList["+count+"].consultAvlDate' value='"+date+"'>"
						 +"<input type='hidden' id='cap"+count+"' name='consultVOList["+count+"].cap' value='"+cap+"'>"					 
						 +"</td>"
						 +"<td style='text-align: center;'>"+cap+"</td>"
						 +'<td style="padding: 5px;"><button type="button" class="form-control trDel">삭제</button> </td>'
						 +"</tr>";
					var checkTime = selectDate+"0"+(substrTime+i)+":00 - "+(substrTime+(i+1))+":00";
				}else{
					var str = "<tr role='row'>"
						 +"<td style='text-align: center;'>"+selectDate+"</td>"
						 +"<td style='text-align: center;'>"+(substrTime+i)+":00 - "+(substrTime+(i+1))+":00"
						 +"<input type='hidden' id='startTime"+count+"' name='consultVOList["+count+"].startTime' value='"+(substrTime+i)+":00'>"
						 +"<input type='hidden' id='endTime"+count+"' name='consultVOList["+count+"].endTime' value='"+(substrTime+(i+1))+":00'>"
						 +"<input type='hidden' id='profId"+count+"' name='consultVOList["+count+"].profId' value='${sessionScope.memberVo.memId}'>"
						 +"<input type='hidden' id='consultAvlDate"+count+"' name='consultVOList["+count+"].consultAvlDate' value='"+date+"'>"
						 +"<input type='hidden' id='cap"+count+"' name='consultVOList["+count+"].cap' value='"+cap+"'>"		
						 +"</td>"
						 +"<td style='text-align: center;'>"+cap+"</td>"
						 +'<td style="padding: 5px;"><button type="button" class="form-control trDel" >삭제</button> </td>'
						 +"</tr>";
					var checkTime = selectDate+(substrTime+i)+":00 - "+(substrTime+(i+1))+":00";	 
					console.log("checkTime : "+ checkTime);	
				}

					$("#consultingTable").append(str);
					count++;
			}else{
				alert("18:00이후의 시간은 등록할 수 없습니다.");
				return;
			}
		} //for문끝
		}else if(count >0){
		var trLength = $('#consultingTable tr').length;
		// 두번째~ 입력
		var count2 = 0;  //alert("중복되는 시간은 추가되지 않습니다."); 를 위한 카운트
		for(var i = 0; i<continuityTimeInt; i++){
			var count1 = 0; //중복 방지를 위해 카운트가 1이라도 올라가면 추가 안함
			if((substrTime+i)<10){
				var selectData = selectDate+"0"+(substrTime+i)+":00 - "+(substrTime+(i+1))+":00";
				var str = "<tr role='row'>"
					 +"<td style='text-align: center;'>"+selectDate+"</td>"
					 +"<td style='text-align: center;'>0"+(substrTime+i)+":00 - "+(substrTime+(i+1))+":00"
					 +"<input type='hidden' id='startTime"+count+"' name='consultVOList["+count+"].startTime' value='0"+(substrTime+i)+":00'>"
					 +"<input type='hidden' id='endTime"+count+"' name='consultVOList["+count+"].endTime' value='"+(substrTime+(i+1))+":00'>"
					 +"<input type='hidden' id='profId"+count+"' name='consultVOList["+count+"].profId' value='${sessionScope.memberVo.memId}'>"
					 +"<input type='hidden' id='consultAvlDate"+count+"' name='consultVOList["+count+"].consultAvlDate' value='"+date+"'>"
					 +"<input type='hidden' id='cap"+count+"' name='consultVOList["+count+"].cap' value='"+cap+"'>"					 
					 +"</td>"
					 +"<td style='text-align: center;'>"+cap+"</td>"
					 +'<td style="padding: 5px;"><button type="button" class="form-control trDel" >삭제</button> </td>'
					 +"</tr>";
			}else{
				var selectData = selectDate+(substrTime+i)+":00 - "+(substrTime+(i+1))+":00";
				var str = "<tr role='row'>"
					 +"<td style='text-align: center;'>"+selectDate+"</td>"
					 +"<td style='text-align: center;'>"+(substrTime+i)+":00 - "+(substrTime+(i+1))+":00"
					 +"<input type='hidden' id='startTime"+count+"' name='consultVOList["+count+"].startTime' value='"+(substrTime+i)+":00'>"
					 +"<input type='hidden' id='endTime"+count+"' name='consultVOList["+count+"].endTime' value='"+(substrTime+(i+1))+":00'>"
					 +"<input type='hidden' id='profId"+count+"' name='consultVOList["+count+"].profId' value='${sessionScope.memberVo.memId}'>"
					 +"<input type='hidden' id='consultAvlDate"+count+"' name='consultVOList["+count+"].consultAvlDate' value='"+date+"'>"
					 +"<input type='hidden' id='cap"+count+"' name='consultVOList["+count+"].cap' value='"+cap+"'>"		
					 +"</td>"
					 +"<td style='text-align: center;'>"+cap+"</td>"
					 +'<td style="padding: 5px;"><button type="button" class="form-control trDel">삭제</button> </td>'
					 +"</tr>";
			}
			for(var j = 0; j< trLength; j++){	//현재 table의 tr데이터들
				var tableData = $("#consultingTable").find("tr:eq("+j+")").text();
				tableData = tableData.substr(0,23);
// 				alert(tableData);
// 				alert("selectData : "+ selectData+"\n tableData : "+ tableData);
				if(selectData == tableData){	//테이블에 존재하는 데이터와 내가 추가하는 데이터가 같을 경우 카운트 증가
					count1++;
				}				
			}
			if(count1 == 0){ //같은데이터가 아예 없는 경우
				$("#consultingTable").append(str);
				count++;
			}else{
				count2++;
			}
// 			alert(selectData);
		}
		if(count2>0){
			alert("중복되는 시간은 추가되지 않습니다.");
		}
		
		
		} 
		
		
		

		
		
		
		
	} //if(selectDate == ""||time =="-- 시간 --") else문 끝
	
} //fn_insert끝
	$(function () {
		$("#btnSubmit").on("click",function(){
			var result = confirm('시간을 저장하시겠습니까?');
			if(result){
				//================== 미입력이 하나라도 있을 경우 저장 불가  ================== 
				if($('#consultingTable tr').length==0){
					alert("시간이 선택되지 않았습니다.");
					return;
				}else{
					$("#consultUpdate").submit();	
				}				
			}else{ //if(result) 끝 		
				return;
			}
		});
		
	});


	// 선틱한 시간 삭제
	$(document).on("click", ".trDel", function(){
		console.log($(this).parent().parent().text());
		$(this).parent().parent().remove();
	});

</script>
</html>