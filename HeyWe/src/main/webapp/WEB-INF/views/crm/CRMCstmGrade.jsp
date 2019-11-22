<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 고객사 등급</title>
<!-- Popup CSS -->
<link rel="stylesheet" type="text/css" href="resources/css/common/popup.css" />
<!-- calendar select css -->
<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="resources/css/common/calendar.css" />
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

<!-- main css -->
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<!-- cu_grade css -->
<link rel="stylesheet" type="text/css" href="resources/css/erp/crm/cu_grade.css" />
<style type="text/css">
/* 
	DarkBlue : rgb(19, 64, 116), #134074
	DeepLightBlue : rgb(141, 169, 196), #8DA9C4
	LightBlue : rgb(222,230,239), #DEE6EF
	White : rgb(255,255,255), #FFFFFF
 */
</style>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui.min.js"></script>
<script type="text/javascript">

var temp = "";

$(document).ready(function() {
	$("#pagingArea").on("click", "input", function() { //페이징 작업
		$("#page").val($(this).attr("name"));
		reloadList();
	});

	$("#searchImg").on("click", function() { //검색 작업
		$("#page").val("1");
		reloadList();
	});

	if ($("#page").val() == "") { //기본 페이지 상태
		$("#page").val("1");
		loadDept();
	}

	reloadList();

	$("#SelBoxD").change(function() { //담당자 드롭다운 메뉴
		loadEmp();
	});
	

	$("#gradeBtn").on("click", function() { //등급 변경 팝업 띄우기
		temp = "";
		$('[name="blockCheck"]:checked').each(function() {
			temp += "," + $(this).val();
		}); //체크박스 체크된 것만 가려서 값 가지고 오기
		
		if(temp.length < 1) {
			makeAlert(1, "", "선택한 고객사가 없습니다.", true, null);
		} else {
			temp = temp.substring(1);

			makePopup(1, "등급 변경", gradePopup(temp), true, 480, 200,
					function() {
						gradePopupCon();
					}, "확인", function() {
						if($.trim($("#dateSelect").val()) == ""){
							makeAlert(2, "", "변경 날짜를 선택해주세요.", true, function() {
								$("#dateSelect").focus();
							});
							
						} else if($.trim($(".changeBox").val()) == ""){
							makeAlert(2, "", "변경 등급을 선택해주세요.", true, function() {
								$(".gradeChange .changeBox").focus();
							});
							
						} else if($.trim($("#updateText").val()) == ""){
							makeAlert(2, "", "변경 사유를 기록해주세요.", true, function() {
								$("#updateText").focus();
							});
						} else {
							updateGrade();
						}
					});

			
		}
	});
	
	$("body").on("click", "#block_Center", function() {
		$("#cNo").val($(this).attr("name"));
		makeNoBtnPopup(1, "등급히스토리" , Histpopup() , true, 650, 300, function(){
			$("#HlistDiv").slimScroll({
				height: "150",
				axis: "both"
			});
			reloadHist();
		} , null);
	});
	
	$("body").on("click", ".close", function() { //팝업 닫음
		$("#gradePopupBox").remove();
		$("#histPopupBox").remove();
		$("#bg").remove();
	});
	
	$("body").on("click", "#backBtn", function() { //팝업 닫음
		$("#gradePopupBox").remove();
		$("#histPopupBox").remove();
		$("#bg").remove();
	});
	
	$("body").on("click", "#bg", function() { //bg 클릭 시 팝업 닫음
		$("#gradePopupBox").remove();
		$("#histPopupBox").remove();
		$("#bg").remove();
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
});

//등급히스토리 팝업
function reloadHist(){
	var params = $("#dataForm").serialize();
	$.ajax({
		type : "post",
		url : "CRMGradeHistAjax",
		dataType : "json",
		data : params,
		success : function(result) {
			redrawHist(result.dataH);
		},
		error : function(request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}

function Histpopup(){
	var html="";
		html+="<div class=\"histListdiv\">";
		html+="<table class=\"histListTop\">";
		html+="<colgroup>";
		html+="<col width=\"110px\">";
		html+="<col width=\"110px\">";
		html+="<col width=\"110px\">";
		html+="<col width=\"110px\">";
		html+="<col width=\"110px\">";
		html+="</colgroup>";
		html+="<tr>";
		html+="<th>영업명</th>";
		html+="<th>담당자명</th>";
		html+="<th>등급</th>";
		html+="<th>변경내용</th>";
		html+="<th>변경날짜</th>";
		html+="</tr>";
		html+="</table>";
		html+="<div id=\"HlistDiv\">"
		html+="<table id=\"drawList\">";
		html+="<colgroup>";
		html+="<col width=\"110px\">";
		html+="<col width=\"110px\">";
		html+="<col width=\"110px\">";
		html+="<col width=\"110px\">";
		html+="<col width=\"110px\">";
		html+="</colgroup>";
		html+="<tbody>";
		html+="</tbody>";
		html+="</table>";
		html+="</div>";
		html+="</div>";
	return html;
}

function redrawHist(dataH){
	var html = "";
	if(dataH.length == 0) {
		html+="<tr><th colspan='5'>등급히스토리가 존재하지 않습니다.</th></tr>";
	} else {
		for(var i = 0; i < dataH.length; i++){
			html+="<tr>";
			html+="<th>"+ dataH[i].CNAME +"</th>";
			html+="<th>"+ dataH[i].ENAME +"</th>";
			html+="<th>"+ dataH[i].CGNAME +"</th>";
			html+="<th>"+ dataH[i].GUPCON +"</th>";
			html+="<th>"+ dataH[i].GHDATE +"</th>";
			html+="</tr>";
		}
	}
	
	$("#drawList tbody").html(html);
}

//등급 변경 팝업
function gradePopup(temp) {
	var html = "";
	
	html += "<div id=\"gradeBox\"><form action=\"#\" id=\"popupForm\" method=\"post\">";
	html += "<input type=\"hidden\" id=\"blockCheck\" name=\"blockCheck\" value=\"" + temp + "\"/>";
	html += "<input type=\"hidden\" name=\"sEmpNo\" value=\"${sEmpNo}\"/>";
	html += "<table id=\"gradeTop\">";
	html += "<colgroup>";
	html += "<col width=\"200px\">";
	html += "<col width=\"200px\">";
	html += "<col width=\"200px\">";
	html += "</colgroup>";
	html += "<tr>";
	html += "<th>변경 날짜</th>";
	html += "<td id=\"Gdate\"></td>";
	html += "</tr>";
	html += "<tr>";
	html += "<th>변경 등급</th>";
	html += "<td id=\"Grade\"></td>";
	html += "</tr>";
	html += "<tr>";
	html += "<th>변경 사유</th>";
	html += "<td id=\"Gcon\"></td>";
	html += "</tr>";
	html += "</table>";
	html += "</form></div>";

	return html;
}

function gradePopupCon() {
	var html1 = "";
	html1 += "<input type=\"hidden\" id=\"uddt\" name=\"uddt\"/>"
			+ "<div><input type=\"text\" width=\"80px\" title=\"변경일 선택\""
			+ "id=\"dateSelect\" name=\"dateSelect\" value=\"\" readonly=\"readonly\"/></div>";
	$("#Gdate").html(html1);
	
	var html2 = "";
	html2 += "<div class=\"gradeChange\">"
			+ "<select class=\"changeBox\" name=\"changeBox\"><option value=\"\">등급 선택</option>"
			+ "<option value=\"0\">S등급</option><option value=\"1\">A등급</option><option value=\"2\">B등급</option>"
			+ "<option value=\"3\">C등급</option><option value=\"4\">D등급</option></select></div>";
	$("#Grade").html(html2);
	
	var html3 = "";
	html3 += "<input type=\"text\" id=\"updateText\" name=\"updateText\"/>";
	$("#Gcon").html(html3);
	
	$("#dateSelect").datepicker({
		dateFormat : 'yy-mm-dd',
		duration: 200,
		onSelect:function(dateText, inst){
			var startDate = parseInt($("#dateSelect").val().replace("-", ''));
			
			$("#uddt").val($("#dateSelect").val());
		}
	});
}

function updateGrade() {
	var params = $("#popupForm").serialize();
	$.ajax({
		type : "post",
		url : "CRMCstmUpdateGradeAjax",
		dataType : "json",
		data : params,
		success : function(result) {
			
			
				if(result.res == "success") {
					reloadList();
					closePopup(1);
					$("#bg").remove();
				} else {
					makeAlert(2, "알림", "등급변경에 실패했습니다.", true, null);
				}
			
		},
		error : function(request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + request.error);
		}
	});
}

//부서
function loadDept() {
	var params = $("#dataForm").serialize();

	$.ajax({
		type : "post",
		url : "CRMCstmGetDeptAjax",
		dataType : "json",
		data : params,
		success : function(dept) {
			reselectDept(dept.listD);
		},
		error : function(request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + request.error);
		}
	});
}

function reselectDept(listD) {
	var html = '';

	html += "<option value=\"\">부서(전체)</option>";
	for (var i = 0; i < listD.length; i++) {
		html += "<option value=\"" + listD[i].DEPT_NO +"\">" + listD[i].DEPT_NAME + "</option>";
	}

	$("#SelBoxD").html(html);
}

//담당자
function loadEmp() {
	var params = $("#dataForm").serialize();

	$.ajax({
		type : "post",
		url : "CRMCstmGetEmpAjax",
		dataType : "json",
		data : params,
		success : function(emp) {
			reselectEmp(emp.listE);
		},
		error : function(request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + request.error);
		}
	});
}

function reselectEmp(listE) {
	var html = '';

	html += "<option value=\"\">사원(전체)</option>";
	for (var i = 0; i < listE.length; i++) {
		html += "<option value=\"" + listE[i].EMP_NO +"\">" + listE[i].NAME + "</option>";
	}

	$("#SelBoxE").html(html);
}

//등급
function reloadList() {
	var params = $("#dataForm").serialize();

	$.ajax({
		type : "post",
		url : "CRMCstmGradeAjax",
		dataType : "json",
		data : params,
		success : function(result) {
			redrawList(result.list);
			redrawPaging(result.pb);
		},
		error : function(request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + request.error);
		}
	});
}

function redrawList(list) {
	var html = "";
	
	if (list.length == 0) {
		html += "<div class=\"noData\">데이터가 존재하지 않습니다.</div>";
	} else {
		for (var i = 0; i < list.length; i++) {
			html += "<div class=\"block\">";
			html += "<div id=\"leftcheck\"><input type=\"checkbox\" id=\"blockCheck\" name=\"blockCheck\" value=\"" + list[i].CNO + "\"></div>";
			html += "<div class=\"block_Center\" name=\"" + list[i].CNO + "\" id=\"block_Center\" >" + list[i].CNAME + "|"
					+ list[i].GNAME + "등급" + "|" + list[i].ENAME + "|"
					+ list[i].DNAME + "</div>";
			html += "</div>";
		}
	}
	$("#blockmok").html(html);
}

function redrawPaging(pb) {
	var html = "";

	html += "<input type=\"button\" value=\"first\" name=\"1\" />";

	if ($("#page").val() == "1") {
		html += "<input type=\"button\" value=\"prev\" name=\"1\" />";
	} else {
		html += "<input type=\"button\" value=\"prev\" name=\""
				+ ($("#page").val() * 1 - 1) + "\" />";
	}

	for (var i = pb.startPcount; i <= pb.endPcount; i++) {
		if (i == $("#page").val()) {
			html += "<input type=\"button\" value=\"" + i + "\" name=\"" + i + "\" disabled=\"disabled\" />";
		} else {
			html += "<input type=\"button\" value=\"" + i + "\" name=\"" + i + "\" />";
		}
	}

	if ($("#page").val() == pb.maxPcount) {
		html += "<input type=\"button\" value=\"next\" name=\"" + pb.maxPcount + "\" />";
	} else {
		html += "<input type=\"button\" value=\"next\" name=\""
				+ ($("#page").val() * 1 + 1) + "\" />";
	}

	html += "<input type=\"button\" value=\"last\" name=\"" + pb.maxPcount + "\"/>";

	$("#pagingArea").html(html);
	$("#pagingArea input[type='button']").button();
	
}
	
</script>
</head>
<body>
<c:import url="/topLeft">
	<c:param name="topMenuNo" value="17"></c:param>
	<c:param name="leftMenuNo" value="32"></c:param>
	<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
</c:import>

	<div class="content_area">
		<div class="content_nav">HeyWe &gt; CRM &gt; 고객 &gt; 고객사 등급</div>
		<!-- 내용 영역 -->
		<div class="content_title">고객사 등급</div>
		<form action="#" id="dataForm" method="post">
			<input type="hidden" name="page" id="page" value="${page}" />
			<input type="hidden" name="sEmpNo" id="sEmpNo" value="${sEmpNo}" />
			<input type="hidden" name="cNo" id="cNo" />
			<div class="search">
				<div class="search_top">
					<input type="text" id="txt_top" name="searchTxt"
						placeholder="검색어를 입력해주세요." > <select class="SelBox_1"
						name="gradeSelect">
						<option value="">등급(전체)</option>
						<option value="0">S등급</option>
						<option value="1">A등급</option>
						<option value="2">B등급</option>
						<option value="3">C등급</option>
						<option value="4">D등급</option>
					</select>
				</div>
				<div>
					<select class="SelBox" id="SelBoxD" name="check"></select>
					<select class="SelBox_1" id="SelBoxE" name="empSelect"><option value="">사원(전체)</option></select>
					<img src="resources/images/erp/crm/search.png" id="searchImg">
				</div>
			</div>
		
		<div>
			<c:if test="${auth eq 3}">
			<input type="button" value="등급변경" id="gradeBtn">
			</c:if>
		</div>
		<div class="bogy"></div>
		<div id="blockmok"></div>
		<div id="pagingArea"></div>
		<div id="gradePopup"></div>
		</form>
	</div>
</body>
</html>