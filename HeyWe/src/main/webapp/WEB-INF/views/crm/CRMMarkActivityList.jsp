<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 일정등록(제안)</title>
<link rel="stylesheet" type="text/css"
	href="resources/css/jquery/jquery-ui.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/crm/sa_plan_cal_add.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/jquery/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/common/calendar.css" />
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="resources/script/jquery/jquery-ui.js"></script>

<!-- calendar css -->
<link rel="stylesheet" type="text/css"
	href="resources/css/calendar/calendar.css" />
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
				showCalendar(d.getFullYear(), (d.getMonth() + 1));

				$.datepicker.setDefaults({
					monthNames : [ '년 1월', '년 2월', '년 3월', '년 4월', '년 5월',
							'년 6월', '년 7월', '년 8월', '년 9월', '년 10월', '년 11월',
							'년 12월' ],
					monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7', '8',
							'9', '10', '11', '12' ],
					dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
					showMonthAfterYear : true,
					showOn : 'both',
					closeText : '닫기',
					changeYear : true,
					changeMonth : true,
					buttonImage : 'resources/images/calender.png',
					buttonImageOnly : true,
					dateFormat : 'yy/mm/dd',
					yearRange : '-100y:+0d'
				});

				$("#date_start").datepicker(
						{
							dateFormat : 'yy-mm-dd',
							duration : 200,
							onSelect : function(dateText, inst) {
								var startDate = parseInt($("#date_end").val()
										.replace("-", '').replace("-", ''));
								var endDate = parseInt(dateText.replace(/-/g,
										''));

								if (endDate > startDate) {
									alert("조회 기간은 과거로 설정하세요.");
									//달력에 종료 날짜 넣어주기
									$("#date_start").val($("#stdt").val());
								} else {
									$("#stdt").val($("#date_start").val());
								}
							}
						});

				$("#date_end").datepicker(
						{
							dateFormat : 'yy-mm-dd',
							duration : 200,
							onSelect : function(dateText, inst) {
								var startDate = parseInt($("#date_start").val()
										.replace("-", '').replace("-", ''));
								var endDate = parseInt(dateText.replace(/-/g,
										''));

								if (startDate > endDate) {
									alert("조회 기간은 과거로 설정하세요.");
									//달력에 종료 날짜 넣어주기
									$("#date_end").val($("#eddt").val());
								} else {
									$("#eddt").val($("#date_end").val());
								}
							}
						});

				if ($("#page").val() == "") {
					$("#page").val("1");
				}
				if ($("#check2").val() == "") {
					$("#check2").val("888");
				}
				if ($("#select1").val() == "") {
					$("#select1").val("10");
				}

				reloadList();
				reloadDept();
				reloadEmp();
				$("#listNum").on("click", "input", function() { // 페이징 영역

					$("#page").val($(this).attr("name"));

					reloadList();

				});
				$("#write2").on("click", function() {

					$("#page").val("1");

					reloadList();

				});
				$(".mokTxt").on("click", function() {
					location.href = "CRMMarkActivityList";
				})
				$(".calTxt").on("click", function() {
					location.href = "CRMMarkActivity";
				})

				$("#sel").on("change", function() {
					$("#check").val($(this).val());
					if ($("#check").val() == 999) {
						$("#check2").val(888);
					}
					reloadEmp();
				});
				$("#sel2").on("change", function() {
					$("#check2").val($(this).val());
				});
			})

	function reloadList() { // 리스트 출력

		var params = $("#dataForm").serialize();

		$.ajax({

			type : "post",

			url : "CRMMarkActivityCalListAjax",

			dataType : "json",

			data : params,

			success : function(result) {
				/* ProgressStateList(result.State) */
				ChanceList(result.list);
				redrawPaging(result.pb);
			},
			error : function(request, status, error) {

				console.log("status : " + request.status);

				console.log("text : " + request.responseText);

				console.log("error : " + error);
			}
		});
	}

	function ProgressStateList(State) {

		var html = "";
		html += "<option value=\"10\">진행상태(전체)</option>"

		for (var i = 0; i < State.length; i++) {
			html += "<option value=" +State[i].PROGRESS_STATE_NO+ ">"
					+ State[i].NAME + "</option>"
		}
		$("#select1").html(html);

	}

	function ChanceList(list) {

		console.log(list.length);

		var html = "";

		for (var i = 0; i < list.length; i++) {
			html += "<div class=\"addPlan_2_1\" id="+list[i].SCH_NO+" name="+list[i].MARK_NO+">"
			html += "<div class=\"addPlan_2_1_1\">"
			html += "<div class=\"addPlan_2_1_1_1\">" + list[i].TITLE
					+ "</div>"
			html += "<div class=\"addPlan_2_1_1_2\"><"+list[i].PSNAME+ "> <" +list[i].MNAME+ " ></div></div>"
			html += "<div class=\"addPlan_2_1_2\">"
			html += "<div class=\"addPlan_2_1_2_1\">" + list[i].MNNAME
					+ "</div>"
			html += "<div class=\"addPlan_2_1_2_2\">" + list[i].START
					+ "</div></div></div>"
		}
		$(".addPlan_2").html(html);

		$(".addPlan_2_1").on("click", function() {
			console.log("aaa");
			$("#schno").val($(this).attr("id"));
			$("#markNo").val($(this).attr("name"));
			
			$("#dataForm").attr("action", "CRMMarkActivityAsk");
			$("#dataForm").submit();
		});

	}

	function redrawPaging(pb) {

		var html = "";

		if ($("#page").val() == "1") {

			html += "<input type=\"button\" value=\"<\" name=\"1\" />";

		} else {

			html += "<input type=\"button\" value=\"<\" name=\""

			+ ($("#page").val() * 1 - 1) + "\" />";

		}

		for (var i = pb.startPcount; i <= pb.endPcount; i++) {

			if (i == $("#page").val()) {

				html += "<input type=\"button\" value=\"" + i + "\" name=\""  + i + "\" disabled=\"disabled\" />";

			} else {

				html += "<input type=\"button\" value=\"" + i + "\" name=\"" + i + "\" />";

			}

		}

		if ($("#page").val() == pb.maxPcount) {

			html += "<input type=\"button\" value=\">\" name=\"" + pb.maxPcount
					+ "\" />";

		} else {

			html += "<input type=\"button\" value=\">\" name=\""

			+ ($("#page").val() * 1 + 1) + "\" />";

		}

		$("#listNum").html(html);
		$("#listNum input[type='button']").button();

	}

	function reloadDept() {
		var params = $("#dataForm").serialize();
		$.ajax({
			type : "post",
			url : "CRMMngr2Ajax",
			dataType : "json",
			data : params,
			success : function(result) {
				redrawDept(result.dept);
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}

	function reloadEmp() {
		var params = $("#dataForm").serialize();
		$.ajax({
			type : "post",
			url : "CRMEmpAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				redrawEmp(result.emp);
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}

	function redrawDept(dept) {
		var html = "";
		html += "<option value=\"999\">부서(전체)</option>"
		for (var i = 0; i < dept.length; i++) {
			html += "<option value=\""+ dept[i].DEPT_NO +"\">"
					+ dept[i].DEPT_NAME + "</option>"
		}
		$("#sel").html(html)
	}

	function redrawEmp(emp) {
		var html = "";
		html += "<option value=\"888\">사원(전체)</option>"
		for (var i = 0; i < emp.length; i++) {
			html += "<option value="+ emp[i].EMP_NO +">" + emp[i].NAME
					+ "</option>"
		}
		$("#sel2").html(html)
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
		<!-- 메뉴 네비게이션 -->
		<div class="content_nav">HeyWe &gt; CRM &gt; 영업활동 &gt; 일정</div>
		<!-- 현재 메뉴 제목 -->
		<div class="content_title">일정</div>
		<!-- 내용 영역 -->
		<div class="calmok">
			<div class="calTxt" style="cursor: pointer">일정</div>
			<div class="mokTxt" style="cursor: pointer">목록</div>
		</div>
		<div class="addPlan">
			<form action="#" id="dataForm" method="post">
				<input type="hidden" id="schno" name="schno"> <input
					type="hidden" id="markNo" name="markNo"> <input
					type="hidden" id="stdt" name="stdt" value="${stdt}" /> <input
					type="hidden" id="eddt" name="eddt" value="${eddt}" /> <input
					type="hidden" id="page" name="page" value="${param.page}" /> <input
					type="hidden" id="check" name="check"> <input type="hidden"
					id="check2" name="check2"> <input type="hidden" id="chance"
					name="chance">
				<div class="search">

					<div class="search1">
						<input type="text" placeholder="일정명을 입력해주세요." id="schName"
							name="schName" />&nbsp <select id="select1" name="select1">
							<option value="10">진행상태(전체)</option>
							<option value="0">기회</option>
							<option value="1">제안</option>
							<option value="2">협상</option>
							<option value="3">계약</option>
						</select> <br /> <br />
					</div>

					<div class="search3">

						<!-- <input type="text" value="날짜1" id="txt" />&nbsp<input type="text"
					value="날짜2" id="txt2" /> <br /> <br /> -->
						<input type="text" width="300px" height="30px" title="시작기간선택"
						id="date_start" name="date_start" value="" readonly="readonly" placeholder="일정시작일" />
					~ <input type="text" title="종료기간선택" id="date_end" name="date_end"
						value="" readonly="readonly" placeholder="일정종료일" />
					</div>

					<div class="search2">
						<select class="SelBox" id="sel" name="sel">
						</select> <select class="SelBox_1" id="sel2" name="sel2">
						</select> <img src="resources/images/erp/crm/search.png" id="write2"
							style="cursor: pointer" /> <br /> <br />
					</div>

				</div>
			</form>
			<div class="addPlan_2"></div>
			<div id="listNum"></div>
		</div>

	</div>
</body>
</html>
