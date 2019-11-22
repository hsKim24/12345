<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 프로젝트 관리</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/as/As_project.css" />
<style type="text/css">
.popup1 {
	width: 100%;
	height: 100%;
	font-size: 11pt;
	text-align: left;
}
.popup2 table{
	width: 470px;
	height: 10px;
	font-size: 11pt;
}

.popup2 table th {
	width: 135px;
	height: 10px;
	font-size: 11pt;
}
.popup2 table td{
	width: 300px;
	height: 10px;
	font-size: 11pt;
	text-align: left;
}
.popup3_3{
	width: 100%;
	height: 35px;
	font-size: 11pt;
	text-align: center;
}
#div1{
	width: 25%;
	height: 30px;
	display: inline-block;
	vertical-align: top;
	text-align: right;
}
#div2{
	width: 70%;
	height: 30px;
	display: inline-block;
	margin-left: 6px;
}
.popup3_2 table td{
	width: 150px;
	height: 20px;
	font-size: 11pt;
}

.popup4_1 {
	width: 100%;
	height: 40px;
}
.popup4_2 {
	width: 100%;
	height: 35px;
}
.popup4_3{
	width: 100%;
	height: 200px;
}
.popup4_3 table td{
	width: 140px;
	height: 20px;
}
.popup4_4{
	width: 210px;
	height: 150px;
}
.popup4_4 td{
	width: 150px;
	height: 30px;
}
.popup5{
	width: 100%;
	height: 250px;
}
#board5 th{
	width: 100px;
	height: 30px;
}
#board5 td{
	width: 320px;
	height: 30px;
}
#pagingArea {
	margin: 10px 0px;
	width : 880px;
	height: 40px;
	margin-left :40px;
	text-align: center;
}

#pagingArea > [type="button"] {
   display: inline-block;
   width: 30px;
   height: 30px;
   border: 1px solid #134074;
   border-radius:2px;
   font-size: 14pt;
   font-weight: bold;
   background-color: #FFFFFF;
   margin-left: 10px;
   color: #134074;
}

#pagingArea > [type="button"]:hover {
   cursor: pointer;
   background-color: #134074;
    color: #FFFFFF;
} 

#pagingArea  .paging_on {
   background-color: #134074;
   color: #FFFFFF;
}

#pagingArea  .paging_off {
   background-color: #FFFFFF;	
   color: #134074;
}
#textStd, #textFnd, #textPm, #textPpl, #textArNm, #textAppSol, #textPtype, #textMkNm, #textSolNm{
	width: 150px;
	height: 24px;
	font-size: 12pt;
}
#searchGbn {	
	width: 100px;
	height: 35px;
	padding: 0px;
	font-size: 11pt;	
	border-radius: 3px;
}
.pmBtn, .arNmBtn, .mkNmBtn, .pNmBtn{
	width: 80px;
	height: 31px;
	padding: 0px;
	font-size: 11pt;	
	background-color: #134074;
	color: #ffffff;
	border-radius: 3px;
	border: 1px solid #134074;
}
.pmBtnDtl, .arNmBtnDtl, .mkNmBtnDtl, .pNmBtnDtl, #addBtn, #delBtn, #allowTaskBtn, #addNmBtn, #taskNmBtn{
	width: 80px;
	height: 31px;
	padding: 0px;
	font-size: 11pt;	
	background-color: #134074;
	color: #ffffff;
	border-radius: 3px;
	border: 1px solid #134074;
	margin-left: 10px;
}
#listdiv {
	display: inline-block;
	min-width: calc(100% - 15px) !important;
	width: 250px;
	margin-left: 50px !important;
	height: 160px !important;
}
#listdiv_1 {
	display: inline-block;
	width: 400px;
	height: 160px;
}

#listdiv2 {
	display: inline-block;
	width: 400px;
	margin: 0px !important;
	height: 180px;
}

.checkPop_2 tbody tr.on {
	background-color: #DEE6EF;
}
.checkPop_2{
	width: 282px;
	height: 250px;
	text-align: center;
	margin: 0 auto;
} 
.css1{
	margin-left: 47px;
}
#searchBtn2{
	border-radius: 3px;
    width: 80px;
    height: 35px;
    padding: 5px;
    background-color: #134074;
    color: #FFF;
    font-weight: bold;
    outline: none;
}
#txt2{
	width: 200px;
	height: 31px;
	padding: 0px;
	font-size: 12pt;
	border-radius: 3px;
}
#dropBar2, #dropBar3{
	width: 90px;
	height: 35px;
	padding: 1px;
	font-size: 12pt;
	border-radius: 3px;
}
.popup4_3 tbody tr.on {
	background-color: #DEE6EF;
}
.popup3_2 tbody tr.on {
	background-color: #DEE6EF;
}

