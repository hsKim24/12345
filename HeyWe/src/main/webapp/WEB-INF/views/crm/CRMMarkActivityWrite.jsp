<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 일정등록</title>
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/crm/sa_plan_cal_add2.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/jquery/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/common/calendar.css" />

<!-- calendar css -->
<link rel="stylesheet" type="text/css"
	href="resources/css/calendar/calendar.css" />
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>

<script type="text/javascript"
	src="resources/script/jquery/jquery-ui.min.js"></script>

<!-- calendar Script -->
<script type="text/javascript"
	src="resources/script/calendar/calendar.js"></script>


<script type="text/javascript">
	$(document).ready(
			function() {
				$(".grey").css("background", "#D8D8D8");

				activtyTypeAjax();

				showCalendar(d.getFullYear(), (d.getMonth() + 1));

				$.datepicker.setDefaults({
					monthNames : [ '년 1월', '년 2월', '년 3월', '년 4월', '년 5월',
							'년 6월', '년 7월', '년 8월', '년 9월', '년 10월', '년 11월',
							'년 12월' ],
					dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
					showMonthAfterYear : true,
					showOn : 'button',
					closeText : '닫기',
					buttonImage : 'resources/images/calender.png',
					buttonImageOnly : true,
					dateFormat : 'yy/mm/dd'
				});

				$("#date_start").datepicker(
						{
							dateFormat : 'yy-mm-dd',
							duration : 200,
							onSelect : function(dateText, inst) {
								var startDate = parseInt($("#date_start").val()
										.replace("-", '').replace("-", ''));

								$("#stdt").val($("#date_start").val());

							}
						});
				
				$("#backImg").on("click", function() {
					makeConfirm(1, "일정 등록", "취소하시겠습니까?", true, function(){
					location.href = "CRMMarkActivity";
				});
				});
				
				$("#writeImg").on("click",function() {
					
					if ($.trim($("#planCon").val()) == "") {
						makeAlert(1, "", "일정명을 입력하세요.", true, null);
						$("#planCon").focus();
					} else if($.trim($("#chance").val()) == ""){
						makeAlert(1, "", "영업을 선택하세요.", true, null);
						$("#chance").focus();
					} else if($.trim($("#stdt").val()) == ""){
						makeAlert(1, "", "일정날짜을 선택하세요.", true, null);
						$("stdt").focus();
					} else if($.trim($("#activityCon").val()) == ""){
						makeAlert(1, "", "활동 내용을 입력하세요.", true, null);
						$("#activityCon").focus();
					}  else if($.trim($("#selectmngr").val()) == ""){
						makeAlert(1, "", "고객을 선택하세요.", true, null);
						$("#selectmngr").focus();
					} else if($.trim($("#selectemp").val()) == ""){
						makeAlert(1, "", "담당자를 선택하세요.", true, null);
						$("#selectemp").focus();
					} else if(parseInt($("#startTime1").val())>parseInt($("#endTime1").val())){
						makeAlert(1, "", "시작시간을 종료시간보다 과거로 선택하세요.", true, null);
						$("#startTime1").focus();
					}
					 else if($("#startTime1").val()==$("#endTime1").val() && $("#startTime2").val()>=$("#endTime2").val()) {
							makeAlert(1, "", "시작시간을 종료시간보다 과거로 선택하세요.", true, null);
							$("#startTime1").focus();
							}					
					else {
						console.log(parseInt($("#endTime1").val()));
						console.log(parseInt($("#startTime1").val()));
					
					  
					
					var stdt = $("#stdt").val();
					var c =	$("#stdt").val() +'-'+ $("#startTime1").val() +':'+ $("#startTime2").val();
					var d = $("#stdt").val() +'-'+ $("#endTime1").val() + ':' +$("#endTime2").val();
					
					
					$("#realStart").val(c);
					$("#realEnd").val(d);
					
					MarkActivityWriteAjax();
					}
					});
				
				$("#empBtn").on(
						"click",
						function() {
							makePopup(1, "담당자 조회", empPopup(), true, 700, 386,
									function() {
										$("#listDiv").slimScroll({
											height : "170px",
											axis : "both"
										});
										drawElist();
									
										$("#search_btn").on("click",
												function() {
													drawElist();
												});
										$("#search_txt").keyup(function(event) {
											if (event.keyCode == '13') {
												drawElist();
											}
										});

									}, "확인", function() {
										closePopup(1);
										reloademp();
									});
						});

				$("#chanceBtn").on(
						"click",
						function() {
							makePopup(1, "영업 조회", chancePopup(), true, 700,
									386, function() {
										$("#listDiv").slimScroll({
											height : "170px",
											axis : "both"
										});
										drawClist();
										$("#search_btn").on("click",
												function() {
													drawClist();
												});
										$("#search_chance").keyup(
												function(event) {
													if (event.keyCode == '13') {
														drawClist();
													}
												});

									}, "확인", function() {
										closePopup(1);
										reloadchance();
									});
						});

				$("#mngrBtn").on(
						"click",
						function() {
							makePopup(1, "담당자 조회", mngrPopup(), true, 700, 386,
									function() {
										$("#listDiv").slimScroll({
											height : "170px",
											axis : "both"
										});
										drawMlist();
										$("#search_btn").on("click",
												function() {
													drawClist();
												});
										$("#search_mngr").keyup(
												function(event) {
													if (event.keyCode == '13') {
														drawClist();
													}
												});

									}, "확인", function() {
										closePopup(1);
										reloadmngr();
									});
						});

			})

	function MarkActivityWriteAjax() {
		var params = $("#dataForm").serialize();
		
		$.ajax({
			type : "post",
			url : "MarkActivityWriteAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				location.href="CRMMarkActivityList"
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});

	}
	function activtyTypeAjax() {
		var params = $("#dataForm").serialize();
		$.ajax({
			type : "post",
			url : "activtyTypeListAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				reloadactivityType(result.at);
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});

	}
	function reloadactivityType(at) {
		var html = "";

		for (var i = 0; i < at.length; i++) {
			html += "<option value=\""+at[i].ACTIVITY_TYPE_NO + "\">"
					+ at[i].NAME + "</option>"

		}
		$("#activityType").html(html);

	}

	function reloademp() {
		var params = $("#dataForm").serialize();
		$.ajax({
			type : "post",
			url : "reloadempAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				$("#emp").val(result.selectemp.EMP_NAME);
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}
	function reloadchance() {
		var params = $("#dataForm").serialize();

		$.ajax({
			type : "post",
			url : "reloadchanceAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				$("#chance").val(result.selectchance.MNAME);

			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}

	function reloadmngr() {
		var params = $("#dataForm").serialize();

		$.ajax({
			type : "post",
			url : "reloadmngrAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				$("#mngr").val(result.selectmngr.MNNAME);

			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}

	function drawElist() {
		$("#empsearchtxt").val($.trim($("#search_txt").val()));
		var params = $("#dataForm").serialize();
		$.ajax({
			type : "post",
			url : "crmEmpSearchAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				drawEmpSearchList(result.list);
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}
	function drawClist() {
		$("#chancesearchtxt").val($.trim($("#search_chance").val()));
		var params = $("#dataForm").serialize();
		$.ajax({
			type : "post",
			url : "chanceSearchAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				drawchanceSearchList(result.list);
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}

	function drawMlist() {
		$("#mngrsearchtxt").val($.trim($("#search_mngr").val()));
		var params = $("#dataForm").serialize();
		$.ajax({
			type : "post",
			url : "mngrSearchAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				drawMngrSearchList(result.list);
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}

	function drawEmpSearchList(list) {
		var html = "";

		if (list.length == 0) {
			html += "<tr><td colspan=\"2\">검색결과가 없습니다</td></tr>";
		} else {
			for (var i = 0; i < list.length; i++) {
				html += "<tr name=\""+ list[i].EMP_NO + "\">";
				html += "<td>" + list[i].DEPT_NAME + "</td>"
				html += "<td>" + list[i].NAME + "</td>"
				html += "</tr>"
			}
		}
		$("#listCon tbody").html(html);

		$("#listCon").on("click", "tr", function() {
			$(this).parent().children().css("background", "white");
			$(this).css("background", "#B0DAEC");
			$("#selectemp").val($(this).attr("name"));
			$("#emp_no").val($("#selectemp").val());
		});
	}

	function drawchanceSearchList(list) {
		var html = "";

		if (list.length == 0) {
			html += "<tr><td colspan=\"2\">검색결과가 없습니다</td></tr>";
		} else {
			for (var i = 0; i < list.length; i++) {
				html += "<tr id=\""+ list[i].PSNAME + "\" name=\""+ list[i].MARK_NO + "\">";
				html += "<td>" + list[i].MNAME + "</td>"
				html += "<td>" + list[i].PSNAME + "</td>"
				html += "</tr>"
			}
		}
		$("#listCon tbody").html(html);

		$("#listCon").on("click", "tr", function() {
			$(this).parent().children().css("background", "white");
			$(this).css("background", "#B0DAEC");
			$("#selectchance").val($(this).attr("name"));
			$("#chance_no").val($("#selectchance").val());
			$("#psname").val($(this).attr("id"));
			

		});
	}
	function drawMngrSearchList(list) {
		var html = "";

		if (list.length == 0) {
			html += "<tr><td colspan=\"2\">검색결과가 없습니다</td></tr>";
		} else {
			for (var i = 0; i < list.length; i++) {
				html += "<tr name=\""+ list[i].MNGR_NO + "\">";
				html += "<td>" + list[i].CCNAME + "</td>"
				html += "<td>" + list[i].MNNAME + "</td>"
				html += "</tr>"
			}
		}
		$("#listCon tbody").html(html);

		$("#listCon").on("click", "tr", function() {
			$(this).parent().children().css("background", "white");
			$(this).css("background", "#B0DAEC");
			$("#selectmngr").val($(this).attr("name"));
			$("#mngr_no").val($("#selectmngr").val());
		});
	}
	function empPopup() {
		var html = "";

		html += "<div id=\"search\">";
		html += "<input type=\"text\" placeholder=\"이름을 입력해주세요\" id=\"search_txt\" name=\"search_txt\">";
		html += "<input type=\"button\" value=\"조회\" id=\"search_btn\">";
		html += "</div>";
		html += "<div id=\"list\">";
		html += "<table id=\"listTop\">";
		html += "<colgroup>";
		html += "<col width=\"330px\">";
		html += "<col width=\"300px\">";
		html += "</colgroup>";
		html += "<tr>";
		html += "<th>부서명</th>";
		html += "<th>이름</th>";
		html += "</tr>";
		html += "</table>";
		html += "<div id=\"listDiv\">";
		html += "<table id=\"listCon\">";
		html += "<colgroup>";
		html += "<col width=\"330px\">";
		html += "<col width=\"300px\">";
		html += "</colgroup>";
		html += "<tbody>";
		html += "</tbody>";
		html += "</table>";
		html += "</div>";
		html += "</div>";

		return html;
	}

	function chancePopup() {
		var html = "";

		html += "<div id=\"search\">";
		html += "<input type=\"text\" placeholder=\"이름을 입력해주세요\" id=\"search_chance\" name=\"search_chance\">";
		html += "<input type=\"button\" value=\"조회\" id=\"search_btn\">";
		html += "</div>";
		html += "<div id=\"list\">";
		html += "<table id=\"listTop\">";
		html += "<colgroup>";
		html += "<col width=\"330px\">";
		html += "<col width=\"300px\">";
		html += "</colgroup>";
		html += "<tr>";
		html += "<th>영업명</th>";
		html += "<th>진행단계</th>";
		html += "</tr>";
		html += "</table>";
		html += "<div id=\"listDiv\">";
		html += "<table id=\"listCon\">";
		html += "<colgroup>";
		html += "<col width=\"330px\">";
		html += "<col width=\"300px\">";
		html += "</colgroup>";
		html += "<tbody>";
		html += "</tbody>";
		html += "</table>";
		html += "</div>";
		html += "</div>";

		return html;
	}

	function mngrPopup() {
		var html = "";

		html += "<div id=\"search\">";
		html += "<input type=\"text\" placeholder=\"이름을 입력해주세요\" id=\"search_mngr\" name=\"search_mngr\">";
		html += "<input type=\"button\" value=\"조회\" id=\"search_btn\">";
		html += "</div>";
		html += "<div id=\"list\">";
		html += "<table id=\"listTop\">";
		html += "<colgroup>";
		html += "<col width=\"330px\">";
		html += "<col width=\"300px\">";
		html += "</colgroup>";
		html += "<tr>";
		html += "<th>고객사명</th>";
		html += "<th>고객명</th>";
		html += "</tr>";
		html += "</table>";
		html += "<div id=\"listDiv\">";
		html += "<table id=\"listCon\">";
		html += "<colgroup>";
		html += "<col width=\"330px\">";
		html += "<col width=\"300px\">";
		html += "</colgroup>";
		html += "<tbody>";
		html += "</tbody>";
		html += "</table>";
		html += "</div>";
		html += "</div>";

		return html;
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
		<div class="content_nav">HeyWe &gt; CRM &gt; 영업 활동 &gt; 일정 &gt;
			일정등록</div>
		<!-- 내용 영역 -->
		<div class="content_title">일정등록</div>
		<div class="title">
			<div id="title2">
				<img src="resources/images/erp/crm/write.png" id="writeImg"
					style="cursor: pointer" /> <img
					src="resources/images/erp/crm/back.png" id="backImg"
					style="cursor: pointer" />
			</div>
		</div>
		<form action="#" id="dataForm" method="post">
			<input type="hidden" id="stdt" name="stdt" value="${stdt}" /> <input
				type="hidden" id="eddt" name="eddt" value="${eddt}" /> <input
				type="hidden" name="empsearchtxt" id="empsearchtxt" /> <input
				type="hidden" id="realStart" name="realStart" /> <input
				type="hidden" id="realEnd" name="realEnd" /> <input type="hidden"
				id="psname" name="psname" /> <input type="hidden" id="color"
				name="color" /> <input type="hidden" name="selectemp"
				id="selectemp" /> <input type="hidden" name="chancesearchtxt"
				id="chancesearchtxt" /> <input type="hidden" name="selectchance"
				id="selectchance" /> <input type="hidden" name="chance_no"
				id="chance_no" /><input type="hidden" name="mngrsearchtxt"
				id="mngrsearchtxt" /> <input type="hidden" name="selectmngr"
				id="selectmngr" />
			<div class="crmInfo">
				<table cellspacing="0">
					<colgroup>
						<col width="220" />
						<col width="650" />
					</colgroup>
					<tbody>
						<tr>
							<td id="tdleft">일정명 *</td>
							<td id="tdright"><input type="text" id="planCon"
								name="planCon" /></td>
						</tr>
						<tr>
							<td id="tdleft">영업명 *</td>
							<td id="tdright"><input type="text" id="chance"	name="chance" readonly="readonly" class="grey"> 
								<input type="button"
								value="선택" id="chanceBtn" /></td>
						</tr>
						<tr>
							<td id="tdleft">활동분류 *</td>
							<td id="tdright"><select id="activityType"
								name="activityType">

							</select></td>
						</tr>
						<tr>
							<td id="tdleft">날짜 *</td>
							<td id="tdright"><input type="text" width="300px"
								height="30px" title="시작기간선택" id="date_start" name="date_start" value="" readonly="readonly" class="grey"/></td>
						</tr>
						<tr>
							<td id="tdleft">활동시간 *</td>
							<td id="tdright"><div class="q0">
									<div class="q1">
										<select class="q1_1" id="startTime1" name="startTime1" >
											<option>00</option>
											<option>01</option>
											<option>02</option>
											<option>03</option>
											<option>04</option>
											<option>05</option>
											<option>06</option>
											<option>07</option>
											<option>08</option>
											<option>09</option>
											<option>10</option>
											<option>11</option>
											<option>12</option>
											<option>13</option>
											<option>14</option>
											<option>15</option>
											<option>16</option>
											<option>17</option>
											<option>18</option>
											<option>19</option>
											<option>20</option>
											<option>21</option>
											<option>22</option>
											<option>23</option>
											<option>24</option>
										</select> :
									</div>
									<div class="q1">
										<select class="q1_1" id="startTime2" name="startTime2">
											<option>00</option>
											<option>15</option>
											<option>30</option>
											<option>45</option>
										</select>
									</div>
									<div class="q2">~</div>
									<div class="q1">
										<select class="q1_1" id="endTime1" name="endTime1">
											<option>00</option>
											<option>01</option>
											<option>02</option>
											<option>03</option>
											<option>04</option>
											<option>05</option>
											<option>06</option>
											<option>07</option>
											<option>08</option>
											<option>09</option>
											<option>10</option>
											<option>11</option>
											<option>12</option>
											<option>13</option>
											<option>14</option>
											<option>15</option>
											<option>16</option>
											<option>17</option>
											<option>18</option>
											<option>19</option>
											<option>20</option>
											<option>21</option>
											<option>22</option>
											<option>23</option>
											<option>24</option>
										</select> :
									</div>
									<div class="q1">
										<select class="q1_1" id="endTime2" name="endTime2">
											<option>00</option>
											<option>15</option>
											<option>30</option>
											<option>45</option>
										</select>
									</div>
								</div></td>
						</tr>

						<tr>
							<td id="tdleft">활동내용 *</td>
							<td id="tdright"><input type="text" id="activityCon"
								name="activityCon" /></td>
						</tr>
						<tr>
							<td id="tdleft">담당자(고객) *</td>
							<td id="tdright"><input type="text" id="mngr" name="mngr_no"
								readonly="readonly" class="grey"> <input type="button" value="선택"
								id="mngrBtn" /></td>
						</tr>
						<tr>
							<td id="tdleft">담당자(자사) *</td>
							<td id="tdright"><input type="text" id="emp" name="Emp_No"
								readonly="readonly" class="grey"> <input type="button" value="선택"
								id="empBtn" /></td>
						</tr>
					</tbody>
				</table>
			</div>
		</form>
	</div>
</body>
</html>