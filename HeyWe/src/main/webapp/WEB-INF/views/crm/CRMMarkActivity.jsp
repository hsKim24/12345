<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 영업활동 메인</title>
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/crm/sa_plan_cal.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/calendar/fullcalendar/fullcalendar.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/jquery/jquery-ui.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/calendar/fullcalendar/fullcalendar.min.css" />

<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="resources/script/jquery/jquery-ui.js"></script>
<script type="text/javascript"
	src="resources/script/jquery/moment.min.js"></script>
<script type="text/javascript"
	src="resources/script/calendar/fullcalendar/fullcalendar.js"></script>
<script type="text/javascript"
	src="resources/script/calendar/fullcalendar/lang-all.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		if ($("#page").val() == "") {
			$("#page").val("1");
		}

		$("#pen").on("click", function() {
			location.href = "CRMMarkActivityWrite"
		})
		$(".mokTxt").on("click", function() {
			location.href = "CRMMarkActivityList";
		})
		$(".calTxt").on("click", function() {
			location.href = "CRMMarkActivity";
		})

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
		$(".mokT2_2").text(today);
		$("#selectDate").val(today);
		reloadCalList();

		calAjax();
		$("#pagingArea").on("click", "input", function() { // 페이징 영역

			$("#page").val($(this).attr("name"));
			reloadCalList();

		});

		$(".mokT_3").on("click", function() {
			alert("ㅎㅇㅎㅇ")
		})
		//calendarEvent(null);

	});

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

		$("#calender").fullCalendar({

			lang : "ko",
			height : 460,
			displayEventTime : false,
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
			/* eventClick : function(event, element) {
				//이벤트 수정
				//event.title = "CLICKED!";
				//$("#calender").fullCalendar('updateEvent', event);
				console.log(event.ename);

				makeNoBtnPopup(1, "일정보기", event.title + "-"
						+ event.ename + "<br/>" + event.activity_con,
						true, 500, 500, null, null);
			}, */
			dayClick : function(date) {
				$(".mokT2_2").text(date.format());
				$("#selectDate").val(date.format());

				reloadCalList();
			}
		});

	}

	function reloadCalList() {
		var params = $("#dataForm").serialize();

		$.ajax({

			type : "post",

			url : "reloadCalMainListAjax",

			dataType : "json",

			data : params,

			success : function(result) {
				CalList(result.callist);
				redrawPaging(result.pb);
			},
			error : function(request, status, error) {

				console.log("status : " + request.status);

				console.log("text : " + request.responseText);

				console.log("error : " + error);
			}
		});
	}

	function CalList(callist) {

		var html = ""

		if (callist.length == 0) {
			html += "<tr>"
			html += "<td class=\"day_Mok\">해당 날짜에는 일정이 없습니다. </br></td></tr>"
		} else {

			html += "<tr class=\"calHeader\" border=\"1px\"> <td class=\"mokT_1\" border=\"1px\"> 단계</td>"
			html += " <td class=\"mokT_2\">시간</td>"
			html += " <td class=\"mokT_3\">제목</td></tr>"

			for (var i = 0; i < callist.length; i++) {

				html += "<tr> <td class=\"mokT_1\">"
				if (callist[i].COLOR == '#ED1C24') {
					html += "<img alt=\"red2\" src=\"resources/images/erp/crm/red2.png\" id=\"red2\"></td>"
				} else if (callist[i].COLOR == '#00A2E8') {
					html += "<img alt=\"blue2\" src=\"resources/images/erp/crm/blue2.png\" id=\"blue2\">"
				} else if (callist[i].COLOR == '#22B14C') {
					html += "<img alt=\"green2\" src=\"resources/images/erp/crm/green2.png\" id=\"green2\">"
				} else if (callist[i].COLOR == '#FFC90E') {
					html += "<img alt=\"yellow2\" src=\"resources/images/erp/crm/yellow2.png\" id=\"yellow2\">"
				}

				html += "<td class=\"mokT_2\">" + callist[i].START + " ~ "
						+ callist[i].END + " </td>"
				html += "<td class=\"mokT_3\">" + callist[i].TITLE
						+ "</br></td></tr>"

			}
			for (var i = 0; i < 5 - callist.length; i++) {
				html += "<tr><td></td></tr>"
			}
			html += "<tr id =\"pageBtn\"> </tr>"
		}

		$(".mokT").html(html);

	}

	function redrawPaging(pb) {

		var html = "";

		if ($("#page").val() == "1") {
			/* html += "<div class="pageBtn_1" >◀</div>" */
			html += "<input type=\"button\" id=\"pagetest\" value=\"<\" name=\"1\" />";

		} else {

			html += "<input type=\"button\" id=\"pagetest\" value=\"<\" name=\""

					+ ($("#page").val() * 1 - 1) + "\" />";

		}

		for (var i = pb.startPcount; i <= pb.endPcount; i++) {

			if (i == $("#page").val()) {

				html += "<input type=\"button\" id=\"pagetest\" value=\"" + i + "\" name=\""  + i + "\" disabled=\"disabled\" />";

			} else {

				html += "<input type=\"button\"id=\"pagetest\" value=\"" + i + "\" name=\"" + i + "\" />";

			}

		}

		if ($("#page").val() == pb.maxPcount) {

			html += "<input type=\"button\" id=\"pagetest\" value=\">\" name=\""
					+ pb.maxPcount + "\" />";

		} else {

			html += "<input type=\"button\" id=\"pagetest\" value=\">\" name=\""

					+ ($("#page").val() * 1 + 1) + "\" />";

		}

		$("#pagingArea").html(html);
		$("#pagingArea input[type='button']").button();
	}

	function calAjax() {

		var params = $("#dataForm").serialize();

		$.ajax({

			type : "post",

			url : "calAjax",

			dataType : "json",

			data : params,

			success : function(result) {

				calendarEvent(result.cal);

			},
			error : function(request, status, error) {

				console.log("status : " + request.status);

				console.log("text : " + request.responseText);

				console.log("error : " + error);
			}
		});
	}
