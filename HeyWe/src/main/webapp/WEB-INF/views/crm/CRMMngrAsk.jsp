<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 담당자 상세페이지</title>
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/crm/cu_manager_r.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/jquery/jquery-ui.css" />
<style type="text/css">
</style>
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="resources/script/jquery/jquery-ui.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		if ($("#page").val() == "") {
			$("#page").val("1");
		}
		reloadOpinion();
		reloadAtt()
		$("#backImg").on("click", function() {
			$("#dataForm").attr("action", "CRMMngr");
			$("#dataForm").submit();
		});
		$("#writeImg").on("click", function() {
			$("#dataForm").attr("action", "CRMMngrUpdate")
			$("#dataForm").submit();
		});
		$("#drawop").on("click", "#trashBtn", function() {
			$("#delOp").val($(this).attr("name"));
			makeConfirm(1, "의견 삭제", "삭제하시겠습니까?", true, function() {
				deleteOpinion();
			});
		});

		$("#writeBtn").on("click", function() {
			if ($.trim($("#txtWrite").val()) == "") {
				makeAlert(1, "", "내용을 입력하세요.", true, null);
			} else {
				makeConfirm(1, "의견 작성", "작성하시겠습니까?", true, function() {
					insertOpinion();
					$("#txtWrite").val("");

				});
			}
		});
		$("#oppage").on("click", "input", function() {
			$("#page").val($(this).attr("name"));
			reloadOpinion();
		});
	});

	//아작스
	function reloadOpinion() {
		var params = $("#dataForm").serialize();
		$.ajax({
			type : "post",
			url : "MngrOpinionAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				redrawOpinion(result.opinion);
				redrawOpinionpb(result.pb);
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}

	function insertOpinion() {
		var params = $("#dataForm").serialize();
		$.ajax({
			type : "post",
			url : "MngrinsertOpinionAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				reloadOpinion();
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}

	function deleteOpinion() {
		var params = $("#dataForm").serialize();
		$.ajax({
			type : "post",
			url : "MngrdeleteOpinionAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				reloadOpinion();
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}

	function deleteAttFile() {
		var params = $("#dataForm").serialize();
		$.ajax({
			type : "post",
			url : "deleteAttFileAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				reloadAtt();
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}

	function reloadAtt() {
		var params = $("#dataForm").serialize();
		$.ajax({
			type : "post",
			url : "MngrAttAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				redrawAtt(result.mngrAtt);
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}
	//함수
	function redrawOpinion(opinion) {
		var html = "";
		if (opinion.length != 0) {
			for (var i = 0; i < opinion.length; i++) {
				html += "<div class=\"contentList\"><div id=\"contentTop\"><div id=\"contentname\">"
						+ opinion[i].EMP_NAME + "</div>";
				html += "<div id=\"contentday\">" + opinion[i].REG_DATE;

				if ('${sEmpNo}' == opinion[i].EMP_NO) {
					html += "<img src=\"resources/images/erp/crm/trash.png\" width=\"15px\" height=\"15px\" style=\"cursor:pointer\" id=\"trashBtn\" name ="+ opinion[i].MNGR_OPINION_NO +" />";
				}

				html += "</div></div><div id=\"contentBottom\">"
						+ opinion[i].CON + "</div></div>";
			}
		} else {
			html += "<div id=\"div1\">의견이 없습니다.</div>"
		}
		$("#drawop").html(html);
	}

	function redrawOpinionpb(pb) {
		var html = "";

		if ($("#page").val() == "1") {
			html += "<input type=\"button\" class =\"preBtn\"value=\"◀\"name=\"1\"/>";
		} else {
			html += "<input type=\"button\" class =\"preBtn\"value=\"◀\"name=\""
					+ ($("#page").val() * 1 - 1) + "\" />";
		}

		for (var i = pb.startPcount; i <= pb.endPcount; i++) {
			if (i == $("#page").val()) {
				html += "<input type=\"button\" class =\"numberBtn\" value=\""+ i + "\" disabled=\"disabled\" />";
			} else {
				html += "<input type=\"button\" class =\"numberBtn\" value=\"" + i + "\"name=\"" + i + "\" />";
			}
		}

		if ($("#page").val() == pb.maxPcount) {
			html += "<input type=\"button\" class =\"nextBtn\"value=\"▶\" name=\"" + pb.maxPcount + "\" />";
		} else {
			html += "<input type=\"button\" class =\"nextBtn\" value=\"▶\"name=\""
					+ ($("#page").val() * 1 + 1) + "\" />";
		}

		$("#oppage").html(html);
		$(".oppage input[type='button']").button();
	}
	function redrawAtt(mngrAtt) {
		var html = "";
		html += "<colgroup><col width=\"870px\"></colgroup><tr id=\"tbtop\"><td id=\"tdfile\">파일명</td></tr>";
		if (mngrAtt.length != 0) {
			html += "<tr><td id =\"tbMiddle\" name=\"${mngrAtt[0].MNGR_NO}\">";
			html += "<a href=\"resources/upload/${mngrAtt[0].FILE_NAME}\" download>${mngrAtt[0].FILE_NAME.substring(20)}</a>";
			html += "&nbsp&nbsp<input type=\"button\" id=\"attdelete\" value=\"삭제\"/>";
			html += "</td></tr>";

		} else {
			html += "<tr><td id =\"tbMiddle\">첨부자료가 없습니다.</td></tr>";
		}
		$("#att").html(html);
		$("#attdelete").on("click", function() {
			$("#attdeleteNo").val($(this).parent().attr("name"));

			makeConfirm(1, "첨부파일 삭제", "해당 첨부파일을 삭제하시겠습니까?", true, function() {
				deleteAttFile();
			});
		});
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
		<div class="content_nav">HeyWe &gt; CRM &gt; 고객 &gt; 담당자 &gt;
			담당자 상세</div>
		<!-- 내용 영역 -->
		<div class="content_title">담당자 상세</div>
		<div class="title">
			<img src="resources/images/erp/crm/write.png" id="writeImg"
				style="cursor: pointer" /> <img
				src="resources/images/erp/crm/back.png" id="backImg"
				style="cursor: pointer" />
		</div>

		<!-- form -->
		<form id="dataForm" method="post" action="#">
			<input type="hidden" value="${param.mngrNo}" name="mngrNo"> <input
				type="hidden" value="${sEmpNo}" name="sEmpNo"> <input
				type="hidden" name="delOp" id="delOp"> <input type="hidden"
				name="attdeleteNo" id="attdeleteNo"> <input type="hidden"
				name="page" id="page" value="${page}">
			<div class="crmInfo">
				<table border="1" cellspacing="0">
					<colgroup>
						<col width="220" />
						<col width="650" />
					</colgroup>
					<tbody>
						<tr>
							<td id="tdleft">담당자(고객사)</td>
							<td id="td_1">${mngr.MNGR_NAME}</td>
						</tr>
						<tr>
							<td id="tdleft">고객사</td>
							<td id="td_1">${mngr.CSTM_NAME}</td>
						</tr>
						<tr>
							<td id="tdleft">부서</td>
							<td id="td_1">${mngr.MNGR_DEPT}</td>
						</tr>
						<tr>
							<td id="tdleft">직책</td>
							<td id="td_1">${mngr.MNGR_DUTY}</td>
						</tr>
						<tr>
							<td id="tdleft">휴대번호</td>
							<td id="td_1">${mngr.MNGR_MOBILE}</td>
						</tr>
						<tr>
							<td id="tdleft">유선번호</td>
							<td id="td_1">${mngr.MNGR_PHONE}</td>
						</tr>
						<tr>
							<td id="tdleft">이메일</td>
							<td id="td_1">${mngr.MNGR_EMAIL}</td>
						</tr>
						<tr>
							<td id="tdleft">담당자 주소 및 위치</td>
							<td id="td_1">${mngr.CSTM_ADDR}${mngr.CSTM_ADDR_DTL}</td>
						</tr>
						<tr>
							<td id="tdleft">담당자</td>
							<td id="td_1">${mngr.EMP_NAME}</td>
						</tr>
					</tbody>
				</table>
				<div id="hr_2"></div>
				<div id="upName">첨부자료</div>
				<div id="uploadFile">
					<table border=1 cellspacing="0">
						<tbody id="att">
						</tbody>
					</table>
				</div>
				<div id="upName_1">의견</div>
				<div class="talk">
					<div id="talk1">
						<input type="text" id="txtWrite" name="txtWrite">
					</div>
					<div id="talk2">
						<input type="button" value="입력" id="writeBtn">
					</div>
					<div class="drawop" id="drawop"></div>
					<div class="oppage" id="oppage"></div>
				</div>
			</div>
		</form>
	</div>
</body>
</html>