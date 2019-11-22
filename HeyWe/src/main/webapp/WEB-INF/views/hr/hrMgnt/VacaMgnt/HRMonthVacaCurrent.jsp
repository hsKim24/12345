<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 월별휴가현황</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/hr/hrMgnt/VacaMgnt/HRMonthVacaCurrent.css" />


<link rel="stylesheet" type="text/css"
	href="resources/css/calendar/fullcalendar/fullcalendar.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/calendar/fullcalendar/fullcalendar.min.css" />

<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="resources/script/jquery/moment.min.js"></script>
<script type="text/javascript"
	src="resources/script/calendar/fullcalendar/fullcalendar.js"></script>
<script type="text/javascript"
	src="resources/script/calendar/fullcalendar/lang-all.js"></script>

<script type="text/javascript">
$(document).ready(function(){

/* 
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth() + 1; //January is 0!
	var yyyy = today.getFullYear();

	if (dd < 10) {
		dd = '0' + dd
	}

	if (mm < 10) {
		mm = '0' + mm
	}

	today = yyyy + '-' + mm + '-' + dd;
	$("#selectDate").val(today);
 */
	calAjax();

});
function changeSelect(){
	$("#deptGbn").val($("#deptGbnSelect").val());
	console.log($("#deptGbn").val());
	calAjax();

}

function calendarEvent(cal) {
	var date = new Date();
	var d = date.getDate();
	var m = date.getMonth();
	var y = date.getFullYear();
	var i = 0;
	console.log(cal);
	if (m < 10) {
		m = "0" + m;
	}
	if (d < 10) {
		d = "0" + d;
	}
	for(var i = 0 ; i < cal.length ; i++) {
		if(cal[i].color == "#ffff00") {
			cal[i].textColor = "#000000";
		}
	}
	$("#calender").fullCalendar(
			{
				lang : "ko",
				height : 460,
				displayEventTime: false,
				events : cal
				/*  
				[ {

					title : "계획1",
					start : "2019-07-02",
					end : "2019-07-08:",
					color : 'yellow', // 기타 옵션들
					textColor : 'black',
					ename : "강호빈"

				}, {
					title : cal[0].ACTIVITY_CON,
					start : cal[0].START,
					end : '2019-07-08'
				} ]
				 */
				,
				//Event Click
				eventClick : function(event, element) {
					$("#stdDate").val(event.start.format());
					console.log($("#stdDate").val());
					makePopup(1, "사원조회", empPopup() , true, 700, 346, function(){
						$("#listDiv").slimScroll({
							height: "170px",
							axis: "both"
						});
						popUpSearch();
					}, "확인",function(){
						closePopup(1);
					});

				},
				dayClick : function(date) {
/* 					alert(date.format() + 'a day has been clicked!');
					$(".mokT2_2").text(date.format());
					$("#selectDate").val(date.format());

					reloadCalList(); */
				}
			});
/* 	// 왼쪽 버튼을 클릭하였을 경우
    $("button.fc-today-button").click(function() {
        console.log("today");
    });
	
	// 왼쪽 버튼을 클릭하였을 경우
    $("button.fc-prev-button").click(function() {
        console.log("prev");
    });

    // 오른쪽 버튼을 클릭하였을 경우
    $("button.fc-next-button").click(function() {
        console.log("next");
    }); */
}
function drawEmpSearchList(list){
	var html = "";
	
	if(list.length == 0){
		html += "<tr class=\"odd_row\"><td colspan=\"4\"></td></tr>";
		html += "<tr class=\"even_row\"><td colspan=\"4\"></td></tr>";
		html += "<tr class=\"odd_row\"><td colspan=\"4\"></td></tr>";
		html += "<tr class=\"even_row\"><td colspan=\"4\">검색결과가 없습니다</td></tr>";
		html += "<tr class=\"odd_row\"><td colspan=\"4\"></td></tr>";
		html += "<tr class=\"even_row\"><td colspan=\"4\"></td></tr>";
		html += "<tr class=\"odd_row\"><td colspan=\"4\"></td></tr>";
	}else {
		for(var i = 0 ; i < list.length ; i++){
			if(i % 2 == 0){
				html += "<tr class=\"odd_row\" name=\""+ list[i].EMP_NO + "\">";
			}else {
				html += "<tr class=\"even_row\" name=\""+ list[i].EMP_NO + "\">";
			}
			html += "<td>" + list[i].DEPT_NAME + "</td>";
			html += "<td>" + list[i].POSI_NAME + "</td>";
			html += "<td>" + list[i].TITLE + "</td>";
			html += "<td>" + list[i].VACA_NAME + "</td>";
			html += "<td>" + list[i].START + " ~ " + list[i].END + "</td>";
			html += "</tr>";
		}
	}
	
	$("#listCon tbody").html(html);
}

