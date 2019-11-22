<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 영업제안 등록</title>
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/crm/sa_chance_r.css" />
<!-- calendar select css -->
<link rel="stylesheet" type="text/css"
	href="resources/css/jquery/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/common/calendar.css" />
<!-- calendar css -->
<link rel="stylesheet" type="text/css"
	href="resources/css/calendar/calendar.css" />
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
	
<!-- jQuery Script -->
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="resources/script/jquery/jquery-ui.min.js"></script>
<!-- calendar Script -->
<script type="text/javascript"
	src="resources/script/calendar/calendar.js"></script>
	<script type="text/javascript"
	src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript">
	$(document).ready(
			function() {
				
				$(".grey").css("background", "#D8D8D8");
				
				if ($("#page").val() == "") {
					$("#page").val("1");
				}
				$(".tdleftChance").css("background-color", "#c2e4f3");
				$(".tdleftOffer").css("background-color", "#76bbd9");
				$("#backImg").on("click", function() {
					makeConfirm(1, "제안 등록", "취소하시겠습니까?", true, function(){
					if ($("#flag").val() == "1") {
						history.back();
					} else {
						$("#dataForm").attr("action", "CRMMarkMgntOfferList");
						$("#dataForm").submit();
					}
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
									makeAlert(1, "", "제안날짜보다 미래로 설정하세요.", true, null);
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

				$("#writeImg").on("click", function() {
					makeConfirm(1, "제안 등록", "작성하시겠습니까?", true, function(){
					fileuploadU();
				});
			});
			});

	function offerWrite() {
		var params = $("#dataForm").serialize();
		
		$.ajax({
			type : "post",
			url : "updateMngntOfferAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				$("#markNo").val($(this).attr("name"));
				$("#dataForm").attr("action", "CRMMarkMgntOfferList");
				$("#dataForm").submit();
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + request.error);
			}
		});
	}
	
	//파일업로드
	function fileuploadU() {
		var fileForm = $("#fileForm");

		fileForm.ajaxForm({ //보내기전 validation check가 필요할경우 
			beforeSubmit : function() {

			},
			success : function(result) {
				if (result.result == "SUCCESS") {

					console.log(result.fileName[0]);
					$("#att").val(result.fileName[0]);

					offerWrite();
				} else {
					makeAlert(1, "확인", "첨부파일 저장 실패", false, null);
				}
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});

		fileForm.submit();
	}
	
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
		<div class="content_title">제안 등록</div>
		<div class="title">
			<img src="resources/images/erp/crm/write.png" id="writeImg"
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
							<td id="tdright">${dataMO.MANAME}</td>
						</tr>
						<tr>
							<td id="tdleft">고객사</td>
							<td id="tdright">${dataMO.CCNAME}</td>
						</tr>
						<tr>
							<td id="tdleft">고객</td>
							<td id="tdright">${dataMO.MNNAME}</td>
						</tr>
						<tr>
							<td id="tdleft">진행단계</td>
							<td id="tdright">${dataMO.PSENAME}</td>
						</tr>
						<tr>
							<td id="tdleft">진행상태</td>
							<td id="tdright">${dataMO.PSPNAME}</td>
						</tr>
						<tr>
							<td id="tdleft">사업유형</td>
							<td id="tdright">${dataMO.BTNAME}</td>
						</tr>
						<tr>
							<td id="tdleft">매출구분</td>
							<td id="tdright">${dataMO.SDNAME}</td>
						</tr>
						<tr>
							<td id="tdleft">매출구분상세</td>
							<td id="tdright">${dataMO.MASALES}</td>
						</tr>
						<tr>
							<td id="tdleft">담당자(자사)</td>
							<td id="tdright">${dataMO.EMNAME}</td>
						</tr>
						<tr>
							<td id="tdleft">비고</td>
							<td id="tdright">${dataMO.MANOTE}</td>
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
							<td id="tdright">${dataMO.CHDATE}</td>
						</tr>
						<tr>
							<td id="tdleft" class="tdleftChance">인지경로</td>
							<td id="tdright">${dataMO.RPNAME}</td>
						</tr>
					</tbody>
				</table>
			</div>
			<form action="#" id="dataForm" method="post">
				<input type="hidden" name="att" id="att" />
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
									id="offerCon"></td>
							</tr>
							<tr>
								<td id="tdleft" class="tdleftOffer">제안날짜 *</td>
								<td id="tdright"><input type="hidden" id="stdt" name="stdt"
									value="${stdt}" /> <input type="text" width="80px"
									title="제안날짜선택" id="date_start" name="date_start" value=""
									readonly="readonly" class="grey"/></td>
							</tr>
							<tr>
								<td id="tdleft" class="tdleftOffer">제안마감날짜 *</td>
								<td id="tdright"><input type="hidden" id="eddt" name="eddt"
									value="${eddt}" /> <input type="text" width="80px"
									title="제안마감날짜선택" id="date_end" name="date_end" value=""
									readonly="readonly" class="grey"/></td>
							</tr>
						</tbody>
					</table>
				</div>
				<input type="hidden" name="page" id="page" value="${page}">
				<input type="hidden" name="markNo" id="markNo"
					value="${param.markNo}" /> <input type="hidden" name="delOp"
					id="delOp"> <input type="hidden" name="sEmpNo" id="sEmpNo"
					value="${sEmpNo}" /> <input type="hidden" name="pseNo" id="pseNo"
					value="${dataMO.PROGRESS_STATE_NO}" /> <input type="hidden"
					name="flag" id="flag" value="${param.flag}" />
				<div id="drawop" class="drawop"></div>
				<div class="oppage" id="oppage"></div>
			</form>
			<form id="fileForm" name="fileForm" action="fileUploadAjax"
				method="post" enctype="multipart/form-data">
				<div id="upName">첨부자료</div>
				<div>
					<label for="attFile" id="uploard">업로드</label>
					<div class="filebox">
						<input type="file" name="attFile" id="attFile" class="attFile">
					</div>
				</div>
			</form>


			<div id="uploadFile">
				<table border=1 cellspacing="0">
					<tbody>
					<colgroup>
						<col width="870px">
					</colgroup>
					<tr id="tbtop">
						<td id="tdfile">파일명</td>
					</tr>
					<tr id="addfile"></tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>