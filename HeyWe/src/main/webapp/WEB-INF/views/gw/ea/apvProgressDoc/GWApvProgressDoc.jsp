<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 결재진행 문서함</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/gw/ea/gwApvProgressDoc.css" />

<!-- calendar select css -->
<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css" href="resources/css/common/calendar.css" />

<!-- calendar css -->
<link rel="stylesheet" type="text/css" href="resources/css/calendar/calendar.css" />

<!-- jQuery Script -->
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui.min.js"></script>

<!-- calendar Script -->
<script type="text/javascript" src="resources/script/calendar/calendar.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	if($("#page").val() == ""){
		$("#page").val("1");
	}
	
	$("#pageArea").on("click", "div", function() {
		$("#page").val($(this).attr("name"));
		reloadList();
	});
	 
	// 기본 검색 기간 3달(90일)
	var date = new Date();
	var eDate = date.getFullYear() + "-"
			  + ('0' + (date.getMonth() + 1)).slice(-2) + "-"
		      + ('0' + date.getDate()).slice(-2);
	date.setDate(date.getDate() - 90);
	var sDate = date.getFullYear() + "-"
			  + ('0' + (date.getMonth() + 1)).slice(-2) + "-"
	          + ('0' + date.getDate()).slice(-2);
	
	$("#stdt").val(sDate);
	$("#eddt").val(eDate);
	
	reloadList();
	 
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
    $("#stdt").datepicker({
    	dateFormat : 'yy-mm-dd',
		duration: 200,
		onSelect:function(dateText, inst){
			var startDate = parseInt(dateText.replace(/-/g,''));
			var endDate = parseInt($("#eddt").val().replace("-", '').replace("-", ''));
			
            if (startDate > endDate) {
            	makeAlert(1, "확인", "올바르지 않은 기간입니다.", true, function() {
            		$("#stdt").val($("#eddt").val());
				});
			}
		}
    });
    $("#eddt").datepicker({
		dateFormat : 'yy-mm-dd',
		duration: 200,
		onSelect:function(dateText, inst){
			var startDate = parseInt($("#stdt").val().replace("-", '').replace("-", ''));
			var endDate = parseInt(dateText.replace(/-/g,''));
			
            if (startDate > endDate) {
            	makeAlert(1, "확인", "올바르지 않은 기간입니다.", true,  function() {
            		$("#eddt").val($("#stdt").val());
				});
            }            	
		}
	});
    
    //결재상태 체크박스
    $("#c1").on("change",function() {
		if($("#c1").is(":checked")){
			$("[type='checkbox']").each(function() {
				$(this).prop("checked", true);
			});
		} else {
			$("[type='checkbox']").each(function() {
				$(this).prop("checked", false);
			});
		}
		$("#searchBtn").click();
	});
    $(".eachState").on("click", "[type='checkbox']",function() {
		$("#c1").attr("checked",false);
		$("#searchBtn").click();
	});
    //수발신 체크
    $(".recieveSend input[type='radio']").on("click", function() {
    	$("#searchBtn").click();
	});
    
 	//검색
 	$("#searchBtn").on("click", function() {
		$("#page").val("1");
		
		var asVal = "";
		
		$(".eachState input[name='as']:checked").each(function() {
			asVal += "," + $(this).val();
		});
		
		asVal = asVal.substring(1);
		
		$("#asVal").val(asVal);
		
		reloadList();
	});
 	$("#searchTxt").on("keypress", function() {
		if(event.which == "13"){
			$("#searchBtn").click();
		}
	});
 	
 	//초기화
	$("[alt='reset']").on("click", function() {
		$("#resetBtn").click();
		$("#stdt").val(sDate);
		$("#eddt").val(eDate);
		$("#c1").prop("checked", true);
		$("#searchBtn").click();
	});
    
 	//상세보기로 이동
 	$(".docList_table tbody").on("click","tr",function(){
 		$("#apvNo").val($(this).attr("name"));
 		
		$("#apvDataForm").attr("action", "GWApvProgress");
		$("#apvDataForm").submit();
 	});
 	
 	
});

