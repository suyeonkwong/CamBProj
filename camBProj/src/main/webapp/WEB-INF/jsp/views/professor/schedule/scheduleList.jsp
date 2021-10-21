<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
</head>
<style>
	tr,td{
		border: 1px solid #E3E5ED;
		text-align: center;
/* 		background-color: #F4F5F9; */
		color: gray;
	}
	th{
		text-align: center;
		background-color: #F0F0F0;
		height: 45px;
		border: 1px solid #E3E5ED;
		font-size: small;
		
	}
	tr{
		height: 30px;
		 
	}	
	
	.C1{
	background-color: #FFE6E6;
	}
	.C2{
		background-color: #FFE0CC;
	}
	.C3{
		background-color: #FFF5CC;
	}
	.C4{
		background-color: #C6ECD9;
	}
	.C5{
		background-color: #CCD9FF;
	}
	.C6{
		background-color: #CCCCFF;
	}
	.C7{
		background-color: #E0CCFF;
	}
	.C8{
		background-color: #E0E0EB;
	}
	.C9{
		background-color: #EBEBE0;
	}
	.C10{
		background-color: #A8C0C0;
	}
	.C11{
		background-color: #FFCE79;
	}
</style>
<body>
<div class="card shadow mb-4" style="width: 98%;">
		<div class="card-header py-3">
		<h6 class="m-0 font-weight-bold text-primary" style="cursor: pointer;" >시간표 조회</h6>
		</div>
		<div class="scheduleDiv">
		
		<%
		Date nowYear = new Date();
		SimpleDateFormat date = new SimpleDateFormat("yyyy");
		String year = date.format(nowYear);
		int intYear = Integer.parseInt(year);
		%>
		<!-- intYear을 비교할 방법이 없어서 var에 저장하고 foreach문에서 사용 -->
		<c:set var="nowYear" value="<%=(intYear) %>"></c:set>
		
		<div style="float: left; width: 17%; margin-top: 10px; ">
			<br/>
			<select class="form-control" style="width: 40%; float: right; margin-right: 8%;" id="semCode">
				<option value="2">2학기</option>
				<option value="1">1학기</option>
			</select>
			<select class="form-control" id="selectYear" name="selectYear" style="width: 40%; margin-right:5px; float: right;">
			<c:forEach var="year" begin="${nowYear-4}" end="${nowYear}">
				<option value="${nowYear-year+(nowYear-4)}">${nowYear-year+(nowYear-4)}</option>
			</c:forEach>
			</select> 
			
			
		</div>
		<table style="width: 70%; margin-left: 14%; margin-bottom: 5%; margin-top: 10px;" id="mySchedule">
		
			<tr class="day">
				<th>/</th>
				<th>월</th>
				<th>화</th>
				<th>수</th>
				<th>목</th>
				<th>금</th>
				<th>토</th>
				<th>일</th>
			</tr>
		
		<tbody id="tbody">
			<c:forEach var="i" begin="1" end="15">
				<tr id="time${i}">
					<th style="width: 12%; background-color: #F0F0F0; font-weight: bold; ">
						${i}교시<br/>
						<c:if test="${i+8<10}">0${i+8}:00 ~ 0${i+8}:50</c:if>
						<c:if test="${i+8>=10}">${i+8}:00 ~ ${i+8}:50</c:if>
					</th>
					<td class="mon" id="mon${i}" style="width: 10%;"></td>
					<td class="tue" id="tue${i}" style="width: 10%;"></td>
					<td class="wed" id="wed${i}" style="width: 10%;"></td>
					<td class="thu" id="thu${i}" style="width: 10%;"></td>
					<td class="fri" id="fri${i}" style="width: 10%;"></td>
					<td class="dayClass" id="sat${i}" style="width: 10%;"></td>
					<td class="dayClass" id="sun${i}" style="width: 10%;"></td>
				</tr>
			</c:forEach>
			
			</tbody>
		</table>
		</div>
		