</script>
</head>
<body>
	<c:import url="/topLeft">
		<c:param name="topMenuNo" value="17"></c:param>
		<c:param name="leftMenuNo" value="19"></c:param>
		<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
	</c:import>
	<div class="content_area">
		<div class="content_nav">HeyWe &gt; CRM &gt; 영업활동 &gt; 일정</div>
		<div class="content_title">영업활동</div>
		<div class="calmok">
			<div class="calTxt" style="cursor: pointer">일정</div>
			<div class="mokTxt" style="cursor: pointer">목록</div>
		</div>
		<form action="#" id="dataForm" method="post">
			<input type="hidden" id="selectDate" name="selectDate" /> <input
				type="hidden" id="sch" name="sch" value="1" /> <input type="hidden"
				id="page" name="page" value="${param.page}" />
		</form>
		<div class="calmok2">
			<div class="cal">
				<div class="rcal" id="calender"></div>
				<div class="bumju">
					<div class="bumju1">
						<div class="bumju1_1">
							<img alt="red" id="redBtn" src="resources/images/erp/crm/red.png">
						</div>
						<div class="bumju1_2">기회</div>
					</div>
					<div class="bumju2">
						<div class="bumju2_1">
							<img alt="blue" id="blueBtn"
								src="resources/images/erp/crm/blue.png">
						</div>
						<div class="bumju2_2">제안</div>
					</div>
					<div class="bumju3">
						<div class="bumju3_1">
							<img alt="green" id="greenBtn"
								src="resources/images/erp/crm/green.png">
						</div>
						<div class="bumju3_2">협상</div>
					</div>
					<div class="bumju4">
						<div class="bumju4_1">
							<img alt="yellow" id="yellowBtn"
								src="resources/images/erp/crm/yellow.png">
						</div>
						<div class="bumju4_2">계약</div>
					</div>
				</div>
			</div>
			<div class="mok">
				<div class="mok2">
					<div class="mok2_1">
						<table class="mokT2">
							<tr>
								<td class="mokT2_1"><img alt="cal" src="resources/images/erp/crm/cal.png" width="35px" height="35px" id="cal"></td>
								<td class="mokT2_2">19 . 04 . 25</td>
								<c:if test="${auth eq 3}">
								<td class="mokT2_3"><img alt="pen" src="resources/images/erp/crm/pen.png" width="35px" height="35px" id="pen" style="cursor: pointer"></td>
								</c:if>
							</tr>
						</table>
					</div>
					<div class="mok2_2">
						<table class="mokT">

						</table>
						<div id="pagingArea"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>