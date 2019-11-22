<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 일정상세(제안)</title>
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/crm/sa_plan_cal_cru.css" />
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {

		$("#writeImg").on("click", function() {

			$("#dataForm").attr("action", "CRMMarkActivityUpdate")
			$("#dataForm").submit();

		});

		$("#backImg").on("click", function() {
			location.href = "CRMMarkActivityList"
		});

		$("#trashImg").on("click", function() {

			makeConfirm(1, "일정 삭제", "삭제하시겠습니까?", true, function() {
				MarkActivityDeleteAjax();
			});

		});

	})

	function MarkActivityDeleteAjax() {

		var params = $("#dataForm").serialize();

		$.ajax({
			type : "post",
			url : "MarkActivityDeleteAjax",
			dataType : "json",
			data : params,
			success : function(result) {

				location.href = "CRMMarkActivityList"
			},
			error : function(request, status, error) {
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
		<c:param name="leftMenuNo" value="19"></c:param>
		<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
	</c:import>

	<div class="content_area">
		<div class="content_nav">HeyWe &gt; CRM &gt; 영업 &gt; 영업활동 &gt;
			일정 &gt; 일정상세</div>
		<!-- 현재 메뉴 제목 -->
		<form action="#" id="dataForm" method="post">
			<input type="hidden" id="delop" name="delop" /> <input type="hidden"
				id="selectDate" name="selectDate" /> <input type="hidden"
				id="schno" name="schno" value="${param.schno}"> <input
				type="hidden" id="markNo" name="markNo" value="${param.markNo}">
			<input type="hidden" id="sNo" name="sNo" value="${sEmpNo}">
		</form>
		<div class="content_title">일정상세</div>
		<div class="title">
			<c:if test="${auth eq 3}">
			<img src="resources/images/erp/crm/write.png" id="writeImg" style="cursor: pointer" />
			</c:if>
			<img src="resources/images/erp/crm/back.png" id="backImg" style="cursor: pointer" />
			<img src="resources/images/erp/crm/trash.png" id="trashImg" style="cursor: pointer" />
		</div>
		<div id="hr_1">
			<hr />
		</div>
		<div class="crmInfo">
			<table border="1" cellspacing="0">
				<colgroup>
					<col width="220" />
					<col width="650" />
				</colgroup>
				<tbody>

					<tr>
						<td id="tdleft">일정명</td>
						<td id="tdright">${data.TITLE }</td>
					</tr>
					<tr>
						<td id="tdleft">영업명</td>
						<td id="tdright">${data.MNAME }</td>
					</tr>
					<tr>
						<td id="tdleft">활동분류</td>
						<td id="tdright">${data.ATNAME }</td>
					</tr>
					<tr>
						<td id="tdleft">진행단계</td>
						<td id="tdright">${data.PSNAME }</td>
					</tr>
					<tr>
						<td id="tdleft">시간</td>
						<td id="tdright">${data.START }~${data.END }</td>
					</tr>
					<tr>
						<td id="tdleft">활동내용</td>
						<td id="tdright">${data.ACTIVITY_CON }</td>
					</tr>

					<tr>
						<td id="tdleft">고객</td>
						<td id="tdright">${data.MNNAME }</td>
					</tr>
					<tr>
						<td id="tdleft">담당자</td>
						<td id="tdright">${data.ENAME }</td>
					</tr>

				</tbody>
			</table>
			<div id="hr_2">
				<hr />
			</div>

		</div>
	</div>
</body>
</html>