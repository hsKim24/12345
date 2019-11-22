<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 담당자수정</title>
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/crm/cu_manager_u.css" />
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		reloadAtt();
		$("#backImg").on("click", function() {
			makeConfirm(1, "담당자 수정", "취소하시겠습니까?", true, function() {
				$("#dataForm").attr("action", "CRMMngrAsk")
				$("#dataForm").submit();
			});
		});
		$("#attFile").on("change", function() {
			var html = "";
			html += "<td>" + $("#attFile").val() + "</td>"

			$("#addfile").html(html);

		})

		$("#writeImg").on("click", function() {
			if ($.trim($("#txtmngr").val()) == "") {
				makeAlert(1, "", "고객을 입력하세요.", true, null);
			} else if ($.trim($("#txt_1").val()) == "") {
				makeAlert(1, "", "고객사를 선택하세요.", true, null);
			} else if ($.trim($("#txtmobile").val()) == "") {
				makeAlert(1, "", "휴대번호를 입력하세요.", true, null);
			} else if ($.trim($("#txtemail").val()) == "") {
				makeAlert(1, "", "이메일을 입력하세요.", true, null);
			} else if ($.trim($("#txt_2").val()) == "") {
				makeAlert(1, "", "담당자를 선택하세요.", true, null);
			} else {
				makeConfirm(1, "담당자 수정", "수정하시겠습니까?", true, function() {
					fileuploadU();
					updatemngr();
				});
			}
		});
		$("#cstmBtn").on("click", function() {
			makePopup(1, "고객사조회", cstmPopup(), true, 700, 386, function() {
				$("#listDiv").slimScroll({
					height : "170px",
					axis : "both"
				});
				drawClist();
				$("#search_btn").on("click", function() {
					drawClist();
				});
				$("#search_cstm").keyup(function(event) {
					if (event.keyCode == '13') {
						drawClist();
					}
				});
			}, "확인", function() {
				closePopup(1);
				reloadcstm();
			});
		});
		$("#empBtn").on("click", function() {
			makePopup(1, "사원조회", empPopup(), true, 700, 386, function() {
				$("#listDiv").slimScroll({
					height : "170px",
					axis : "both"
				});
				drawElist();
				$("#search_btn").on("click", function() {
					drawElist();
				});
				$("#search_txt").keyup(function(event) {
					if (event.keyCode == '13') {
						drawElist();
					}
				});
			}, "확인", function() {
				closePopup(1);
				reloademp();
			});
		});
	});

	//아작스

	function reloadAtt() {
		var params = $("#dataForm").serialize();
		$.ajax({
			type : "post",
			url : "MngrUpdateAttAjax",
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

	function reloademp() {
		var params = $("#dataForm").serialize();
		$.ajax({
			type : "post",
			url : "reloadempAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				$("#txt_2").val(result.selectemp.EMP_NAME);
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}

	function reloadcstm() {
		var params = $("#dataForm").serialize();
		$.ajax({
			type : "post",
			url : "reloadcstmAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				$("#txt_1").val(result.selectcstm.NAME);
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}
	function updatemngr() {
		
		
		var params = $("#dataForm").serialize();
		$.ajax({
			type : "post",
			url : "MngrUpdateAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				$("#dataForm").attr("action", "CRMMngrAsk")
				$("#dataForm").submit();
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}

	//함수
	function redrawAtt(mngrAtt) {
		var html = "";
		html += "<colgroup><col width=\"870px\"></colgroup><tr id=\"tbtop\"><td id=\"tdfile\">파일명</td></tr>";
		if (mngrAtt.length != 0) {
			for (i = 0; i < mngrAtt.length; i++) {
				html += "<tr><td id =\"tbMiddle\">" + mngrAtt[i].FILE_NAME
						+ "</td></tr>";
			}
		} else {
			html += "<tr><td id =\"tbMiddle\">첨부자료가 없습니다.</td></tr>";
		}
		$("#att").html(html);
	}

	function empPopup() {
		var html = "";

		html += "<div id=\"search\">";
		html += "<input type=\"text\" placeholder=\"이름을 입력해주세요\" id=\"search_txt\" name=\"search_txt\">";
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

	function cstmPopup() {
		var html = "";

		html += "<div id=\"search\">";
		html += "<input type=\"text\" placeholder=\"고객사명을 입력해주세요\" id=\"search_cstm\" name=\"search_cstm\">";
		html += "<input type=\"button\" value=\"조회\" id=\"search_btn\">";
		html += "</div>";
		html += "<div id=\"list\">";
		html += "<table id=\"listTop\">";
		html += "<colgroup>";
		html += "<col width=\"630px\">";
		html += "</colgroup>";
		html += "<tr id=\"cstmtr\">";
		html += "<th>고객사명</th>";
		html += "</tr>";
		html += "</table>";
		html += "<div id=\"listDiv\">";
		html += "<table id=\"listCon\">";
		html += "<colgroup>";
		html += "<col width=\"630px\">";
		html += "</colgroup>";
		html += "<tbody>";
		html += "</tbody>";
		html += "</table>";
		html += "</div>";
		html += "</div>";

		return html;
	}

	function drawCstmSearchList(list) {
		var html = "";
		if (list.length == 0) {
			html += "<tr><td colspan=\"2\">검색결과가 없습니다</td></tr>";
		} else {
			for (var i = 0; i < list.length; i++) {
				html += "<tr name=\""+ list[i].CRM_CSTM_NO + "\">";
				html += "<td>" + list[i].NAME + "</td>"
				html += "</tr>"
			}
		}
		$("#listCon tbody").html(html);
		$("#listCon").on("click", "tr", function() {
			$(this).parent().children().css("background", "white");
			$(this).css("background", "#B0DAEC");
			$("#selectcstm").val($(this).attr("name"));
			$("#cstm_no").val($("#selectcstm").val());
		});
	}

	function drawEmpSearchList(list) {
		var html = "";

		if (list.length == 0) {
			html += "<tr><td colspan=\"2\">검색결과가 없습니다</td></tr>";
		} else {
			for (var i = 0; i < list.length; i++) {
				html += "<tr name=\""+ list[i].EMP_NO + "\">";
				html += "<td>" + list[i].DEPT_NAME + "</td>"
				html += "<td>" + list[i].NAME + "</td>"
				html += "</tr>"
			}
		}

		$("#listCon tbody").html(html);

		$("#listCon").on("click", "tr", function() {
			$(this).parent().children().css("background", "white");
			$(this).css("background", "#B0DAEC");
			$("#selectemp").val($(this).attr("name"));
			$("#emp_no").val($("#selectemp").val());
		});
	}
	function drawClist() {
		$("#cstmsearchtxt").val($.trim($("#search_cstm").val()));
		var params = $("#dataForm").serialize();
		$.ajax({
			type : "post",
			url : "cstmSearchAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				drawCstmSearchList(result.list);
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}
	function drawElist() {
		$("#empsearchtxt").val($.trim($("#search_txt").val()));
		var params = $("#dataForm").serialize();
		$.ajax({
			type : "post",
			url : "empSearchAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				drawEmpSearchList(result.list);
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}

	//파일업로드
	function fileuploadU() {
		var fileForm = $("#fileForm");
		fileForm.ajaxForm({ //보내기전 validation check가 필요할경우 
			beforeSubmit : function(data, frm, opt) {
			}, //submit이후의 처리 
			success : function(responseText, statusText) {
			}, //ajax error
			error : function() {
				alert("에러발생!!");
			}
		});

		fileForm.submit();
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
			담당자 수정</div>
		<!-- 내용 영역 -->
		<div class="content_title">담당자 수정</div>
		<div class="title">
			<img src="resources/images/erp/crm/write.png" id="writeImg"
				style="cursor: pointer" /> <img
				src="resources/images/erp/crm/back.png" id="backImg"
				style="cursor: pointer" />
		</div>
		<div class="crmInfo">
			<form action="#" method="post" id="dataForm">
				<table border="1" cellspacing="0">
					<colgroup>
						<col width="220" />
						<col width="650" />
					</colgroup>
					<tbody>
						<tr>
							<td id="tdleft">담당자(고객사) *</td>
							<td id="tdright"><input type="text" class="txt" id="txtmngr"
								value="${mngrUpdate.MNGR_NAME}" name="mngr_name"></td>
						</tr>
						<tr>
							<td id="tdleft">고객사 *</td>
							<td id="tdright"><input type="text" id="txt_1" class="grey"
								readonly="readonly" name="cstm_name"
								value="${mngrUpdate.CSTM_NAME}"> <input type="hidden"
								id="cstm_no" name="cstm_no" value="${mngrUpdate.CSTM_NO}" />
								<input type="button" value="조회" id="cstmBtn" /></td>
						</tr>
						<tr>
							<td id="tdleft">부서</td>
							<td id="tdright"><input type="text" class="txt" id="txt"
								value="${mngrUpdate.MNGR_DEPT}" name="mngr_dept"></td>
						</tr>
						<tr>
							<td id="tdleft">직책</td>
							<td id="tdright"><input type="text" class="txt" id="txt"
								value="${mngrUpdate.MNGR_DUTY}" name="mngr_duty"></td>
						</tr>
						<tr>
							<td id="tdleft">휴대번호 *</td>
							<td id="tdright"><input type="text" class="txt"
								id="txtmobile" value="${mngrUpdate.MNGR_MOBILE}"
								name="mngr_mobile"></td>
						</tr>
						<tr>
							<td id="tdleft">유선번호</td>
							<td id="tdright"><input type="text" class="txt"
								id="txtphone" value="${mngrUpdate.MNGR_PHONE}" name="mngr_phone"></td>
						</tr>
						<tr>
							<td id="tdleft">이메일 *</td>
							<td id="tdright"><input type="text" class="txt"
								id="txtemail" name="mngr_email" value="${mngrUpdate.MNGR_EMAIL}"></td>
						</tr>
						<tr>
							<td id="tdleft">담당자 *</td>
							<td id="tdright"><input type="text" id="txt_2"
								readonly="readonly" class="grey" value="${mngrUpdate.EMP_NAME}">
								<input type="button" value="조회" id="empBtn" /> <input
								type="hidden" id="emp_no" name="emp_no"
								value="${mngrUpdate.EMP_NO}" /></td>
						</tr>
					</tbody>
				</table>
				<input type="hidden" name="mngrNo" value="${param.mngrNo}" /> <input
					type="hidden" name="empsearchtxt" id="empsearchtxt" /> <input
					type="hidden" name="selectemp" id="selectemp" /> <input
					type="hidden" name="cstmsearchtxt" id="cstmsearchtxt" /> <input
					type="hidden" name="selectcstm" id="selectcstm" />
			</form>
			<div id="hr_2"></div>
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
			<%-- <div id="uploadFile">
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
			</div> --%>
		</div>
	</div>
</body>
</html>