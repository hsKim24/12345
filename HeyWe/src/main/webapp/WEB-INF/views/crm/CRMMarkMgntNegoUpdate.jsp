<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 영업협상 상세</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/crm/sa_chance_r.css" />
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#backImg").on("click", function(){
		makeConfirm(1, "협상 수정", "취소하시겠습니까?", true, function(){
		$("#dataForm").attr("action", "CRMMarkMgntNegoAsk");
		$("#dataForm").submit();
		});
	});
	$("#writeBtn").on("click", function(){
			if($.trim($("#sply").val()) == ""){
				makeAlert(1, "", "공급가액을 입력하세요.", true, null);
				}
			else if($.trim($("#surtax").val()) == ""){
				makeAlert(1, "", "부가세여부를 입력하세요.", true, null);
				}
			else{
				makeConfirm(1, "협상 수정", "수정하시겠습니까?", true, function(){
				updateNego();
				});
			}
	});
});

// 아작스
function updateNego(){
	var params = $("#dataForm").serialize(); 
	$.ajax({
		type : "post",
		url : "updateNegoAjax",
		dataType : "json",
		data : params,
		success : function(result){
			$("#dataForm").attr("action", "CRMMarkMgntNegoAsk");
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
	<c:param name="leftMenuNo" value="23"></c:param>
</c:import>
	<div class="content_area">
		<div class="content_nav">HeyWe &gt; CRM &gt; 영업관리 &gt; 협상</div>
		<!-- 내용 영역 -->
		<div class="content_title">협상 수정</div> 
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
			<form action="#" id="dataForm" method="post">
			<div class="negoDiv">
				<table border="1" cellspacing="0"> 
				<colgroup>
					<col width="220" />
					<col width="650" />
				</colgroup>
					<tbody>
						<tr>
						<td class="tdleftNego">공급가액 *</td>
						<td id="tdright"><input type="text" id="sply" name="sply" value="${dtl.SPLY}"/></td>
					</tr>
					<tr>
						<td class="tdleftNego">부가세여부 *</td>
						<td id="tdright"><input type="text" id="surtax" name="surtax" value="${dtl.SURTAX_WHETHER}"/></td>
					</tr>
					</tbody>
				</table>
			</div>
			<input type="hidden" name="sEmpNo" value="${sEmpNo}"/>
			<input type="hidden" name="pseNo" value="${dtl.PROGRESS_STATE_NO}"/>
			<input type="hidden" name="markNo" id="markNo" value="${param.markNo}"/>
			</form>
		</div>
	</div>
</body>
</html>