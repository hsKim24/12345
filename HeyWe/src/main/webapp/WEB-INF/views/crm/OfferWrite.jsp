<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 영업기회(메인)</title>
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/crm/sa_chance.css" />
<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css" href="resources/css/common/calendar.css" />
<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.css" />

<!-- calendar css -->
<link rel="stylesheet" type="text/css" href="resources/css/calendar/calendar.css" />
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>

<script type="text/javascript" src="resources/script/jquery/jquery-ui.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui.js"></script>
<!-- calendar Script -->
<script type="text/javascript" src="resources/script/calendar/calendar.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		showCalendar(d.getFullYear(),(d.getMonth() + 1));
		
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			showOn: 'button',
			closeText: '닫기',
			buttonImage: 'resources/images/calender.png',
			buttonImageOnly: true,
			dateFormat: 'yy/mm/dd'    
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
		
		if ($("#page").val() == "") {
			$("#page").val("1");
		}
		if ($("#check2").val() == "") {
			$("#check2").val("888");
		}
		if ($("#select1").val() == "") {
			$("#select1").val("10");
		}
		console.log($("#select1").val());
		console.log($("#check2").val());

		reloadList();
		reloadDept();
		reloadEmp();
		$("#write2").on("click", function() {

			$("#page").val("1");

			reloadList();

		});

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

			url : "CRMMarkChanceListAjax",

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
			html += "<div class=\"article\" name=\""  + list[i].CHANCE_NO + "\" id=\"" +list[i].MARK_NO + "\">"
			html += "<div class=\"articletop\">"
			if (list[i].PROGRESS_STEP_NO == 0) {
				html += "진행단계:&nbsp&nbsp<div id=\"block11\">인지</div>"
			} else {
				html += "진행단계:&nbsp&nbsp<div id=\"block1\">인지</div>"
			}
			if (list[i].PROGRESS_STEP_NO == 1) {
				html += "&nbsp->&nbsp<div id=\"block22\">제안</div>"
			} else {
				html += "&nbsp->&nbsp<div id=\"block2\">제안</div>"
			}
			if (list[i].PROGRESS_STEP_NO == 2) {
				html += "&nbsp->&nbsp <div id=\"block33\">협상</div>"
			} else {
				html += "&nbsp->&nbsp <div id=\"block3\">협상</div>"
			}
			if (list[i].PROGRESS_STEP_NO == 3) {
				html += "&nbsp->&nbsp <div id=\"block44\">계약</div>"
			} else {
				html += "&nbsp->&nbsp <div id=\"block4\">계약</div>"
			}
			html += "<div id=\"dot\">"
			html += "</div></div>"
			html += "<div class=\"articlemiddle\">"
			html += "<div id=\"ChanceName\">" + list[i].MNAME + "</div>"
			html += "<div>||</div> <div id=\"companyName\">" + list[i].CCNAME
					+ "</div>"
			html += "<div>||</div><div id=\"man\">" + list[i].MNNAME
					+ "</div><br />"
			html += "<div id=\"status\">" + list[i].PSENAME + "</div>"
			html += "<div>||</div><div id=\"day\">" + list[i].MARK_START_DATE
					+ "</div></div></div>"

		}
		$(".articlelist").html(html);
		
		$(".article").on("click", function() {
			console.log("aaa");
			$("#chanceno").val($(this).attr("name"));
			$("#markNo").val($(this).attr("id"));
			$("#dataForm").attr("action", "CRMMarkMgntOfferWrite");
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
		
		$("#listNum").on("click", "input", function() { // 페이징 영역

			$("#page").val($(this).attr("name"));
			
			reloadList();

		});
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
		<c:param name="leftMenuNo" value="22"></c:param>
		<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
	</c:import>

	<div class="content_area">
		<div class="content_nav">HeyWe &gt; CRM &gt; 영업관리 &gt; 제안  &gt; 제안등록 &gt; 기회선택</div>
		<div class="content_title">
			제안등록>기회선택 
		</div>
		<br />
	<!-- 	<div class = "TestBoxList">
		
			<div id="TestBox1">전체</div>
			<div id="TestBox2">제안</div>
			<div id="TestBox3">협상</div>
			<div id="TestBox4">계약</div>
		</div> -->
		<!-- 내용 영역 -->
		<div class="search">

			<form action="#" id="dataForm" method="post">
			<input type="hidden" id="OfferWrite" name="OfferWrite" value="1"/>
			<input
				type="hidden" id="chanceno" name="chanceno">
			<input
				type="hidden" id="markNo" name="markNo">
				<input type="hidden" id="stdt" name="stdt" value="${stdt}" /> <input
					type="hidden" id="eddt" name="eddt" value="${eddt}" /> <input
					type="hidden" id="page" name="page" value="${param.page}" /> <input
					type="hidden" id="check" name="check"> <input type="hidden"
					id="check2" name="check2"> <input type="hidden" id="chance"
					name="chance">
				<div class="search1">
					<input type="text" id="searchTxt" name="searchTxt" placeholder="검색어를 입력해주세요." />&nbsp <select id="select1"
						name="select1">
						<option value="10">진행상태(전체)</option>
						<option value="0">진행중</option>
						<option value="1">종료(실패)</option>
						<option value="2">종료(성공)</option>
						<option value="3">보류</option>
					</select> <br /> <br />
				</div>
			</form>

			<div class="search3">
				<input type="text" width="300px" height="30px" title="시작기간선택" id="date_start"
					name="date_start" value="" readonly="readonly" placeholder="영업시작일"/> ~ <input
					type="text" title="종료기간선택" id="date_end" name="date_end" value=""
					readonly="readonly" placeholder="영업종료일" />
			</div>

			<div class="search2">
							<select class="SelBox" id="sel" name="sel">
							</select> <select class="SelBox_1" id="sel2" name="sel2">
							</select> <img src="resources/images/erp/crm/search.png" id="write2" style="cursor:pointer" /> <br />
							<br />
						</div>

		</div>
		<br />

		<div id="hr_3">
			<hr />
		</div>

		<div class="articlelist"></div>
	<div id="listNum">
		
	</div>
	</div>
</body>
</html>