<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 결재상태</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/hr/hrMgnt/hrApnt/hrApntApvState.css" />
<style type="text/css">
/* 
	DarkBlue : rgb(19, 64, 116), #134074
	DeepLightBlue : rgb(141, 169, 196), #8DA9C4
	LightBlue : rgb(222,230,239), #DEE6EF
	White : rgb(255,255,255), #FFFFFF
 */
</style>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var date = new Date();

		var daysago = 30;
		var oldday = new Date(Date.parse(date)-(3600000*24*daysago));
		var nextday = new Date(Date.parse(date)+(3600000*24*daysago));
		
		var startDate = oldday.getFullYear() + "-" + leadingZeros(oldday.getMonth() + 1, 2) + "-" + leadingZeros(oldday.getDate(),2);
		var endDate = nextday.getFullYear() + "-" + leadingZeros(nextday.getMonth() + 1, 2) + "-" + leadingZeros(nextday.getDate(),2);
		
		$("#start_date").val(startDate);
		$("#startDate").val(startDate);
		$("#end_date").val(endDate);
		$("#endDate").val(endDate);
		
		if($("#hrApntApvStatePage").val() == ""){
			$("#hrApntApvStatePage").val("1");
		}
		
		redraw();
		
		$(".paging_group").on("click", "input", function(){
			$("#hrApntApvStatePage").val($(this).attr("name"));
			
			redraw();
		});
		
		$(".apvStateList tbody").on("click", "tr", function(){
			if($(this).attr("name") == "0"){
				makeAlert(1, "발령사유", $(this).children(".apntNote").html(), true, null);
			}
		});
	});
	
	function leadingZeros(n, digits) {
		var zero = '';
		n = n.toString();

		if (n.length < digits) {
			for (i = 0; i < digits - n.length; i++)
			zero += '0';
		}
		return zero + n;
	}
	
	function redraw(){
		var params = $("#actionForm").serialize();
		$.ajax({
			type : "post",
			url : "HRHrApntApvStateAjax",
			dataType : "json",
			data : params,
			success : function(result){
				drawList(result.list);
				drawPaging(result.pb);
			},
			error : function(request, status, error){
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}
	
	function drawList(list){
		var html = "";

		for(var i = 0 ; i < 10 ; i++){
			if(i < list.length){
				if(i % 2 == 0){
					html += "<tr class=\"odd_row\" name=\"0\" >";
				} else {
					html += "<tr class=\"even_row\" name=\"0\" >";
				}
				
				html += "<td>"+ list[i].RNUM +"</td>";
				html += "<td>"+ list[i].NAME +"</td>";
				html += "<td>"+ list[i].EMP_NO +"</td>";
				html += "<td>"+ list[i].POSI_NAME +"</td>";
				html += "<td>"+ list[i].DEPT_NAME +"</td>";
				html += "<td>"+ list[i].APNT_DATE +"</td>";
				html += "<td>"+ list[i].APV_STATE +"</td>";
				html += "<td>"+ list[i].HR_APNT_NO +"</td>";
				html += "<td style=\"display:none;\" class=\"apntNote\">" + list[i].APNT_REASON + "</td>";
				html += "</tr>";
				
			}else {
				if(i % 2 == 0){
					if(i == 4 && list.length == 0){
						html += "<tr class=\"odd_row\" name=\"1\" ><td colspan=\"8\">결과가 존재하지 않습니다</td>";
						$("#hrApntApvStatePage").val("1");
					}else {
						html += "<tr class=\"odd_row\" name=\"1\" ><td colspan=\"8\"></td>";
					}
				} else {
					html += "<tr class=\"even_row\" name=\"1\" ><td colspan=\"8\"></td>";
				}
				html += "</tr>";
			}
			
		}
		
		$(".apvStateList tbody").html(html);
		
		
	}
	
	function drawPaging(pb){
		var html = "";
		html += "<input type=\"button\" value=\"&lt&lt\" name=\"1\" >";
		
		if($("#hrApntApvStatePage").val() == "1"){
			html += "<input type=\"button\" value=\"&lt\" name=\"1\" >";
		} else {
			html += "<input type=\"button\" value=\"&lt\" name=\"" + ($("#hrApntApvStatePage").val() * 1 - 1) + "\">";
		}
		
		for(var i = pb.startPcount ; i <= pb.endPcount ; i++){
			if(i == $("#hrApntApvStatePage").val()){
				html += "<input type=\"button\" value=\"" + i + "\" name=\"" + i + "\" disabled=\"disabled\" class=\"paging_on\">";
			} else {
				html += "<input type=\"button\" value=\"" + i + "\" name=\"" + i +  "\" class=\"paging_off\">";
			}
		}
		
		if($("#hrApntApvStatePage").val() == pb.maxPcount) {
			html += "<input type=\"button\" value=\"&gt\" name=\"" + pb.maxPcount +  "\">"; 
		}else {
			html += "<input type=\"button\" value=\"&gt\" name=\"" + ($("#hrApntApvStatePage").val() * 1 + 1) +   "\">";
		}
		
		html += "<input type=\"button\" value=\"&gt&gt\" name=\"" + pb.maxPcount +  "\">";
		
		$(".paging_group").html(html);
	}
</script>
</head>
<body>

<form action="#" id="actionForm" method="post">
	<input type="hidden" id="hrApntApvStatePage" name="hrApntApvStatePage" value="${hrApntApvStatePage}">
	<input type="hidden" id="startDate" name="startDate">
	<input type="hidden" id="endDate" name="endDate">
</form>

<c:import url="/topLeft">
	<c:param name="topMenuNo" value="49"></c:param>
	<c:param name="leftMenuNo" value="54"></c:param>
	<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
</c:import>

<div class="content_area">
	<div class="content_nav">HeyWe &gt; 인사 &gt; 인사관리 &gt; 인사발령 &gt; 결재상태</div>
	<!-- 내용 영역 -->
	<div class="content_title">
     	<div class="content_title_text">결재상태</div>
	</div>
	
	<div class="content_box">
		<div class="content_box_calendar_row">
			<!-- 캘린더 --> 
			<input type="text" size="10" class="calecdar_data_input" readonly="readonly" id="start_date">
			 ~
			<input type="text" size="10" class="calecdar_data_input" readonly="readonly" id="end_date">
		</div>
		
		<div class="content_table">
			<table class="apvStateList">
				<colgroup>
					<col width="150">
					<col width="160">
					<col width="150">
					<col width="150">
					<col width="150">
					<col width="150">
					<col width="150">
					<col width="150">
				</colgroup>
				<thead>
					<tr>
						<td>No</td>
						<td>이름</td>
						<td>사번</td>
						<td>직위</td>
						<td>부서</td>
						<td>발령일자</td>
						<td>결재상태</td>
						<td>인사발령번호</td>
						<td style="display:none;">
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
			
			<div class="paging_group">
			</div>
		</div>
	</div>
</div>
</body>
</html>
