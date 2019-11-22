<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 휴가신청내역조회</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/hr/hrMgnt/VacaMgnt/HRVacaReqAsk.css" />
<style type="text/css">
/* 
	DarkBlue : rgb(19, 64, 116), #134074
	DeepLightBlue : rgb(141, 169, 196), #8DA9C4
	LightBlue : rgb(222,230,239), #DEE6EF
	White : rgb(255,255,255), #FFFFFF
 */
 
</style>

<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){

	dateNext();
	
});

function reloadList(){
	var params = $("#dataForm").serialize();
	$.ajax({
		type : "post",
		url : "HRVacaReqRecListAjax", 
		dataType : "json", 
		data : params,
		success : function(result){
			redrawList(result.list);
			infoDraw();
		},
		error : function(request, status, error){
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + request.error);
		}
	});
}
function infoDraw(){

	var info ="";
	info += "<div id=\"prev\">prev</div>";
	info += "<div id=\"month\">" + $("#stdDate").val() + "</div>";
	info += "<div id=\"next\">next</div>";
	$("#info").html(info);
	$("#next").on("click",function(){
		$("#clickTime").val(($("#clickTime").val())*1 + 1);
		dateNext();
		console.log($("#clickTime").val());
	});
	$("#prev").on("click",function(){
		$("#clickTime").val(($("#clickTime").val())*1 - 1);
		dateNext();
		console.log($("#clickTime").val());
	});
}
function redrawList(list){
	/* dateNext(); */
	
	var html="";
	html += "<tr height= \"20\" id = \"table_color\">"
	html += "<th>번호</th>"
	html += "<th>휴가종류</th>"
	html += "<th>기간</th>"
	html += "<th>신청상태</th>"
	html += "<th></th>"
	html += "</tr>"
	if(list.length == 0){
		html += "<tr><td colspan=\"5\">조회결과가 없습니다</td><tr>";
	} else {
		for(var i = 0; i < list.length; i++){
			if(list[i].CD_NAME == "결재대기"){
				if(i%2==0){
					html += "<tr height= \"20\" class= \"B\" name =\""+ list[i].VACA_REQ_REC_NO+ "\" >";
					html += "<td id = \"번호\">" + (i+1) + "</td>";
					html += "<td id = \"휴가종류\">" + list[i].VACA_NAME + "</td>";
					html += "<td id = \"휴가기간\">" + list[i].START_DATE + " ~ " + list[i].END_DATE + "</td>";
					html += "<td id = \"신청상태\">" + list[i].CD_NAME + "</td>";
					html += "<td><input type=\"button\"  class = \"cancelBtn\" value = \"취소\"/></td>";
					html += "</tr>";
				}else{
					html += "<tr height= \"20\" class= \"A\" name =\""+ list[i].VACA_REQ_REC_NO+ "\" >";
					html += "<td id = \"번호\">" + (i+1) + "</td>";
					html += "<td id = \"휴가종류\">" + list[i].VACA_NAME + "</td>";
					html += "<td id = \"휴가기간\">" + list[i].START_DATE + " ~ " + list[i].END_DATE + "</td>";
					html += "<td id = \"신청상태\">" + list[i].CD_NAME + "</td>";
					html += "<td><input type=\"button\"  class = \"cancelBtn\" value = \"취소\"/></td>";
					html += "</tr>";
				}
			}else{
				if(i%2==0){
					html += "<tr height= \"20\" class= \"B\" name =\""+ list[i].VACA_REQ_REC_NO+ "\" >";
					html += "<td id = \"번호\">" + (i+1) + "</td>";
					html += "<td id = \"휴가종류\">" + list[i].VACA_NAME + "</td>";
					html += "<td id = \"휴가기간\">" + list[i].START_DATE + " ~ " + list[i].END_DATE + "</td>";
					html += "<td id = \"신청상태\">" + list[i].CD_NAME + "</td>";
					html += "<td></td>";
					html += "</tr>";
				}else{
					html += "<tr height= \"20\" class= \"A\" name =\""+ list[i].VACA_REQ_REC_NO+ "\" >";
					html += "<td id = \"번호\">" + (i+1) + "</td>";
					html += "<td id = \"휴가종류\">" + list[i].VACA_NAME + "</td>";
					html += "<td id = \"휴가기간\">" + list[i].START_DATE + " ~ " + list[i].END_DATE + "</td>";
					html += "<td id = \"신청상태\">" + list[i].CD_NAME + "</td>";
					html += "<td></td>";
					html += "</tr>";
				}
			}
		}
	}				

	$("#VacaReqListArea").html(html);
	$(".cancelBtn").on("click",function(){
		$("#vacaReqRecNo").val($(this).parent().parent().attr("name"));
		console.log($("#vacaReqRecNo").val());
		makeConfirm(1,"확인","삭제하시겠습니까?","false",cancelVacaReq);
	});
}
function cancelVacaReq(){
	
	var params = $("#dataForm").serialize();
	$.ajax({
		type : "post",
		url : "HRcancelVacaReqAjax", 
		dataType : "json", 
		data : params,
		success : function(result){
			if(result.res==0){
				makeAlert(2,"실패","삭제에 실패했습니다.","false",null);
			}else{
				makeAlert(2,"성공","삭제에 성공했습니다.","false",null);
			}
			dateNext();
		},
		error : function(request, status, error){
			makeAlert(2,"실패","삭제에 실패했습니다.","false",null);
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + request.error);
		}
	});
}
function dateNext(){

	var params = $("#dataForm").serialize();
	$.ajax({
		type : "post",
		url : "HRdateNextAjax", 
		dataType : "json", 
		data : params,
		success : function(result){
			//redrawList(result.list);
			$("#stdDate").val(result.stdDate);
			$("#endDate").val(result.endDate);
			reloadList();
		},
		error : function(request, status, error){
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + request.error);
		}
	});
} 
</script>
</head>
<body>


<c:import url="/topLeft"> <%-- top이란 주소를 넣어 보여주는 것. --%>
   <%-- <c:param name="topMenuNo" value="49"></c:param>
   <c:param name="leftMenuNo" value="55"></c:param> --%>
  <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
   <c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> 
</c:import>


<div class="content_area">
	<div class="content_nav">HeyWe &gt; 인사 &gt; 인사관리 &gt; 휴가관리&gt; 휴가신청내역조회</div>
	<!-- 내용 영역 -->
	<div class="content_title">
		<div class="content_title_txt">휴가신청내역조회</div>
	</div>
	<div class="content_area_table_area">
	<form action="#" id="dataForm" method="post">
		<input type="hidden" name="vacaReqRecNo" id="vacaReqRecNo"/>
		<input type="hidden" name="stdDate" id="stdDate"/>
		<input type="hidden" name="endDate" id="endDate"/>
		<input type="hidden" name="clickTime" id="clickTime" value="0"/>
		<div id = "info">
	
		</div>
	</form>
		<table id = "table_va" border = "1" cellspacing="0">
			<colgroup>
				<col width="50"/>
				<col width="150"/>
				<col width="300"/>
				<col width="150"/>
				<col width="150"/>
			</colgroup>
			<thead></thead>
			<tbody id="VacaReqListArea">


				
			</tbody>
		</table>
		
		
	</div>
	
	
</div>
<div id="popup"></div>
<div id = "popupBox">
	<div>취소하시겠습니까?</div>
	<input type="button" value = "예" id="yesBtn">
	<input type="button" value = "아니오" id="close">
</div>
</body>
</html>