.popup7_4 tbody tr.on {
	background-color: #DEE6EF;
}
.popup7_4 td{
	width: 160px;
}
.popup7{
	margin-left: 24px;
}
</style>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function () {
			
	if($("#page").val() == ""){
		$("#page").val("1");
	}
	reloadList();
//-------권한 자산부장(7)아니면 등록버튼 안보임
	if("${sAuthNo}" != 7){
		$("#regiBtn").css("display", "none");
	}
//-------엔터쳤을때 안팅기기
	$(".midB").on("keypress", "input", function(event) {
		if(event.keyCode == 13) {
			$("#searchBtn").click();
			return false;
		}
	});
	
	$("#pagingArea").on("click", "input", function() {
		$("#page").val($(this).attr("name"));
		reloadList();
	});
	
	$("#searchBtn").on("click", function() {
		$("#page").val("1");
		reloadList();
	});
	
//-------신규등록
	$("#regiBtn").on("click", function () {
		
		var html="";
			html +=	"<form action=\"#\" id=\"writePdataForm\" method=\"post\">";
			html += "<input type=\"hidden\" name=\"projNo\" id=\"projNo\" >";
			html += "<input type=\"hidden\" name=\"solNo\" id=\"solNo\" >";
			html += "<input type=\"hidden\" name=\"arNo\" id=\"arNo\" >";
			html += "<input type=\"hidden\" name=\"mkNo\" id=\"mkNo\" >";
			html += "<input type=\"hidden\" name=\"empNo\" id=\"empNo\" >";
			
			html += "<div class=\"popup1\">";
			html +=	"<div><div id=\"div1\">프로젝트명</div>"
						+"<div id=\"div2\"><input type=\"text\" id=\"textSolNm\" name=\"textSolNm\" readonly=\"readonly\">"
						+"<input type=\"button\" value=\"프로젝트명\" class=\"pNmBtn\"></div><br><br>";
			html +=	"<div><div id=\"div1\">고 객 사</div>"
						+"<div id=\"div2\"><input type=\"text\" id=\"textMkNm\" name=\"textMkNm\" readonly=\"readonly\">"
						+"<input type=\"button\" value=\"고객사\" class=\"mkNmBtn\"></div></div><br>";
			html +=	"<div><div id=\"div1\">유 형</div>"
						+"<div id=\"div2\"><input type=\"text\" id=\"textPtype\" name=\"textPtype\"></div></div><br>";
			html +=	"<div><div id=\"div1\">적용 솔루션</div>"
						+"<div id=\"div2\"><input type=\"text\" id=\"textAppSol\" name=\"textAppSol\"></div></div><br>";
			html +=	"<div><div id=\"div1\">지 역</div>"
						+"<div id=\"div2\"><input type=\"text\" id=\"textArNm\" name=\"textArNm\" readonly=\"readonly\">"
						+"<input type=\"button\" value=\"지역\" class=\"arNmBtn\"></div></div><br>";
			html +=	"<div><div id=\"div1\">인 원</div>"
						+"<div id=\"div2\"><input type=\"text\" id=\"textPpl\" name=\"textPpl\" readonly=\"readonly\"></div></div><br>";
			html +=	"<div><div id=\"div1\">프로젝트 매니저</div>"
						+"<div id=\"div2\"><input type=\"text\" id=\"textPm\" name=\"textPm\" readonly=\"readonly\">"
						+"<input type=\"button\" value=\"PM\" class=\"pmBtn\"></div></div><br>";
			html +=	"<div><div id=\"div1\">시 작 일</div>"
						+"<div id=\"div2\"><input type=\"date\" id=\"textStd\" name=\"textStd\"></div></div>";
			html +=	"<div><div id=\"div1\">종 료 일</div>"
						+"<div id=\"div2\"><input type=\"date\" id=\"textFnd\" name=\"textFnd\"></div></div>";
			html += "</div>";
			html +=	"</form>"; 
			
		makePopup(1, "신규등록", html, true, 450, 520,
				function() {
			// 컨텐츠 이벤트
//-------프로젝트명 버튼 클릭
			$(".pNmBtn").on("click", function () {
				
				var html="";
				
				html +=	"<form action=\"#\" id=\"solTakeDataForm\" method=\"post\">";
				html += "<div class=\"checkPop_2\">";
				html += "<input type=\"hidden\" name=\"no\" id=\"no\">";
				html += "<input type=\"hidden\" name=\"nm\" id=\"nm\">";
				html += "<table class=\"css1\">";
				html +=	"<colgroup>";	
				html +=	"<col width=\"182\">";
				html +=	"<col width=\"182\">";
				html += "</colgroup>";
				html += "<thead>";
				html += "<tr>";
				html += "<th>프로젝트명</th>";
				html += "</tr>";
				html += "</thead>";
				html += "</table>";
				html += "<div id=\"listdiv\">";
				html += "<table id=\"board3\">";
				html +=	"<colgroup>";	
				html +=	"<col width=\"180\">";
				html +=	"<col width=\"180\">";
				html += "</colgroup>";
				html += "<tbody>";
				html += "</tbody>";
				html += "</table>";
				html += "</div>";
				html += "</div>";
				html += "</form>";
				
				makePopup(2, "프로젝트명", html, true, 350, 350,
					function() {
//-------스크롤					
					$("#listdiv").slimScroll({
						height: "170px",
						width: "230px",
						
						axis: "both"
					});
					
						$("#solTakeDataForm").attr("action","ASProjList")
						solTakeDataForm();
				
						$(".checkPop_2 tbody").on("click","tr", function () {
							$(".checkPop_2 tbody tr").removeAttr("class");// 선택한것만 냅둘려고 클래스 속성 제거
							$(".checkPop_2 #no").val($(this).children().attr("name"));// name 가져와서 .ch~no에 데이터 담기
							$(".checkPop_2 #nm").val($(this).children().html());// html에 자식값을 nm에 전달
							$(this).attr("class", "on");//하나선택한거 on시켜서 css 색깔입히는거 
							//td가 하나씩 늘어날때마다 eq(숫자)를 늘려준다.
						});
						
					}, "확인", function(){
						$("#writePdataForm #solNo").val($(".checkPop_2 #no").val());// no값을 textempno에 담기
						$("#writePdataForm #textSolNm").val($(".checkPop_2 #nm").val());// nm값을 textempnm에 담기
						closePopup(2);
					});
				});
			
//-------고객사명 버튼클릭
			$(".mkNmBtn").on("click", function () {
				
				var html="";
				
				html +=	"<form action=\"#\" id=\"mkTakeDataForm\" method=\"post\">";
				html += "<div class=\"checkPop_2\">";
				html += "<input type=\"hidden\" name=\"no\" id=\"no\">";
				html += "<input type=\"hidden\" name=\"nm\" id=\"nm\">";
				html += "<table class=\"css1\">";
				html +=	"<colgroup>";	
				html +=	"<col width=\"182\">";
				html +=	"<col width=\"182\">";
				html += "</colgroup>";
				html += "<thead>";
				html += "<tr>";
				html += "<th>고객사</th>";
				html += "</tr>";
				html += "</thead>";
				html += "</table>";
				html += "<div id=\"listdiv\">";
				html += "<table id=\"board3\">";
				html +=	"<colgroup>";	
				html +=	"<col width=\"180\">";
				html +=	"<col width=\"180\">";
				html += "</colgroup>";
				html += "<tbody>";
				html += "</tbody>";
				html += "</table>";
				html += "</div>";
				html += "</div>";
				html += "</form>";
				
				makePopup(2, "고객사", html, true, 350, 350,
					function() {
//스크롤					
					$("#listdiv").slimScroll({
						height: "170px",
						width: "230px",
						
						axis: "both"
					});
					
						$("#mkTakeDataForm").attr("action","ASProjList")
						mkTakeDataForm();
				
						$(".checkPop_2 tbody").on("click","tr", function () {
							$(".checkPop_2 tbody tr").removeAttr("class");// 선택한것만 냅둘려고 클래스 속성 제거
							$(".checkPop_2 #no").val($(this).children().attr("name"));// name 가져와서 .ch~no에 데이터 담기
							$(".checkPop_2 #nm").val($(this).children().html());// html에 자식값을 nm에 전달
							$(this).attr("class", "on");//하나선택한거 on시켜서 css 색깔입히는거 
							//td가 하나씩 늘어날때마다 eq(숫자)를 늘려준다.
						});
						
					}, "확인", function(){
						$("#writePdataForm #mkNo").val($(".checkPop_2 #no").val());// no값을 textempno에 담기
						$("#writePdataForm #textMkNm").val($(".checkPop_2 #nm").val());// nm값을 textempnm에 담기
						closePopup(2);
					});
				});
			
//-------지역 버튼클릭
			$(".arNmBtn").on("click", function () {
				
				var html="";
				
				html +=	"<form action=\"#\" id=\"arTakeDataForm\" method=\"post\">";
				html += "<div class=\"checkPop_2\">";
				html += "<input type=\"hidden\" name=\"no\" id=\"no\">";
				html += "<input type=\"hidden\" name=\"nm\" id=\"nm\">";
				html += "<table class=\"css1\">";
				html +=	"<colgroup>";	
				html +=	"<col width=\"182\">";
				html +=	"<col width=\"182\">";
				html += "</colgroup>";
				html += "<thead>";
				html += "<tr>";
				html += "<th>지역</th>";
				html += "</tr>";
				html += "</thead>";
				html += "</table>";
				html += "<div id=\"listdiv\">";
				html += "<table id=\"board3\">";
				html +=	"<colgroup>";	
				html +=	"<col width=\"180\">";
				html +=	"<col width=\"180\">";
				html += "</colgroup>";
				html += "<tbody>";
				html += "</tbody>";
				html += "</table>";
				html += "</div>";
				html += "</div>";
				html += "</form>";
				
				makePopup(2, "지역", html, true, 350, 350,
					function() {
//스크롤
					$("#listdiv").slimScroll({
						height: "170px",
						width: "230px",
						axis: "both"
					});
										
						$("#arTakeDataForm").attr("action","ASProjList")
						arTakeDataForm();
				
						$(".checkPop_2 tbody").on("click","tr", function () {
							$(".checkPop_2 tbody tr").removeAttr("class");// 선택한것만 냅둘려고 클래스 속성 제거
							$(".checkPop_2 #no").val($(this).children().attr("name"));// name 가져와서 .ch~no에 데이터 담기
							$(".checkPop_2 #nm").val($(this).children().html());// html에 자식값을 nm에 전달
							$(this).attr("class", "on");//하나선택한거 on시켜서 css 색깔입히는거 
							//td가 하나씩 늘어날때마다 eq(숫자)를 늘려준다.
						});
						
					}, "확인", function(){
						$("#writePdataForm #arNo").val($(".checkPop_2 #no").val());// no값을 textempno에 담기
						$("#writePdataForm #textArNm").val($(".checkPop_2 #nm").val());// nm값을 textempnm에 담기
						closePopup(2);
					});
				});
				
//-------프로젝트매니저 버튼클릭
			$(".pmBtn").on("click", function () {
				
				var html="";
				
				html +=	"<form action=\"#\" id=\"pmTakeDataForm\" method=\"post\">";
				html += "<div class=\"checkPop_2\">";
				html += "<input type=\"hidden\" name=\"no\" id=\"no\">";
				html += "<input type=\"hidden\" name=\"nm\" id=\"nm\">";
				html += "<table class=\"css1\">";
				html +=	"<colgroup>";	
				html +=	"<col width=\"182\">";
				html +=	"<col width=\"182\">";
				html += "</colgroup>";
				html += "<thead>";
				html += "<tr>";
				html += "<th>사원</th>";
				html += "</tr>";
				html += "</thead>";
				html += "</table>";
				html += "<div id=\"listdiv\">";
				html += "<table id=\"board3\">";
				html +=	"<colgroup>";	
				html +=	"<col width=\"180\">";
				html +=	"<col width=\"180\">";
				html += "</colgroup>";
				html += "<tbody>";
				html += "</tbody>";
				html += "</table>";
				html += "</div>";
				html += "</div>";
				html += "</form>";
				
				makePopup(2, "PM", html, true, 350, 350,
					function() {
//스크롤					
					$("#listdiv").slimScroll({
						height: "170px",
						width: "230px",
						axis: "both"
					});
					
						$("#pmTakeDataForm").attr("action","ASProjList")
						pmTakeDataForm();
				
						$(".checkPop_2 tbody").on("click","tr", function () {
							$(".checkPop_2 tbody tr").removeAttr("class");// 선택한것만 냅둘려고 클래스 속성 제거
							$(".checkPop_2 #no").val($(this).children().attr("name"));// name 가져와서 .ch~no에 데이터 담기
							$(".checkPop_2 #nm").val($(this).children().html());// html에 자식값을 nm에 전달
							$(this).attr("class", "on");//하나선택한거 on시켜서 css 색깔입히는거 
							//td가 하나씩 늘어날때마다 eq(숫자)를 늘려준다.
						});
						
					}, "확인", function(){
						$("#writePdataForm #empNo").val($(".checkPop_2 #no").val());// no값을 textempno에 담기
						$("#writePdataForm #textPm").val($(".checkPop_2 #nm").val());// nm값을 textempnm에 담기
						closePopup(2);
					});
				});
			
			
		}, "등록", function(){
//------- 종료일자가 시작일보다 이전으로 선택할수 없게 하는 것.(선언)			
			var startDate = $('#textStd').val();
		    var endDate = $('#textFnd').val();
		    var startArray = startDate.split('-');
		    var endArray = endDate.split('-');   
		    var start_date = new Date(startArray[0], startArray[1], startArray[2]);
		    var end_date = new Date(endArray[0], endArray[1], endArray[2]);
			
			if($.trim($("#textSolNm").val()) == ""){
				 makeAlert(2, "알림", "프로젝트명을 선택하세요", null, null);
				$("#textSolNm").focus();
			}else if($.trim($("#textMkNm").val())==""){
				makeAlert(2, "알림", "고객사를 선택하세요", null, null);
				$("#textMkNm").focus();
			}else if($.trim($("#textPtype").val())==""){
				makeAlert(2, "알림", "유형을 입력하세요", null, null);
				$("#textPtype").focus();
			}else if($.trim($("#textArNm").val())==""){
				makeAlert(2, "알림", "지역을 선택하세요", null, null);
				$("#textArNm").focus();
			}else if($.trim($("#textPm").val())==""){
				makeAlert(2, "알림", "프로젝트매니저를 선택하세요", null, null);
				$("#textPm").focus();
			}else if($.trim($("#textStd").val())==""){
				makeAlert(2, "알림", "시작일을 선택하세요", null, null);
				$("#textStd").focus();
//------- 종료일자가 시작일보다 이전선택시 못하게알림				
			}else if(start_date.getTime() > end_date.getTime()) {
	        	makeAlert(2, "알림", "종료일자가 시작일보다 빠릅니다.", null, null);
			}else if($.trim($("#textFnd").val())==""){
				makeAlert(2, "알림", "종료일를 선택하세요", null, null);
				$("#textFnd").focus();
			}else{	
				$("#writePdataForm").attr("action","ASProjList")
				writeForm();
			}
			
		});
	});
//-------상세보기 & 수정가능
	$("#mainBoard tbody").on("click", "tr", function () {
		$("#projNo").val($(this).attr("name"));
		$("#dataForm").attr("action","ASProjList");
		//alert($(this).attr("name"));
		projDtlForm();
	}); 
	
	
});//document ready 괄호

