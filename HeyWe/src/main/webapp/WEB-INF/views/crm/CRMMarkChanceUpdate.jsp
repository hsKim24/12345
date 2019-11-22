<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 영업기회수정</title>
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/crm/main.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/crm/sa_chance_c.css" />
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
				
				reloadList();
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
				$("#writeImg").on("click", function() {
					//작성 내용에 스크립트 동작을 막겠다.
					if ($.trim($("#Mark_Name").val()) == "") {
						alert("영업명을 입력하세요. ");
						$("#Mark_Name").focus();
					} else {
						makeConfirm(1, "영업기회 수정", "수정하시겠습니까?", true, function() {
						MarkChanceUpdate();
						})
					}
				})
				
				$("#backImg").on("click", function(){
					makeConfirm(1, "기회 수정", "취소하시겠습니까?", true, function(){
					history.back();
				});
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

				$("#cstmBtn").on(
						"click",
						function() {
							makePopup(1, "담당자 조회", cstmPopup(), true, 700, 386,
									function() {
										$("#listDiv").slimScroll({
											height : "170px",
											axis : "both"
										});
										drawClist();
										$("#search_btn").on("click",
												function() {
													drawClist();
												});
										$("#search_cstm").keyup(
												function(event) {
													if (event.keyCode == '13') {
														drawClist();
													}
												});

									}, "확인", function() {
										closePopup(1);
										reloadcstm();
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

			});

	function MarkChanceUpdate() {
		if($("#selectemp").val()=="" || $("#selectemp").val() == null) {
			$("#selectemp").val(${data.EMP_NO });
		}
		if($("#selectmngr").val()=="" || $("#selectmngr").val() == null) {
			$("#selectmngr").val(${data.MNGR_NO });
		}
			
		var params = $("#dataForm").serialize();
		
		$.ajax({

			type : "post",

			url : "MarkChanceUpdate2Ajax",

			dataType : "json",

			data : params,

			success : function(result) {
				alert("영업기회가 수정되었습니다.")
				location.href = "CRMMarkChanceList"
			},
			error : function(request, status, error) {

				console.log("status : " + request.status);

				console.log("text : " + request.responseText);

				console.log("error : " + error);
			}
		});
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
	function reloadcstm() {
		var params = $("#dataForm").serialize();

		$.ajax({
			type : "post",
			url : "reloadcstmAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				$("#cstm").val(result.selectcstm.NAME);

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
			url : "empSearchAjax",
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
		$("#cstmsearchtxt").val($.trim($("#search_cstm").val()));
		var params = $("#dataForm").serialize();
		$.ajax({
			type : "post",
			url : "cstmSearchAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				drawCstmSearchList(result.list);
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

	function drawCstmSearchList(list) {
		var html = "";

		if (list.length == 0) {
			html += "<tr><td colspan=\"2\">검색결과가 없습니다</td></tr>";
		} else {
			for (var i = 0; i < list.length; i++) {
				html += "<tr name=\""+ list[i].CRM_CSTM_NO + "\">";
				html += "<td>" + list[i].NAME + "</td>"
				html += "</tr>"
			}
		}
		$("#listCon tbody").html(html);

		$("#listCon").on("click", "tr", function() {
			$(this).parent().children().css("background", "white");
			$(this).css("background", "#B0DAEC");
			$("#selectcstm").val($(this).attr("name"));
			$("#crm_cstm_no").val($("#selectcstm").val());
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

	function reloadList() {
		/* 		var params = $("#dataForm").serialize(); */

		$.ajax({

			type : "post",

			url : "CstmDiv2Ajax",

			dataType : "json",

			/* 			data : params,  */

			success : function(result) {

				ProgressState(result.State);
				BsnsType(result.bt);
				SalesDiv(result.sd);
				RecogPath(result.rp);
			},
			error : function(request, status, error) {

				console.log("status : " + request.status);

				console.log("text : " + request.responseText);

				console.log("error : " + error);
			}
		});
	}

	function CstmDiv(Div) {

		var html = ""

		for (var i = 0; i < Div.length; i++) {

			html += "<option value=\""+Div[i].CSTM_DIV_NO + "\">"
					+ Div[i].DIVNAME + "</option>"

		}

		$("#Cstm_Div").html(html);

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

	function cstmPopup() {
		var html = "";

		html += "<div id=\"search\">";
		html += "<input type=\"text\" placeholder=\"고객사명을 입력해주세요\" id=\"search_cstm\" name=\"search_cstm\">";
		html += "<input type=\"button\" value=\"조회\" id=\"search_btn\">";
		html += "</div>";
		html += "<div id=\"list\">";
		html += "<table id=\"listTop\">";
		html += "<colgroup>";
		html += "<col width=\"630px\">";
		html += "</colgroup>";
		html += "<tr id=\"cstmtr\">";
		html += "<th>고객사명</th>";
		html += "</tr>";
		html += "</table>";
		html += "<div id=\"listDiv\">";
		html += "<table id=\"listCon\">";
		html += "<colgroup>";
		html += "<col width=\"630px\">";
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

	function CstmGrade(Grade) {

		var html = ""

		for (var i = 0; i < Grade.length; i++) {

			html += "<option value=\""+Grade[i].CSTM_GRADE_NO + "\">"
					+ Grade[i].NAME + "</option>"

		}

		$("#Cstm_Grade").html(html);

	}
	function ProgressState(State) {

		var html = ""

		for (var i = 0; i < State.length; i++) {

			html += "<option value=\""+State[i].PROGRESS_STATE_NO + "\">"
					+ State[i].NAME + "</option>"

		}

		$("#Progress_State").html(html);

	}
	function BsnsType(bt) {

		var html = ""

		for (var i = 0; i < bt.length; i++) {

			html += "<option value=\""+bt[i].BSNS_TYPE_NO + "\">"
					+ bt[i].BTNAME + "</option>"

		}

		$("#Bsns_Type").html(html);

	}
	function SalesDiv(sd) {

		var html = ""

		for (var i = 0; i < sd.length; i++) {

			html += "<option value=\""+sd[i].SALES_DIV_NO + "\">"
					+ sd[i].SDNAME + "</option>"

		}

		$("#Sales_Div").html(html);

	}

	function RecogPath(rp) {

		var html = ""

		for (var i = 0; i < rp.length; i++) {

			html += "<option value=\""+rp[i].RECOG_PATH_NO + "\">"
					+ rp[i].RPNAME + "</option>"

		}

		$("#Recog_Path").html(html);

	}
	

</script>
</head>
<body>
	<c:import url="/topLeft">
		<c:param name="topMenuNo" value="17"></c:param>
		<c:param name="leftMenuNo" value="20"></c:param>
		<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
	</c:import>
	<div class="content_area">
		<div class="content_nav">HeyWe &gt; CRM &gt; 영업기회
			&gt; 영업기회 수정</div>
		<!-- 내용 영역 -->
		<div class="content_title">영업기회 수정</div>
		<form action="#" id="dataForm" method="post">
			<input type="hidden" id="stdt" name="stdt" value="${stdt}" /> <input
				type="hidden" id="" name="stdt" value="${stdt}" /> <input
				type="hidden" id="eddt" name="eddt" value="${eddt}" /> <input
				type="hidden" name="empsearchtxt" id="empsearchtxt" /> <input
				type="hidden" name="sEmpNo" value="${sEmpNo}" /> <input
				type="hidden" name="selectemp" id="selectemp" /> <input
				type="hidden" name="cstmsearchtxt" id="cstmsearchtxt" /> <input
				type="hidden" name="selectcstm" id="selectcstm" /> <input
				type="hidden" name="mngrsearchtxt" id="mngrsearchtxt" /> <input
				type="hidden" name="selectmngr" id="selectmngr" /> <input
				type="hidden" id="chanceno" name="chanceno"
				value="${param.chanceno}"> <input type="hidden" id="markNo"
				name="markNo" value="${param.markNo}"> <input type="hidden"
				id="sNo" name="sNo" value="${sEmpNo}">
			<div>
				<img src="resources/images/erp/crm/write.png" id="writeImg"
					style="cursor: pointer" /> <img
					src="resources/images/erp/crm/back.png" id="backImg"
					style="cursor: pointer" />
			</div>
			<div class="crmInfo">
				<table border="1" cellspacing="0">
					<colgroup>
						<col width="220" />
						<col width="650" />
					</colgroup>
					<tbody>
						<tr>
							<td id="tdleft">영업명 *</td>
							<td id="tdright"><input type="text" width="500px"
								id="Mark_Name" name="Mark_Name" value="${data.MNAME }" /></td>

						</tr>

						<tr>
							<td id="tdleft">담당자(고객) *</td>
							<td id="tdright"><input type="text" id="mngr" name="mngr_no"
								value="${data.MNNAME }" readonly="readonly" class="grey"> <input type="button" value="선택"
								id="mngrBtn" /></td>
						</tr>
						<tr>
							<td id="tdleft">진행상태</td>
							<td id="tdright"><select id="Progress_State"
								name="Progress_State" value="${data.PSENAME}"></select></td>
						</tr>

						<tr>
							<td id="tdleft">사업유형</td>
							<td id="tdright"><select id="Bsns_Type" name="Bsns_Type">

							</select></td>
						</tr>
						<tr>
							<td id="tdleft">매출구분</td>
							<td id="tdright"><select id="Sales_Div" name="Sales_Div">

							</select></td>
						</tr>
						<tr>
							<td id="tdleft">매출구분상세</td>
							<td id="tdright"><input type="text" width="500px"
								id="Sales_Div_Dtl" name="Sales_Div_Dtl"
								value="${data.SALES_DIV_DTL}" /></td>
						</tr>
						<tr>
							<td id="tdleft">진행단계</td>
							<td id="tdright"><select id="select" disabled="disabled">
									<option value="0">인지</option>
							</select></td>
						</tr>
						<tr>
							<td id="tdleft">인지경로</td>
							<td id="tdright"><select id="Recog_Path" name="Recog_Path"></select></td>
						</tr>
						<tr>
							<td id="tdleft">영업시작일 *</td>
							<td id="tdright"><input type="text" width="300px"
								height="30px" title="시작기간선택" id="date_start" name="date_start"
								value="${data.MARK_START_DATE}" value="" readonly="readonly" class="grey"/></td>
						</tr>
						<tr>
							<td id="tdleft">담당자(자사) *</td>
							<td id="tdright"><input type="text" id="emp" name="Emp_No"
								value="${data.ENAME }" readonly="readonly" class="grey"> <input type="button" value="선택"
								id="empBtn" /></td>
						</tr>
						<tr>
							<td id="tdleft">비고</td>
							<td id="tdright"><input type="text" width="500px" id="Note"
								value="${data.NOTE }" name="Note" /></td>
						</tr>
					</tbody>
				</table>
			</div>
		</form>
	</div>

</body>
</html>