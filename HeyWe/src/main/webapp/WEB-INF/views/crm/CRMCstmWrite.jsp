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
<link rel="stylesheet" type="text/css"
	href="resources/css/erp/crm/cu_customer_c.css" />

<style type="text/css">
/* 
	DarkBlue : rgb(19, 64, 116), #134074
	DeepLightBlue : rgb(141, 169, 196), #8DA9C4
	LightBlue : rgb(222,230,239), #DEE6EF
	White : rgb(255,255,255), #FFFFFF
 */
</style>
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>

<script type="text/javascript"
	src="resources/script/jquery/jquery.form.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
	$(document).ready(function() {

		$(".grey").css("background", "#D8D8D8");
		
		reloadList();
		$("#attFile").on("change", function() {
			var html = "";

			html += "<td>" + $("#attFile").val() + "</td>"

			$("#addfile").html(html);
		})
		$("#writeImg").on("click", function() {
			//작성 내용에 스크립트 동작을 막겠다.
			if ($.trim($("#Cstm_Name").val()) == "") {
				makeAlert(1, "", "고객사명을 입력하세요.", true, null);
				$("#Cstm_Name").focus();
			} else if ($.trim($("#selectemp").val()) == "") {
				makeAlert(1, "", "담당자명을 선택하세요.", true, null);
				$("#selectemp").focus();
			} else {
				makeConfirm(1, "고객사 작성", "작성하시겠습니까?", true, function() {
					fileuploadU();
				})
			}
		});


		$("#backImg").on("click", function() {
			location.href = "CRMCstm";
		})

		$("#empBtn").on("click", function() {
			makePopup(1, "담당자 조회", empPopup(), true, 700, 386, function() {
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
	function reloademp() {
		var params = $("#dataForm").serialize();
		$.ajax({
			type : "post",
			url : "reloadempAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				$("#emp").val(result.selectemp.EMP_NAME);
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
			url : "crmEmpSearchAjax",
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

	function reloadList() {
		/* 		var params = $("#dataForm").serialize(); */

		$.ajax({

			type : "post",

			url : "CstmDiv2Ajax",

			dataType : "json",

			/* 			data : params,  */

			success : function(result) {
				CstmDiv(result.Div);
				CstmGrade(result.Grade);
				ProgressState(result.State);
			},
			error : function(request, status, error) {

				console.log("status : " + request.status);

				console.log("text : " + request.responseText);

				console.log("error : " + error);
			}
		});
	}
	function CRMCstmWrite() {
		var params = $("#dataForm").serialize();

		$.ajax({

			type : "post",

			url : "CRMCstmWrite2Ajax",

			dataType : "json",

			data : params,

			success : function(result) {
				location.href = "CRMCstm"
			},
			error : function(request, status, error) {

				console.log("status : " + request.status);

				console.log("text : " + request.responseText);

				console.log("error : " + error);
			}
		});
	}

	function CstmDiv(Div) {

		var html = ""

		for (var i = 0; i < Div.length; i++) {

			html += "<option value=\""+Div[i].CSTM_DIV_NO + "\">"
					+ Div[i].DIVNAME + "</option>"

		}

		$("#Cstm_Div").html(html);

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
	function CstmGrade(Grade) {

		var html = ""

		for (var i = 0; i < Grade.length; i++) {

			html += "<option value=\""+Grade[i].CSTM_GRADE_NO + "\">"
					+ Grade[i].NAME + "</option>"

		}

		$("#Cstm_Grade").html(html);

	}
	function ProgressState(State) {

		var html = ""

		for (var i = 0; i < State.length; i++) {

			html += "<option value=\""+State[i].PROGRESS_STATE_NO + "\">"
					+ State[i].NAME + "</option>"

		}

		$("#Progress_State").html(html);

	}
	function sample4_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var roadAddr = data.roadAddress; // 도로명 주소 변수
						var extraRoadAddr = ''; // 참고 항목 변수

						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
							extraRoadAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraRoadAddr += (extraRoadAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if (extraRoadAddr !== '') {
							extraRoadAddr = ' (' + extraRoadAddr + ')';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample4_postcode').value = data.zonecode;
						document.getElementById("sample4_roadAddress").value = roadAddr;

						// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
						if (roadAddr !== '') {
							document.getElementById("sample4_extraAddress").value = extraRoadAddr;
						} else {
							document.getElementById("sample4_extraAddress").value = '';
						}

						var guideTextBox = document.getElementById("guide");
						// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
						if (data.autoRoadAddress) {
							var expRoadAddr = data.autoRoadAddress
									+ extraRoadAddr;
							guideTextBox.innerHTML = '(예상 도로명 주소 : '
									+ expRoadAddr + ')';
							guideTextBox.style.display = 'block';

						} else if (data.autoJibunAddress) {
							var expJibunAddr = data.autoJibunAddress;
							guideTextBox.innerHTML = '(예상 지번 주소 : '
									+ expJibunAddr + ')';
							guideTextBox.style.display = 'block';
						} else {
							guideTextBox.innerHTML = '';
							guideTextBox.style.display = 'none';
						}
					}
				}).open();
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

					CRMCstmWrite();
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
		<c:param name="leftMenuNo" value="31"></c:param>
		<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
	</c:import>
	<div class="content_area">
		<div class="content_nav">HeyWe &gt; CRM &gt; 고객 &gt; 고객사 &gt;
			고객사 작성</div>
		<!-- 내용 영역 -->
		<div class="content_title">고객사 작성</div>
		<div class="title">
			<img src="resources/images/erp/crm/write.png" id="writeImg"
				style="cursor: pointer" /> <img
				src="resources/images/erp/crm/back.png" id="backImg"
				style="cursor: pointer" />
		</div>
		<div class="crmInfo">
			<form action="#" id="dataForm" method="post">
				<input type="hidden" name="att" id="att" /> <input type="hidden"
					name="empsearchtxt" id="empsearchtxt" /> <input type="hidden"
					name="selectemp" id="selectemp" /> <input type="hidden"
					name="cstmsearchtxt" id="cstmsearchtxt" /> <input type="hidden"
					name="selectcstm" id="selectcstm" />
				<table border="1" cellspacing="0">
					<colgroup>
						<col width="220" />
						<col width="650" />
					</colgroup>
					<tbody>
						<tr>
							<td id="tdleft">고객사 <strong>*</strong></td>
							<td id="tdright"><input type="text" id="Cstm_Name"
								name="Cstm_Name" ></td>
							<!--txt  -->
						</tr>
						<tr>
							<td id="tdleft">구분 <strong>*</strong></td>
							<td id="tdright"><select id="Cstm_Div" name="Cstm_Div">

							</select></td>
						</tr>

						<tr>
							<td id="tdleft">등급</td>
							<td id="tdright"><select id="Cstm_Grade" name="Cstm_Grade">

							</select></td>
						</tr>
						
						<tr>
							<td id="tdleft">사업자번호</td>
							<td id="tdright"><input type="text" id="Bsns_No"
								name="Bsns_No"></td>
						</tr>
						<tr>
							<td id="tdleft">대표번호</td>
							<td id="tdright"><input type="text" id="Rpstn_No"
								name="Rpstn_No"></td>
						</tr>
						<tr>
							<td id="tdleft">팩스번호</td>
							<td id="tdright"><input type="text" id="Faw_No"
								name="Faw_No"></td>
						</tr>
						<tr>
							<td id="tdleft">웹사이트</td>
							<td id="tdright"><input type="text" id="Web" name="Web"></td>
						</tr>
						<tr id=tr_1>
							<td id="tdleft">주소</td>
							<td id="tdright_2"><input type="text" id="sample4_postcode"
								name="post" placeholder="우편번호" readonly="readonly" class="grey"> <input type="button"
								onclick="sample4_execDaumPostcode()" value="우편번호 찾기"
								id="postBtn"><br> <input type="text"
								id="sample4_roadAddress" placeholder="도로명주소" name="Addr2" readonly="readonly" class="grey" >
								<span id="guide" style="color: #999; display: none"></span> <br />
								<input type="text" id="sample4_detailAddress" placeholder="상세주소"
								name="AddrDtl" 	> <input type="hidden"
								id="sample4_extraAddress" placeholder="참고항목"></td>
						</tr>
						<tr>
							<td id="tdleft">담당자 *</td>
							<td id="tdright2"><input type="text" id="emp" name="Emp_No" readonly="readonly" class="grey"/>
								<input type="button" value="선택" id="empBtn" /></td>
						</tr>
					</tbody>
				</table>
				<div id="hr_2"></div>
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