/*  makeThreeBtnPopup(1, "test", "test", true, 600, 200,
		function() {
	// 컨텐츠 이벤트
	}, "테스트1", function(){
		alert("aa1");
		closePopup(1);
	}, "테스트2", function(){
		alert("aa2");
		closePopup(1);
	}, "테스트3", function(){
		alert("aa3");
		closePopup(1);
	}); 
			
	 makePopup(1, "test", "test", true, 600, 200,
				function() {
			// 컨텐츠 이벤트
		}, "버튼", function(){
			alert("aa");
			closePopup(1);
		}); 
*/

//-------메인+ 페이징 리로드
function reloadList(){
	var params = $("#dataForm").serialize();

	$.ajax({
		type : "post",	
		url : "ASProjListAjax",	
		dataType : "json",	
		data : params,
		success : function (result) {
			redrawList(result.list3);
			redrawPaging(result.pb);
		},
		error : function (request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("erro : " + error);
		}
	});
}

//-------프로젝트 메인테이블 그리기
function redrawList(list) {
	
	var html = "";
	if(list.length == 0){
		html += "<tr><td colspan=\"8\">조회결과가 없습니다.</td></tr>";
	}else {
		for(var i = 0; i < list.length; i++){
			
			html +=	"<tr class=\"table_con\" name=\"" + list[i].PNO + "\">";
			html +=		"<td id=\"project\">" + list[i].SOLNM + "</td>";
			html +=		"<td id=\"clientC\">" + list[i].MKNM + "</td>";
			html +=		"<td id=\"typ\">" + list[i].PTYPE + "</td>";
			html +=		"<td id=\"applSol\">" + list[i].PAPPSOL + "</td>";
			html +=		"<td id=\"loca\">" + list[i].ARNM + "</td>";
			html +=		"<td id=\"pplNum\">" + list[i].INPPL + "</td>";
			html +=		"<td id=\"period\">" + list[i].PD + "</td>";
			html +=	"</tr >";
		}
			
	}
	
	$("#mainBoard tbody").html(html);
}

//------- 페이징
function redrawPaging(pb) {
	var html = "";
	html += "<input type=\"button\" value=\"&lt&lt\" name=\"1\" >";

	if ($("#page").val() == "1") {
		html += "<input type=\"button\" value=\"&lt\" name=\"1\" >";
	} else {
		html += "<input type=\"button\" value=\"&lt\" name=\""
				+ ($("#page").val() * 1 - 1) + "\">";
	}

	for (var i = pb.startPcount; i <= pb.endPcount; i++) {
		if (i == $("#page").val()) {
			html += "<input type=\"button\" value=\"" + i + "\" name=\"" 
					+ i + "\" disabled=\"disabled\" class=\"paging_on\">";
		} else {
			html += "<input type=\"button\" value=\"" + i + "\" name=\""
					+ i +  "\" class=\"paging_off\">";
		}
	}

	if ($("#page").val() == pb.maxPcount) {
		html += "<input type=\"button\" value=\"&gt\" name=\"" 
				+ pb.maxPcount +  "\">";
	} else {
		html += "<input type=\"button\" value=\"&gt\" name=\""
				+ ($("#page").val() * 1 + 1) + "\">";
	}
	html += "<input type=\"button\" value=\"&gt&gt\" name=\""
			+ pb.maxPcount +  "\">";

	$("#pagingArea").html(html);
}

//-------쓰기 ajax
function writeForm(){
	var params = $("#writePdataForm").serialize();

	$.ajax({
		type : "post",	
		url : "ASProjListWriteAjax",	
		dataType : "json",	
		data : params,
		success : function (result) {
			makeAlert(2, "알림", "등록성공", null, function () {
				closePopup(2);
				closePopup(1);
			});
			reloadList();
		},
		error : function (request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("erro : " + error);
		}
	});
}

