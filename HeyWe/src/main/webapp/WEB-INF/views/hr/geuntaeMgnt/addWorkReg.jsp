<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 추가근무등록</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/hr/geuntaeMgnt/addWorkReg.css" />
<!-- calendar select css -->
<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css" href="resources/css/common/calendar.css" />

<style type="text/css">
/* 
	DarkBlue : rgb(19, 64, 116), #134074
	DeepLightBlue : rgb(141, 169, 196), #8DA9C4
	LightBlue : rgb(222,230,239), #DEE6EF
	White : rgb(255,255,255), #FFFFFF
 */
</style>
<!-- calendar select script -->
<script type="text/javascript" src="resources/script/calendar/calendar.js"></script>

<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		dropBox();
		
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			showOn: 'both',
			closeText: '닫기',
			buttonImage: 'resources/images/calender.png',
			buttonImageOnly: true,
			dateFormat: 'yy/mm/dd'    
		}); 
		
		var date = new Date();
		var sysDate = date.getFullYear() + leadingZeros(date.getMonth() + 1, 2) + leadingZeros(date.getDate(),2);
		
		$("#date").datepicker({
			dateFormat : 'yy-mm-dd',
			duration: 200,
			onSelect:function(dateText, inst){
				var date = parseInt($("#date").val().replace("-", '').replace("-", ''));

				if(sysDate < date){
					makeAlert(1, "날짜", "미래 날짜는 등록할 수 없습니다.", true, null);
					$("#date").val($("#formDate").val());
				}else{
					$("#formDate").val($("#date").val());
				}
				
			}
		});
		
		//근무시간에 숫자만 입력하도록
		$("#time_input_txt").on("change", function() {
			if(isNaN($(this).val() * 1)) {
				makeAlert(1, "근무시간", "숫자를 입력하세요.", true, null);
				$(this).val("");
				$(this).focus();
			}
		});
		
		$("#ok_btn").on("click", function(){
			if($(".dropbox").val() == "-1"){
				makeAlert(1, "등록", "근태명을 선택하세요.", true, null);
			}else if($.trim($("#time_input_txt").val()) == ''){
				makeAlert(1, "등록", "근무시간을 입력하세요.", true, null);
			}else if($("#date").val() == ''){
				makeAlert(1, "등록", "날짜를 선택하세요.", true, null);
			}else if($("#note").val() == ''){
				makeAlert(1, "등록", "사유를 입력하세요.", true, null);
			}else {
				makeConfirm(1, "등록", "등록하시겠습니까?", true, function(){
					$("#formGeuntaeNo").val($(".dropbox").val());
					$("#formAddWorkTime").val($("#time_input_txt").val());
					$("#formNote").val($("#note").val());
					
					var params = $("#actionForm").serialize();
					
					$.ajax({
						type : "post",
						url : "HRAddWorkRegAjax",
						dataType : "json",
						data : params,
						success : function(result){
							if(result.errorCheck == 0){
								location.href = "HRAddWorkReg";
							}else {
								makeAlert(2, "등록", "등록에 실패했습니다.", true, null);
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
	
	function dropBox(){
		$.ajax({
			type : "post",
			url : "HRAddWorkGeuntaeListAjax",
			dataType : "json",
			success : function(result){
				dropBoxDraw(result.list);
			},
			error : function(request, status, error){
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}
	
	function dropBoxDraw(list){
		var html = "";
		
		for(var i = 0 ; i < list.length ; i++){
			html += "<option value=\""+ list[i].GEUNTAE_NO + "\">" + list[i].GEUNTAE_NAME + "</option>";
		}
		
		$(".dropbox").append(html);
	}
</script>
</head>
<body>

<form action="#" id="actionForm" method="post">
	<input type="hidden" name="fromEmpNo" value="${sEmpNo}">
	<input type="hidden" id="formGeuntaeNo" name="formGeuntaeNo">
	<input type="hidden" id="formAddWorkTime" name="formAddWorkTime">
	<input type="hidden" id="formDate" name="formDate">
	<input type="hidden" id="formNote" name="formNote">
</form>

<c:import url="/topLeft">
	<c:param name="topMenuNo" value="49"></c:param>
	<c:param name="leftMenuNo" value="71"></c:param>
	<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
</c:import>

<div class="content_area">
	<div class="content_nav">HeyWe &gt; 인사 &gt; 근태관리 &gt; 추가근무등록</div>
	<!-- 내용 영역 -->
	<div class="content_title">
     	<div class="content_title_text">추가근무등록</div>
	</div>
	<div class="content_box">
		<table id="addWork_table">
			<colgroup>
				<col width="200">
				<col width="300">
				<col width="200">
				<col width="300">
			</colgroup>
			<tr>
				<td class="attr_title">사원코드</td>
				<td>${sEmpNo}</td>
				<td class="attr_title">근태명</td>
				<td>
					<select class="dropbox">
						<option value="-1">선택</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="attr_title">근무시간</td>
				<td>
					<input type="text" placeholder="시간을 입력하세요" maxlength="2" id="time_input_txt">
				</td>
				<td class="attr_title">날짜</td>
				<td>
					<input type="text" placeholder="YYYY-MM-DD" readonly="readonly" id="date">
				</td>
				
			</tr>
			<tr>
				<td class="attr_title">사유</td>
				<td colspan="3">
					<input type="text" placeholder="사유를 입력하세요" id="note">
				</td>
			</tr>
		</table>
		
		<div class="btn_group">
			<input type="button" value="등록" id="ok_btn">
		</div>
	</div>
</div>
</body>
</html>