</div>
</body>
<script src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
//**** 시간표 셀 병합
function genRowspan(){
	
	var week = ['mon', 'tue', 'wed', 'thu', 'fri','sat','sun'];
	
	$(week).each(function(idx, item){
		$("." + item).each(function() { // 시간표 모든 td들을 불러온다
	    	
	    	var val = $(this).text(); 
	    	
	    	if(val == '' || val == null){ // 값이 비어 있으면 넘어간다.
	    		return true; 
	    	}
	    	
	        var rows = $("." + item + ":contains('" + val + "')"); // 반복 : 해당 td 값과 같은 값을 가진 td를 모두 저장한다 (연달아 있어야 함)
	        if (rows.length > 1) { // td의 수가 2 이상 이면
	            rows.eq(0).attr("rowspan", rows.length); // td를 합치고,
	            rows.not(":eq(0)").remove(); // 첫 td 빼고 삭제한다.
	        }
	    });
	});	
    
}
function delAndMakeTable() {
	var tbHtml = "";
	var num = "";
	for(var i = 1; i <=15; i++){
		$('#time'+i).remove();
		if((i+8)<10){
			num = "0"+(i+8)
		}else{
			num = i+8
		}
		tbHtml +=  '<tr id=time'+i+'>'
		+'<th style="width: 12%; background-color: #F0F0F0; font-weight: bold;">'
		+	i+'교시<br/>'
		+	num+':00 ~ '+num+':50'
		+ '</th>'
		+ '<td class="mon" id="mon'+i+'"style="width: 10%;"></td>  '
		+ '<td class="tue" id="tue'+i+'"style="width: 10%;"></td>  '
		+ '<td class="wed" id="wed'+i+'"style="width: 10%;"></td>  '
		+ '<td class="thu" id="thu'+i+'"style="width: 10%;"></td>  '
		+ '<td class="fri" id="fri'+i+'"style="width: 10%;"></td>  '
		+ '<td class="sat" id="sat'+i+'"style="width: 10%;"></td>  '
		+ '<td class="sun" id="sun'+i+'"style="width: 10%;"></td>  '
	+ '</tr>' ;

	}

	$("#mySchedule > tbody:last").append(tbHtml);
}