//-------상세보기내  프로젝트명(sol)가져오기
function solTakeDataForm(){
	var params = $("#solTakeDataForm").serialize();
	
	$.ajax({
		type : "post",	
		url : "ASProjListSolTakeAjax",	
		dataType : "json",	
		data : params,
		success : function (result) {
			redrawList1(result.list4);
			
		},
		error : function (request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("erro : " + error);
		}
	});
}

//-------상세보기내  프로젝트명(sol)가져오기 / 테이블 그리기
function redrawList1(list) {
	var html = "";
	if (list.length == 0) {
		html += "<tr><td colspan=\"8\">조회결과가 없습니다.</td></tr>";
	} else {
		for (var i = 0; i < list.length; i++) {

			html += "<tr class=\"table_con\">";
			html += "<td name=\"" + list[i].SOL_NO + "\">" + list[i].SOL_NAME + "</td>";
			html += "</tr >";
		}
	}

	$("#board3 tbody").html(html);
}

//-------상세보기내  고객사(mk)가져오기
function mkTakeDataForm(){
	var params = $("#mkTakeDataForm").serialize();

	$.ajax({
		type : "post",	
		url : "ASProjListMkTakeAjax",	
		dataType : "json",	
		data : params,
		success : function (result) {
			redrawList2(result.list5);
			
		},
		error : function (request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("erro : " + error);
		}
	});
}

//-------상세보기내  고객사(mk)가져오기 / 테이블 그리기
function redrawList2(list) {
	var html = "";
	if (list.length == 0) {
		html += "<tr><td colspan=\"8\">조회결과가 없습니다.</td></tr>";
	} else {
		for (var i = 0; i < list.length; i++) {

			html += "<tr class=\"table_con\">";
			html += "<td name=\"" + list[i].MARK_NO + "\">" + list[i].NAME + "</td>";
			html += "</tr >";
		}
	}

	$("#board3 tbody").html(html);
}

//-------상세보기내  지역(area)가져오기
function arTakeDataForm(){
	var params = $("#arTakeDataForm").serialize();

	$.ajax({
		type : "post",	
		url : "ASProjListAreaTakeAjax",	
		dataType : "json",	
		data : params,
		success : function (result) {
			redrawList3(result.list6);
			
		},
		error : function (request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("erro : " + error);
		}
	});
}

//-------상세보기내  지역(area)가져오기 / 테이블 그리기
function redrawList3(list) {
	var html = "";
	if (list.length == 0) {
		html += "<tr><td colspan=\"8\">조회결과가 없습니다.</td></tr>";
	} else {
		for (var i = 0; i < list.length; i++) {

			html += "<tr class=\"table_con\">";
			html += "<td name=\"" + list[i].AREA_NO + "\">" + list[i].AREA_NAME + "</td>";
			html += "</tr >";
		}
	}

	$("#board3 tbody").html(html);
}

//-------상세보기내  프로젝트매니저(PM)가져오기
function pmTakeDataForm(){
	var params = $("#pmTakeDataForm").serialize();
	
	$.ajax({
		type : "post",	
		url : "ASProjListPmTakeAjax",	
		dataType : "json",	
		data : params,
		success : function (result) {
			redrawList4(result.list7);
			
		},
		error : function (request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("erro : " + error);
		}
	});
}

//-------상세보기내  프로젝트매니저(PM)가져오기 / 테이블 그리기
function redrawList4(list) {
	var html = "";
	if (list.length == 0) {
		html += "<tr><td colspan=\"8\">조회결과가 없습니다.</td></tr>";
	} else {
		for (var i = 0; i < list.length; i++) {

			html += "<tr class=\"table_con\">";
			html += "<td name=\"" + list[i].EMP_NO + "\">" + list[i].ENAME + "</td>";
			html += "</tr >";
		}
	}

	$("#board3 tbody").html(html);
}

