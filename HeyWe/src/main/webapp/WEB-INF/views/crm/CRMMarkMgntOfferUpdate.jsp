<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 영업제안 상세</title>
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/crm/sa_chance_r.css" />
<!-- calendar select css -->
<link rel="stylesheet" type="text/css"
	href="resources/css/jquery/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/common/calendar.css" />
<style type="text/css">
	.ui-datepicker select.ui-datepicker-month {
	    width: 40%;
	    font-size: 11px;
	}
	.ui-datepicker select.ui-datepicker-year {
	    width: 48%;
	    font-size: 11px;
	}
</style>
	
<!-- calendar css -->
<link rel="stylesheet" type="text/css"
	href="resources/css/calendar/calendar.css" />
<!-- jQuery Script -->
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="resources/script/jquery/jquery-ui.min.js"></script>
<!-- calendar Script -->
<script type="text/javascript"
	src="resources/script/calendar/calendar.js"></script>
<script type="text/javascript">
	$(document).ready(
			function() {
				
				$(".grey").css("background", "#D8D8D8");
				
				$(".tdleftOffer").css("background-color", "#76bbd9");
				$(".chanceDiv").css("display", "");
				$(".tdleftChance").css("background-color", "#c2e4f3");

				 if($("#stdt").val()=="" || $("#stdt").val() == null) {
					$("#stdt").val($("#date_start").val());
				} 
				 if($("#eddt").val()=="" || $("#eddt").val() == null) {
					$("#eddt").val($("#date_end").val());
				} 
				
				$("#backImg").on("click", function() {
					makeConfirm(1, "제안 수정", "취소하시겠습니까?", true, function(){
					$("#dataForm").attr("action", "CRMMarkMgntOfferList");
					$("#dataForm").submit();
					});
				});

				$.datepicker.setDefaults({
					monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
					monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
					dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
					showMonthAfterYear:true,
					showOn: 'both',
					closeText: '닫기',
					changeYear: true,
					changeMonth: true,
					buttonImage: 'resources/images/calender.png',
					buttonImageOnly: true,
					dateFormat: 'yy/mm/dd',
					yearRange: '-100y:+0d'
				}); 

				$("#date_start").datepicker(
						{
							dateFormat : 'yy-mm-dd',
							duration : 200,
							onSelect : function(dateText, inst) {
								var startDate = parseInt($("#date_end").val()
										.replace("-", '').replace("-", ''));
								var endDate = parseInt(dateText.replace(/-/g,
										''));

								if (endDate > startDate) {
									makeAlert(1, "", "제안마감날짜보다 과거로 설정하세요.", true, null);
									$("#date_start").val($("#stdt").val());
								} else {
									$("#stdt").val($("#date_start").val());
								}
							}
						});

				$("#date_end").datepicker(
						{
							dateFormat : 'yy-mm-dd',
							duration : 200,
							onSelect : function(dateText, inst) {
								var startDate = parseInt($("#date_start").val()
										.replace("-", '').replace("-", ''));
								var endDate = parseInt(dateText.replace(/-/g,
										''));

								if (startDate > endDate) {
									makeAlert(1, "", "제안날짜보다 미래로 설정하세요.", true, null);
									$("#date_end").val($("#eddt").val());
								} else {
									$("#eddt").val($("#date_end").val());
								}
							}
						});

				$("#writeBtn").on(
						"click",
						function() {
							makeConfirm(1, "고객사 작성", "수정하시겠습니까?", true, function() {
								
							
							var params = $("#dataForm").serialize();
							console.log(params);
							$.ajax({
								type : "post",
								url : "updateMngntOfferAskAjax",
								dataType : "json",
								data : params,
								success : function(result) {
									$("#dataForm").attr("action",
											"CRMMarkMgntOfferAsk");
									$("#dataForm").submit();
								},
								error : function(request, status, error) {
									console.log("status : " + request.status);
									console.log("text : "
											+ request.responseText);
									console.log("error : " + request.error);
								}
							});
							});
						});

				$("#checkChance").on(
						"change",
						function() {
							if ($("input:checkbox[id='checkChance']").is(
									":checked") == true) {

							} else {
								$("").css("display", "none");
							}
						});

				$("#checkOffer").on(
						"change",
						function() {
							if ($("input:checkbox[id='checkOffer']").is(
									":checked") == true) {
								$(".offerDiv").css("display", "");
								$(".tdleftOffer").css("background-color",
										"#76bbd9");
							} else {
								$(".offerDiv").css("display", "none");
							}
						});
			});
