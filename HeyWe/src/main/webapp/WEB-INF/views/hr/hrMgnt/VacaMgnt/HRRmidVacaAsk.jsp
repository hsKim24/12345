<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 잔여휴가조회</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/hr/hrMgnt/VacaMgnt/HRRmidVacaAsk.css" />
<style type="text/css">
/* 
	DarkBlue : rgb(19, 64, 116), #134074
	DeepLightBlue : rgb(141, 169, 196), #8DA9C4
	LightBlue : rgb(222,230,239), #DEE6EF
	White : rgb(255,255,255), #FFFFFF
 */
 
</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	if($("#page").val()==""){
		$("#page").val("1");
	}
	reloadList();
	$("#searchBtn").on("click", function(){
		$("#page").val("1");
		reloadList();
	});

	$(".paging_group").on("click","div" ,function(){
		$("#page").val($(this).attr("name"));
		reloadList();
	});
	$("#SearchBtn").on("click",function(){
		
		reloadList();
	});
	
	$("#empSearch").on("keypress",function(event) {
		if(event.keyCode == 13) {
			$("#SearchBtn").click();
			return false;
		}
	});
});


function reloadList(){
	var params = $("#dataForm").serialize();
	$.ajax({
		type : "post",
		url : "HRleftVacaListAjax", 
		dataType : "json", 
		data : params,
		success : function(result){
			redrawList(result.list);
			redrawPaging(result.pb);
		},
		error : function(request, status, error){
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + request.error);
		}
	});
}

function redrawList(list){
	var html="";
	html += "<tr height= \"20\" id = \"table_color\">"
	html += "	<th>부서명</th>"
	html +=	"<th>이름</th>"
	html +=	"<th>직위명</th>"
	html +=	"<th>사원코드</th>"
	html +=	"<th>사용연차</th>"
	html +=	"<th>잔여연차</th>"
	html +=	"<th>사용 Refresh</th>"
	html +=	"<th>잔여 Refresh</th>"
	html += "</tr>"
	if(list.length == 0){
		html += "<tr><td colspan=\"8\">조회결과가 없습니다</td><tr>";
	} else {
		for(var i = 0; i < list.length; i++){
			if(i%2==0){
				html += "<tr  height= \"20\" class = \"B\" name=\"" + list[i].RNUM + "\">";
				html += "<td>" + list[i].DEPT_NAME + "</td>";
				html += "<td>" + list[i].EMP_NAME + "</td>";
				html += "<td>" + list[i].POSI_NAME + "</td>";
				html += "<td>" + list[i].EMP_NO + "</td>";
				html += "<td>" + list[i].USE_YVACA + "</td>";
				html += "<td>" + list[i].LEFT_YVACA + "</td>";
				html += "<td>" + list[i].TOT_USE_FVACA + "</td>";
				html += "<td>" + list[i].LEFT_FVACA + "</td>";
				html += "</tr>";
			}else{
				html += "<tr  height= \"20\" class = \"A\" name=\"" + list[i].RNUM + "\">";
				html += "<td>" + list[i].DEPT_NAME + "</td>";
				html += "<td>" + list[i].EMP_NAME + "</td>";
				html += "<td>" + list[i].POSI_NAME + "</td>";
				html += "<td>" + list[i].EMP_NO + "</td>";
				html += "<td>" + list[i].USE_YVACA + "</td>";
				html += "<td>" + list[i].LEFT_YVACA + "</td>";
				html += "<td>" + list[i].TOT_USE_FVACA + "</td>";
				html += "<td>" + list[i].LEFT_FVACA + "</td>";
				html += "</tr>";
			}
		}
	}
	$("#leftVacaArea").html(html);
	
}



function redrawPaging(pb){
	var html ="";
	html += "<div name=\"1\" ><<</div>";
	if($("#page").val() == "1"){
		html += "<div  name=\"1\" ><</div>";
	}else{
		html += "<div  name=\""
					+ ($("#page").val() * 1 - 1) + "\" ><</div>";
	}
	
	
	for(var i = pb.startPcount; i <= pb.endPcount; i ++){
		if(i==$("#page").val()){
			html += "<div class=\"paging_on\"   name = \"" + i + "\" >" + i + "</div>";
		}else{
			html += "<div class=\"paging_off\"    name = \""
				+ i + "\" >" + i + "</div>";
		}
	}
	
	if($("#page").val() == pb.maxPcount){
		html += "<div name=\"" + pb.maxPcount + "\">></div>";
	}else{
		html += "<div name=\"" + ($("#page").val() * 1 + 1) + "\">></div>";
	}
	
	html += "<div name=\"" + pb.maxPcount + "\">>></div>";
	
	$(".paging_group").html(html);
	
}
</script>
</head>
<body>

<c:import url="/topLeft"> <%-- top이란 주소를 넣어 보여주는 것. --%>
  <%--  <c:param name="topMenuNo" value="49"></c:param>
   <c:param name="leftMenuNo" value="55"></c:param> --%>
   <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
   <c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> 
</c:import>
<div class="content_area">

	<div class="content_nav">HeyWe &gt; 인사 &gt; 인사관리 &gt; 휴가관리&gt; 잔여휴가조회</div>
	<!-- 내용 영역 -->
	<div class="content_title">
		<div class="content_title_txt">잔여 휴가 조회 (관리자)</div>
	</div>
	<div class="content_area_table_area">
<form action="#" id="dataForm" method="post">
		<input type="hidden" name="page" id="page" value="${page}"/>
	

	<div id="forBtnRight">
		<div id="seldiv">
			부서별 
			<select style="height : 23px;" id = "deptGbn" name="deptGbn">
					<option value="all">전체</option>
				<c:forEach var="data"  items="${deptList}">
				<!-- 부서이름 뽑아오기 -->
					<option value="${data.DEPT_NAME}">${data.DEPT_NAME}</option>
				</c:forEach>
			</select>
		</div>
		<div id="seldiv">
			사원명 
			<input type="text" name="empSearch" id="empSearch" />
		</div>
		<input type="button"  id = "SearchBtn" value = "검색"  />
	</div>

	<table id = "table_va" border = "1" cellspacing="0">
			<colgroup>
				<%-- <col width="30"/> --%>
				<col width="80"/>
				<col width="80"/>
				<col width="80"/>
				<col width="80"/>
				<col width="80"/>
				<col width="80"/>
				<col width="80"/>
				<col width="80"/>
			</colgroup>
			<thead></thead>
			<tbody id = "leftVacaArea">

				

				
				
			</tbody>
		</table>
		
		<div class="paging_group">
<!--          <div>&lt;</div>
         <div class="paging_on">1</div>
         <div class="paging_off">2</div>
         <div class="paging_off">3</div>
         <div class="paging_off">4</div>
         <div>&gt;</div> -->
      	</div>
	</form>
	</div>
	
	
</div>
</body>
</html>