//-------상세보기 관련 ajax
function projDtlForm(){
	var params = $("#dataForm").serialize();
	
	$.ajax({
		type : "post",	
		url : "ASProjListDtlAjax",	
		dataType : "json",	
		data : params,
		success : function (result) {
			redrawList5(result.data, result.list);
			
		},
		error : function (request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("erro : " + error);
		}
	});
}
//-------상세보기 관련 테이블 그리기 
function redrawList5(data, list){

		var html="";
		//히든에 숨겨진 사용되지 않는 NO의 값을 받을때 히든에 VALUE를 줘서 값을 받음
		html +=	"<form action=\"#\" id=\"updateDataForm\" method=\"post\">"; 
		html += "<input type=\"hidden\" id=\"projNo\" name=\"projNo\" value=\""+ data.PNO +"\">"
		html += "<input type=\"hidden\" id=\"solNo\" name=\"solNo\" value=\""+ data.SOLNO +"\">"
		html += "<input type=\"hidden\" name=\"arNo\" id=\"arNo\" value=\""+ data.ARNO +"\">";
		html += "<input type=\"hidden\" name=\"mkNo\" id=\"mkNo\" value=\""+ data.MKNO +"\">";
		html += "<input type=\"hidden\" name=\"empNo\" id=\"empNo\" value=\""+ data.ENO +"\">"; 
		html += "<input type=\"hidden\" name=\"outEmpNo\" id=\"outEmpNo\">"; 
		html += "<input type=\"hidden\" name=\"deptNo\" id=\"deptNo\">"; 
		html += "<input type=\"hidden\" name=\"mngtNo\" id=\"mngtNo\">"; 
		html += "<input type=\"hidden\" name=\"inpStd\" id=\"inpStd\">"; 
		html += "<input type=\"hidden\" name=\"inpFnd\" id=\"inpFnd\">"; 
		html += "<input type=\"hidden\" name=\"pjTaskNo\" id=\"pjTaskNo\">"; 
		html += "<input type=\"hidden\" name=\"inpNo\" id=\"inpNo\" >"; 
		
		html += "<div class=\"popup2\">";
		html +=		"<table id=\"board2\">";
		html +=			"<tbody>";
		html +=				"<tr class=\"table_con2\">";
		html +=					"<th class=\"indexlongTh\">프로젝트명</th>";
		html +=					"<td id=\"textSolNm\"><input type=\"text\" id=\"textSolNmUp\" name=\"textSolNmUp\" value=\""+ data.SOLNM +"\" readonly=\"readonly\">";
		html += "<input type=\"button\" value=\"프로젝트명\" class=\"pNmBtnDtl\"></td>";
		html +=				"</tr>"
		html +=				"<tr class=\"table_con\">";
		html +=					"<th class=\"indexlongTh\">고객사</th>";
		html +=					"<td id=\"textMkNm\"><input type=\"text\" id=\"textMkNmUp\" name=\"textMkNmUp\" value=\""+ data.MKNM +"\" readonly=\"readonly\">"; 
		html += "<input type=\"button\" value=\"고객사\" class=\"mkNmBtnDtl\"></td>";
		html +=				"</tr>";
		html +=				"<tr class=\"table_con2\">";
		html +=					"<th class=\"indexlongTh\">프로젝트 매니저</th>";
		html +=					"<td id=\"textPm\"><input type=\"text\" id=\"textPmUp\" name=\"textPmUp\" value=\""+ data.ENM +"\" readonly=\"readonly\">"; 
		html += "<input type=\"button\" value=\"PM\" class=\"pmBtnDtl\"></td>";
		html +=				"</tr>"	;	
		html +=				"<tr class=\"table_con\">";
		html +=					"<th class=\"indexlongTh\">지역</th>";
		html +=					"<td id=\"textArNm\"><input type=\"text\" id=\"textArNmUp\" name=\"textArNmUp\" value=\""+ data.ARNM +"\" readonly=\"readonly\">";
		html += "<input type=\"button\" value=\"지역\" class=\"arNmBtnDtl\"></td>";
		html +=				"</tr>";
		html +=				"<tr class=\"table_con2\">";
		html +=					"<th class=\"indexshortTh\">기간</th>";
		html +=					"<td id=\"pd\"><input type=\"text\" id=\"textStdUp\" name=\"textStdUp\" readonly=\"readonly\" value=\""+ data.PSTD +"\">"
								+"<input type=\"date\" id=\"textFndUp\" name=\"textFndUp\" value=\""+ data.PFND +"\"></td>"; 
		html +=				"</tr>"	;	
		html +=				"<tr class=\"table_con\">";
		html +=					"<th class=\"indexshortTh\">적용솔루션</th>";
		html +=					"<td id=\"textAppSol\"><input type=\"text\" id=\"textAppSolUp\" name=\"textAppSolUp\" value=\""+ data.PAPPSOL +"\"></td>";
		html +=				"</tr>";
		html +=				"<tr class=\"table_con2\">";
		html +=					"<th class=\"short\">인원</th>";
		html +=					"<td id=\"textPpl\"><input type=\"text\" id=\"textPplUp\" name=\"textPplUp\" value=\""+ list.length +"\" readonly=\"readonly\"></td>";
		html +=				"</tr>";
		html +=				"<tr class=\"table_con\">";
		html +=					"<th class=\"short\">유형</th>";
		html +=					"<td id=\"textPtype\"><input type=\"text\" id=\"textPtypeUp\" name=\"textPtypeUp\" value=\""+ data.PTYPE +"\"></td>";
		html +=				"</tr>";
		html +=			"</tbody>";				
		html +=		"</table>";
		html +=	"</div>";
		html +=	"<div class=\"popup3\">";
		html +=		"<div class=\"popup3_1\">";
		html +=			"<table>";
		html +=				"<colgroup>";
		html +=					"<col width=\"160\">";
		html +=					"<col width=\"160\">";
		html +=					"<col width=\"160\">";
		html +=				"</colgroup>";
		html +=				"<thead>";
		html +=					"<tr>";
		html +=						"<th>이름</th>";
		html +=						"<th>직급</th>";
		html +=						"<th>업무</th>";
		html +=					"</tr>";
		html +=				"</thead>";
		html +=			"</table>";
		html +=		"</div>";
		html +=		"<div class=\"popup3_2\">";	
		html += 			"<div id=\"listdiv_1\">";
		html +=			"<table id=\"board2sub\">";	
		html +=				"<tbody>";
//-------상세보기 하단부 테이블(이름,직급,업무 - 인원추가,제거)
		if (list.length == 0) {
			html += "<tr><td></td><td colspan=\"8\">조회결과가 없습니다.</td><td></td></tr>";
		} else {
			for (var i = 0; i < list.length; i++) {

				html += "<tr class=\"table_con\" name=\"" + list[i].INPUT_PPL_NO + "\">";
				html += "<td>" + list[i].NAME + "</td>";
				html += "<td>" + list[i].POSI_NAME + "</td>";
				html += "<td>" + list[i].MNGR_TASK_NAME + "</td>";
				html += "</tr >";
			}
		}
		html +=				"</tbody>";
		html +=			"</table>";
		html +=		"</div>";
		html +=		"</div>";
		html += 	"<div class=\"popup3_3\">";
		html += 		"<input type=\"button\" value=\"인원추가\" id=\"addBtn\" name=\"addbtn\">";
		html += 		"<input type=\"button\" value=\"인원제거\" id=\"delBtn\" name=\"delBtn\">";
		
		html +=		"</div>"; 
		html +=	"</div>"; 
		html +=	"</form>";
		
		
		makeTwoBtnPopup(1, "프로젝트 상세보기 & 수정", html, true, 500, 690,
				function() {
			// 컨텐츠 이벤트
//-------스크롤			
			$("#listdiv_1").slimScroll({
				height: "160px",
				width: "490px",
				
				axis: "both"
			});
			
//-------권한 상세보기내 6개 버튼 막기 자산부장(7)아니면 버튼 사라짐
			if("${sAuthNo}" != 7){
				$(".pNmBtnDtl").css("display", "none");
				$(".mkNmBtnDtl").css("display", "none");
				$(".arNmBtnDtl").css("display", "none");
				$(".pmBtnDtl").css("display", "none");
				$("#addBtn").css("display", "none");
				$("#delBtn").css("display", "none");
			}	

//-------프로젝트 상세보기 내 4개 버튼 이벤트

//-------프로젝트명 버튼클릭
			$(".pNmBtnDtl").on("click", function () {
				
				var html="";
				
				html +=	"<form action=\"#\" id=\"solTakeDataForm\" method=\"post\">";
				html += "<div class=\"checkPop_2\">";
				html += "<input type=\"hidden\" name=\"no\" id=\"no\">";
				html += "<input type=\"hidden\" name=\"nm\" id=\"nm\">";
				html += "<table class=\"css1\">";
				html +=	"<colgroup>";	
				html +=	"<col width=\"182\">";
				html +=	"<col width=\"182\">";
				html += "</colgroup>";
				html += "<thead>";
				html += "<tr>";
				html += "<th>프로젝트명</th>";
				html += "</tr>";
				html += "</thead>";
				html += "</table>";
				html += "<div id=\"listdiv\">";
				html += "<table id=\"board3\">";
				html +=	"<colgroup>";	
				html +=	"<col width=\"180\">";
				html +=	"<col width=\"180\">";
				html += "</colgroup>";
				html += "<tbody>";
				html += "</tbody>";
				html += "</table>";
				html += "</div>";
				html += "</div>";
				html += "</form>";
				
				makePopup(2, "프로젝트명", html, true, 350, 350,
					function() {
					
					$("#listdiv").slimScroll({
						height: "170px",
						width: "230px",
						axis: "both"
					});
					
						$("#solTakeDataForm").attr("action","ASProjList")
						solTakeDataForm();
				
						$(".checkPop_2 tbody").on("click","tr", function () {
							$(".checkPop_2 tbody tr").removeAttr("class");// 선택한것만 냅둘려고 클래스 속성 제거
							$(".checkPop_2 #no").val($(this).children().attr("name"));// name 가져와서 .ch~no에 데이터 담기
							$(".checkPop_2 #nm").val($(this).children().html());// html에 자식값을 nm에 전달
							$(this).attr("class", "on");//하나선택한거 on시켜서 css 색깔입히는거 
							//td가 하나씩 늘어날때마다 eq(숫자)를 늘려준다.
						});
						
					}, "확인", function(){
						$("#updateDataForm #solNo").val($(".checkPop_2 #no").val());// no값을 textempno에 담기
						$("#updateDataForm #textSolNmUp").val($(".checkPop_2 #nm").val());// nm값을 textempnm에 담기
						closePopup(2);
					});
				});
				
//-------고객사명 버튼클릭
			$(".mkNmBtnDtl").on("click", function () {
				
				var html="";
				
				html +=	"<form action=\"#\" id=\"mkTakeDataForm\" method=\"post\">";
				html += "<div class=\"checkPop_2\">";
				html += "<input type=\"hidden\" name=\"no\" id=\"no\">";
				html += "<input type=\"hidden\" name=\"nm\" id=\"nm\">";
				html += "<table class=\"css1\">";
				html +=	"<colgroup>";	
				html +=	"<col width=\"182\">";
				html +=	"<col width=\"182\">";
				html += "</colgroup>";
				html += "<thead>";
				html += "<tr>";
				html += "<th>고객사</th>";
				html += "</tr>";
				html += "</thead>";
				html += "</table>";
				html += "<div id=\"listdiv\">";
				html += "<table id=\"board3\">";
				html +=	"<colgroup>";	
				html +=	"<col width=\"180\">";
				html +=	"<col width=\"180\">";
				html += "</colgroup>";
				html += "<tbody>";
				html += "</tbody>";
				html += "</table>";
				html += "</div>";
				html += "</div>";
				html += "</form>";
				
				makePopup(2, "고객사", html, true, 350, 350,
					function() {
					
					$("#listdiv").slimScroll({
						height: "170px",
						width: "230px",
						axis: "both"
					});
					
						$("#mkTakeDataForm").attr("action","ASProjList")
						mkTakeDataForm();
				
						$(".checkPop_2 tbody").on("click","tr", function () {
							$(".checkPop_2 tbody tr").removeAttr("class");// 선택한것만 냅둘려고 클래스 속성 제거
							$(".checkPop_2 #no").val($(this).children().attr("name"));// name 가져와서 .ch~no에 데이터 담기
							$(".checkPop_2 #nm").val($(this).children().html());// html에 자식값을 nm에 전달
							$(this).attr("class", "on");//하나선택한거 on시켜서 css 색깔입히는거 
							//td가 하나씩 늘어날때마다 eq(숫자)를 늘려준다.
						});
						
					}, "확인", function(){
						$("#updateDataForm #mkNo").val($(".checkPop_2 #no").val());// no값을 textempno에 담기
						$("#updateDataForm #textMkNmUp").val($(".checkPop_2 #nm").val());// nm값을 textempnm에 담기
						closePopup(2);
					});
				});
			
//-------지역 버튼클릭
			$(".arNmBtnDtl").on("click", function () {
				
				var html="";
				
				html +=	"<form action=\"#\" id=\"arTakeDataForm\" method=\"post\">";
				html += "<div class=\"checkPop_2\">";
				html += "<input type=\"hidden\" name=\"no\" id=\"no\">";
				html += "<input type=\"hidden\" name=\"nm\" id=\"nm\">";
				html += "<table class=\"css1\">";
				html +=	"<colgroup>";	
				html +=	"<col width=\"182\">";
				html +=	"<col width=\"182\">";
				html += "</colgroup>";
				html += "<thead>";
				html += "<tr>";
				html += "<th>지역</th>";
				html += "</tr>";
				html += "</thead>";
				html += "</table>";
				html += "<div id=\"listdiv\">";
				html += "<table id=\"board3\">";
				html +=	"<colgroup>";	
				html +=	"<col width=\"180\">";
				html +=	"<col width=\"180\">";
				html += "</colgroup>";
				html += "<tbody>";
				html += "</tbody>";
				html += "</table>";
				html += "</div>";
				html += "</div>";
				html += "</form>";
				
				makePopup(2, "지역", html, true, 350, 350,
					function() {
					
					$("#listdiv").slimScroll({
						height: "170px",
						width: "230px",
						axis: "both"
					});
					
						$("#arTakeDataForm").attr("action","ASProjList")
						arTakeDataForm();
				
						$(".checkPop_2 tbody").on("click","tr", function () {
							$(".checkPop_2 tbody tr").removeAttr("class");// 선택한것만 냅둘려고 클래스 속성 제거
							$(".checkPop_2 #no").val($(this).children().attr("name"));// name 가져와서 .ch~no에 데이터 담기
							$(".checkPop_2 #nm").val($(this).children().html());// html에 자식값을 nm에 전달
							$(this).attr("class", "on");//하나선택한거 on시켜서 css 색깔입히는거 
							//td가 하나씩 늘어날때마다 eq(숫자)를 늘려준다.
						});
						
					}, "확인", function(){
						$("#updateDataForm #arNo").val($(".checkPop_2 #no").val());// no값을 textempno에 담기
						$("#updateDataForm #textArNmUp").val($(".checkPop_2 #nm").val());// nm값을 textempnm에 담기
						closePopup(2);
					});
				});
				
//-------프로젝트매니저 버튼클릭
			$(".pmBtnDtl").on("click", function () {
				
				var html="";
				
				html +=	"<form action=\"#\" id=\"pmTakeDataForm\" method=\"post\">";
				html += "<div class=\"checkPop_2\">";
				html += "<input type=\"hidden\" name=\"no\" id=\"no\">";
				html += "<input type=\"hidden\" name=\"nm\" id=\"nm\">";
				html += "<table class=\"css1\">";
				html +=	"<colgroup>";	
				html +=	"<col width=\"182\">";
				html +=	"<col width=\"182\">";
				html += "</colgroup>";
				html += "<thead>";
				html += "<tr>";
				html += "<th>사원</th>";
				html += "</tr>";
				html += "</thead>";
				html += "</table>";
				html += "<div id=\"listdiv\">";
				html += "<table id=\"board3\">";
				html +=	"<colgroup>";	
				html +=	"<col width=\"180\">";
				html +=	"<col width=\"180\">";
				html += "</colgroup>";
				html += "<tbody>";
				html += "</tbody>";
				html += "</table>";
				html += "</div>";
				html += "</div>";
				html += "</form>";
				
				makePopup(2, "PM", html, true, 350, 350,
					function() {
					
					$("#listdiv").slimScroll({
						height: "170px",
						width: "230px",
						axis: "both"
					});
					
						$("#pmTakeDataForm").attr("action","ASProjList")
						pmTakeDataForm();
				
						$(".checkPop_2 tbody").on("click","tr", function () {
							$(".checkPop_2 tbody tr").removeAttr("class");// 선택한것만 냅둘려고 클래스 속성 제거
							$(".checkPop_2 #no").val($(this).children().attr("name"));// name 가져와서 .ch~no에 데이터 담기
							$(".checkPop_2 #nm").val($(this).children().html());// html에 자식값을 nm에 전달
							$(this).attr("class", "on");//하나선택한거 on시켜서 css 색깔입히는거 
							//td가 하나씩 늘어날때마다 eq(숫자)를 늘려준다.
						});
						
					}, "확인", function(){
						$("#updateDataForm #empNo").val($(".checkPop_2 #no").val());// no값을 textempno에 담기
						$("#updateDataForm #textPmUp").val($(".checkPop_2 #nm").val());// nm값을 textempnm에 담기
						closePopup(2);
					});
				});	
		
//-------인원추가 버튼클릭
			$("#addBtn").on("click", function () {
				
				var html="";
				
				html +=	"<form action=\"#\" id=\"addEmpDataForm\" method=\"post\">";
				html += "<input type=\"hidden\" name=\"empNo\" id=\"empNo\" >"; 
				html += "<input type=\"hidden\" name=\"outEmpNo\" id=\"outEmpNo\" >"; 
				html += "<input type=\"hidden\" name=\"pjTaskNo\" id=\"pjTaskNo\" >"; 
				html += "<input type=\"hidden\" id=\"projNo\" name=\"projNo\" value=\""+ $("#updateDataForm #projNo").val() +"\">";
				
				html += "<div class=\"popup5\">";
				html +=		"<table id=\"board5\">";
				html +=			"<tbody>";
				html +=				"<tr class=\"table_con2\">";
				html +=					"<th class=\"indexlongTh\">이름</th>";
				html +=					"<td><input type=\"text\" id=\"textAddNm\" name=\"textAddNm\" readonly=\"readonly\" >";
				html += "<input type=\"button\" value=\"이름\" id=\"addNmBtn\"></td>";
				html +=				"</tr>"
				html +=				"<tr class=\"table_con\">";
				html +=					"<th class=\"indexlongTh\">업무</th>";
				html +=					"<td id=\"textMkNm\"><input type=\"text\" id=\"pjTask\" name=\"pjTask\" readonly=\"readonly\" >"; 
				html += "<input type=\"button\" value=\"업무\" id=\"taskNmBtn\"></td>";
				html +=				"</tr>";
				html +=				"<tr class=\"table_con2\">";
				html +=					"<th class=\"indexlongTh\">PJ 시작일</th>";
				html +=					"<td id=\"textPm\"><input type=\"text\" id=\"pjStd\" name=\"pjStd\" value=\""+ data.PSTD +"\" readonly=\"readonly\" >"; 
				html +=				"</tr>"	;	
				html +=				"<tr class=\"table_con\">";
				html +=					"<th class=\"indexlongTh\">PJ 종료일</th>";
				html +=					"<td id=\"textArNm\"><input type=\"text\" id=\"pjFnd\" name=\"pjFnd\" value=\""+ data.PFND +"\" readonly=\"readonly\" >";
				html +=				"</tr>";
				html +=			"</tbody>";				
				html +=		"</table>";
				html +=	"</div>";
				html += "</form>";
				
				makePopup(2, "인원추가", html, true, 460, 300,
					function() {
					
//-------인원추가내 이름 버튼					
					$("#addNmBtn").on("click", function () {
						
						var html="";
						
					 	html +=	"<form action=\"#\" id=\"addEmpSearchDataForm\" method=\"post\"/>";
						html += "<div class=\"popup4\">";
						html +=		"<div class=\"popup4_2\">";	
						html +=			"<table>";
						html +=				"<colgroup>";
						html +=					"<col width=\"148\">";
						html +=					"<col width=\"148\">";
						html +=					"<col width=\"148\">";
						html +=				"</colgroup>";
						html +=				"<thead>";
						html +=					"<tr>";
						html +=						"<th>이름</th>";
						html +=						"<th>소속</th>";
						html +=						"<th>사용기술</th>";
						html +=					"</tr>";
						html +=				"</thead>";
						html +=			"</table>";		
						html +=		"</div>";
						html +=		"<div id=\"listdiv2\">";
						html +=		"<div class=\"popup4_3\">";
						html += "<input type=\"hidden\" name=\"no\" id=\"no\"/>";
						html += "<input type=\"hidden\" name=\"nm\" id=\"nm\"/>";
						html +=			"<table id=\"board5_1\">";					
						html +=				"<tbody>";
						html +=				"</tbody>";			
						html +=			"</table>";
						html +=		"</div>";
						html +=		"</div>";
						html +=	"</div>";
						html += "</form>";
						 
						makePopup(3, "이름", html, true, 460, 400,
								function() {
							// 컨텐츠 이벤트
							$("#listdiv2").slimScroll({
								height: "200px",
								width: "450px ",
								
								axis: "both"
							});
							
							addEmpForm();
							
							$("body").on("click",".popup4_3 tbody tr", function () {
								$(".popup4_3 tbody tr").removeAttr("class");// 선택한것만 냅둘려고 클래스 속성 제거
								$(".popup4_3 #no").val($(this).children().attr("name"));// name 가져와서 .ch~no에 데이터 담기
								//console.log($(this).children().attr("name"));
								//console.log($(".popup4_3 #no").val());
								$(".popup4_3 #nm").val($(this).children().html());// html에 자식값을 nm에 전달
								$(this).attr("class", "on");//하나선택한거 on시켜서 css 색깔입히는거 
								//td가 하나씩 늘어날때마다 eq(숫자)를 늘려준다.
							});
								
							
						}, "확인", function(){
//-------내부인원, 외부인원 값 담기 if/else 문
							if($(".popup4_3 tbody tr.on").children().eq(1).html() != "외부") {
								$("#addEmpDataForm #empNo").val($(".popup4_3 #no").val());// no값을 textempno에 담기
							} else {
								$("#addEmpDataForm #outEmpNo").val($(".popup4_3 #no").val());// no값을 textempno에 담기
							}
							
							$("#addEmpDataForm #textAddNm").val($(".popup4_3 #nm").val());// nm값을 textempnm에 담기
							
							closePopup(3);
						}); 
						
					});
					
//-------인원추가내 업무 버튼						
					$("#taskNmBtn").on("click", function () {
						
						var html="";
						
					 	html +=	"<form action=\"#\" id=\"addTaskDataForm\" method=\"post\">";
						html += "<div class=\"popup7\">";
						html +=		"<div class=\"popup7_2\">";	
						html +=			"<table>";
						html +=				"<colgroup>";
						html +=					"<col width=\"170\">";
						html +=				"</colgroup>";
						html +=				"<thead>";
						html +=					"<tr>";
						html +=						"<th>업무</th>";
						html +=					"</tr>";
						html +=				"</thead>";
						html +=			"</table>";		
						html +=		"</div>";
						html +=		"<div id=\"listdiv_2\">";
						html +=		"<div class=\"popup7_4\">";
						html += "<input type=\"hidden\" name=\"no\" id=\"no\"/>";
						html += "<input type=\"hidden\" name=\"nm\" id=\"nm\"/>";
						html +=			"<table id=\"board5_2\">";					
						html +=				"<tbody>";
						html +=				"</tbody>";			
						html +=			"</table>";
						html +=		"</div>";
						html +=		"</div>";
						html +=	"</div>";
						html += "</form>";
						 
						 makePopup(3, "업무", html, true, 240, 320,
									function() {
								// 컨텐츠 이벤트
								$("#listdiv_2").slimScroll({
									height: "140px",
									width: "170px ",
									axis: "both"
									
								});
								
								addTaskForm();
								
								$("body").on("click",".popup7_4 tbody tr", function () {
									$(".popup7_4 tbody tr").removeAttr("class");// 선택한것만 냅둘려고 클래스 속성 제거
									$(".popup7_4 #no").val($(this).children().attr("name"));// name 가져와서 .ch~no에 데이터 담기
									//console.log($(this).children().attr("name"));
									//console.log($(".popup4_3 #no").val());
									$(".popup7_4 #nm").val($(this).children().html());// html에 자식값을 nm에 전달
									$(this).attr("class", "on");//하나선택한거 on시켜서 css 색깔입히는거 
									//td가 하나씩 늘어날때마다 eq(숫자)를 늘려준다.
								});
								
							}, "확인", function(){
								$("#addEmpDataForm #pjTaskNo").val($(".popup7_4 #no").val());// no값을 textempno에 담기
								$("#addEmpDataForm #pjTask").val($(".popup7_4 #nm").val());// nm값을 textempnm에 담기
								closePopup(3);
							}); 
							
						});
					
						
					}, "확인", function(){
						writeAddForm();
						closePopup(2);
					}); 
					
				});	
				
//-------인원제거 버튼클릭
			$("#delBtn").on("click", function () {
				
				var html="";
				
				html +=	"<form action=\"#\" id=\"delEmpDataForm\" method=\"post\">";
				html += "<input type=\"hidden\" name=\"empNo\" id=\"empNo\" >"; 
				html += "<input type=\"hidden\" name=\"outEmpNo\" id=\"outEmpNo\" >"; 
				html += "<input type=\"hidden\" name=\"pjTaskNo\" id=\"pjTaskNo\" >"; 
				
				
				html += "<input type=\"hidden\" id=\"projNo\" name=\"projNo\" value=\""+ $("#updateDataForm #projNo").val() +"\">";
				html += "<input type=\"hidden\" id=\"inpNo\" name=\"inpNo\" value=\"\">";
				
				html +=		"<div class=\"popup3_2\">";	
				html += 			"<div id=\"listdiv_1\">";
				html +=			"<table id=\"board2sub\">";	
				html +=				"<tbody>";
//-------상세보기 하단부 테이블 그리기
				if (list.length == 0) {
					html += "<tr><td></td><td colspan=\"8\">조회결과가 없습니다.</td><td></td></tr>";
				} else {
					for (var i = 0; i < list.length; i++) {
						console.log(list);
						html += "<tr class=\"table_con\" name=\"" + list[i].INPUT_PPL_NO + "\" >";
						html += "<td>" + list[i].NAME + "</td>";
						html += "<td>" + list[i].POSI_NAME + "</td>";
						html += "<td>" + list[i].MNGR_TASK_NAME + "</td>";
						html += "</tr >";
					}
				}
				html +=				"</tbody>";
				html +=			"</table>";
				html +=		"</div>";
				html +=	"</div>"; 
				html += "</form>";
				
				makePopup(2, "인원제거", html, true, 430, 320,
						function() {
					// 컨텐츠 이벤트
					$("#listdiv_1").slimScroll({
						height: "180px",
						width: "400px ",
						
						axis: "both"
					});
					
					$(".popup3_2 tbody").on("click","tr", function () {
						$(".popup3_2 tbody tr").removeAttr("class");// 선택한것만 냅둘려고 클래스 속성 제거
						$(this).attr("class", "on");
						$("#delEmpDataForm #inpNo").val($(".popup3_2 .on").attr("name"));
					});
					
				}, "확인", function(){
					deleteEmpForm();
					closePopup(2);
				});
				
			});
			
		
	}, "수정완료", function(){

//-------종료일이 시작일 이전으로 선택 못하게 하기 위한 선언
		var startDate = $('#textStdUp').val();
	    var endDate = $('#textFndUp').val();
	    var startArray = startDate.split('-');
	    var endArray = endDate.split('-');   
	    var start_date = new Date(startArray[0], startArray[1], startArray[2]);
	    var end_date = new Date(endArray[0], endArray[1], endArray[2]);
		
		if($.trim($("#textSolNmUp").val()) == ""){
			 makeAlert(2, "알림", "프로젝트명을 선택하세요", null, null);
			$("#textSolNmUp").focus();
		}else if($.trim($("#textMkNmUp").val())==""){
			makeAlert(2, "알림", "고객사를 선택하세요", null, null);
			$("#textMkNmUp").focus();
		}else if($.trim($("#textPtypeUp").val())==""){
			makeAlert(2, "알림", "유형을 입력하세요", null, null);
			$("#textPtypeUp").focus();
		}else if($.trim($("#textArNmUp").val())==""){
			makeAlert(2, "알림", "지역을 선택하세요", null, null);
			$("#textArNmUp").focus();
		}else if($.trim($("#textPmUp").val())==""){
			makeAlert(2, "알림", "프로젝트매니저를 선택하세요", null, null);
			$("#textPmUp").focus();
		}else if($.trim($("#textFndUp").val())==""){
			makeAlert(2, "알림", "종료일를 선택하세요", null, null);
			$("#textFndUp").focus();
		}else if(start_date.getTime() > end_date.getTime()) {
        	makeAlert(2, "알림", "종료일자가 시작일보다 빠릅니다.", null, null);
		}else{	
//-------권한
			if("${sAuthNo}" == 7){
				updateForm();
				reloadList();
			}else{
				makeAlert(2, "알림", "권한이 없습니다.", null, null);
			}
		}
		
	}, "폐기", function(){
//-------권한		
		if("${sAuthNo}" == 7){
			deleteProjForm();
			reloadList();
		}else{
			makeAlert(2, "알림", "권한이 없습니다.", null, null);
		}
		
			
	}); 
}
//-------수정 ajax
function updateForm(){
	var params = $("#updateDataForm").serialize();
	//console.log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"+ params);
	$.ajax({
		type : "post",	
		url : "ASProjListUpdateAjax",	
		dataType : "json",	
		data : params,
		success : function (result) {
			makeAlert(2, "알림", "수정성공", null, function () {
				closePopup(1);
			});
			
		},
		error : function (request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("erro : " + error);
		}
	});
}