</script>
</head>
<body>
	<c:import url="/topLeft">
		<c:param name="topMenuNo" value="17"></c:param>
		<c:param name="leftMenuNo" value="22"></c:param>
	</c:import>
	<div class="content_area">
		<div class="content_nav">HeyWe &gt; CRM &gt; 영업관리 &gt; 제안</div>
		<!-- 내용 영역 -->
		<div class="content_title">제안 수정</div>
		<div class="title">
			<img src="resources/images/erp/crm/write.png" id="writeBtn"
				style="cursor: pointer" /> <img
				src="resources/images/erp/crm/back.png" id="backImg"
				style="cursor: pointer" />
		</div>

		<div class="crmInfo">
			<div class="commonDiv">
				<table border="1" cellspacing="0">
					<colgroup>
						<col width="220" />
						<col width="650" />
					</colgroup>
					<tbody>
						<tr>
							<td id="tdleft">영업명</td>
							<td id="tdright">${dtl.MARK_NAME}</td>
						</tr>
						<tr>
							<td id="tdleft">고객사</td>
							<td id="tdright">${dtl.CSTM_NAME}</td>
						</tr>
						<tr>
							<td id="tdleft">고객</td>
							<td id="tdright">${dtl.MNGR_NAME}</td>
						</tr>
						<tr>
							<td id="tdleft">진행단계</td>
							<td id="tdright">${dtl.PROGRESS_STEP_NAME}</td>
						</tr>
						<tr>
							<td id="tdleft">진행상태</td>
							<td id="tdright">${dtl.PROGRESS_STATE_NAME}</td>
						</tr>
						<tr>
							<td id="tdleft">사업유형</td>
							<td id="tdright">${dtl.BSNS_NAME}</td>
						</tr>
						<tr>
							<td id="tdleft">매출구분</td>
							<td id="tdright">${dtl.SALES_DIV_NAME}</td>
						</tr>
						<tr>
							<td id="tdleft">매출구분상세</td>
							<td id="tdright">${dtl.SALES_DIV_DTL}</td>
						</tr>
						<tr>
							<td id="tdleft">담당자(자사)</td>
							<td id="tdright">${dtl.EMP_NAME}</td>
						</tr>
						<tr>
							<td id="tdleft">비고</td>
							<td id="tdright">${dtl.NOTE}</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="chanceDiv">
				<table border="1" cellspacing="0">
					<colgroup>
						<col width="220" />
						<col width="650" />
					</colgroup>
					<tbody>
						<tr>
							<td id="tdleft" class="tdleftChance">영업시작일</td>
							<td id="tdright">${dtl.START_DATE}</td>
						</tr>
						<tr>
							<td id="tdleft" class="tdleftChance">인지경로</td>
							<td id="tdright">${dtl.RECOG_NAME}</td>
						</tr>
					</tbody>
				</table>
			</div>
			<form action="#" id="dataForm" method="post">
				<div class="offerDiv">
					<table border="1" cellspacing="0">
						<colgroup>
							<col width="220" />
							<col width="650" />
						</colgroup>
						<tbody>

							<tr>
								<td id="tdleft" class="tdleftOffer">제안내용 *</td>
								<td id="tdright"><input type="text" name="offerCon"
									id="offerCon" value="${dtl2.OFFER_CON}"></td>
							</tr>
							<tr>
								<td id="tdleft" class="tdleftOffer">제안날짜 *</td>
								<td id="tdright"><input type="text" width="80px"
									title="제안날짜선택" id="date_start" name="date_start"
									value="${dtl2.OFF_OFFER_DATE}" readonly="readonly" class="grey"/></td>
							</tr>
							<tr>
								<td id="tdleft" class="tdleftOffer">제안마감날짜 *</td>
								<td id="tdright"><input type="text" width="80px"
									title="제안마감날짜선택" id="date_end" name="date_end"
									value="${dtl2.OFF_FINISH_DATE}" readonly="readonly" class="grey"/></td>
							</tr>
						</tbody>
					</table>
				</div>
				<input type="hidden" id="stdt" name="stdt" value="${stdt}" /> <input
					type="hidden" id="eddt" name="eddt" value="${eddt}" /> <input
					type="hidden" name="markNo" id="markNo" value="${param.markNo}" />
				<input type="hidden" name="sEmpNo" id="sEmpNo" value="${sEmpNo}" />
				<input type="hidden" name="pseNo" id="pseNo" value="${dtl.PROGRESS_STATE_NO}" />
			</form>
		</div>
	</div>
</body>
</html>