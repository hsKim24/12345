<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 결재라인 관리</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/gw/ea/gwApvLineMngt.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/gw/ea/gwApvLineSelectPopup.css" />

<script type="text/javascript"src="resources/script/jquery/jquery.slimscroll.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script> <!-- 메뉴에 필요함 -->
<script type="text/javascript">
$(document).ready(function() {
	reloadSavedApvLineList();
	reloadOrgList();
	reloadEmpList();
	
	$(".stored_line_list_table").slimScroll({
		height: "90%",
		width: "100%",
		axis: "both"
	});
	$(".orgArea").slimScroll({
		axis: "both"
	});
	$(".empListArea > div").slimScroll({
		width: "100%",
		height: "100%",
		axis: "both"
	});
	
	//조직도 부서 클릭
	$(document).on("click", ".dept", function() {
		var b;
		var sr;
		if($(this).closest("div").find("div").attr("hidden") == "hidden"){	//조직도 부서클릭 오픈 시
			b = false;
			sr = "resources/images/erp/gw/ea/folder.png"
			$("#deptNo").val($(this).attr("name"));
			reloadEmpList();
		} else {
			b = true;
			sr = "resources/images/erp/gw/ea/folderOff.png"
		}
		
		$(this).find("img").attr("src", sr); 						//this는 span이고 div가 감싸고 있음
		$(this).closest("div").find("div").attr("hidden", b); 		//closest : 가장 가까운 상위 요소
																	//find : 모든 하위요소
	});
	//HeyWe 클릭
	$(".orgArea>span").on("click", function() {
		$("#deptNo").val("");
		reloadEmpList();
	});
																	
	//사원 검색버튼
	$("#searchBtn").on("click", function() {
		$("#empName").val($("#empNameTxt").val());
		reloadEmpList();
		$("#empName").val("");
		$("#empNameTxt").val("");
	});
	$("#empNameTxt").on("keypress", function() {
		if(event.which == "13"){
			$("#searchBtn").click();
		}
	});
	
	// cAll 전체 체크박스 컨트롤
	$("#cAll").on("click", function() {
		console.log("name='cBox'인 체크박스 갯수 : " + $("input:checkbox[name='cBox']").length);			//name='cBox'인 체크박스 갯수
		console.log("선택된 체크박스 갯수 : " + $("input:checkbox[name='cBox']:checked").length);							//선택된 체크박스 갯수
		
		var b = $(this).is(":checked");
		
		$("input:checkbox[name='cBox']").each(function() {
			this.checked = b;
		});
	});
	//개별체크
	$(".empListArea").on("click", "tr", function() {
		var c = $(this).find("input[type='checkbox']");
		if(c.prop("checked") == true){
			c.prop("checked", false);
		} else {
			c.prop("checked", true);
		}
	});
	
	//결재자 추가 버튼
	$("#addApverBtn").on("click", function() {
		var html ="";
		
		if(($("#except input").length + $("input:checkbox[name='cBox']:checked").length) <= 5) {
		
			$("input:checkbox[name='cBox']:checked").each(function() {
				//선택된 결재자를 사원목록에서 제외시키기 위해 controller에서 선택된 결재자들을 배열로 받아줄 것임 
				var exceptEmpNo = "";
				exceptEmpNo = "<input type=\"hidden\" name=\"exceptEmpNo\" value=\""+ $(this).parents("tr").attr("name") + "\" />";
				$("#except").append(exceptEmpNo);
				
				//선택된 결재자를 결재자 목록에 추가
				var empInfo = ""; 
				empInfo += "[" + $(this).parents("tr").children("td").eq(1).text() + "]"
				empInfo += "&nbsp;" + $(this).parents("tr").children("td").eq(3).text() 
				empInfo += "&nbsp;" + $(this).parents("tr").children("td").eq(2).text();
							 
				
				html += "<div name=\"" + $(this).parents("tr").attr("name") + "\">";
				html += 	"<div class=\"apvLeft\"><span>" + empInfo + "</span></div>" 
				html += 	"<div class=\"apvRight\"><input type=\"button\" value=\"삭제\" /></div>";
				html += "</div>";
				
				console.log($(this).parents("tr").attr("name"));	//사원번호
				console.log($(this).parents("tr").children("td").eq(1).text());	//부서명
				console.log($(this).parents("tr").children("td").eq(2).text());	//직급명
				console.log($(this).parents("tr").children("td").eq(3).text());	//사원명
				
			});
		
			console.log("결재라인 지정된 결재자 수 : " + $("#except input").length);
			
			reloadEmpList();
			
			$(".c_list").append(html);
			
		} else {
			makeAlert(1, "확인", "결재자는 5명을 초과할 수 없습니다.", false, null);
		}
	});
	// 결재자 삭제
	$(".c_list").on("click", "input", function() {
		var empNo = $(this).parent("div").parent("div").attr("name");
		$("input[name='exceptEmpNo']").each(function() {
			if($(this).val() == empNo){
				$(this).remove();
			}	
		});
		
		$(this).parent("div").parent("div").remove();
		reloadEmpList();
	});
	
	//현재 결재라인 저장 버튼 클릭시
	$("#saveCurApvLineBtn").on("click", function() {
		if($("#except input").length == 0){
			return;
		}
		
		if($("#apvLineCnt").val() >= 15){
			makeAlert(2, "확인", "저장할 수 있는 결재라인은 최대 15개 입니다.", true, null);
			return;
		}
		
		//
		var html="";
		html += "<div><br/>&emsp;다음 결재라인 명으로 등록합니다.</div>"
		html += "<div><br/>&emsp;<input size=\"30\" maxlength=\"15\" type=\"text\" id=\"apvLineName\" placeholder=\"결재라인명\" /></div>"
		
		makePopup(1, "결재라인명 지정", html, true, 300, 200, null, "등록", 
			function() {
				if(checkEmpty("#apvLineName")){
					makeAlert(2, "확인", "결재자명을 입력해주세요.", true, function() {
						$("#apvLineName").focus();
					});
				} else {
					
					$("#newApvLineName").val($("#apvLineName").val());
					
					var params = $("#dataForm").serialize();
					
					$.ajax({
						type: "post",
						url: "GWSaveNewApvLineAjax",
						dataType: "json",
						data: params,
						success: function(result) {
							reloadSavedApvLineList();
							closePopup(1);
							makeAlert(2, "확인", "등록 되었습니다.", true, null);
						},
						error: function(request, status, error) {
							console.log("status: " + request.status);
							console.log("text: " + request.responseText);
							console.log("error: " + error);
						}
					}); 
				}
			}
		);
	});
	
	//저장 결재라인 해당 결재라인 삭제
	$(".stored_line_list_table tbody").on("click", "input", function() {
		$("#delApvLineNo").val($(this).closest("td").closest("tr").attr("name"));
		
		makeConfirm(1, "결재라인 삭제", "\"" + $(this).closest("td").closest("tr").children("td").eq(0).text() + "\" 삭제하시겠습니까?", true, 
			function() {
				var params = $("#dataForm").serialize();
				
				$.ajax({
					type: "post",
					url: "GWDelApvLineAjax",
					dataType: "json",
					data: params,
					success: function(result) {
						reloadSavedApvLineList();
						makeAlert(2, "확인", "삭제되었습니다.", true, null);
					},
					error: function(request, status, error) {
						console.log("status: " + request.status);
						console.log("text: " + request.responseText);
						console.log("error: " + error);
					}
				}); 
			}		
		);
		
	});
});

