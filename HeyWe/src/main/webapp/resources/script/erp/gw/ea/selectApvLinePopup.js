/** 
 * GWApvUpdate, GWNewApvWrite 의 결재라인 지정 팝업
 */

function makeSelectApvLinePopup() {

	var html = "";
	html += 	"<div class=\"mid_left\">";
	html += 		"<div class=\"directSelectArea\">" ;
	html +=				"<div>";
	html +=					"결재라인&nbsp;&nbsp;";
	html += 			"</div>";
	html += 			"<select id=\"saveApvLine\">";	//저장결재라인 select
	html +=				"</select>";
	html +=			"</div>";
	html +=			"<div><b>조직도</b></div>";
	html +=			"<div class=\"orgArea\">";
	html +=				"<span><img alt=\"folder\" src=\"resources/images/erp/gw/ea/folder.png\">HeyWe</span><br/>";
	html +=				"<div class=\"orgList\"></div>";/* 리스트 뿌려주는 곳 */
	html +=			"</div>";
	html += 	"</div>";
	html += 	"<div class=\"mid_right\">";
	html +=			"<div class=\"empSearchingArea\">";
	html +=				"<div class=\"searchImg\">";
	html +=					"<img alt=\"search\" src=\"resources/images/erp/gw/ea/search.png\" />";
	html +=				"</div>";
	html +=				"<div class=\"searchBar\">";
	html +=					"<input type=\"text\" id=\"empNameTxt\" placeholder=\"사원명\" />";
	html +=				"</div>";				
	html +=				"<input type=\"button\" id=\"searchBtn\" value=\"검색\" />";
	html +=			"</div>";
	html +=			"<div class=\"empListAreaHeader\">";
	html +=				"<table>";
	html +=					"<thead>";
	html +=						"<tr>";
	html +=							"<th width=\"30px\"><input type=\"checkbox\" id=\"cAll\" /></th>";
	html +=							"<th width=\"120px\">부서</th>";
	html +=							"<th width=\"120px\">직급(직책)</th>";
	html +=							"<th width=\"150px\">사원명</th>";
	html +=						"</tr>";
	html +=					"</thead>";
	html +=				"</table>";
	html +=			"</div>";
	html +=			"<div class=\"empListArea\">";
	html +=			"<div>";
	html +=				"<table class=\"empList\">";
	html +=					"<colgroup>"
	html +=						"<col width=30px>"
	html +=						"<col width=120px>"
	html +=						"<col width=120px>"
	html +=						"<col width=150px>"
	html +=					"</colgroup>"
	html +=					"<tbody>";	//사원목록 뿌려주는 곳
	html +=					"</tbody>";
	html +=				"</table>";
	html += 		"</div>";
	html += 		"</div>";
	html += 		"<div class=\"mid_right_mid2\">";
	html += 			"<div class=\"mid2_left\">결재자</div>";
	html +=				"<div class=\"mid2_right\"><input type=\"button\" id=\"addApverBtn\" value=\"결재자 추가\" /></div>";
	html += 		"</div>";
	html += 		"<div class=\"mid_right_bot\">";
	html +=			"</div>";
	html +=			"<div style=\"font-style: italic; color: #8B8786;\">결재자는 최소1명 최대 5명을 지정할 수 있습니다.</div>";
	html += 	"</div>";

	makePopup(1, "결재라인 지정", html, true, 800, 500, 
			
			function() {
				var maxApver = 5;
				var apverTemp = new Array();
				
				reloadSALselectList();
				reloadOrgList();
				reloadEmpList();
				
				$(".orgArea").slimScroll({
					height : "90%",
					axis: "both"
				});
				
				$(".empListArea>div").slimScroll({
					height : "100%",
					axis: "both"
				});
				
				
				//select 옵션 클릭
				$("#saveApvLine").on("change", function() {
					if($(this).val() == '1'){
						return;
					}
					$("input[name='exceptEmpNo']").each(function() {
						$(this).remove();
					});
					
					var exceptEmpNos = $(this).val().split(",");
					
					for(var i=0; i<exceptEmpNos.length; i++){
						console.log(exceptEmpNos[i]);
						var exceptEmpNo = "";
						exceptEmpNo = "<input type=\"hidden\" name=\"exceptEmpNo\" value=\""+ exceptEmpNos[i] + "\" />";
						$("#except").append(exceptEmpNo);
					}
					
					//
					
					var html = "";
					var params = $("#dataForm").serialize();
					
					$.ajax({
						type: "post",
						url: "GWapverListAjax",
						dataType: "json",
						data: params,
						success: function(result) {
							
							for(var i=0; i<result.apverList.length; i++){
								var empInfo = ""; 
								empInfo += "[" + result.apverList[i].DEPT_NAME + "]"
								empInfo += "&nbsp;" + result.apverList[i].NAME;
								empInfo += "&nbsp;" + result.apverList[i].POSI_NAME;
									 
					
								html += "<div name=\"" + result.apverList[i].EMP_NO + "\">";
								html += 	"<div class=\"apvLeft\"><span>" + empInfo + "</span></div>" 
								html += 	"<div class=\"apvRight\"><input type=\"button\" value=\"삭제\" /></div>";
								html += "</div>";
								
							}
							$(".mid_right_bot").html(html);
							reloadEmpList();
						},
						error: function(request, status, error) {
							console.log("status: " + request.status);
							console.log("text: " + request.responseText);
							console.log("error: " + error);
						}
					}); 
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
							var empInfo = "[" + $(this).parents("tr").children("td").eq(1).text() + "]"
										+ "&nbsp;" + $(this).parents("tr").children("td").eq(3).text() 
										+ "&nbsp;" + $(this).parents("tr").children("td").eq(2).text();
										 
							
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
						
						$(".mid_right_bot").append(html);
						
					} else {
						makeAlert(2, "확인", "결재자는 5명을 초과할 수 없습니다.", false, null)
					}
				});
				
				// 결재자 삭제
				$(".mid_right_bot").on("click", "input", function() {
					var empNo = $(this).parent("div").parent("div").attr("name");
					$("input[name='exceptEmpNo']").each(function() {
						if($(this).val() == empNo){
							$(this).remove();
						}	
					});
					
					$(this).parent("div").parent("div").remove();
					reloadEmpList();
				});
				
				// 취소 버튼 + 팝업에서 그냥 나갈 때
				$(document).on("click", "#popup1BtnLeft, #popup1 img[alt='exit'], #popup1Bg", function() {
					var temp = ""; 
					$(".apver").each(function() {
						temp += "," + $(this).attr("name");
					});
					
					$("input[name='exceptEmpNo']").each(function() {
						if(temp.indexOf($(this).val()) == -1){
							$(this).remove();
						}
					});
				});
			}
			
			, "적용", 
				function() {	//결재라인 적용 시
					if($("input[name='exceptEmpNo']").length != 0){
						var params = $("#dataForm").serialize();
					
						$.ajax({
							type: "post",
							url: "GWapverListAjax",
							dataType: "json",
							data: params,
							success: function(result) {
								redrawApverList(result.apverList);
							},
							error: function(request, status, error) {
								console.log("status: " + request.status);
								console.log("text: " + request.responseText);
								console.log("error: " + error);
							}
						}); 
					
						closePopup(1);
						makeAlert(2, "확인", "등록 되었습니다.", true, null);
					} else {
						makeAlert(2, "확인", "결재라인을 적용하려면 결재자가<br/>최소 1명이상 정해져야 합니다.", false, null);
					}
				}
			)
}