function popUpSearch(){
		
	var params = $("#dataForm").serialize(); 
	
	$.ajax({
		type : "post",
		url : "HRVacaReqDtlAjax",
		dataType : "json",
		data : params,
		success : function(result){
			drawEmpSearchList(result.list);
		},
		error : function(request, status, error){
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}

function empPopup(){
	var html="";
	
	html += "<div id=\"list\">";
	html += "<table id=\"listTop\">";
	html += 	"<colgroup>";
	html += 		"<col width=\"100px\">";
	html += 		"<col width=\"90px\">";
	html += 		"<col width=\"90px\">";
	html += 		"<col width=\"90px\">";
	html += 		"<col width=\"260px\">";
	html +=		"</colgroup>";
	html += 	"<tr>";
	html += 		"<th>부서명</th>";
	html += 		"<th>이름</th>";
	html += 		"<th>직위</th>";
	html += 		"<th>휴가명</th>";
	html += 		"<th>날짜</th>";
	html += 	"</tr>";
	html += "</table>";
	html += 	"<div id=\"listDiv\">";
	html += "<table id=\"listCon\">";
	html += "<colgroup>";
	html += 		"<col width=\"100px\">";
	html += 		"<col width=\"90px\">";
	html += 		"<col width=\"90px\">";
	html += 		"<col width=\"90px\">";
	html += 		"<col width=\"260px\">";
	html += "</colgroup>";
	html += "<tbody>";
	html += "</tbody>";
	html += "</table>";
	html += "</div>";
	html += "</div>";
	
	return html;
}

function calAjax() {
	var params = $("#dataForm").serialize();
	$.ajax({
		type : "post",
		url : "HRcalAjax",
		dataType : "json",
		data : params, 
		success : function(result) {
			
			calendarEvent(result.cal);
			var oldEvents = $("#calender").fullCalendar("getEventSources");
			$("#calender").fullCalendar("removeEventSources", oldEvents);
			$("#calender").fullCalendar("refetchEvents");
			$("#calender").fullCalendar("addEventSource", result.cal);
			$("#calender").fullCalendar("refetchEvents");
		},
		error : function(request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}
</script >
</head>
<body>

<c:import url="/topLeft"> <%-- top이란 주소를 넣어 보여주는 것. --%>
  <%--  <c:param name="topMenuNo" value="49"></c:param>
   <c:param name="leftMenuNo" value="55"></c:param> --%>
   <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
   <c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> 
</c:import>


		
<div class="content_area">
	<div class="content_nav">HeyWe &gt; 인사 &gt; 인사관리 &gt; 휴가관리&gt; 월별휴가현황</div>
	<!-- 내용 영역 -->
	<div class="content_title">
		<div class="content_title_txt">월별 휴가 현황</div>
	</div>
	<div class="content_area_table_area">
		<div id="seldiv">
			<div style="display : inline-block;">부서별</div> 
			<select id = "deptGbnSelect" style="height:24px;width:80px;" onchange="changeSelect()" >
				<!-- 내 부서 먼저 출력 -->
				<option value="${sDeptName}">${sDeptName}</option>
				<c:forEach var="data"  items="${deptList}">
				<!-- 부서이름 뽑아오기 -->
					<c:if test="${sDeptName ne data.DEPT_NAME}">
							<option value="${data.DEPT_NAME}">${data.DEPT_NAME}</option>
					</c:if>
				</c:forEach>
			</select>
		</div>
		<div id="rgbDiv">
			<div>겹치는 인원 기준</div>
			<div id="green">~4</div>
			<div>양호</div>
			<div id="yellow">~9</div>
			<div>다소 고려</div>
			<div id="red">10~</div>
			<div>비 권장</div>
		</div>
	</div>
	<div class="rcal" id="calender" style ="width: 920px;
    margin-left: 99px;font-size: 10pt!important;"></div>
</div>
		<form action="#" id="dataForm" method="post">
			<input type="hidden" id="deptGbn" name="deptGbn" value="${sDeptName}"/>
			<input type="hidden" id="stdDate" name="stdDate"/>
		</form>
		
	

</body>
</html>