function reloadSavedApvLineList() {
	$.ajax({
		type: "post",
		url: "GWSavedApvLineListAjax",
		dataType: "json",
		success: function(result) {
			redrawSavedApvLineList(result.sApvLineNames, result.sApvLineList);
			$("#apvLineCnt").val(result.cnt);
		},
		error: function(request, status, error) {
			console.log("status: " + request.status);
			console.log("text: " + request.responseText);
			console.log("error: " + error);
		}
	});  
}

function redrawSavedApvLineList(sApvLineNames, sApvLineList) {
	var html = "";

	if(sApvLineNames == null){
		html += "<tr><td colspan=\"3\"> 저장된 결재라인이 없습니다. </td></tr>";	
	} else {
		for(var i=0; i<sApvLineNames.length; i++){
			html +=	"<tr ";
			if(i%2 == 1){
				html +=	"class=\"row_even\"";
			}
			html +=	"name=\"" + sApvLineNames[i].SAVE_APV_LINE_NO + "\">";
			html +=		"<td>" + sApvLineNames[i].SAVE_APV_LINE_NAME + "</td>";
			html +=		"<td>"
			for(var j=0; j<sApvLineList.length; j++){
				if(sApvLineNames[i].SAVE_APV_LINE_NO == sApvLineList[j].SAVE_APV_LINE_NO){
					html += "[";
					html += sApvLineList[j].DEPT_NAME;
					html += "]" + sApvLineList[j].NAME + "&nbsp;" + sApvLineList[j].POSI_NAME + "&emsp;&emsp;&emsp;";
				}
			}
			html +=		"</td>";
			html +=		"<td><input type=\"button\" id=\"delApvLineBtn\" value=\"삭제\"></td>";
			html +=	"</tr>";
		}
	}
	
	$(".stored_line_list_table tbody").html(html);
}

