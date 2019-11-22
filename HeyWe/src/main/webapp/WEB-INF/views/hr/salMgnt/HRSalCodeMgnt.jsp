<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 급여코드관리</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/hr/salMgnt/HRSalCodeMgnt.css" />
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

	$("#addBtn").on("click",function(){
		var upContents = "";
		upContents += "<pre>";
		upContents += "<div style=\"color : white;font-size:10pt;font-weight:bold;background-color:#DEE6EF;width:480px;height:120px;\">";
		upContents += "<br /><br /> 	    <div style=\"padding:3px;border-radius:2px;background-color:#134074;display: inline-block;\">수당명</div>	  <input type=\"text\" id=\"gN\"/>";
		upContents += "<br /><br /> 	    <div style=\"padding:3px;border-radius:2px;background-color:#134074;display: inline-block;\">급여배율</div>	  <input type=\"number\" id=\"sM\"/>";
		upContents += "</div>";
		upContents += "</pre>";
		makePopup(1,"급여코드수정",upContents,true,"500","250",null,"저장",addGeuntae);
	});
	
});
function addGeuntae(){
	$("#geuntaeName").val($("#gN").val());
	$("#salMgfn").val($("#sM").val());
	var params = $("#dataForm").serialize();
	$.ajax({
		type : "post",
		url : "HRaddGeuntaeAjax", 
		dataType : "json", 
		data : params,
		success : function(result){
			if(result.res==0){
				makeAlert(2,"실패","추가에 실패하였습니다.",true,null);
			}else{
				closePopup(1);
				makeAlert(2,"성공","추가에 성공하였습니다.",true,null);
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
		url : "HRGeuntaeListAjax", 
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
	html += "<tr height= \"20\" id = \"table_color\">";
	html += "<th>번호</th>";
	html += "<th>수당명</th>";
	html += "<th>급여배율</th>";
	html += "<th></th>";
	html += "<th></th>";
	html += "</tr>";
	if(list.length == 0){
		html += "<tr><td colspan=\"5\">조회결과가 없습니다</td><tr>";
	} else {
		for(var i = 0; i < list.length; i++){
			if(i%2==0){
				html += "<tr height= \"20\" class = \"A\" name=\"" + list[i].GEUNTAE_NO + "\">";
				html += "<td name = \"" + list[i].GEUNTAE_NO + "\">" + list[i].RNUM + "</td>";
				html += "<td name = \"" + list[i].GEUNTAE_NAME + "\">" + list[i].GEUNTAE_NAME + "</td>";
				html += "<td name = \"" + list[i].SAL_MGFN + "\">" + list[i].SAL_MGFN + "</td>";
				html += "<td><input type=\"button\"  class = \"updateBtn\" value = \"수정\"/></td>";
				html += "<td><input type=\"button\"  class = \"deleteBtn\" value = \"삭제\"/></td>";
				html += "</tr>";
			}else{
				html += "<tr height= \"20\" class = \"B\" name=\"" + list[i].GEUNTAE_NO + "\">";
				html += "<td name = \"" + list[i].GEUNTAE_NO + "\">" + list[i].RNUM + "</td>";
				html += "<td name = \"" + list[i].GEUNTAE_NAME + "\">" + list[i].GEUNTAE_NAME + "</td>";
				html += "<td name = \"" + list[i].SAL_MGFN + "\">" + list[i].SAL_MGFN + "</td>";
				html += "<td><input type=\"button\"  class = \"updateBtn\" value = \"수정\"/></td>";
				html += "<td><input type=\"button\"  class = \"deleteBtn\" value = \"삭제\"/></td>";
				html += "</tr>";
			}
		}
	}
	$("#geuntaeArea").html(html);
	$(".deleteBtn").on("click",function(){
		$("#stdNo").val($(this).parent().parent().attr("name"));
		console.log($("#stdNo").val());
		makeConfirm(1,"확인","삭제하시겠습니까?",true,delGeuntae);
	});
		var upContents = "";
		upContents += "<pre>";
		upContents += "<div style=\"color : white;font-size:10pt;font-weight:bold;background-color:#DEE6EF;width:480px;height:120px;\">";
		upContents += "<br /><br /> 	    <div style=\"padding:3px;border-radius:2px;background-color:#134074;display: inline-block;\">수당명</div>	  <input type=\"text\" id=\"gN\"/>";
		upContents += "<br /><br /> 	    <div style=\"padding:3px;border-radius:2px;background-color:#134074;display: inline-block;\">급여배율</div>	  <input type=\"number\" id=\"sM\"/>";
		upContents += "</div>";
		upContents += "</pre>";
		
	$(".updateBtn").on("click",function(){
		makePopup(1,"급여코드수정",upContents,true,"500","250",null,"저장",updateGeuntae);
		$("#stdNo").val($(this).parent().parent().attr("name"));
		$("#gN").val($(this).parent().parent().children().eq(1).html());
		$("#sM").val($(this).parent().parent().children().eq(2).html());
		$("#geuntaeName").val($("#gN").val());
		$("#salMgfn").val($("#sM").val());
		console.log($("#stdNo").val());
		console.log($("#gN").val());
		console.log($("#sM").val());
	});
	/*  aaaaaaaaaaaaaaaaa*/
}
function updateGeuntae(){
	$("#geuntaeName").val($("#gN").val());
	$("#salMgfn").val($("#sM").val());
	var params = $("#dataForm").serialize();
	$.ajax({
		type : "post",
		url : "HRupdateGeuntaeAjax", 
		dataType : "json", 
		data : params,
		success : function(result){
			if(result.res==0){
				closePopup(1);
				makeAlert(2,"실패","수정에 실패하였습니다.",true,null);
			}else{
				closePopup(1);
				makeAlert(2,"성공","수정에 성공하였습니다.",true,null);
			}
			reloadList();
		},
		error : function(request, status, error){
			closePopup(1);
			makeAlert(2,"실패","수정에 실패하였습니다.",true,null);
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + request.error);
		}
	});
}
function delGeuntae(){
	var params = $("#dataForm").serialize();
	$.ajax({
		type : "post",
		url : "HRdelGeuntaeAjax", 
		dataType : "json", 
		data : params,
		success : function(result){
			if(result.res==0){
				closePopup(1);
				makeAlert(2,"실패","삭제에 실패하였습니다.",true,null);
			}else{
				closePopup(1);
				makeAlert(2,"성공","삭제에 성공하였습니다.",true,null);
			}
			reloadList();
		},
		error : function(request, status, error){
			closePopup(1);
			makeAlert(2,"실패","삭제에 실패하였습니다.",true,null);
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + request.error);
		}
	});
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

<c:import url="/topLeft"> <%-- top이란 주소를 넣어 보여주는 것. --%>
   <%--  <c:param name="topMenuNo" value="49"></c:param>
   <c:param name="leftMenuNo" value="55"></c:param>  --%>
    <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
   <c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> 
</c:import>


<div class="content_area">
	<div class="content_nav">HeyWe &gt; 인사 &gt; 급여관리 &gt; 급여코드관리 (관리자)</div>
	<!-- 내용 영역 -->
	<div class="content_title">
		<div class="content_title_txt">급여코드관리 (관리자)</div>
	</div>
	<div class="content_area_table_area">
	<form action="#" id="dataForm" method="post">
		<input type="hidden" name="stdNo" id="stdNo" />
		<input type="hidden" name="geuntaeName" id="geuntaeName" />
		<input type="hidden" name="salMgfn" id="salMgfn" />
		<input type="hidden" name="page" id="page" value="${page}"/>
		
	<div id="forBtnRight">
		<input type="button"  id = "addBtn" value = "추가"/>
	</div>
		<table id = "table_va" border = "1" cellspacing="0">
			<colgroup>
				<col width="30"/>
				<col width="100"/>
				<col width="100"/>
				<col width="80"/>
				<col width="80"/>
			</colgroup>
			<thead></thead>
			<tbody id = "geuntaeArea">
				
				
				
			</tbody>
		</table>
		
		<div class="paging_group">

      	</div>
      	</form>
	</div>
</div>

	
</body>
</html>