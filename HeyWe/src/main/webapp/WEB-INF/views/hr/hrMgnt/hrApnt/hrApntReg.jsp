<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 인사발령</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/hr/hrMgnt/hrApnt/hrApntReg.css" />
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
<!-- calendar select script -->
<script type="text/javascript" src="resources/script/calendar/calendar.js"></script>

<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			showOn: 'both',
			closeText: '닫기',
			minDate: new Date(),
			changeMonth: true,
		    changeYear: true,
			buttonImage: 'resources/images/calender.png',
			buttonImageOnly: true,
			dateFormat: 'yy/mm/dd'    
		}); 
		
		var date = new Date();
		var sysDate = date.getFullYear() + leadingZeros(date.getMonth() + 1, 2) + leadingZeros(date.getDate(),2);
		
		$("#apntDate").datepicker({
			dateFormat : 'yy-mm-dd',
			duration: 200,
			onSelect:function(dateText, inst){
				var date = parseInt($("#apntDate").val().replace("-", '').replace("-", ''));

				if(sysDate >= date){
					makeAlert(1, "발령날짜", "과거 날짜는 등록할 수 없습니다.", true, null);
					$("#apntDate").val($("#formApntDate").val());
				}else {
					$("#formApntDate").val($("#apntDate").val());
				}
				
			}
		});
		
		$("#empNo, #empName").on("click",function(){
			makePopup(1, "사원조회", empPopup() , true, 700, 386, function(){
				$("#selectFlag").val("0");
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
					$("#selectEmpPic").val($(this).attr("pic"));
					$("#selectEmpName").val($(this).children(".listEmpName").html());
					$("#selectFlag").val("1");
				});
				
			}, "선택", function(){ 
				if($("#selectFlag").val() == "1"){
					$("#empNo").val($("#selectEmpNo").val());
					if($("#selectEmpPic").val() != 'undefined'){
						$("#empPic").attr("src", "resources/upload/" + $("#selectEmpPic").val());
					}
					$("#formEmpNo").val($("#selectEmpNo").val());
					$("#empName").val($("#selectEmpName").val());
				}
				
				closePopup(1);
			});
			
			/* makeAlert(1, "test", "test중입니다.", true, null); */
			
			/* makeConfirm(1, "test", "test중입니다.", true, function(){
				alert("aa");
			}); */		
		});
		
		$("#posiName").on("click",function(){
			makePopup(1, "직위조회", posiPopup() , true, 400, 340, function(){
				$("#selectFlag").val("0");
				
				$("#listDiv").slimScroll({
					height: "170px",
					axis: "both"
				});
				
				posiSearch();
				
				$("#listCon tbody").on("click", "tr", function(){
					$("#listCon tr").css("background-color", "");
					$(this).css("background-color", "#B0DAEC");
					$("#selectPosiNo").val($(this).attr("name"));
					$("#selectPosiName").val($(this).children(".listPosiName").html());
					$("#selectFlag").val("1");
				});
				
			}, "선택", function(){ 
				if($("#selectFlag").val() == "1"){
					$("#posiName").val($("#selectPosiName").val());
					$("#formPosiNo").val($("#selectPosiNo").val());
				}
				
				closePopup(1);
			});
			
			/* makeAlert(1, "test", "test중입니다.", true, null); */
			
			/* makeConfirm(1, "test", "test중입니다.", true, function(){
				alert("aa");
			}); */		
		});
		
		$("#deptName").on("click",function(){
			makePopup(1, "부서조회", deptPopup() , true, 400, 340, function(){
				$("#selectFlag").val("0");
				
				$("#listDiv").slimScroll({
					height: "170px",
					axis: "both"
				});
				
				deptSearch();
				
				$("#listCon tbody").on("click", "tr", function(){
					$("#listCon tr").css("background-color", "");
					$(this).css("background-color", "#B0DAEC");
					$("#selectDeptNo").val($(this).attr("name"));
					$("#selectDeptName").val($(this).children(".listDeptName").html());
					$("#selectFlag").val("1");
				});
				
			}, "선택", function(){ 
				if($("#selectFlag").val() == "1"){
					$("#deptName").val($("#selectDeptName").val());
					$("#formDeptNo").val($("#selectDeptNo").val());
				}
				
				closePopup(1);
			});
			
			/* makeAlert(1, "test", "test중입니다.", true, null); */
			
			/* makeConfirm(1, "test", "test중입니다.", true, function(){
				alert("aa");
			}); */		
		});
		
		$("#backBtn").on("click", function(){
			history.back();
		});
		
		$("#apvAskBtn").on("click", function(){
			if($("#empNo").val() == ''){
				makeAlert(1, "결재요청", "사원을 선택해주세요.", true, null);
			}else if($("#apntDate").val() == ''){
				makeAlert(1, "결재요청", "발령날짜를 선택해주세요.", true, null);
			}else if($("#note").val() == ''){
				makeAlert(1, "결재요청", "발령사유를 작성해주세요.", true, null);
			}else {
				makeConfirm(1, "결재요청", "결재요청하시겠습니까?", true, function(){
					$("#formNote").val($("#note").val());
					$("#formDmngrDiv").val($("#dmngr_div").val());
					
					var dmngr_div = "";
					if($("#dmngr_div").val() == 0){
						dmngr_div = "예";
					}else{
						dmngr_div = "아니오";
					}
					
					var expCon = "";
					
					expCon += "<table border=\"1\" cellpadding=\"1\" cellspacing=\"0\">";
					expCon += "<tbody>";
					expCon += "<tr>";
					expCon += "<td style=\"background-color:#dee6ef; border-color:#134074; text-align:center; width:150px\"><span style=\"font-size:14px\"><strong>부서</strong></span></td>";
					expCon += "<td style=\"border-color:#134074; height:40px; text-align:center; width:400px\">" + $("#deptName").val() + "</td>";
					expCon += "</tr>";
					expCon += "<tr>";
					expCon += "<td style=\"background-color:#dee6ef; border-color:#134074; text-align:center; width:150px\"><span style=\"font-size:14px\"><strong>부서장구분</strong></span></td>";
					expCon += "<td style=\"border-color:#134074; height:40px; text-align:center; width:400px\">" + dmngr_div + "</td>";
					expCon += "</tr>";
					expCon += "<tr>";
					expCon += "<td style=\"background-color:#dee6ef; border-color:#134074; text-align:center; width:150px\"><span style=\"font-size:14px\"><strong>직위</strong></span></td>";
					expCon += "<td style=\"border-color:#134074; height:40px; text-align:center; width:400px\">" + $("#posiName").val() + "</td>";
					expCon += "</tr>";
					expCon += "<tr>";
					expCon += "<td style=\"background-color:#dee6ef; border-color:#134074; text-align:center; width:150px\"><span style=\"font-size:14px\"><strong>발령날짜</strong></span></td>";
					expCon += "<td style=\"border-color:#134074; height:40px; text-align:center; width:400px\">" + $("#apntDate").val() + "</td>";
					expCon += "</tr>";
					expCon += "<tr>";
					expCon += "<td style=\"background-color:#dee6ef; border-color:#134074; text-align:center; width:150px\"><span style=\"font-size:14px\"><strong>발령사유</strong></span></td>";
					expCon += "<td style=\"border-color:#134074; height:40px; text-align:center; width:400px\">" + $("#note").val() + "</td>";
					expCon += "</tr>";
					expCon += "</tbody>";
					expCon += "</table>";
					
					$("#expCon").val(expCon);
					
					var params = $("#actionForm").serialize(); 
					
					$.ajax({
						type : "post",
						url : "HRHrApntRegAjax",
						dataType : "json",
						data : params,
						success : function(result){
							if(result.flag == 0){
								location.href = "HRHrApntRecAsk";
							}else {
								makeAlert(2, "결재요청", "결재요청에 실패했습니다.", true, null);
							}
						},
						error : function(request, status, error){
							console.log("status : " + request.status);
							console.log("text : " + request.responseText);
							console.log("error : " + error);
						}
					});
				})
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
					html += "<tr class=\"odd_row\" name=\""+ list[i].EMP_NO + "\" pic=\""+ list[i].PIC + "\">";
				}else {
					html += "<tr class=\"even_row\" name=\""+ list[i].EMP_NO + "\" pic=\""+ list[i].PIC + "\">";
				}
				html += "<td>" + list[i].DEPT_NAME + "</td>";
				html += "<td class=\"listEmpName\">" + list[i].NAME + "</td>";
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
	
	function posiPopup(){
		var html="";
		
		html += "<div id=\"list\">";
		html += "<table id=\"listTop\">";
		html += "<colgroup>";
		html += "<col width=\"330px\">";
		html += "</colgroup>";
		html += "<tr>";
		html += "<th>직위명</th>";
		html += "</tr>";
		html += "</table>";
		html += "<div id=\"listDiv\">";
		html += "<table id=\"listCon\">";
		html += "<colgroup>";
		html += "<col width=\"330px\">";
		html += "</colgroup>";
		html += "<tbody>";
		html += "</tbody>";
		html += "</table>";
		html += "</div>";
		html += "</div>";
		
		return html;
	}
	
	function posiSearch(){

		$.ajax({
			type : "post",
			url : "HRPosiAskAjax",
			dataType : "json",
			success : function(result){
				drawPosiSearchList(result.list);
			},
			error : function(request, status, error){
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}
	
	function drawPosiSearchList(list){
		var html = "";
		
		for(var i = 0 ; i < list.length ; i++){
			if(i % 2 == 0){
				html += "<tr class=\"odd_row\" name=\""+ list[i].POSI_NO + "\">";
			}else {
				html += "<tr class=\"even_row\" name=\""+ list[i].POSI_NO + "\">";
			}
			html += "<td class=\"listPosiName\">" + list[i].POSI_NAME + "</td>";
			html += "</tr>";
		}
		
		$("#listCon tbody").html(html);
	}
	
	function deptPopup(){
		var html="";
		
		html += "<div id=\"list\">";
		html += "<table id=\"listTop\">";
		html += "<colgroup>";
		html += "<col width=\"330px\">";
		html += "</colgroup>";
		html += "<tr>";
		html += "<th>부서명</th>";
		html += "</tr>";
		html += "</table>";
		html += "<div id=\"listDiv\">";
		html += "<table id=\"listCon\">";
		html += "<colgroup>";
		html += "<col width=\"330px\">";
		html += "</colgroup>";
		html += "<tbody>";
		html += "</tbody>";
		html += "</table>";
		html += "</div>";
		html += "</div>";
		
		return html;
	}
	
	function deptSearch(){

		$.ajax({
			type : "post",
			url : "HRDeptMgntAjax",
			dataType : "json",
			success : function(result){
				drawDeptSearchList(result.list);
			},
			error : function(request, status, error){
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}
	
	function drawDeptSearchList(list){
		var html = "";
		
		for(var i = 0 ; i < list.length ; i++){
			if(i % 2 == 0){
				html += "<tr class=\"odd_row\" name=\""+ list[i].DEPT_NO + "\">";
			}else {
				html += "<tr class=\"even_row\" name=\""+ list[i].DEPT_NO + "\">";
			}
			html += "<td class=\"listDeptName\">" + list[i].DEPT_NAME + "</td>";
			html += "</tr>";
		}
		
		$("#listCon tbody").html(html);
	}
</script>
</head>
<body>

<form action="#" id="actionForm" method="post">
	<input type="hidden" id="empSearchTxt" name="empSearchTxt">
	<input type="hidden" id="formEmpNo" name="formEmpNo">
	<input type="hidden" id="formPosiNo" name="formPosiNo">
	<input type="hidden" id="formDeptNo" name="formDeptNo">
	<input type="hidden" id="formApntDate" name="formApntDate">
	<input type="hidden" id="formNote" name="formNote">
	<input type="hidden" id="formDmngrDiv" name="formDmngrDiv">
	
	<input type="hidden" id="expCon" name="expCon">
	<input type="hidden" name="sEmpNo" value="${sEmpNo}">
</form>

<input type="hidden" id="selectFlag" value="0">
<input type="hidden" id="selectEmpNo">
<input type="hidden" id="selectEmpPic">
<input type="hidden" id="selectEmpName">
<input type="hidden" id="selectPosiNo">
<input type="hidden" id="selectPosiName">
<input type="hidden" id="selectDeptNo">
<input type="hidden" id="selectDeptName">

<c:import url="/topLeft">
	<c:param name="topMenuNo" value="49"></c:param>
	<c:param name="leftMenuNo" value="53"></c:param>
	<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
</c:import>

<div class="content_area">
	<div class="content_nav">HeyWe &gt; 인사 &gt; 인사관리 &gt; 인사기록조회 &gt; 인사발령</div>
	<div class="content_title">
     	<div class="content_title_text">인사발령</div>
	</div>
	<!-- 내용 영역 -->
	<div class="content_box">
		<div class="content_box_top">
			<div class="profile_img">
				<img alt="사진없음" src="resources/images/erp/common/nopic.png" id="empPic">
			</div>
			<div class="emp_box">
				<div class="table">
					<div class="emp_box_note">사번</div>
					<input type="text" readonly="readonly" placeholder="사원을 검색하세요" class="emp_data" id="empNo">
				</div>
			</div>
			<div class="emp_box">
				<div class="table">
					<div class="emp_box_note">이름</div>
					<input type="text" readonly="readonly" placeholder="사원을 검색하세요" class="emp_data" id="empName">
				</div>
			</div>
		</div>
			
		<div class="content_box_middle">
			<div class="content_box_section">
			<div class="content_box_name">발령 후</div>
			<div class="emp_box">
				<div class="table">
					<div class="emp_box_note">직위</div>
					<input type="text" placeholder="직위을 선택하세요" readonly="readonly" class="emp_data" id="posiName">
				</div>
			</div>	
			<div class="emp_box">
				<div class="table">
					<div class="emp_box_note">부서</div>
					<input type="text"placeholder="부서를 선택하세요" readonly="readonly" class="emp_data" id="deptName">
				</div>
			</div>
			</div>
			<br>
			<div class="content_box_section">
			<div class="content_box_name" id="mid_second_line"></div>
			<div class="emp_box">
				<div class="table">
					<div class="emp_box_note" id="dmngr_box" >부서장</div>
					<select id="dmngr_div">
						<option value="0">예</option>
						<option selected="selected" value="1">아니오</option>
					</select>
				</div>
			</div>	
			</div>
		</div>	
		<div class="content_box_bottom">
			<div class="emp_box">
					<div class="table">
						<div class="emp_box_note">발령날짜</div>
						<input type="text"placeholder="YYYY-MM-DD" readonly="readonly" class="emp_data" id="apntDate">
					</div>
				</div>
			<div class="emp_box" id="noteBox">
				<div class="table">
					<div class="emp_box_note">발령사유</div>
					<input type="text"placeholder="입력하세요" class="emp_data" id="note">
				</div>
			</div>
		</div>
		<div class="button_group">
			<input type="text" value="※ 퇴직 발령은 부서와 직위를 선택하지 마세요." id="text" disabled="disabled" style="color:blue;" > 
			<input type="button" value="취소" id="backBtn">
			<input type="button" value="결재요청" id="apvAskBtn">
		</div>	
	</div>
</div>
</body>
</html>