function reloadOrgList() {
	//var params = $("#dataForm").serialize();
	
	$.ajax({
		type: "post",
		url: "GWorgListAjax",
		dataType: "json",
	//	data: params,
		success: function(result) {
			redrawOrgList(result.deptList, result.empList);
		},
		error: function(request, status, error) {
			console.log("status: " + request.status);
			console.log("text: " + request.responseText);
			console.log("error: " + error);
		}
	}); 
}

function redrawOrgList(deptList, empList){
	var html = "";
	
	for(var i = 0; i < empList.length; i++){
		if(empList[i].DEPT_NO == null){
			html += "<div>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"emp\" name=\"" + empList[i].EMP_NO + "\">"
				 + "<img alt=\"user\" src=\"resources/images/erp/common/user.png\">" 
				 + "<span>&nbsp;" + empList[i].NAME + "&nbsp;" + empList[i].POSI_NAME + "</span></span></div>";
		}
	}
	
	for(var i = 0; i < deptList.length; i++){
		html += "<div>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"dept\" name=\"" + deptList[i].DEPT_NO + "\">"
				+ "<img alt=\"folder\" src=\"resources/images/erp/gw/ea/folderOff.png\">" + deptList[i].DEPT_NAME + "</span>"; 
		
		for(var j = 0; j < empList.length; j++){
			if(deptList[i].DEPT_NO == empList[j].DEPT_NO){
				html += "<div hidden=\"hidden\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
						+ "<span class=\"emp\" name=\"" + empList[j].EMP_NO + "\">"
						+ "<img alt=\"user\" src=\"resources/images/erp/common/user.png\">"
						+ "<span>&nbsp;" + empList[j].NAME + "&nbsp;" + empList[j].POSI_NAME + "</span></span></div>";
			}
		}
		
		html += "</div>";
	}
	
	$(".orgList").html(html);
}

//사원 목록
function reloadEmpList() {
	var params = $("#dataForm").serialize();
	
	$.ajax({
		type: "post",
		url: "GWempListAjax",
		dataType: "json",
		data: params,
		success: function(result) {
			redrawEmpList(result.empList);
		},
		error: function(request, status, error) {
			console.log("status: " + request.status);
			console.log("text: " + request.responseText);
			console.log("error: " + error);
		}
	}); 
}