//-------addemp 이름
function addEmpForm(){
	var params = $("#addEmpDataForm").serialize();
	
	$.ajax({
		type : "post",	
		url : "ASProjListAddEmpAjax",	
		dataType : "json",	
		data : params,
		success : function (result) {
			redrawList6(result.list)
			
		},
		error : function (request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("erro : " + error);
		}
	});
}
//-------addemp list 그리기
function redrawList6(list) {
	var html = "";
	if (list.length == 0) {
		html += "<tr><td colspan=\"8\">조회결과가 없습니다.</td></tr>";
	} else {
		for (var i = 0; i < list.length; i++) {

			html += "<tr class=\"table_con\">";
			html += "<td name=\"" + list[i].NO + "\">" + list[i].NAME + "</td>";
			html += "<td name=\"" + list[i].NO + "\">" + list[i].DEPT + "</td>";
			html += "<td name=\"" + list[i].NO + "\">" + list[i].SKILL + "</td>";
			html += "</tr >";
		}
	}

	$("#board5_1 tbody").html(html);
}

//-------Task 추가
function addTaskForm(){
	var params = $("#addEmpDataForm").serialize();
	
	$.ajax({
		type : "post",	
		url : "ASProjListTaskAjax",	
		dataType : "json",	
		data : params,
		success : function (result) {
			redrawList7(result.list)
			
		},
		error : function (request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("erro : " + error);
		}
	});
}
//-------Task 추가 그리기
function redrawList7(list) {
	var html = "";
	if (list.length == 0) {
		html += "<tr><td colspan=\"8\">조회결과가 없습니다.</td></tr>";
	} else {
		for (var i = 0; i < list.length; i++) {

			html += "<tr class=\"table_con\">";
			html += "<td name=\"" + list[i].MNGR_TASK_NO + "\">" + list[i].MNGR_TASK_NAME + "</td>";
			html += "</tr >";
		}
	}

	$("#board5_2 tbody").html(html);
}