//select option
function reloadSALselectList() {
	
	$.ajax({
		type: "post",
		url: "GWSavedApvLineListAjax",
		dataType: "json",
		success: function(result) {
			redrawSALselectList(result.sApvLineNames, result.sApvLineList);
		},
		error: function(request, status, error) {
			console.log("status: " + request.status);
			console.log("text: " + request.responseText);
			console.log("error: " + error);
		}
	}); 
} 

function redrawSALselectList(sApvLineNames, sApvLineList) {
	var html="";
	
	html += "<option value=\"1\" selected=\"selected\"> - - - - 직접 선택 - - - - </option>";
	
	if(sApvLineNames != null && sApvLineNames != ""){
		
		for(var i=0; i<sApvLineNames.length; i++){
			html +=	"<option name=\"" + sApvLineNames[i].SAVE_APV_LINE_NO + "\" value=\"";
		
			var apverNos = ""
			for(var j=0; j<sApvLineList.length; j++){
				if(sApvLineNames[i].SAVE_APV_LINE_NO == sApvLineList[j].SAVE_APV_LINE_NO){
					apverNos += "," + sApvLineList[j].EMP_NO;
				}
			}
			console.log(apverNos.substring(1));
			
			html += apverNos.substring(1); 
			html +=	"\">"; 
			html += sApvLineNames[i].SAVE_APV_LINE_NAME + "</option>";
		}
	}
	
	$("#saveApvLine").html(html);
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
		html +=		"<td deptNo=\"" + empList[i].DEPT_NO + "\">" + empList[i].DEPT_NAME + "</td>";
		html +=		"<td posiNo=\"" + empList[i].POSI_NO + "\">" + empList[i].POSI_NAME + "</td>";
		html +=		"<td>" + empList[i].NAME + "</td>";
		html +=	"</tr>";
	}
	
	$(".empList tbody").html(html);
}

function redrawApverList(apverList) {
	if(apverList.length == 0){
		makeAlert(2, "확인", "지정된 결재자가 없습니다.", false, null)
	} else {
		var html = "";
		html += "<span><br/><br/>결재</span>";
		for(var i=0; i<apverList.length; i++){
			html += "<div class=\"apver\" name=\"" + apverList[i].EMP_NO + "\">";
			html +=		"<div class=\"posi\" name=\"" + apverList[i].POSI_NO + "\">" + apverList[i].POSI_NAME + "</div>";
			html +=		"<div class=\"empName\">";
			html +=			"<div name=\"" + apverList[i].DEPT_NAME + "\">" + apverList[i].NAME + "</div>";
			html +=		"</div>";
			html +=		"<div class=\"apvDate\"><span style=\"font-style: italic; color: #8B8786;\">결재일</span></div>";
			html +=	"</div>";
		}
		
		$(".apverArea").html(html);
	}
}