function reloadList() {
	
	var params = $("#dataForm").serialize();
	
	$.ajax({
		type : "post",
		url : "GWApvProgressDocAjax",
		dataType : "json",
		data : params,
		success : function(result){
			console.log(result);
			redrawList(result.list, result.apvCompleteList);
			redrawPaging(result.pb);
		},
		error : function(request, status, error) {
			console.log("status : " + request.status);	
			console.log("text : " + request.responseText);	
			console.log("error : " + error);	
		}
	});
}

function redrawList(list, apvCompleteList) {
	var html = "";
	if(list.length == 0){
		html += "<tr class=\"empty\"><td colspan=\"11\">조회결과가 없습니다.</td></tr>";
	} else {
		var docState = "";
		var rns = "";
		
		for(var i = 0; i < list.length; i++){
			html += "<tr name=\"" + list[i].APV_NO + "\">";
			html += "<td>" + list[i].CONSULT_NO + "</td>";
			html += "<td>" + list[i].APV_DOC_TYPE_NAME + "</td>";
			html += "<td>" + list[i].TITLE + "</td>";
			html += "<td>" + list[i].NAME + "</td>";
			html += "<td>" + list[i].DRAFT_DATE + "</td>";
			html += "<td>" + list[i].IMP_DATE + "</td>";
			html += "<td>" + list[i].APV_DATE + "</td>";
			html += "<td>" + list[i].REJER + "</td>";
			html += "<td>" + list[i].REJ_DATE + "</td>";
			if(list[i].DOC_STATE == "상신"){
				docState = "state_A";
			} else if(list[i].DOC_STATE == "진행중"){
				docState = "state_B";
			} else if(list[i].DOC_STATE == "종결"){
				docState = "state_C";
			} else if(list[i].DOC_STATE == "전결"){
				docState = "state_D";
			} else if(list[i].DOC_STATE == "반려"){
				docState = "state_E";
			}
			html += "<td class=\"" + docState + "\">" + list[i].DOC_STATE + "</td>";
			
			if(list[i].RNS == "수신"){
				html += "<td class=\"receive\">";
				
				var flag = false;
				for(var j=0; j< apvCompleteList.length; j++){
					if(list[i].APV_NO == apvCompleteList[j].APV_NO){
						flag = true;
					}
				}
					
				if(flag){
					html += "<b>처리완료</b>";
				} else {
					html += list[i].RNS; 
				}
				html += "</td>";
			} else if(list[i].RNS == "발신"){
				html += "<td class=\"send\">" + list[i].RNS + "</td>";
			}
			
			html += "</tr>";
		}
		
	}

	$("#docList_table tbody").html(html);
}

function redrawPaging(pb) {
	var html = "";
	
	html += "<div name = 1>&lt;&lt;</div>";
	
	if($("#page").val() == "1"){
		html += "<div name = 1>&lt;</div>";
	} else {
		html += "<div name=\"" + ($("#page").val() * 1 - 1) + "\">&lt;</div>";		
	}
	
	for(var i = pb.startPcount; i <= pb.endPcount; i++){
		if(i == $("#page").val()){
			html += "<div name = \"" + i + "\" id=\"checked\">" + i + "</div>";
		} else {
			html += "<div name = \"" + i + "\">" + i + "</div>";
		}
	}
	
	if($("#page").val() == pb.maxPcount){
		html += "<div name=\"" + pb.maxPcount + "\">&gt;</div>";
	} else {
		html += "<div name=\"" + ($("#page").val() * 1 + 1) + "\">&gt;</div>";
	}
	
	html += "<div name=\"" + pb.maxPcount + "\">&gt;&gt;</div>";
	
	$("#pageArea").html(html);
}
</script>
</head>
<body>
<!-- 상세보기 form -->
<form action="#" id="apvDataForm" method="post">
	<input type="hidden" id="apvNo" name="apvNo" value=""/>
	<input type="hidden" name="topMenuNo" value="2">
	<input type="hidden" name="leftMenuNo" value="5">