/*makeNoBtnPopup(2, "인원추가", html, true, 460, 460,
		function() {
	
}, null, null);

});	
노버튼팝업호출/ popup.js 참조
*/

//-------쓰기 ajax
function writeAddForm(){
	var params = $("#addEmpDataForm").serialize();

	$.ajax({
		type : "post",	
		url : "ASProjListAddAjax",	
		dataType : "json",	
		data : params,
		success : function (result) {
			addReloadForm();
		},
		error : function (request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("erro : " + error);
		}
	});
}
//-------인원추가 리로디 ajax
function addReloadForm(){
	var params = $("#updateDataForm").serialize();

	$.ajax({
		type : "post",	
		url : "ASProjListAddEmpReloadAjax",	
		dataType : "json",	
		data : params,
		success : function (result) {
			redrawList8(result.list);
		},
		error : function (request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("erro : " + error);
		}
	});
}
//-------인원추가 리로리 그리기
function redrawList8(list) {
	var html = "";
	if (list.length == 0) {
		html += "<tr><td colspan=\"8\">조회결과가 없습니다.</td></tr>";
	} else {
		for (var i = 0; i < list.length; i++) {

			html += "<tr class=\"table_con\" name=\"" + list[i].INPUT_PPL_NO + "\">";
			html += "<td>" + list[i].NAME + "</td>";
			html += "<td>" + list[i].POSI_NAME + "</td>";
			html += "<td>" + list[i].MNGR_TASK_NAME + "</td>";
			html += "</tr >";
		}
	}

	$("#board2sub tbody").html(html);
}
//-------인원제거 ajax
function deleteEmpForm(){
	var params = $("#delEmpDataForm").serialize();
	//console.log(params);
	$.ajax({
		type : "post",	
		url : "ASProjListDelEmpAjax",	
		dataType : "json",	
		data : params,
		success : function (result) {
			addReloadForm();
		},
		error : function (request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("erro : " + error);
		}
	});
} 
//-------프로젝트 삭제 ajax
function deleteProjForm(){
	var params = $("#dataForm").serialize();
	
	$.ajax({
		type : "post",	
		url : "ASProjListDelProjAjax",	
		dataType : "json",	
		data : params,
		success : function (result) {
			makeAlert(2, "알림", "폐기성공", null, function () {
				closePopup(1);	
			});
			
		},
		error : function (request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("erro : " + error);
		}
	});
} 

