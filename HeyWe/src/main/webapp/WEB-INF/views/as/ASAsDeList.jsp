<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 폐기 목록</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/as/As_delist.css" />
<style type="text/css">
.popup1 {
	width: 100%;
	height: 100%;
	font-size: 11pt;
	text-align: left;
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
#checkRe, #empCheck, #searchEmpBtn{
	width: 80px;
	height: 30px;
	font-size: 10pt;
	padding: 0px;
	background-color: #134074;
	color:white;
	border-radius: 3px;
}
#textItemNm, #textEmpNm, #textDepNm, #textPurPri, #textPurDate, #textCsNum, #textItemNo, #textDeptNm, #searchEmpTxt{
	width: 150px;
	height: 24px;
	font-size: 12pt;
}
#barcordImg{
	width: 150px;
	height: 150px;
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
#searchGbn, #searchGbnD{	
	width: 90px;
	height: 35px;
	padding: 0px;
	font-size: 11pt;	
	border-radius: 3px;
}
#searchGbn1{	
	width: 90px;
	height: 30px;
	padding: 0px;
	font-size: 11pt;	
	border-radius: 3px;
}

.checkPop {
	width: 100%;
	height: 100%;
}
.checkPop_1{
	width: 100%;
	height: 40%;
	text-align: center;
}
.checkPop_2{
	width: 282px;
	height: 250px;
	text-align: center;
	margin: 0 auto;
} 

.checkPop_2 tbody tr.on {
	background-color: #DEE6EF;
}
#listdiv {
	display: inline-block;
	min-width: calc(100% - 15px) !important;
	width: calc(100% - 15px);
	margin: 0px !important;
	height: 160px !important;
}
</style>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function () {
	
	if($("#page").val() == ""){
		$("#page").val("1");
	}
	
	reloadList();
	
//엔터 쳤을때 검색 작동되게하는것
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
	
});
//리로드 리스트
function reloadList(){
	var params = $("#dataForm").serialize();

	$.ajax({
		type : "post",	
		url : "ASAsDeListAjax",	
		dataType : "json",	
		data : params,
		success : function (result) {
			redrawList(result.list);
			redrawPaging(result.pb);
		},
		error : function (request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("erro : " + error);
		}
	});
}
//리스트 그리기
function redrawList(list) {
	console.log(list);
	var html = "";
	if(list.length == 0){
		html += "<tr><td colspan=\"8\">조회결과가 없습니다.</td></tr>";
	}else {
		for(var i = 0; i < list.length; i++){
			
			html +=		"<tr class=\"table_con\" name=\"" + list[i].ASNO + "\">";
			html +=		"<td>" + list[i].ASNO + "</td>";
			html +=		"<td id=\"itemName\">" + list[i].ASNM  + "</td>";
			html +=		"<td id=\"name\">" + list[i].ENAME + "</td>";
			html +=		"<td id=\"dept\">" + list[i].DNAME + "</td>";
			html +=		"<td id=\"purcDate\">" + list[i].PDATE + "</td>";
			html +=		"<td id=\"purcPrice\">" + list[i].PPRI  + "</td>";
			html +=		"<td id=\"dstrDate\">" + list[i].DTD  + "</td>";
			html +=		"</tr >";
		}
			
	}
	
	$("#mainBoard tbody").html(html);
}
//페이징
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
</script>
</head>
<body>
<c:import url="/topLeft">
	<c:param name="topMenuNo" value="39"></c:param>
	<c:param name="leftMenuNo" value="41"></c:param>
	<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param> 
		<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param>
	--%>
</c:import>
<div class="content_area">
	<!-- 메뉴 네비게이션 -->
	<div class="content_nav">HeyWe &gt; 자산 &gt; 폐기 목록</div>
	<!-- 현재 메뉴 제목 -->
	<div class="content_title">목록</div>
	<!-- 내용 영역 -->	
		<form action="#" id="dataForm" method="post">
		<input type="hidden" name="page" id="page" value="${page}">
		<input type="hidden" name="textItemNo" id="textItemNo" >
		<div class="midB">
			<select id="searchGbn" name="searchGbn">
				<option value="0">제품코드</option>
				<option value="1">품명</option>
				<option value="2">담당부서</option>
			</select>
			<input type="text" id="txt" name="txt" >
			<input type="button" value="검색" id="searchBtn">		
		</div>
	</form>	
		<div class="secB">
			<div class="secB1">
				<table id="mainBoard">
					<colgroup>
						<col width="144"> 
						<col width="144"> 
						<col width="144">
						<col width="144">
						<col width="144">
						<col width="144">
						<col width="144">
					</colgroup>
					<thead>
						<tr>
							<th>제품코드</th>
							<th>품명</th>
							<th>사용자</th>
							<th>담당부서</th>
							<th>구입일자</th>
							<th>구입가격</th>	
							<th>폐기일자</th>		
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
				<div id="pagingArea">
				</div>
			</div>
			<div class="secB2">
			</div>	
			<div class="secB3">
			</div>						
		</div>
</div>
</body>
</html>