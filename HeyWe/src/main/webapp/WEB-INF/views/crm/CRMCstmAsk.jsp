<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 고객사</title>
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/common/main.css" />
<!-- jquery UI CSS -->
<link rel="stylesheet" type="text/css"
	href="resources/css/jquery/jquery-ui.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/crm/cu_customer_r.css" />
<style type="text/css">
</style>
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<!-- jquery UI JS -->
<script type="text/javascript"
	src="resources/script/jquery/jquery-ui.js"></script>
<script type="text/javascript">
	$(document).ready(
			function() {
				if ($("#page").val() == "") {
					$("#page").val("1");
				}
				$("#oppage").on("click", "input", function() {
					$("#page").val($(this).attr("name"));
					reloadList();
				});
				//jQuery Button
				$(".content_area input[type='button']").button();
				if ($("#page").val() == "") {
					$("#page").val("1");
				}
				reloadList();
				reloadAtt();
				$("#writeImg").on("click", function() {
					$("#dataForm").attr("action", "CRMCstmUpdate");
					$("#dataForm").submit();
				})
				$("#backImg").on("click", function() {
					location.href = "CRMCstm";
				})

				$("#writeBtn").on("click", function() {
					if ($.trim($("#opinion").val()) == "") {
						alert("의견을 입력하세요. ");
						$("#opinion").focus();
					} else {
						makeConfirm(1, "의견 작성", "작성하시겠습니까?", true, function() {
							opinionInsert();
							$("#opinion").val("");
							reloadList();
						});
					}
				})
				$(".contentList").on("click", "#trashBtn", function() {
					$("#delop").val($(this).attr("name"));
					makeConfirm(1, "의견 삭제", "삭제하시겠습니까?", true, function() {
						deleteOpinion();
					});
				});

				//등급히스토리
				$("body").on(
						"click",
						"#histBtn",
						function() {
							makeNoBtnPopup(1, "등급히스토리", Histpopup(), true, 650,
									300, function() {
										$("#HlistDiv").slimScroll({
											height : "150",
											axis : "both"
										});
										reloadHist();
									}, null);
						});

			});

	function deleteOpinion() {
		var params = $("#dataForm").serialize();

		$.ajax({

			type : "post",

			url : "CstmopnionDeleteAjax",

			dataType : "json",

			data : params,

			success : function(result) {
				reloadList();
			},
			error : function(request, status, error) {

				console.log("status : " + request.status);

				console.log("text : " + request.responseText);

				console.log("error : " + error);
			}
		});
	}

	function reloadList() {
		var params = $("#dataForm").serialize();
		$.ajax({
			type : "post",
			url : "CstmOpnion2Ajax",
			dataType : "json",
			data : params,
			success : function(result) {
				CstmOpnion(result.oplist);
				redrawOpinionpb(result.pb);
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
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
	}

	function CstmOpnion(opList) {

		var html = ""

		for (var i = 0; i < opList.length; i++) {
			html += "<div id=\"contentTop\">"
			html += "<div id=\"contentname\">" + opList[i].ENAME + "</div>"
			html += "<div id=\"contentday\">" + opList[i].REG_DATE + "</div>"
			if ('${sEmpNo}' == opList[i].EMP_NO) {
				html += "<img id=\"trashBtn\" src=\"resources/images/erp/crm/trash.png\" width=\"15px\" height=\"15px\" style=\"cursor:pointer\" id=\"trashBtn\" name=\""+opList[i].CSTM_OPINION_NO+"\">"
			}
			html += "</div><div id=\"contentBottom\">" + opList[i].CON
					+ "</div><hr />"
		}

		$(".contentList").html(html);

	}
	function opinionInsert() {
		var params = $("#dataForm").serialize();

		$.ajax({

			type : "post",

			url : "CstmOpnionInsertAjax",

			dataType : "json",

			data : params,

			success : function(result) {
				reloadList();
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
			url : "CstmAttAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				redrawAtt(result.cstmAtt);
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}

	function redrawAtt(cstmAtt) {
		var html = "";
		html += "<colgroup><col width=\"870px\"></colgroup><tr id=\"tbtop\"><td id=\"tdfile\">파일명</td></tr>";
		if (cstmAtt.length != 0) {
			html += "<tr><td id =\"tbMiddle\" name=\"${cstmAtt[0].CSTM_ATT_FILE_NO}\">";
			html += "<a href=\"resources/upload/${cstmAtt[0].FILE_NAME}\" download>${cstmAtt[0].FILE_NAME.substring(20)}</a>";
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
	
	//첨부파일 삭제
	function deleteAttFile() {
		var params = $("#dataForm").serialize();
		$.ajax({
			type : "post",
			url : "deleteCstmAttFileAjax",
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
	
	//등급히스토리 팝업
	function reloadHist() {
		var params = $("#dataForm").serialize();
		$.ajax({
			type : "post",
			url : "CRMCstmHistAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				redrawHist(result.dataC);
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}

	function redrawHist(dataC) {
		var html = "";
		if (dataC.length == 0) {
			html += "<tr><th colspan='5'>등급히스토리가 존재하지 않습니다.</th></tr>";
		} else {
			for (var i = 0; i < dataC.length; i++) {
				html += "<tr>";
				html += "<th>" + dataC[i].CNAME + "</th>";
				html += "<th>" + dataC[i].ENAME + "</th>";
				html += "<th>" + dataC[i].CGNAME + "</th>";
				html += "<th>" + dataC[i].GUPCON + "</th>";
				html += "<th>" + dataC[i].GHDATE + "</th>";
				html += "</tr>";
			}
		}

		$("#drawList tbody").html(html);
	}

	function Histpopup() {
		var html = "";
		html += "<div class=\"histListdiv\">";
		html += "<table class=\"histListTop\">";
		html += "<colgroup>";
		html += "<col width=\"110px\">";
		html += "<col width=\"110px\">";
		html += "<col width=\"110px\">";
		html += "<col width=\"110px\">";
		html += "<col width=\"110px\">";
		html += "</colgroup>";
		html += "<tr>";
		html += "<th>고객사명</th>";
		html += "<th>담당자명</th>";
		html += "<th>등급</th>";
		html += "<th>변경내용</th>";
		html += "<th>변경날짜</th>";
		html += "</tr>";
		html += "</table>";
		html += "<div id=\"HlistDiv\">"
		html += "<table id=\"drawList\">";
		html += "<colgroup>";
		html += "<col width=\"110px\">";
		html += "<col width=\"110px\">";
		html += "<col width=\"110px\">";
		html += "<col width=\"110px\">";
		html += "<col width=\"110px\">";
		html += "</colgroup>";
		html += "<tbody>";
		html += "</tbody>";
		html += "</table>";
		html += "</div>";
		html += "</div>";
		return html;
	}
</script>
</head>
<body>

	<c:import url="/topLeft">
		<c:param name="topMenuNo" value="17"></c:param>
		<c:param name="leftMenuNo" value="31"></c:param>
		<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
   <c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
	</c:import>

	<div class="content_area">
		<div class="content_nav">HeyWe &gt; CRM &gt; 고객 &gt; 고객사 &gt;
			고객사 상세</div>
		<!-- 내용 영역 -->
		<div class="content_title">고객사 상세</div>
		<div class="title">
			<img src="resources/images/erp/crm/write.png" id="writeImg"
				style="cursor: pointer" /> <img
				src="resources/images/erp/crm/back.png" id="backImg"
				style="cursor: pointer" />
		</div>
		<div>
			<input type="button" value="고객사히스토리" id="histBtn"
				class="ui-button ui-corner-all ui-widget" role="button">
		</div>
		<form action="#" id="dataForm" method="post">
			<input type="hidden" id="EMP_NO" name="EMP_NO" value="${data.EMP }" />
			<input type="hidden" id="attdeleteNo" name="attdeleteNo"  />
			<input type="hidden" name="page" id="page" value="${page}"> <input
				type="hidden" id="delop" name="delop" /> <input type="hidden"
				id="cstmgrade" name="cstmgrade" value="${data.GRADENAME }" /> <input
				type="hidden" id="cstmno" name="cstmno" value="${param.cstmno}">
			<input type="hidden" id="sNo" name="sNo" value="${sEmpNo}"> <input
				type="hidden" name="cNo" id="cNo" />

			<div class="crmInfo">
				<table border="1" cellspacing="0">
					<colgroup>
						<col width="220" />
						<col width="650" />
					</colgroup>
					<tbody>
						<tr>
							<td id="tdleft">고객사 명</td>
							<td id="td_1"><a>${data.CSTMNAME }</a></td>
						</tr>
						<tr>
							<td id="tdleft">구분</td>
							<td id="td_1">${data.CDNAME }</td>
						</tr>
						<tr>
							<td id="tdleft">등급</td>
							<td id="td_1">${data.GRADENAME }</td>
						</tr>
						<tr>
							<td id="tdleft">진행상태</td>
							<td id="td_1">진행중</td>
						</tr>
						<tr>
							<td id="tdleft">사업자번호</td>
							<td id="td_1">${data.BSNS_NO }</td>
						</tr>
						<tr>
							<td id="tdleft">대표번호</td>
							<td id="td_1">${data.RPSTN_NO }</td>
						</tr>
						<tr>
							<td id="tdleft">팩스번호</td>
							<td id="td_1">${data.FAW_NO }</td>
						</tr>
						<tr>
							<td id="tdleft">웹사이트</td>
							<td id="td_1"><a>${data.WEB }</a></td>
						</tr>
						<tr>
							<td id="tdleft">주소</td>
							<td id="td_1">${data.ADDR }&nbsp${data.ADDR_DTL}</td>
						</tr>
						<tr>
							<td id="tdleft">담당자</td>
							<td id="td_1">${data.ENAME }</td>
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
						<input type="text" id="opinion" name="opinion">
					</div>
					<div id="talk2">
						<input type="button" value="입력" id="writeBtn">
					</div>
					<div class="contentList"></div>
					<div class="oppage" id="oppage"></div>
				</div>
			</div>
		</form>
	</div>

</body>
</html>