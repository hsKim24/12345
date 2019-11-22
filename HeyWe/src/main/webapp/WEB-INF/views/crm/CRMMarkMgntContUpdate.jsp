<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 영업계약 등록</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/crm/sa_chance_r.css" />
<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css" href="resources/css/common/calendar.css" />
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
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	 
	$(".grey").css("background", "#D8D8D8");
	
	$("#backImg").on("click", function(){
		makeConfirm(1, "계약 수정", "취소하시겠습니까?", true, function(){
			$("#dataForm").attr("action", "CRMMarkMgntContAsk");
			$("#dataForm").submit();
		});
	});
	$("#writeBtn").on("click", function(){
		if($.trim($("#contcon").val()) == ""){
			makeAlert(1, "", "계약내용을 입력하세요.", true, null);
			}
		else if($.trim($("#cont_date").val()) == ""){
			makeAlert(1, "", "계약일을 선택하세요.", true, null);
			}
		else if($.trim($("#cont_date_start").val()) == ""){
			makeAlert(1, "", "계약시작일을 선택하세요.", true, null);
			}
		else if($.trim($("#cont_date_end").val()) == ""){
			makeAlert(1, "", "계약종료일을 선택하세요.", true, null);
			}
		else if($.trim($("#amt").val()) == ""){
			makeAlert(1, "", "계약금을 입력하세요.", true, null);
			}
		else if($.trim($("#surtax").val()) == ""){
			makeAlert(1, "", "부가세여부를 입력하세요.", true, null);
			}
		else if($.trim($("#pay").val()) == ""){
			makeAlert(1, "", "대금지급조건을 입력하세요.", true, null);
			}
		else if($.trim($("#date_end").val()) == ""){
			makeAlert(1, "", "하자보증기간을 선택하세요.", true, null);
			}
		else{
			makeConfirm(1, "계약 수정", "수정하시겠습니까?", true, function(){
				updateCont();
			});
		}
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
	$("#cont_date").datepicker({
		dateFormat : 'yy-mm-dd',
		duration: 200
	});
	$("#cont_date_start").datepicker({
		dateFormat : 'yy-mm-dd',
		duration: 200
	});
	$("#cont_date_end").datepicker({
		dateFormat : 'yy-mm-dd',
		duration: 200
	});
	$("#date_end").datepicker({
		dateFormat : 'yy-mm-dd',
		duration: 200
	});
	$("#refresh1").on("click", function(){
		$("#cont_date").val("");
	});
	$("#refresh2").on("click", function(){
		$("#cont_date_start").val("");
	});
	$("#refresh3").on("click", function(){
		$("#cont_date_end").val("");
	});
	$("#refresh4").on("click", function(){
		$("#date_end").val("");
	});
});