</form>

<c:import url="/topLeft">
	<c:param name="topMenuNo" value="2"></c:param>
	<c:param name="leftMenuNo" value="5"></c:param>
</c:import>
	<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
<div class="content_area">
	<div class="content_nav">HeyWe &gt; 그룹웨어 &gt; 전자결재 &gt; 결재진행 문서함</div>	
	<!-- 내용 영역 -->
	<div class="content_title">
		결재진행 문서함
	</div>
	<div class="gwApvProgressDocList">
		<!-- 결재진행 문서함 상단 -->
		
		<!-- form 영역 시작 -->
		<form action="#" method="post" id="dataForm">
			<input type="hidden" id="page" name="page" />
			<input type="hidden" id="asVal" name="asVal" />
			
			<input type="hidden" id="radioCheck" name="radioCheck" />
		
			<div class="searchCondArea">
				<div class="selectDuration"> 
					<b>기간 선택</b> &nbsp; &nbsp;      
					<select name="durationSearchGbn">
						<option value="0">기안일</option>
						<option value="1">결재일</option>
						<option value="2">반려일</option>
						<option value="3">시행일</option>
					</select>
					<input type="text" placeholder="YYYY-MM-DD" id="stdt" name="stdt" value="${stdt}" readonly="readonly" /> -
					<input type="text" placeholder="YYYY-MM-DD" id="eddt" name="eddt" value="${eddt}" readonly="readonly" />
				</div>
				<div class="recieveSend"> 
					<b>수발신</b> &nbsp; &nbsp; &nbsp; &nbsp;    
					<input type="radio" name="sr" checked="checked" id="r1" value="전체" /><label for="r1">전체</label>  
					<input type="radio" name="sr" id="r2" value="수신" /><label for="r2">수신</label> 
					<input type="radio" name="sr" id="r3" value="발신" /><label for="r3">발신</label>
				</div>
				<div class="apvState"> 
					<b>결재상태</b> &nbsp; &nbsp; &nbsp;
					<input type="checkbox" id="c1" value="전체" checked="checked"><label for="c1">전체</label>
					<span class="eachState">
						<input type="checkbox" name="as" id="c2" value="0"><label for="c2">상신</label>
						<input type="checkbox" name="as" id="c3" value="1"><label for="c3">진행중</label>
						<input type="checkbox" name="as" id="c4" value="2"><label for="c4">종결</label>
						<input type="checkbox" name="as" id="c5" value="3"><label for="c5">전결</label>
						<input type="checkbox" name="as" id="c6" value="4"><label for="c6">반려</label>
					</span>
				</div>
				<div class="searchDoc"> 
					<b>문서 검색</b>  &nbsp; &nbsp;
					<select name="docSearchGbn">
						<option value="0">제목</option>
						<option value="1">품의번호</option>
						<option value="2">문서분류</option>
						<option value="3">기안자</option>
						<option value="4">반려자</option>
					</select>
					<div class="searching">
						<img alt="search" src="resources/images/erp/gw/ea/search.png">
					</div>
					<input type="text" id="searchTxt" name="searchTxt" autocomplete="off" placeholder="검색어 입력"><input type="button" id="searchBtn" value="검색" />
					<input type="reset" id="resetBtn" hidden="hidden" />
					<img alt="reset" src="resources/images/erp/gw/ea/reset.png" />
				</div>
			</div>
		</form>
		<!-- form영역 끝 -->
		
		<!-- 결재진행 문서함 하단-->
		<div class="cpd_search_output"> 
			<div class="docList">
				<table class="docList_table" id="docList_table">
					<thead>
						<tr>
							<th>품의 번호</th>
							<th>문서 분류</th>
							<th>제목</th>
							<th>기안자</th>
							<th>기안일</th>
							<th>시행일</th>
							<th>결재일</th>
							<th>반려자</th>
							<th>반려일</th>
							<th>상태</th>
							<th>수발신</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
					<tfoot>
						<tr>
							<td colspan="11" id="pageArea">
							</td>
						<tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>
</div>
</body>
</html>