<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 담당자</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/crm/cu_manager.css" />
<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.css" />
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	if($("#page").val()==""){
		$("#page").val("1");
	}
	if($("#check2").val()==""){
		$("#check2").val("888");
	}
	reloadList();
	reloadDept();
	reloadEmp();
	$("#pagingArea").on("click", "input", function(){
		$("#page").val($(this).attr("name"));
		reloadList();
	});
	$("#searchImg").on("click", function(){
		$("#page").val("1");
		reloadList();
	});
	$("#sel").on("change", function(){
		$("#check").val($(this).val());
		$("#check2").val(888);
		reloadEmp();
	});
	$("#sel2").on("change", function(){
		$("#check2").val($(this).val());
	});
	$("#block").on("click", "#block1", function(){
		$("#mngrNo").val($(this).attr("name"));
		$("#dataForm").attr("action", "CRMMngrAsk");
		$("#dataForm").submit();
	});
	$("#writeImg").on("click", function(){
		$("#dataForm").attr("action", "CRMMngrWrite");
		$("#dataForm").submit();
	});
});

//아작스
function reloadList(){
	var params = $("#dataForm").serialize(); 
	$.ajax({
		type : "post",
		url : "CRMMngrAjax",
		dataType : "json",
		data : params,
		success : function(result){
			redrawList(result.list);
			redrawPaging(result.pb);
		},
		error : function(request, status, error){
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}

function reloadDept(){
	var params = $("#dataForm").serialize();
	$.ajax({
		type : "post",
		url : "CRMMngr2Ajax",
		dataType : "json",
		data : params,
		success : function(result){
			redrawDept(result.dept);
		},
		error : function(request, status, error){
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}

function reloadEmp(){
	var params = $("#dataForm").serialize();
	$.ajax({
		type : "post",
		url : "CRMEmpAjax",
		dataType : "json",
		data : params,
		success : function(result){
			redrawEmp(result.emp);
		},
		error : function(request, status, error){
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + error);
		}
	});
}

//함수
function redrawList(list){
	var html="";
	if(list.length!=0){
	for(var i = 0 ; i<list.length; i++){
		html +="<div class=\"block\"name="+ list[i].MNGR_NO + " id=\"block1\"><div class=\"block_Top\"></div><div class=\"block_Bottom\"><div class=\"block_Bottom_1\"><div class=\"block_Bottom_1_1\">"
		+ list[i].MNGR_NAME + "</div><div class=\"block_Bottom_1_2\">" + list[i].CRM_CSTM_NAME + " / " + list[i].CSTM_GRADE_NAME + "</div></div><div class=\"block_Bottom_2\">" 
		+ "<div class=\"block_Bottom_2_1\">"+ list[i].MOBILE + "</div><div class=\"block_Bottom_2_1\">" + list[i].EMAIL + "</div></div></div></div>";
		}
	}
	else{
		html += "<div id=\"flag\">검색결과가 없습니다.</div>"
	}
	$("#block").html(html)
}

function redrawPaging(pb){
	var html = "";
	
	if($("#page").val() == "1"){
		html += "<input type=\"button\" class =\"preBtn\"value=\"◀\"name=\"1\"/>";		
	}
	else{
		html += "<input type=\"button\" class =\"preBtn\"value=\"◀\"name=\"" + ($("#page").val()*1-1)+"\" />";
	}	
	
	
	for(var i = pb.startPcount ; i<= pb.endPcount ; i++){
		if(i == $("#page").val()){
			html += "<input type=\"button\" class =\"numberBtn\" value=\""+ i + "\" disabled=\"disabled\" />";
		}
		else{
			html += "<input type=\"button\" class =\"numberBtn\" value=\"" + i + "\"name=\"" + i + "\" />";
		}
	}
	
	
	if($("#page").val() == pb.maxPcount){
		html += "<input type=\"button\" class =\"nextBtn\"value=\"▶\" name=\"" + pb.maxPcount + "\" />";
	}
	else{
		html += "<input type=\"button\" class =\"nextBtn\" value=\"▶\"name=\"" + ($("#page").val()*1+1)+"\" />";
	}
	
	$("#pagingArea").html(html);
	$("#pagingArea input[type='button']").button();
}

function redrawDept(dept){
	var html="";
	html += "<option value=\"999\">부서(전체)</option>"
	for(var i = 0 ; i<dept.length; i++){
		html += "<option value=\""+ dept[i].DEPT_NO +"\">"+ dept[i].DEPT_NAME +"</option>"
	}
	$("#sel").html(html)
}

function redrawEmp(emp){
	var html="";
	html += "<option value=\"888\">사원(전체)</option>"
	for(var i = 0 ; i<emp.length; i++){
		html += "<option value="+ emp[i].EMP_NO +">"+ emp[i].NAME +"</option>"
	}
	$("#sel2").html(html)
}

</script>
</head>
<body>
<c:import url="/topLeft">
	<c:param name="topMenuNo" value="17"></c:param>
	<c:param name="leftMenuNo" value="30"></c:param>
	<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
</c:import>
	<div class="content_area">
		<div class="content_nav">HeyWe &gt; CRM &gt; 고객 &gt; 담당자</div>
		<!-- 내용 영역 -->
		<div class="content_title">
			담당자 <img src="resources/images/erp/crm/write.png" id="writeImg" style="cursor:pointer"/>
		</div>
		<!-- form -->
		<form id="dataForm" method="post" action="#">
		<input type="hidden" id="check" name="check">
		<input type="hidden" id="check2" name="check2">
		<input type="hidden" id="mngrNo" name="mngrNo">
		<div class="search">
			<div>
				<select class="SelBox" id="sel" name="sel">
				</select> 
				<select class="SelBox_1" id="sel2" name="sel2">
				</select> 
			</div>
			<div class="search_top">
				<input type="text" id="txt_top" name="searchTxt" placeholder="담당자 명을 입력해주세요."
				onkeypress="if(event.keyCode==13) {; return false;}">
				<img src="resources/images/erp/crm/search.png" id="searchImg" style="cursor:pointer">
			</div>
		</div>

		<div class="bogy">
		</div>
		<hr id="hr_1" />
		<input type="hidden" name="page" id="page" value="${page}">
		<div id="block">
		</div>
		</form>
		<div id="pagingArea" class="pageArea">
		</div>
	</div>
</body>
</html>