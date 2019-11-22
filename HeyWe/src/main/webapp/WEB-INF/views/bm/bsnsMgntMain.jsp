<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>HeyWe - 경영관리 메인</title>
		<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
		<link rel="stylesheet" type="text/css" href="resources/css/erp/bm/bsnsMgntMainStyle.css"/>
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
		$(document).ready(function() {
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
			$(".schListDateTableCon").text(today);
			$("#selectDate").val(today);
			reloadCalList();

			BMCalAjax();
			//calendarEvent(null);
		});
		
		function reloadCalList() {
			var params = $("#dataForm").serialize();

			$.ajax({
				type : "post",
				url : "BMSchListAjax",
				dataType : "json",
				data : params,
				success : function(result) {
					CalList(result.list);
				},
				error : function(request, status, error) {
					console.log("status : " + request.status);
					console.log("text : " + request.responseText);
					console.log("error : " + error);
				}
			});
		}

		function CalList(list) {
			var html = ""

			for (var i = 0; i < list.length; i++) {
				html += "<tr> <td class=\"schListConTable_1\">"
				if (list[i].LOAN_DIV_NO == '1') {
					html += "<img alt=\"red2\" src=\"resources/images/erp/crm/red2.png\" id=\"red2\"></td>"
				} else if(list[i].LOAN_DIV_NO=='2') {
					html += "<img alt=\"blue2\" src=\"resources/images/erp/crm/blue2.png\" id=\"blue2\">"
				} 

				html += "<td width=\"180\" class=\"schListConTable_2\">" + list[i].START + " ~ "
						+ list[i].END + " </td>"
				html += "<td class=\"schListConTable_3\">" + list[i].TITLE + "</br>"
						+ list[i].NAME + "</td></tr>"
			}
			$(".schListConTable").html(html);
		}

		function BMCalAjax() {
			var params = $("#dataForm").serialize();

			$.ajax({
				type : "post",
				url : "BMCalAjax",
				dataType : "json",
				data : params, 
				success : function(result) {
					calEvent(result.data);
				},
				error : function(request, status, error) {
					console.log("status : " + request.status);
					console.log("text : " + request.responseText);
					console.log("error : " + error);
				}
			});
		}
		
		function calEvent(data) {
			var date = new Date();
			var d = date.getDate();
			var m = date.getMonth();
			var y = date.getFullYear();
			var i = 0;

			if (m < 10) {
				m = "0" + m;
			}

			if (d < 10) {
				d = "0" + d;
			}

			$("#cal").fullCalendar({
				lang : "ko",
				height : 460,
				displayEventTime: false,
				events : data
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
					//이벤트 수정
					//event.title = "CLICKED!";
					//$("#calender").fullCalendar('updateEvent', event);
					//console.log(event.start.format());
					/* makeNoBtnPopup(1, "일정보기", event.title + "-"
							+ event.ename + "<br/>" + event.activity_con,
							true, 500, 500, null, null); */
					$(".schListDateTableCon").text(event.start.format());
					$("#sltedDate").val(event.start.format());

					reloadCalList();
				},
				dayClick : function(date) {
					//alert(date.format() + 'a day has been clicked!');
					$(".schListDateTableCon").text(date.format());
					$("#sltedDate").val(date.format());

					reloadCalList();
				}
			});
		}
		</script>
	</head>
	<body>
		<c:import url="/topLeft">
			<c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
			<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param>
		</c:import>

		<!-- 내용 영역 -->
		<div class="content_area">
			<!-- 메뉴 네비게이션 -->
			<div class="content_nav">HeyWe &gt; 경영관리 &gt; 메인</div>
			<!-- 현재 메뉴 제목 -->
			<div class="content_title">메인</div>
			<br/>
			<!-- 내용 영역 -->
			<form action="#" id="dataForm" method="post">
				<input type="hidden" id="sltedDate" name="sltedDate" />
				<input type="hidden" id="sch" name="sch" value="1"/>
			</form>
			<div class="calArea">
				<div class="conArea">
					<div class="cal" id="cal"></div>
					<div class="category">
						<div class="category1">
							<div class="category1_1">
								<img alt="red" id="redBtn" src="resources/images/erp/crm/red.png">
							</div>
							<div class="category1_2">매입채무</div>
						</div>
						<div class="category2">
							<div class="category2_1">
								<img alt="blue" id="blueBtn"
									src="resources/images/erp/crm/blue.png">
							</div>
							<div class="category2_2">매출채권</div>
						</div>
					</div>
				</div>
				<div class="schListArea">
					<div class="schListBg">
						<div class="schListDate">
							<table class="schListDateTable">
								<tr>
									<td class="schListDateTableIcon"><img alt="cal" src="resources/images/erp/crm/cal.png" 
										width="35px" height="35px" id="cal"></td>
									<td class="schListDateTableCon"></td>
								</tr>
							</table>
						</div>
						<div class="schListCon">
							<table class="schListConTable"></table>
						</div>
					</div>
				</div>
			</div>
		</div>		
	</body>
</html>