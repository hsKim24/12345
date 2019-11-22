<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 영업협상현황</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/crm/sa_status_chance.css" />
<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.css" />
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css" href="resources/css/common/calendar.css" />
<link rel="stylesheet" type="text/css" href="resources/css/calendar/calendar.css" />
<style type="text/css">
	.ui-datepicker select.ui-datepicker-month {
	    width: 40%;
	    font-size: 11px;
	}
	.ui-datepicker select.ui-datepicker-year {
	    width: 48%;
	    font-size: 11px;
	}
</style>
<script type="text/javascript" src="resources/script/calendar/calendar.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	if($("#page").val()==""){
		$("#page").val("1");
	} 
	reloadList();
	reloadDept();
	reloadEmp();
	reloadPse();
	$("#pagingArea").on("click", "input", function(){
		$("#page").val($(this).attr("name"));
		reloadList(); 
	});
	$("#select3").on("change", function(){
		$("#check3").val($(this).val());
		$("#check4").val(444);
		reloadEmp();
	});
	$("#select4").on("change", function(){
		$("#check4").val($(this).val());
	});
	$("#select5").on("change", function(){
		$("#check5").val($(this).val());
	});
	$("#searchBtn").on("click", function(){
		$("#page").val("1"); 
		reloadList();
	});
	$("#chancelist").on("click", "tr" , function(){
		if($(this).attr("id")=="seltr"){
			$("#markNo").val($(this).attr("name"));
			$("#dataForm").attr("action", "CRMMarkMgntNegoAsk");
			$("#dataForm").submit();
		}
	});
	$.datepicker.setDefaults({
		monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
		monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		showMonthAfterYear:true,
		showOn: 'both',
		closeText: '닫기',
		changeYear: true,
		changeMonth: true,
		buttonImage: 'resources/images/calender.png',
		buttonImageOnly: true,
		dateFormat: 'yy/mm/dd',
		yearRange: '-100y:+0d'
	});  
	
	$("#date_start").datepicker({
		dateFormat : 'yy-mm-dd',
		duration: 200,
		onSelect:function(dateText, inst){
			var startDate = parseInt($("#date_end").val().replace("-", '').replace("-", ''));
			var endDate = parseInt(dateText.replace(/-/g,''));
			
            if (endDate > startDate) {
            	alert("조회 기간은 과거로 설정하세요.");
            	//달력에 종료 날짜 넣어주기
        		$("#date_start").val($("#stdt").val());
			} else {
				$("#stdt").val($("#date_start").val());
			}
		}
	});
	
	$("#date_end").datepicker({
		dateFormat : 'yy-mm-dd',
		duration: 200,
		onSelect:function(dateText, inst){
			var startDate = parseInt($("#date_start").val().replace("-", '').replace("-", ''));
			var endDate = parseInt(dateText.replace(/-/g,''));
			
            if (startDate > endDate) {
            	alert("조회 기간은 과거로 설정하세요.");
            	//달력에 종료 날짜 넣어주기
        		$("#date_end").val($("#eddt").val());
			} else {
				$("#eddt").val($("#date_end").val());
			}
		}
	});
	$("#refreshBtn").on("click", function(){
		$("#date_start").val("");
		$("#date_end").val("");
		$("#stdt").val("");
		$("#eddt").val("");
	});
	
	$("#writeBtn").on("click", function(){
		$("#dataForm").attr("action", "NegoWrite");
		$("#dataForm").submit();
	});
});
//아작스
function reloadList(){
	var params = $("#dataForm").serialize(); 
	$.ajax({
		type : "post",
		url : "CRMMMNListAjax",
		dataType : "json",
		data : params,
		success : function(result){
			redrawList(result.list);
			redrawPaging(result.pb);
			redrawCnt(result.totalCnt);
		},
		error : function(request, status, error){
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}

function reloadDept(){
	var params = $("#dataForm").serialize(); 
	$.ajax({
		type : "post",
		url : "MCCsel3Ajax",
		dataType : "json",
		data : params,
		success : function(result){
			redrawDept(result.dept);
		},
		error : function(request, status, error){
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}

function reloadEmp(){
	var params = $("#dataForm").serialize();
	$.ajax({
		type : "post",
		url : "MCCsel4Ajax",
		dataType : "json",
		data : params,
		success : function(result){
			redrawEmp(result.emp);
		},
		error : function(request, status, error){
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}

function reloadPse(){
	var params = $("#dataForm").serialize();
	$.ajax({
		type : "post",
		url : "MCCsel5Ajax",
		dataType : "json",
		data : params,
		success : function(result){
			redrawPse(result.pse);
		},
		error : function(request, status, error){
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}

//함수
function redrawList(list){
	var html="";
	
	for(var i = 0 ; i<list.length; i++){
			if(i%2==0){
				html +="<tr class=\"mok2t_0\" id=\"seltr\" name="+ list[i].MARK_NO +">"
				html +="<th>"+ list[i].MARK_NAME +"</th>"
				html +="<th>"+ list[i].CSTM_NAME +"</th>"
				html +="<th>"+ list[i].MNGR_NAME +"</th>"
				html +="<th>"+ list[i].EMP_NAME +"</th>"
				html +="<th>"+ list[i].PSE_NAME +"</th>"
				html +="</tr>"
			}
			else{
				html +="<tr class=\"mok2t_1\" id=\"seltr\" name="+ list[i].MARK_NO +">"
				html +="<th>"+ list[i].MARK_NAME +"</th>"
				html +="<th>"+ list[i].CSTM_NAME +"</th>"
				html +="<th>"+ list[i].MNGR_NAME +"</th>"
				html +="<th>"+ list[i].EMP_NAME +"</th>"
				html +="<th>"+ list[i].PSE_NAME +"</th>"
				html +="</tr>"
			}
		}
		if(list.length%2!=0){
		for(var i=0; i<10-list.length; i++){
			if(i%2!=0){
				html +="<tr class=\"mok2t_0\" id=\"Nseltr\" >"
					html +="<th></th>"
						html +="<th></th>"
						html +="<th></th>"
						html +="<th></th>"
						html +="<th></th>"
				html +="</tr>"
			}
			else{
				html +="<tr class=\"mok2t_1\" id=\"Nseltr\" >"
				html +="<th></th>"
				html +="<th></th>"
				html +="<th></th>"
				html +="<th></th>"
				html +="<th></th>"
				html +="</tr>"
			}
		}
	}
	else{
		for(var i=0; i<10-list.length; i++){
			if(i%2==0){
				html +="<tr class=\"mok2t_0\" id=\"Nseltr\" >"
					html +="<th></th>"
						html +="<th></th>"
						html +="<th></th>"
						html +="<th></th>"
						html +="<th></th>"
				html +="</tr>"
			}
			else{
				html +="<tr class=\"mok2t_1\" id=\"Nseltr\" >"
				html +="<th></th>"
				html +="<th></th>"
				html +="<th></th>"
				html +="<th></th>"
				html +="<th></th>"
				html +="</tr>"
			}
		}
	}
		$("#chancelist").html(html)
	}
	
function redrawCnt(totalCnt){
	var html="";
				html += totalCnt
				html += "건"
		$("#total2").html(html)
	}
	
function redrawPaging(pb){
	var html = "";
	
	if($("#page").val() == "1"){
		html += "<input type=\"button\" class =\"preBtn\"value=\"◀\"name=\"1\"/>";		
	}
	else{
		html += "<input type=\"button\" class =\"preBtn\"value=\"◀\"name=\"" + ($("#page").val()*1-1)+"\" />";
	}	
	
	
	for(var i = pb.startPcount ; i<= pb.endPcount ; i++){
		if(i == $("#page").val()){
			html += "<input type=\"button\" class =\"numberBtn\" value=\""+ i + "\" disabled=\"disabled\" />";
		}
		else{
			html += "<input type=\"button\" class =\"numberBtn\" value=\"" + i + "\"name=\"" + i + "\" />";
		}
	}
	
	
	if($("#page").val() == pb.maxPcount){
		html += "<input type=\"button\" class =\"nextBtn\"value=\"▶\" name=\"" + pb.maxPcount + "\" />";
	}
	else{
		html += "<input type=\"button\" class =\"nextBtn\" value=\"▶\"name=\"" + ($("#page").val()*1+1)+"\" />";
	}
	
	$("#pagingArea").html(html);
	$("#pagingArea input[type='button']").button();
}

function redrawDept(dept){
	var html="";
	html += "<option value=\"333\">부서(전체)</option>"
	for(var i = 0 ; i<dept.length; i++){ 
		html += "<option value=\""+ dept[i].DEPT_NO +"\">"+ dept[i].DEPT_NAME +"</option>"
	}
	$("#select3").html(html)
}

function redrawEmp(emp){
	var html="";
	html += "<option value=\"444\">사원(전체)</option>"
	for(var i = 0 ; i<emp.length; i++){
		html += "<option value="+ emp[i].EMP_NO +">"+ emp[i].NAME +"</option>"
	}
	$("#select4").html(html)
}

function redrawPse(pse){
	var html="";
	html += "<option value=\"555\">진행상태(전체)</option>"
	for(var i = 0 ; i<pse.length; i++){
		html += "<option value="+ pse[i].PROGRESS_STATE_NO +">"+ pse[i].NAME +"</option>"
	}
	$("#select5").html(html)
}

</script>
</head>
<body>
<c:import url="/topLeft">
	<c:param name="topMenuNo" value="17"></c:param>
	<c:param name="leftMenuNo" value="23"></c:param>
</c:import> 
	<div class="content_area">
		<div class="content_nav">HeyWe &gt; CRM &gt; 영업관리 &gt; 협상</div>
		<div class="content_title">협상 관리</div>
			<div class="writeDiv">
			<c:if test="${auth eq 3}">
			<img src="resources/images/erp/crm/write.png" id="writeBtn" style="cursor:pointer" />
			</c:if>
		</div>
		<div class="mok">
		<form action="#" id="dataForm" method="post">
		<input type="hidden" name="page" id="page" value="${page}">
		<input type="hidden" name="check1" id="check1">
		<input type="hidden" name="check2" id="check2">
		<input type="hidden" name="check3" id="check3">
		<input type="hidden" name="check4" id="check4">
		<input type="hidden" name="check5" id="check5">
		<input type="hidden" name="markNo" id="markNo">
		<input type="hidden" id="stdt" name="stdt" value="${stdt}" />
		<input type="hidden" id="eddt" name="eddt" value="${eddt}" />
			<div class="search">
				<div class="search2">
				<input type="text" placeholder="영업명을 입력해주세요." id="select1" name="select1"/>
				<input type="text" placeholder="고객 또는 고객사명을 입력해주세요." id="select2" name="select2"/> <br /><br />
				</div>
				<div class="search1">
				<select name="searchGbn" id="searchGbn">
	            	<option value="0">영업시작일</option>
	            	<option value="1">영업종료일</option>
	            </select>
	               <input type="text" class="txtt2" title="시작기간선택" id="date_start" name="date_start" value="" readonly="readonly" placeholder="시작일"/>~
	               <input type="text" class="txtt2_2" title="종료기간선택" id="date_end" name="date_end" value="" readonly="readonly" placeholder="종료일"/>
	               <input type="button" value="날짜초기화" id="refreshBtn">
	               <br/><div id="calendarArea"></div> 
	               <br/><br/>
	            </div>
				<div class="search3">  
					<select id="select3">
					</select>
					<select id="select4">
					</select>
					<select id="select5">
					</select>
					<img src="resources/images/erp/crm/search.png" id="searchBtn" style="cursor:pointer" />
				</div>
			</div>
			<div class="status">
				<div id="total1">전체</div>
				<div id="total2"></div>
			</div>
			<div class="mok2">
				<div class="mok2_1">
					<table class="mok2_1_1" cellspacing="0">
						<thead>
							<tr class="mok2t">
								<th width="20%">영업명</th>
								<th width="20%">고객사</th>
								<th width="15%">고객</th>
								<th width="15%">담당자</th>
								<th width="15%">진행상태</th>
							</tr>
						</thead>
						<tbody id="chancelist">
						</tbody>
					</table>
					<div id="pagingArea" class="pageArea"></div>
				</div>
			</div>
			</form>
		</div>
	</div>
</body>
</html>