function redrawEmpList(empList){
	var html = "";
	
	for(var i = 0; i < empList.length; i++){
		html +=	"<tr ";
		if(i%2 == 1){ //0번째가 표시될 때는 홀수 번째이므로
			html += "class=\"row_even\"";
		}
		html +=	"name=\"" + empList[i].EMP_NO + "\">";
		html +=		"<td onclick=\"event.cancelBubble = true;\"><input type=\"checkbox\" id=\"c" + i + "\" name=\"cBox\" /></td>";
		html +=	"<td deptNo=\"" + empList[i].DEPT_NO + "\">" + empList[i].DEPT_NAME + "</td>";
		html +=		"<td posiNo=\"" + empList[i].POSI_NO + "\">" + empList[i].POSI_NAME + "</td>";
		html +=		"<td>" + empList[i].NAME + "</td>";
		html +=	"</tr>";
	}
	
	$(".empList tbody").html(html);
}

</script>
</head>
<body>
<form action="#" id="dataForm" method="post">
	<input type="hidden" id="deptNo" name="deptNo" />
	<input type="hidden" id="empName" name="empName" />
	<div id="except"></div>
	<input type="hidden" id="apvLineCnt" name="apvLineCnt" />
	<input type="hidden" id="newApvLineName" name="newApvLineName" />
	<input type="hidden" id="apverEmpNo" name="apverEmpNo" />
	<input type="hidden" id="delApvLineNo" name="delApvLineNo" />
</form>

<c:import url="/topLeft">
	<c:param name="topMenuNo" value="2"></c:param>
	<c:param name="leftMenuNo" value="6"></c:param>
</c:import>
<div class="content_area">
	<div class="content_nav">HeyWe &gt; 그룹웨어 &gt; 전자결재 &gt; 결재라인 관리</div>
	<div class="content_title">결재라인 관리</div>
	<div class="confirmation_line_management">
		<div class="stored_line_list">
			<div class="stored_line_list_title">저장된 결재라인 목록</div>
			<div class="stored_line_list_table_header">
				<table>
					<colgroup>
						<col width=250px>
						<col width=700px>
						<col width=50px>
					</colgroup>
					<thead>
						<tr>
							<th>결재라인명</th>
							<th colspan="2">결재자</th>
						</tr>
					</thead>
				</table>
			</div>
			<div class="stored_line_list_table">
				<table>
					<colgroup>
						<col width=250px>
						<col width=700px>
						<col width=50px>
					</colgroup>
					<tbody>		<!-- 저장된 결재라인 목록 -->
					</tbody>
				</table>
			</div>
		</div>
		<div class="line_store_remove">
			<div class="line_store_remove_title">결재라인 저장, 삭제</div>
			<div class="line_store_remove_contents">
				<div class="orgAreaWrap">
				<div class="orgArea">
					<span><img alt="folder" src="resources/images/erp/gw/ea/folder.png">HeyWe</span><br/>
					<div class="orgList"></div> <!-- 리스트 뿌려주는 곳 --> 
				</div>
				</div>
				<div class="mid">
					<div class="mid_top">
						<div class="searchImg">
							<img alt="search" src="resources/images/erp/gw/ea/search.png" />
						</div>
						<div class="searchBar">
							<input type="text" id="empNameTxt" placeholder="사원명" />
						</div>
						<input type="button" id="searchBtn" value="검색" />
					</div>
					<div class="empListAreaHeader">
						<table>
							<thead>
								<tr>
									<th width="30px"><input type="checkbox" id="cAll" /></th>
									<th width="120px">부서</th>
									<th width="120px">직급(직책)</th>
									<th width="150px">사원명</th>
								</tr>
							</thead>
						</table>
					</div>
					<div class="empListArea">
						<div>
						<table class="empList">
							<colgroup>
								<col width=30px>
								<col width=120px>
								<col width=120px>
								<col width=150px>
							</colgroup>
							<tbody>		<!-- 사원 목록 -->
							</tbody>
						</table>
						</div>
					</div>
				</div>
				<div class="right">
					<div class="right_title">결재자</div>
					<div class="c_list"></div>
				</div>
			</div>
			<div class="line_store_remove_bot">
				<input type="button" id="addApverBtn" value="결재자 추가"> <input type="button" id="saveCurApvLineBtn" value="현재 결재라인 저장하기">
			</div>
		</div>
	</div>
</div>

</body>
</html>