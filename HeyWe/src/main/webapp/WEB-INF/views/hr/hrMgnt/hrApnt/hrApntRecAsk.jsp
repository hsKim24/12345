	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 인사기록조회</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/hr/hrMgnt/hrApnt/hrApntRecAsk.css" />
<!-- calendar select css -->
<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css" href="resources/css/common/calendar.css" />

<style type="text/css">
	.ui-datepicker select.ui-datepicker-year {
	    width: 48%;
	    font-size: 11px;
	}
	
	.ui-datepicker select.ui-datepicker-month {
	    width: 40%;
	    font-size: 11px;
	}
</style>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>

<!-- calendar select script -->
<script type="text/javascript" src="resources/script/jquery/jquery-ui.min.js"></script>
<script type="text/javascript" src="resources/script/calendar/calendar.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		if($("#hrApntRecAskPage").val() == ""){
			$("#hrApntRecAskPage").val("1");
		}
		
		drawDropdown();
		
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			showOn: 'both',
			closeText: '닫기',
			changeMonth: true,
		    changeYear: true,
			buttonImage: 'resources/images/calender.png',
			buttonImageOnly: true,
			dateFormat: 'yy/mm/dd',
			yearRange: "-100:+1"
		}); 
		
		var date = new Date();
		var sysDate = date.getFullYear() + leadingZeros(date.getMonth() + 1, 2) + leadingZeros(date.getDate(),2);
		
		$("#date_start").datepicker({
			dateFormat : 'yy-mm-dd',
			duration: 200,
			onSelect:function(dateText, inst){
				var startDate = parseInt($("#date_end").val().replace("-", '').replace("-", ''));
				var endDate = parseInt(dateText.replace(/-/g,''));
				
				if (endDate > startDate) {
					makeAlert(1, "기간", "기간을 다시 설정해주세요.", true, null);
	            	
	        		$("#date_start").val($("#startDate").val());
				} else {
					$("#startDate").val($("#date_start").val());
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
	            	makeAlert(1, "기간", "기간을 다시 설정해주세요.", true, null);
	            	
	        		$("#date_end").val($("#endDate").val());
				} else {
					$("#endDate").val($("#date_end").val());
				}
			}
		});
		
		$("#hrApntReg").on("click", function(){
			location.href = "HRHrApntReg";
		});
		
		$("#search").on("click", function(){
			if($("#startDate").val() == "" && $("#endDate").val() != ""){
				makeAlert(1, "기간", "기간을 설정해주세요.", true, null);
			} else if($("#startDate").val() != "" && $("#endDate").val() == ""){
				makeAlert(1, "기간", "기간을 설정해주세요.", true, null);
			}else {
				$("#formDeptNo").val($("#dept").val());
				$("#formPosiNo").val($("#posi").val());
				$("#formApvNo").val($("#apv").val());
				$("#formEmpNo").val();
				$("#hrApntRecAskPage").val("1");
				
				redraw();
			}
			
		});
		
		$(".paging_group").on("click", "input", function(){
			$("#hrApntRecAskPage").val($(this).attr("name"));
			
			redraw();
		});
		
		
		$("#person_select_txt, #person_search_btn").on("click",function(){
			makePopup(1, "사원조회", empPopup() , true, 700, 386, function(){
				$("#selectEmpFlag").val("0");
				popUpSearch();
				
				$("#listDiv").slimScroll({
					height: "170px",
					axis: "both"
				});
				
				$("#search_btn").on("click", function(){
					popUpSearch();
				});
				
				$("#search_txt").keyup(function(event){
					if(event.keyCode == '13'){
						popUpSearch();
					}
				});
				
				$("#listCon tbody").on("click", "tr", function(){
					$("#listCon tr").css("background-color", "");
					$(this).css("background-color", "#B0DAEC");
					$("#selectEmpNo").val($(this).attr("name"));
					$("#selectEmpFlag").val("1");
				});
				
			}, "선택", function(){ 
				if($("#selectEmpFlag").val() == "1"){
					$("#person_select_txt").val($("#selectEmpNo").val());
					$("#formEmpNo").val($("#selectEmpNo").val());
				}
				
				closePopup(1);
			});
			
			/* makeAlert(1, "test", "test중입니다.", true, null); */
			
			/* makeConfirm(1, "test", "test중입니다.", true, function(){
				alert("aa");
			}); */		
		});
		
		$(".recAsklist tbody").on("click", "tr", function(){
			if($(this).attr("name") == "0"){
				makeAlert(1, "발령사유", $(this).children(".apntNote").html(), true, null);
			}
		});
		
	});
	
	function leadingZeros(n, digits) {
		var zero = '';
		n = n.toString();

		if (n.length < digits) {
			for (i = 0; i < digits - n.length; i++)
			zero += '0';
		}
		return zero + n;
	}


	
	function redraw(){
		var params = $("#actionForm").serialize();
		$.ajax({
			type : "post",
			url : "HRHrApntRecAskAjax",
			dataType : "json",
			data : params,
			success : function(result){
				drawList(result.list);
				drawPaging(result.pb);
			},
			error : function(request, status, error){
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}
	
	function drawDropdown(){
		$.ajax({
			type : "post",
			url : "HRDeptMgntAjax",
			dataType : "json",
			success : function(result){
				drawDept(result.list);
			},
			error : function(request, status, error){
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
		
		$.ajax({
			type : "post",
			url : "HRPosiAskAjax",
			dataType : "json",
			success : function(result){
				drawPosi(result.list);
			},
			error : function(request, status, error){
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
		
		redraw();
	}
	
	function drawDept(list){
		var html = "";
		
		for(var i = 0 ; i < list.length ; i++){
			html += "<option value=\""+ list[i].DEPT_NO +"\">"+ list[i].DEPT_NAME +"</option>";
		}
		
		$("#dept").append(html);
	}
	
	function drawPosi(list){
		var html = "";
		
		for(var i = 0 ; i < list.length ; i++){
			html += "<option value=\""+ list[i].POSI_NO +"\">"+ list[i].POSI_NAME +"</option>";
		}
		
		$("#posi").append(html);
	}
	
	function drawList(list){
		var html = "";

		for(var i = 0 ; i < 10 ; i++){
			if(i < list.length){
				if(i % 2 == 0){
					html += "<tr class=\"odd_row\" name=\"0\" >";
				} else {
					html += "<tr class=\"even_row\" name=\"0\" >";
				}
				
				html += "<td>"+ list[i].RNUM +"</td>";
				html += "<td>"+ list[i].NAME +"</td>";
				html += "<td>"+ list[i].EMP_NO +"</td>";
				html += "<td>"+ list[i].POSI_NAME +"</td>";
				html += "<td>"+ list[i].DEPT_NAME +"</td>";
				html += "<td>"+ list[i].APNT_DATE +"</td>";
				html += "<td>"+ list[i].APV_STATE +"</td>";
				html += "<td>"+ list[i].HR_APNT_NO +"</td>";
				html += "<td style=\"display:none;\" class=\"apntNote\">" + list[i].APNT_REASON + "</td>";
				html += "</tr>";
			}else {
				if(i % 2 == 0){
					if(i == 4 && list.length == 0){
						html += "<tr class=\"odd_row\" name=\"1\" ><td colspan=\"8\">결과가 존재하지 않습니다</td>";
						$("#hrApntRecAskPage").val("1");
					}else {
						html += "<tr class=\"odd_row\" name=\"1\" ><td colspan=\"8\"></td>";
					}
				} else {
					html += "<tr class=\"even_row\" name=\"1\" ><td colspan=\"8\"></td>";
				}
				html += "</tr>";
			}
			
		}
		
		$(".recAsklist tbody").html(html);
		
		
	}
	
	function drawPaging(pb){
		var html = "";
		html += "<input type=\"button\" value=\"&lt&lt\" name=\"1\" >";
		
		if($("#hrApntRecAskPage").val() == "1"){
			html += "<input type=\"button\" value=\"&lt\" name=\"1\" >";
		} else {
			html += "<input type=\"button\" value=\"&lt\" name=\"" + ($("#hrApntRecAskPage").val() * 1 - 1) + "\">";
		}
		
		for(var i = pb.startPcount ; i <= pb.endPcount ; i++){
			if(i == $("#hrApntRecAskPage").val()){
				html += "<input type=\"button\" value=\"" + i + "\" name=\"" + i + "\" disabled=\"disabled\" class=\"paging_on\">";
			} else {
				html += "<input type=\"button\" value=\"" + i + "\" name=\"" + i +  "\" class=\"paging_off\">";
			}
		}
		
		if($("#hrApntRecAskPage").val() == pb.maxPcount) {
			html += "<input type=\"button\" value=\"&gt\" name=\"" + pb.maxPcount +  "\">"; 
		}else {
			html += "<input type=\"button\" value=\"&gt\" name=\"" + ($("#hrApntRecAskPage").val() * 1 + 1) +   "\">";
		}
		
		html += "<input type=\"button\" value=\"&gt&gt\" name=\"" + pb.maxPcount +  "\">";
		
		$(".paging_group").html(html);
	}
	
	function drawEmpSearchList(list){
		var html = "";
		
		if(list.length == 0){
			html += "<tr class=\"odd_row\"><td colspan=\"2\"></td></tr>";
			html += "<tr class=\"even_row\"><td colspan=\"2\"></td></tr>";
			html += "<tr class=\"odd_row\"><td colspan=\"2\"></td></tr>";
			html += "<tr class=\"even_row\"><td colspan=\"2\">검색결과가 없습니다</td></tr>";
			html += "<tr class=\"odd_row\"><td colspan=\"2\"></td></tr>";
			html += "<tr class=\"even_row\"><td colspan=\"2\"></td></tr>";
			html += "<tr class=\"odd_row\"><td colspan=\"2\"></td></tr>";
		}else {
			for(var i = 0 ; i < list.length ; i++){
				if(i % 2 == 0){
					html += "<tr class=\"odd_row\" name=\""+ list[i].EMP_NO + "\">";
				}else {
					html += "<tr class=\"even_row\" name=\""+ list[i].EMP_NO + "\">";
				}
				html += "<td>" + list[i].DEPT_NAME + "</td>";
				html += "<td>" + list[i].NAME + "</td>";
				html += "</tr>";
			}
		}
		
		$("#listCon tbody").html(html);
	}

	function empPopup(){
		var html="";
		
		html += "<div id=\"empSearch\">";
		html += "<input type=\"text\" placeholder=\"이름을 입력해주세요\" id=\"search_txt\">";
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
	
	function popUpSearch(){
		$("#empSearchTxt").val($.trim($("#search_txt").val()));
		
		var params = $("#actionForm").serialize(); 
		
		$.ajax({
			type : "post",
			url : "HREmpSearchAjax",
			dataType : "json",
			data : params,
			success : function(result){
				drawEmpSearchList(result.list);
			},
			error : function(request, status, error){
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}
	
</script>
</head>
<body>
<form action="#" id="actionForm" method="post">
	<input type="hidden" id="formDeptNo" name="formDeptNo" value="1000">
	<input type="hidden" id="formPosiNo" name="formPosiNo" value="1000">
	<input type="hidden" id="formApvNo" name="formApvNo" value="1000">
	<input type="hidden" id="formEmpNo" name="formEmpNo" value="1000">
	<input type="hidden" id="hrApntRecAskPage" name="hrApntRecAskPage" value="${hrApntRecAskPage}">
	<input type="hidden" id="startDate" name="startDate">
	<input type="hidden" id="endDate" name="endDate">
	<input type="hidden" id="empSearchTxt"name="empSearchTxt" />
</form>

<input type="hidden" id="selectEmpNo" />
<input type="hidden" id="selectEmpFlag" value="0"/>
<input type="hidden" id="auth" value="${auth}">

<c:import url="/topLeft">
	<c:param name="topMenuNo" value="49"></c:param>
	<c:param name="leftMenuNo" value="53"></c:param>
	<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
</c:import>
	
<div class="content_area">
	<div class="content_nav">HeyWe &gt; 인사 &gt; 인사관리 &gt; 인사기록조회 </div>
	<!-- 내용 영역 -->
	<div class="content_title">
     	<div class="content_title_text">인사기록조회</div>
	</div>
  	<br/>
  	<c:if test="${auth eq 3}">
	  	<div class="regBtnBox">
		  	<input type="button" value="인사발령" id="hrApntReg">
	  	</div>
  	</c:if>
	<div class="content_select">
		<div class="content_select_row">
			<div class="table">
				<div class="content_select_row_name">
					<div>부서</div>
				</div>
			</div>
			<select class="dropdown" id="dept">
				<option value="1000">전체</option>
			</select>
			<div class="table">
				<div class="content_select_row_name">
					<div>직위</div>
				</div>
			</div>
			<select class="dropdown" id="posi">
				<option value="1000">전체</option>
			</select>
			<div class="table">
				<div class="content_select_row_name">
					<div>결재</div>
				</div>
			</div>
			<select class="dropdown" id="apv">
				<option value="1000">전체</option>
				<option value="0">결재대기</option>
				<option value="1">승인</option>
				<option value="2">반려</option>
			</select>
			<div class="table">
				<div class="content_select_row_name">
					<div>기간</div>
				</div>
			</div>
			<div class="calendar_group">
				<!-- 캘린더 --> 
				<input type="text" placeholder="YYYY-MM-DD" size="13" id="date_start" readonly="readonly">
				 ~
				<input type="text" placeholder="YYYY-MM-DD" size="13" id="date_end" readonly="readonly">
			</div>
			
		</div>
		<div class="content_select_row">
			<div class="table">
				<div class="content_select_row_name">
					<div>사원선택</div>
				</div>
			</div>
			<input type="text" size="10" readonly="readonly" id="person_select_txt" value="전체">
			<div id="person_search_btn"></div>
			<div class="table">
				<div class="content_select_row_name" id="search">
					<div>검색</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="content_table">
		<table class="recAsklist">
			<colgroup>
				<col width="150">
				<col width="160">
				<col width="150">
				<col width="150">
				<col width="150">
				<col width="150">
				<col width="150">
				<col width="150">
			</colgroup>
			<thead>
				<tr>
					<td>No</td>
					<td>이름</td>
					<td>사번</td>
					<td>직위</td>
					<td>부서</td>
					<td>발령일자</td>
					<td>결재상태</td>
					<td>인사발령번호</td>
					<td style="display:none;">
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		
		<div class="paging_group">
		</div>
	</div>
</div>
</body>
</html>
