<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 휴가기준수정</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/hr/hrMgnt/VacaMgnt/HRVacaStdUpdate.css" />
<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.min.css" />
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
<script type="text/javascript" src="resources/script/jquery/jquery-ui.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	if($("#page").val()==""){
		$("#page").val("1");
	}


	reloadList();
	
	$(".paging_group").on("click","div" ,function(){
		$("#page").val($(this).attr("name"));
		reloadList();
	});

	$("#추가Btn").on("click",function(){
		var upContents = "";
		upContents += "<pre>";
		upContents += "<div style=\"color : white;font-size:10pt;font-weight:bold;background-color:#DEE6EF;width:480px;height:220px;\">";
		upContents += "<br /><br /> 	    <div style=\"padding:3px;border-radius:2px;background-color:#134074;display: inline-block;\">휴가명칭</div>	  <input type=\"text\" id=\"vN\"/>";
		upContents += "<br /><br /> 	    <div style=\"padding:3px;border-radius:2px;background-color:#134074;display: inline-block;\">급여구분</div>	  <input type=\"text\" id=\"sD\"/>";
		upContents += "<br /><br /> 	    <div style=\"padding:3px;border-radius:2px;background-color:#134074;display: inline-block;\">기본일수</div>	  <input type=\"text\" id=\"bD\"/>";
		upContents += "<br /><br /> 	    <div style=\"padding:3px;border-radius:2px;background-color:#134074;display: inline-block;\">비고</div> 	  <input type=\"text\" id=\"nt\"/>";
		upContents += "</div>";
		upContents += "</pre>";
		makePopup(1,"휴가기준수정",upContents,true,"500","350",null,"저장",rightEvent2);

	});
	
	
	
});