</script>
</head>
<body>
<c:import url="/topLeft">
	<c:param name="topMenuNo" value="39"></c:param>
	<c:param name="leftMenuNo" value="42"></c:param>
	<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param> 
		<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param>
	--%>
</c:import>
<div class="content_area">
	<!-- 메뉴 네비게이션 -->
	<div class="content_nav">HeyWe &gt; 자산 &gt; 프로젝트 관리 </div>
	<!-- 현재 메뉴 제목 -->
	<div class="content_title">목록</div>
	<!-- 내용 영역 -->		
	<form action="#" id="dataForm" method="post">
		<input type="hidden" name="page" id="page" value="${page}">
		<input type="hidden" name="projNo" id="projNo"  >
		<input type="hidden" name="solNo" id="solNo" >
		<div class="midB">
			<select id="searchGbn" name="searchGbn">
				<option value="0">프로젝트명</option>
				<option value="1">고객사</option>
				<option value="2">유형</option>
			</select>
			<input type="text" id="txt" name="txt" >
			<input type="button" value="검색" id="searchBtn">
		</div>
	</form>	
		<div class="secB">
			<div class="secB1">
				<table id="mainBoard">
					<colgroup>
						<col width="175"> 
						<col width="163">
						<col width="163">
						<col width="163">
						<col width="163">
						<col width="155">
						<col width="163">
					</colgroup>
					<thead>
						<tr>
							<th>프로젝트명</th>
							<th>고객사</th>
							<th>유형</th>
							<th>적용솔루션</th>
							<th>지역</th>
							<th>인원</th>
							<th>기간</th>	
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
				<div id="pagingArea">
				</div>
			</div>
			<div class="secB2">
				<input type="button" value="등록" id="regiBtn" class="bottomBtn">
			</div>
			<div class="secB3">
			</div>		
		</div>
</div>
</body>
</html>