function updateCont(){
	var params = $("#dataForm").serialize(); 
	$.ajax({
		type : "post",
		url : "updateContAjax",
		dataType : "json",
		data : params,
		success : function(result){
			$("#dataForm").attr("action", "CRMMarkMgntContAsk");
			$("#dataForm").submit();
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
<c:import url="/topLeft">
	<c:param name="topMenuNo" value="17"></c:param>
	<c:param name="leftMenuNo" value="24"></c:param>
</c:import>
	<div class="content_area">
		<div class="content_nav">HeyWe &gt; CRM &gt; 영업관리 &gt; 계약</div>
		<div class="content_title">계약 수정</div>
		<div class="title">
			<img src="resources/images/erp/crm/write.png" id="writeBtn" style="cursor:pointer"/>
			<img src="resources/images/erp/crm/back.png" id="backImg" style="cursor:pointer"/>
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
							<td class="tdleftChance">영업시작일</td>
							<td id="tdright">${dtl.START_DATE}</td>
						</tr>
						<tr>
							<td class="tdleftChance">인지경로</td>
							<td id="tdright">${dtl.RECOG_PATH_NAME}</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="offerDiv">
				<table border="1" cellspacing="0"> 
				<colgroup>
					<col width="220" />
					<col width="650" />
				</colgroup>
					<tbody>
						<tr>
						<td class="tdleftOffer">제안내용</td>
						<td id="tdright">${dtl.OFFER_CON}</td>
					</tr>
					<tr>
						<td class="tdleftOffer">제안날짜</td>
						<td id="tdright">${dtl.OFF_OFFER_DATE}</td>
					</tr>
					<tr>
						<td class="tdleftOffer">제안마감날짜</td>
						<td id="tdright">${dtl.OFF_FINISH_DATE}</td>
					</tr>
					</tbody>
				</table>
			</div>
			<div class="negoDiv">
				<table border="1" cellspacing="0"> 
				<colgroup>
					<col width="220" />
					<col width="650" />
				</colgroup>
					<tbody>
						<tr>
						<td class="tdleftNego">공급가액</td>
						<td id="tdright">${dtl.SPLY_AMT}</td>
					</tr>
					<tr>
						<td class="tdleftNego">부가세여부</td>
						<td id="tdright">${dtl.NE_SURTAX_WHETHER}</td>
					</tr>
					</tbody>
				</table>
			</div>
			<form action="#" id="dataForm" method="post">
			<div class="contDiv">
				<table border="1" cellspacing="0"> 
				<colgroup>
					<col width="220" />
					<col width="650" />
				</colgroup>
					<tbody>
						<tr>
							<td class="tdleftCont">계약내용 *</td>
							<td id="tdright"><input type="text" id="contcon" name="cont_con" value="${dtl.CON}"/></td>
						</tr>
						<tr>
							<td class="tdleftCont">계약일 *</td>
							<td id="tdright">
								<input type="text" id="cont_date" name="cont_date" value="${dtl.CONT_DATE}" readonly="readonly" class="grey"/>
								<input type="button" id="refresh1" value="날짜 초기화">
							</td>
						</tr>
						<tr>
							<td class="tdleftCont">계약시작일 *</td>
							<td id="tdright">
								<input type="text" id="cont_date_start" name="cont_date_start" value="${dtl.CON_START_DATE}" readonly="readonly" class="grey"/>
								<input type="button" id="refresh2" value="날짜 초기화">
							</td>
						</tr>
						<tr>
							<td class="tdleftCont">계약종료일 *</td>
							<td id="tdright">
								<input type="text" id="cont_date_end" name="cont_date_end" value="${dtl.CON_FINISH_DATE}" readonly="readonly" class="grey"	/>
								<input type="button" id="refresh3" value="날짜 초기화">
							</td>
						</tr>
						<tr>
							<td class="tdleftCont">계약금 *</td>
							<td id="tdright"><input type="text" id="amt" value="${dtl.CON_AMT}" name="amt"/></td>
						</tr>
						<tr>
							<td class="tdleftCont">부가세 여부 *</td>
							<td id="tdright"><input type="text" id="surtax" name="surtax" value="${dtl.CON_SURTAX_WHETHER}" /></td>
						</tr>
						<tr>
							<td class="tdleftCont">대금지급조건 *</td>
							<td id="tdright"><input type="text" id="pay" name="pay" value="${dtl.CON_PAY_PROV_COND}" /></td>
						</tr>
						<tr>
							<td class="tdleftCont">하자보증기간 *</td>
							<td id="tdright">
								<input type="text" id="date_end" name="date_end" value="${dtl.FLAW_ASSUR_DATE}" readonly="readonly" class="grey"/>
								<input type="button" id="refresh4" value="날짜 초기화">
							</td>
						</tr>
						
					</tbody>
				</table>
			</div>
			<input type="hidden" name="markNo" id="markNo" value="${param.markNo}"/>
			<input type="hidden" name="sEmpNo" id="sEmpNo" value="${sEmpNo}"/>
			<input type="hidden" name="pseNo" id="pseNo" value="${dtl.PROGRESS_STATE_NO}"/>
			</form>
		</div>
	</div>
</body>
</html>