function delVacaStd(){

	var params = $("#dataForm").serialize();
	$.ajax({
		type : "post",
		url : "HRdelVacaStdAjax", 
		dataType : "json", 
		data : params,
		success : function(result){
			if(result.msg != "" || result.msg != null){
				makeAlert(2,"실패",result.msg,"false",null);
			}else{
				makeAlert(2,"성공",result.msg,"false",null);
			}
			reloadList();
		},
		error : function(request, status, error){
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + request.error);
		}
	});
}
function reloadList(){
	var params = $("#dataForm").serialize();
	$.ajax({
		type : "post",
		url : "HRVacaStdListAjax", 
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
	html += "<th>번호</th>"
	html += "<th>휴가명</th>"
	html += "<th>기본일수</th>"
	html += "<th>유급/무급</th>"
	html += "<th>비고</th>"
	html += "<th></th>"
	html += "<th></th>"
	html += "</tr>"
	if(list.length == 0){
		html += "<tr><td colspan=\"7\">조회결과가 없습니다</td><tr>";
	} else {
		for(var i = 0; i < list.length; i++){
			if(i%2==0){
				html += "<tr  height= \"20\" name = \"" + list[i].VACA_STD_NO + "\" class = \"A\" >";
			}else{
				html += "<tr  height= \"20\" name = \"" + list[i].VACA_STD_NO + "\" class = \"B\" >";
			}
			html += "<td name = \"" + list[i].VACA_STD_NO + "\">" + list[i].VACA_STD_NO + "</td>";
			html += "<td name = \"" + list[i].VACA_NAME + "\">" + list[i].VACA_NAME + "</td>";
			html += "<td name = \"" + list[i].BASIC_DAY + "\">" + list[i].BASIC_DAY + "</td>";
			html += "<td name = \"" + list[i].SAL_DIV + "\">" + list[i].SAL_DIV + "</td>";
			html += "<td name = \"" + list[i].NOTE + "\">" + list[i].NOTE + "</td>";
			if(list[i].VACA_STD_NO == "1"){
				html += "<td></td>";
				html += "<td></td>";
			}else{
				html += "<td>" + "<input type=\"button\" name = \""+ list[i].VACA_STD_NO+ "\" value=\"수정\" class=\"updateBtn\" />" + "</td>";
				html += "<td>" + "<input type=\"button\" name = \""+ list[i].VACA_STD_NO+ "\" value=\"삭제\" class=\"delBtn\" />" + "</td>";
			}
			html += "</tr>";
		}
	}
	$("#leftVacaArea").html(html);
	$(".delBtn").on("click", function(){
		$("#stdNo").val($(this).attr("name")-1);
		console.log($("#stdNo").val());
		makeConfirm(1,"확인","삭제하시겠습니까?",true,delVacaStd);
	});
	var upContents = "";
	upContents += "<pre>";
	upContents += "<div style=\"color : white;font-size:10pt;font-weight:bold;background-color:#DEE6EF;width:480px;height:220px;\">";
	upContents += "<br /><br /> 	    <div style=\"padding:3px;border-radius:2px;background-color:#134074;display: inline-block;\">휴가명칭</div>	  <input type=\"text\" id=\"vN\"/>";
	upContents += "<br /><br /> 	    <div style=\"padding:3px;border-radius:2px;background-color:#134074;display: inline-block;\">급여구분</div>	  <input type=\"text\" id=\"sD\"/>";
	upContents += "<br /><br /> 	    <div style=\"padding:3px;border-radius:2px;background-color:#134074;display: inline-block;\">기본일수</div>	  <input type=\"number\" id=\"bD\"/>";
	upContents += "<br /><br /> 	    <div style=\"padding:3px;border-radius:2px;background-color:#134074;display: inline-block;\">비고</div> 	  <input type=\"text\" id=\"nt\"/>";
	upContents += "</div>";
	upContents += "</pre>";
	
	$(".updateBtn").on("click", function(){
		$("#stdNo").val($(this).attr("name")-1);
		console.log($("#stdNo").val());
		
		makePopup(1,"휴가기준수정",upContents,true,"500","350",null,"저장",rightEvent1);
		$("#vacaName").val($(this).parent().parent().children().eq(1).html());
		$("#basicDay").val($(this).parent().parent().children().eq(2).html());
		$("#salDiv").val($(this).parent().parent().children().eq(3).html());
		$("#note").val($(this).parent().parent().children().eq(4).html());
		$("#vN").val($("#vacaName").val());
		$("#bD").val($("#basicDay").val());
		$("#sD").val($("#salDiv").val());
		$("#nt").val($("#note").val());
	});
}


function rightEvent1(){
	makeConfirm(2,"확인","수정하시겠습니까?",true,updateVacaStd);
}
function rightEvent2(){
	makeConfirm(2,"확인","추가하시겠습니까?",true,insertVacaStd);
}

function insertVacaStd(){
	if($.trim($("#vN").val())=="" || $.trim($("#bD").val()) =="" 
			|| $.trim($("#sD").val())=="" || $.trim($("#nt").val())=="" ){
		makeAlert(3,"실패","빈 칸을 모두 작성해 주세요","false",null);
	}else{
		if($("#bD").val() < 0){
			makeAlert(3,"실패","기본 일수는 0일 이상이어야 합니다.","false",null);
		}else{
			$("#vacaName").val($("#vN").val());
			$("#basicDay").val($("#bD").val());
			$("#salDiv").val($("#sD").val());
			$("#note").val($("#nt").val());
			var params = $("#dataForm").serialize();
			$.ajax({
				type : "post",
				url : "HRinsertVacaStdAjax", 
				dataType : "json", 
				data : params,
				success : function(result){
					if(result.res != 1){
						if(result.res == 9){
							makeAlert(3,"실패","급여 구분을 확인하세요.(유급 or 무급)","false",null);
						}else{
							makeAlert(3,"실패","신청에 실패하였습니다.","false",null);
						}
					}else{
						makeAlert(3,"성공","신청에 성공하였습니다","false",null);
						closePopup(1);
					}
						reloadList();
				},
				error : function(request, status, error){
					console.log("status : " + request.status);
					console.log("text : " + request.responseText);
					console.log("error : " + request.error);
				}
			});
		}
	}
}

function updateVacaStd(){
	
	if($.trim($("#vN").val())=="" || $.trim($("#bD").val()) =="" 
			|| $.trim($("#sD").val())=="" || $.trim($("#nt").val())=="" ){
		makeAlert(3,"실패","빈 칸을 모두 작성해 주세요","false",null);
	}else{
		if($("#bD").val() < 0){
			makeAlert(3,"실패","기본 일수는 0일 이상이어야 합니다.","false",null);
		}else{
			$("#vacaName").val($("#vN").val());
			$("#basicDay").val($("#bD").val());
			$("#salDiv").val($("#sD").val());
			$("#note").val($("#nt").val());
			var params = $("#dataForm").serialize();
			$.ajax({
				type : "post",
				url : "HRupdateVacaStdAjax", 
				dataType : "json", 
				data : params,
				success : function(result){
					if(result.res != 1){
						if(result.res == 9){
							makeAlert(3,"실패","급여 구분을 확인하세요.(유급 or 무급)","false",null);
						}else{
							makeAlert(3,"실패","수정에 실패하였습니다.","false",null);
						}
					}else{
						makeAlert(3,"성공","수정에 성공하였습니다","false",null);
						closePopup(1);
					}
						reloadList();
				},
				error : function(request, status, error){
					console.log("status : " + request.status);
					console.log("text : " + request.responseText);
					console.log("error : " + request.error);
				}
			});
		}
	}
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
			html += "<div class=\"paging_on\" name = \"" + i + "\" >" + i + "</div>";
		}else{
			html += "<div class=\"paging_off\" name = \""
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
<body>

<c:import url="/topLeft"> <%-- top이란 주소를 넣어 보여주는 것. --%>
   <%-- <c:param name="topMenuNo" value="49"></c:param>
   <c:param name="leftMenuNo" value="55"></c:param> --%>
    <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
   <c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param>
</c:import>


<div class="content_area">
	<div class="content_nav">HeyWe &gt; 인사 &gt; 인사관리 &gt; 휴가관리&gt; 휴가기준수정</div>
	<!-- 내용 영역 -->
	<div class="content_title">
		<div class="content_title_txt">휴가 기준 수정 (관리자)</div>
	</div>
	<div class="content_area_table_area">
	<form action="#" id="dataForm" method="post">
		<input type="hidden" name="page" id="page" value="${page}"/>
		<input type="hidden" name="stdNo" id="stdNo" />
		<input type="hidden" name="vacaName" id="vacaName" />
		<input type="hidden" name="salDiv" id="salDiv" />
		<input type="hidden" name="basicDay" id="basicDay" />
		<input type="hidden" name="note" id="note" />
	
	<div id="forBtnRight"><input type="button"  id = "추가Btn" value = "추가"/></div>
		<table id = "table_va" border = "1" cellspacing="0">
			<colgroup>
				<col width="50"/>
				<col width="120"/>
				<col width="120"/>
				<col width="100"/>
				<col width="420"/>
				<col width="100"/>
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
<div id="popup"></div>
<div id = "popupBox">
	<div>휴가명</div>
	<input type="text" />
	<div>기본일수</div>
	<input type="text" />
	<div>비고</div>
	<input type="text" id="comment" />
	<input type="button" value = "취소" id="close">
</div>
</body>
</html>