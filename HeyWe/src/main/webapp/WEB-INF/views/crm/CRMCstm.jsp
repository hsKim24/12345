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
	href="resources/css/erp/crm/cu_customer.css" />
<link rel="stylesheet" type="text/css"
	href="resources/css/jquery/jquery-ui.css" />
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
	src="resources/script/jquery/jquery-ui.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		if ($("#page").val() == "") {
			$("#page").val("1");
		}
		if ($("#check2").val() == "") {
			$("#check2").val("888");
		}
		reloadList();
		reloadDept();
		reloadEmp();

		$("#writeImg").on("click", function() {
			location.href = "CRMCstmWrite"
		})

		$("#searchImg").on("click", function() {

			$("#page").val("1");

			reloadList();

		});

		$("#sel").on("change", function() {
			$("#check").val($(this).val());
			if ($("#check").val() == 999) {
				$("#check2").val(888);
			}
			reloadEmp();
		});
		$("#sel2").on("change", function() {
			$("#check2").val($(this).val());
		});
		$(".pageBtn").on("click", "input", function() { // 페이징 영역

			$("#page").val($(this).attr("name"));

			reloadList();

		});
	})

	function reloadList() {
		var params = $("#dataForm").serialize();

		$.ajax({

			type : "post",

			url : "CRMCstm2Ajax",

			dataType : "json",

			data : params,

			success : function(result) {
				CRMCstm2List(result.list);
				redrawPaging(result.pb);
			},
			error : function(request, status, error) {

				console.log("status : " + request.status);

				console.log("text : " + request.responseText);

				console.log("error : " + error);
			}
		});
	}

	function CRMCstm2List(list) {

		var html = "";

		for (var i = 0; i < list.length; i++) {
			html += "<div class=\"block\" name=\""  + list[i].CRM_CSTM_NO + "\"><div class=\"block_Bottom\"><div class=\"block_Bottom_1\">"
			html += "<div class=\"block_Bottom_1_1\"><strong>" + list[i].NAME
					+ "</strong></div>"
			html += "<div class=\"block_Bottom_1_2\">" + list[i].ADDR
					+ "</div></div>"
			html += "<div class=\"block_Bottom_2\">"
			html += "<div class=\"block_Bottom_2_1\"><strong>등급 :</strong> "
					+ list[i].GRADENAME + "</div>"
			html += "<div class=\"block_Bottom_2_2\"><strong>대표번호 : </strong> "
					+ list[i].BSNS_NO + "</div></div>"
			html += "<div class=\"block_Bottom_3\"><img src=\"resources/images/erp/common/user.png\">"
			html += "<div class=\"userImg\">" + list[i].DEPT_NAME + " | "
					+ list[i].ENAME + " </div></div></div>"
			html += "<div class=\"block_Top\">영업기회 <strong>(0)</strong>"
			html += "| 영업활동 <strong>(1)</strong> | 견적 <strong>(3)</strong>| 계약 <strong>(0)</strong></div></div>"

		}

		if (list.length == 0) {
			html += "<div id = \"NoCnt\"> 조회된 결과가 없습니다. </div>"
		}

		$(".blocklist").html(html);

		$(".block").on("click", function() {
			console.log("aaa");
			$("#cstmno").val($(this).attr("name"));

			$("#dataForm").attr("action", "CRMCstmAsk");
			$("#dataForm").submit();
		});
	}

	function redrawPaging(pb) {

		var html = "";

		if ($("#page").val() == "1") {
			/* html += "<div class="pageBtn_1" >◀</div>" */
			html += "<input type=\"button\" id=\"pagetest\" value=\"<\" name=\"1\" />";

		} else {

			html += "<input type=\"button\" id=\"pagetest\" value=\"<\" name=\""

					+ ($("#page").val() * 1 - 1) + "\" />";

		}

		for (var i = pb.startPcount; i <= pb.endPcount; i++) {

			if (i == $("#page").val()) {

				html += "<input type=\"button\" id=\"pagetest\" value=\"" + i + "\" name=\""  + i + "\" disabled=\"disabled\" />";

			} else {

				html += "<input type=\"button\"id=\"pagetest\" value=\"" + i + "\" name=\"" + i + "\" />";

			}

		}

		if ($("#page").val() == pb.maxPcount) {

			html += "<input type=\"button\" id=\"pagetest\" value=\">\" name=\""
					+ pb.maxPcount + "\" />";

		} else {

			html += "<input type=\"button\" id=\"pagetest\" value=\">\" name=\""

					+ ($("#page").val() * 1 + 1) + "\" />";

		}

		$(".pageBtn").html(html);
		$(".pageBtn input[type='button']").button();
	}
	function reloadDept() {
		var params = $("#dataForm").serialize();
		$.ajax({
			type : "post",
			url : "CRMMngr2Ajax",
			dataType : "json",
			data : params,
			success : function(result) {
				redrawDept(result.dept);
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}

	function reloadEmp() {
		var params = $("#dataForm").serialize();
		$.ajax({
			type : "post",
			url : "CRMEmpAjax",
			dataType : "json",
			data : params,
			success : function(result) {
				redrawEmp(result.emp);
			},
			error : function(request, status, error) {
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	}

	function redrawDept(dept) {
		var html = "";
		html += "<option value=\"999\">부서(전체)</option>"
		for (var i = 0; i < dept.length; i++) {
			html += "<option value=\""+ dept[i].DEPT_NO +"\">"
					+ dept[i].DEPT_NAME + "</option>"
		}
		$("#sel").html(html)
	}

	function redrawEmp(emp) {
		var html = "";
		html += "<option value=\"888\">사원(전체)</option>"
		for (var i = 0; i < emp.length; i++) {
			html += "<option value="+ emp[i].EMP_NO +">" + emp[i].NAME
					+ "</option>"
		}
		$("#sel2").html(html)
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
		<div class="content_nav">HeyWe &gt; CRM &gt; 고객 &gt; 고객사</div>

		<!-- 내용 영역 -->
		<div class="content_title">
			고객사 <img src="resources/images/erp/crm/write.png" id="writeImg"
				style="cursor: pointer" />
		</div>

		<form action="#" id="dataForm" method="post">
			<input type="hidden" id="check" name="check"> <input
				type="hidden" id="check2" name="check2"> <input
				type="hidden" id="cstmno" name="cstmno"> <input
				type="hidden" id="page" name="page" value="${param.page}" />
			<div class="mok">
				<div class="search">
					<div class="search_top">
						<input type="text" id="txt_top" name="searchTxt"
							placeholder="고객사 명을 입력해주세요."> <select class="SelBox_1"
							name="GRADE">
							<option value="10">등급(전체)</option>
							<option value="0">S등급</option>
							<option value="1">A등급</option>
							<option value="2">B등급</option>
							<option value="3">C등급</option>
							<option value="4">D등급</option>
						</select>
					</div>

					<div>
						<select class="SelBox" id="sel" name="sel">
						</select> <select class="SelBox_1" id="sel2" name="sel2">
						</select> <img src="resources/images/erp/crm/search.png" id="searchImg"
							style="cursor: pointer">
					</div>


				</div>
				<hr id="hr_1" />

			</div>


			<div class="blocklist"></div>
		</form>
		<div class="pageBtn"></div>
	</div>
</body>
</html>