$(function () {
	/////////////////////////////////////////////////////////////////화면 로딩시 뿌려질 가장 최근학기 시간표 끝
	const yearVal =$("#selectYear").val();
		const semCodeVal = $("#semCode").val();
		const data = {"year":yearVal,"semCode":semCodeVal};
		console.log("data.year : " + data.year + ", data.semCode : " + data.semCode);
				
		$.ajax({
			type:"post"
			,url:"/professor/schedule/searchSchedule"
			,data:JSON.stringify(data)	//보낼때(request)
			,dataType:"json"	//받을 때(response)
			,contentType:"application/json"
			,cache:false
			,success:function(data){
				console.log(data.length);
				//테이블 초기화
				delAndMakeTable();				
				var count = 0;
				var ori_lectName=[];
				var final_lectName = [];
// 				$("#time15 #mon").text("zzzzzz").css("background-color","red").css("color","white");
				for(var i=0; i<data.length; i++){
					console.log(data[i]);	//데이터 전체
					console.log(data[i].dayCode);	// 데이터 요일 [월,화,수,목,금]
					console.log(data[i].period);	// 데이터 시간
					var day = data[i].dayCode;
					var period = data[i].period;
					var lectName = data[i].lectName;
					var room = data[i].roomIdnNum;
					//중복 이름 제거를 위한 배열
					ori_lectName.push(data[i].lectName);
					if(day =="월"){
						$("#time"+period+" #mon"+period).html('<span style="font-weight:bold;">'+lectName+'</span><br/><span style="font-size:small;">['+room+"]</span>");
					}else if(day =="화"){
						$("#time"+period+" #tue"+period).html('<span style="font-weight:bold;">'+lectName+'</span><br/><span style="font-size:small;">['+room+"]</span>");
					}else if(day =="수"){
						$("#time"+period+" #wed"+period).html('<span style="font-weight:bold;">'+lectName+'</span><br/><span style="font-size:small;">['+room+"]</span>");
					}else if(day =="목"){
						$("#time"+period+" #thu"+period).html('<span style="font-weight:bold;">'+lectName+'</span><br/><span style="font-size:small;">['+room+"]</span>");
					}else if(day =="금"){
						$("#time"+period+" #fri"+period).html('<span style="font-weight:bold;">'+lectName+'</span><br/><span style="font-size:small;">['+room+"]</span>");
					}else if(day =="토"){
						$("#time"+period+" #sat"+period).html('<span style="font-weight:bold;">'+lectName+'</span><br/><span style="font-size:small;">['+room+"]</span>");
					}else if(day =="일"){
						$("#time"+period+" #sun"+period).html('<span style="font-weight:bold;">'+lectName+'</span><br/><span style="font-size:small;">['+room+"]</span>");
					}
						
					
					} //for문 끝
					//이름 중복제거 및 색상 
					$.each(ori_lectName,function(i,value){
					    if(final_lectName.indexOf(value) == -1 ){ 
					    	final_lectName.push(value);
					    }
					});
					
					for(var i=0; i<final_lectName.length; i++){
						$("td:contains('"+final_lectName[i]+"')").addClass("C"+(i+1));
					}
					//셀 병합
// 					$("")
					genRowspan();
					
				} //ajax success 끝
				
		});
	
	///////////////////////////////////////////// 
	$('#selectYear').on('change', function() {
		const yearVal =$(this).val();
		const semCodeVal = $("#semCode").val();
		const data = {"year":yearVal,"semCode":semCodeVal};
		console.log("data.year : " + data.year + ", data.semCode : " + data.semCode);
				
		$.ajax({
			type:"post"
			,url:"/professor/schedule/searchSchedule"
			,data:JSON.stringify(data)	//보낼때(request)
			,dataType:"json"	//받을 때(response)
			,contentType:"application/json"
			,cache:false
			,success:function(data){
				console.log(data.length);
				//테이블 초기화
				delAndMakeTable();				
				var count = 0;
				var ori_lectName=[];
				var final_lectName = [];
// 				$("#time15 #mon").text("zzzzzz").css("background-color","red").css("color","white");
				for(var i=0; i<data.length; i++){
					console.log(data[i]);	//데이터 전체
					console.log(data[i].dayCode);	// 데이터 요일 [월,화,수,목,금]
					console.log(data[i].period);	// 데이터 시간
					var day = data[i].dayCode;
					var period = data[i].period;
					var lectName = data[i].lectName;
					var room = data[i].roomIdnNum;
					//중복 이름 제거를 위한 배열
					ori_lectName.push(data[i].lectName);
					if(day =="월"){
						$("#time"+period+" #mon"+period).html('<span style="font-weight:bold;">'+lectName+'</span><br/><span style="font-size:small;">['+room+"]</span>");
					}else if(day =="화"){
						$("#time"+period+" #tue"+period).html('<span style="font-weight:bold;">'+lectName+'</span><br/><span style="font-size:small;">['+room+"]</span>");
					}else if(day =="수"){
						$("#time"+period+" #wed"+period).html('<span style="font-weight:bold;">'+lectName+'</span><br/><span style="font-size:small;">['+room+"]</span>");
					}else if(day =="목"){
						$("#time"+period+" #thu"+period).html('<span style="font-weight:bold;">'+lectName+'</span><br/><span style="font-size:small;">['+room+"]</span>");
					}else if(day =="금"){
						$("#time"+period+" #fri"+period).html('<span style="font-weight:bold;">'+lectName+'</span><br/><span style="font-size:small;">['+room+"]</span>");
					}else if(day =="토"){
						$("#time"+period+" #sat"+period).html('<span style="font-weight:bold;">'+lectName+'</span><br/><span style="font-size:small;">['+room+"]</span>");
					}else if(day =="일"){
						$("#time"+period+" #sun"+period).html('<span style="font-weight:bold;">'+lectName+'</span><br/><span style="font-size:small;">['+room+"]</span>");
					}
						
					
					} //for문 끝
					//이름 중복제거 및 색상 
					$.each(ori_lectName,function(i,value){
					    if(final_lectName.indexOf(value) == -1 ){ 
					    	final_lectName.push(value);
					    }
					});
					
					for(var i=0; i<final_lectName.length; i++){
						$("td:contains('"+final_lectName[i]+"')").addClass("C"+(i+1));
					}
					//셀 병합
// 					$("")
					genRowspan();
					
				} //ajax success 끝
				
		}); //ajax끝
		
	});

	$('#semCode').on('change', function() {
		const yearVal = $("#selectYear").val();
		const semCodeVal = $(this).val();
		const data = {"year":yearVal,"semCode":semCodeVal};
		console.log("data.year : " + data.year + ", data.semCode : " + data.semCode);
				
		$.ajax({
			type:"post"
			,url:"/professor/schedule/searchSchedule"
			,data:JSON.stringify(data)	//보낼때(request)
			,dataType:"json"	//받을 때(response)
			,contentType:"application/json"
			,cache:false
			,success:function(data){
				console.log(data.length);
				//테이블 초기화
				delAndMakeTable();				
				var count = 0;
				var ori_lectName=[];
				var final_lectName = [];
// 				$("#time15 #mon").text("zzzzzz").css("background-color","red").css("color","white");
				for(var i=0; i<data.length; i++){
					console.log(data[i]);	//데이터 전체
					console.log(data[i].dayCode);	// 데이터 요일 [월,화,수,목,금]
					console.log(data[i].period);	// 데이터 시간
					var day = data[i].dayCode;
					var period = data[i].period;
					var lectName = data[i].lectName;
					var room = data[i].roomIdnNum;
					//중복 이름 제거를 위한 배열
					ori_lectName.push(data[i].lectName);
					if(day =="월"){
						$("#time"+period+" #mon"+period).html('<span style="font-weight:bold;">'+lectName+'</span><br/><span style="font-size:small;">['+room+"]</span>");
					}else if(day =="화"){
						$("#time"+period+" #tue"+period).html('<span style="font-weight:bold;">'+lectName+'</span><br/><span style="font-size:small;">['+room+"]</span>");
					}else if(day =="수"){
						$("#time"+period+" #wed"+period).html('<span style="font-weight:bold;">'+lectName+'</span><br/><span style="font-size:small;">['+room+"]</span>");
					}else if(day =="목"){
						$("#time"+period+" #thu"+period).html('<span style="font-weight:bold;">'+lectName+'</span><br/><span style="font-size:small;">['+room+"]</span>");
					}else if(day =="금"){
						$("#time"+period+" #fri"+period).html('<span style="font-weight:bold;">'+lectName+'</span><br/><span style="font-size:small;">['+room+"]</span>");
					}else if(day =="토"){
						$("#time"+period+" #sat"+period).html('<span style="font-weight:bold;">'+lectName+'</span><br/><span style="font-size:small;">['+room+"]</span>");
					}else if(day =="일"){
						$("#time"+period+" #sun"+period).html('<span style="font-weight:bold;">'+lectName+'</span><br/><span style="font-size:small;">['+room+"]</span>");
					}
						
					
					} //for문 끝
					//이름 중복제거 및 색상 
					$.each(ori_lectName,function(i,value){
					    if(final_lectName.indexOf(value) == -1 ){ 
					    	final_lectName.push(value);
					    }
					});
					
					for(var i=0; i<final_lectName.length; i++){
						$("td:contains('"+final_lectName[i]+"')").addClass("C"+(i+1));
					}
					//셀 병합
// 					$("")
					genRowspan();
					
				} //ajax success 끝
				
		}); //ajax끝
		
		
	}); //semCode change 끝
	
}) // ready function 끝


</script>
</html>