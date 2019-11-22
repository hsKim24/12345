<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>HeyWe > 경영관리 > 신용카드/계좌 관리 > 신용카드 관리 - 메인</title>
		<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
		<link rel="stylesheet" type="text/css" href="resources/css/erp/bm/crdtCardAcntMgnt/crdtCardAcntMgntStyle.css"/>
		<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.min.css" />
		<link rel="stylesheet" type="text/css" href="resources/css/common/calendar.css" />
		
		<script type="text/javascript"
				src="resources/script/jquery/jquery-1.12.4.min.js"></script>
		<script type="text/javascript" src="resources/script/jquery/jquery-ui.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				if($("#page").val() == "") {
					$("#page").val("1");
				}
				
				reloadCrdtCardMgntList();
				reloadCardDivList();
				reloadCardCoList();
				
				// 검색
				$("#searchBtn").on("click", function() {
					$("#page").val("1");
					reloadCrdtCardMgntList();
				});
				
				// 페이징
				$("#pagingArea").on("click", "input", function() {
					$("#page").val($(this).attr("name"));
					reloadCrdtCardMgntList();
				});
				
				// tr 클릭  시 체크박스 선택/해제
				$("tbody").on("click", "tr", function(list){
					// tr의 자식들(td) 중 0번째 td의 자식(input = checkbox)이 체크 되어있으면
					if($(this).children().eq(0).children().is(":checked")) {
						// 체크 해제
						$(this).children().eq(0).children().prop("checked", false);
					} else {
						// 체크
						$(this).children().eq(0).children().prop("checked", true);
					}
					// 모든 tr의 checkbox가 체크되면
					// th의 checkbox도 체크
					var checkFlag = 0;
					
					$("#crdtCardMgntTable tbody input[type='checkbox']").each(function() {
						if(!$(this).is(":checked")) {
							checkFlag++;
						}
					});
					
					if(checkFlag == 0) {
						$("#checkAll").prop("checked", true);
					} else {
						$("#checkAll").prop("checked", false);
					}
				});
				// checkbox가 tr에 속해있으므로 2번 체크박스를 클릭할 경우
				// 두번 클릭한 결과가 나오므로 한번 더 처리
				$("tbody").on("click", "[type='checkbox']", function() {
					if($(this).is(":checked")) {
						$(this).prop("checked", false);
					} else {
		                   $(this).prop("checked", true);
	                }
					// 모든 tr의 checkbox가 체크되어있다가 하나라도 해제가 되는 경우
					// th의 checkbox가 체크되어 있으면 체크 해제
	                if($("#check_all").is(":checked")) {
	                   $("#check_all").prop("checked", false);
	                }
				});
				// th의 checkbox 체크 시 모든 tr의 checkbox를 체크
				$("#checkAll").on("click",function(){
	                if($(this).is(":checked")){
	                   $("tbody input").prop("checked",true);
	                } else{
	                   $("tbody input").prop("checked",false);
	                }
	             });
				
				// 신규등록 버튼 클릭
				$("#newRegBtn").on("click", function()	{
					// 신규등록 makePopup
					makePopup(1, "신용카드 신규등록", crdtCardNewRegPopup(), true, 500, 450, function() {
						// 카드번호에 - 자동 추가
						$("#cardNo").on("keyup", function(){
							if($(this).val().length > 4 && $(this).val().lastIndexOf("-") == -1){
								$(this).val($(this).val().substring(0, 4) + "-"
											+ $(this).val().substring(4, 8) + "-"
											+ $(this).val().substring(8, 12) + "-"
											+ $(this).val().substring(12, 16));
							} else if($(this).val().length == 4 || $(this).val().length == 9 || $(this).val().length == 14){
								$(this).val($(this).val() + "-");
							}
						});
						// 카드번호에 숫자만 입력하도록 (단, -은 가능)
						$("#cardNo").on("change", function(){
							var data = $(this).val();
							
 							while(data.lastIndexOf("-") != -1){
 								data = data.replace("-", '');
							}
							
							if(isNaN(data * 1)) {
								makeAlert(2	, "알림", "숫자만 입력해주세요", false, function() {
									$("#cardNo").val("");
									$("#cardNo").focus();
								});
							}
						});
						
						// datepicker 할당(calendar)
						$("#eprtnDate").datepicker({
							dateFormat : 'yy-mm-dd',
							duration: 200,
							onSelect:function(dateText, inst){
								$("#eprtnDateValue").val($("#eprtnDate").val());
							}
						});
						// 카드 구분 리스트 가져오기
						$.ajax({
							type : "post",
							url : "getCmnCdAjax",
							dataType : "json",
							data : "cdL=6",
							success : function(result) {
								var html = "";
								for(var i = 0; i < result.cdList.length; i++) {
									if(i == 0) {
										html += "<input type=\"radio\" name=\"cardDivRadio\"checked=\"checked\" value=\""
												+ result.cdList[i].CD_S + "\"/>"
												+ result.cdList[i].CD_NAME;
									} else {
										html += "<input type=\"radio\" name=\"cardDivRadio\" value=\""
												+ result.cdList[i].CD_S + "\"/>" 
												+ result.cdList[i].CD_NAME;
									}
								}
								$("#cardDivRadio").html(html);
							},
							error : function(request, status, error) {
								console.log("status : ", request.status);
								console.log("text : ", request.responseText);
								console.log("error : ", error);
							}
						}); // 카드 구분 리스트 가져오기 (끝)
						// 카드사 리스트 가져오기
						$.ajax({
							type : "post",
							url : "BMCardCoListAjax",
							dataType : "json",
							success : function(result) {
								var html = "";
								for(var i = 0; i < result.cardCoList.length; i++) {
									html +=	"<option value=" + result.cardCoList[i].CARD_CO_NO + ">" 
											+ result.cardCoList[i].CARD_CO_NAME + "</option>"; 
								}
								
								$("#cardCoSlt").html(html);
							},
							error : function(request, status, error) {
								console.log("status : ", request.status);
								console.log("text : ", request.responseText);
								console.log("error : ", error);
							}
						});	// 카드사 리스트 가져오기 (끝)

						// 사원검색 버튼 클릭
						$("#user, #empSearchBtn").on("click",function(){
							// 사원검색 makePopup
							makePopup(2, "사원조회", empPopup() , true, 700, 386, function(){
								$("#selectEmpFlag").val("0");
								popUpSearch();
								
								$("#listDiv").slimScroll({
									height: "170px",
									axis: "both"
								});
								
								$("#search_btn").on("click", function(){
									popUpSearch();
								});
								
								$("#search_txt").keyup(function(event){
									if(event.keyCode == '13'){
										popUpSearch();
									}
								});
								
								$("#listCon tbody").on("click", "tr", function(){
									$("#listCon tr").css("background-color", "");
									$(this).css("background-color", "#B0DAEC");
									$("#selectEmpNo").val($(this).attr("name"));
									$("#selectEmpName").val($(this).children(".selectEmpName").html());
									$("#selectEmpFlag").val("1");
								});
							}, "선택", function(){ 
								if($("#selectEmpFlag").val() == "1"){
									$("#user").val($("#selectEmpName").val());
									$("#userEmpNo").val($("#selectEmpNo").val());
								}
								
								closePopup(2);
							});	// 사원검색 makePopup (끝)
						});	// 사원검색 버튼 클릭 (끝)
					}, "등록", function(){
						if($.trim($("#cardName").val()) == "") {
							makeAlert(2, "알림", "카드명을 입력해주세요", true, function() {
								$("#cardName").focus();								
							});
						} else if($.trim($("#cardNo").val()) == "") {
							makeAlert(2, "알림", "카드번호를 입력해주세요", true, function() {
								$("#cardNo").focus();															
							});
						} else if($.trim($("#cardNo").val().length) != 19) {
							makeAlert(2, "알림", "카드번호를 올바르게 입력해주세요", true, function() {
								$("#cardNo").focus();								
							});
						} else if($.trim($("#owner").val()) == "") {
							makeAlert(2, "알림", "소유주를 입력해주세요", true, function() {
								$("#owner").focus();								
							});
						} else if($.trim($("#user").val()) == "") {
							makeAlert(2, "알림", "사용자를 입력해주세요", true, function() {
								$("#user").focus();								
							});
						} else if($.trim($("#eprtnDate").val()) == "") {
							makeAlert(2, "알림", "유효기간을 입력해주세요", true, function() {
								$("#eprtnDate").focus();								
							});
						} else {
							var params = $("#popupDataForm").serialize();
							
							$.ajax({
								type : "post",
								url : "BMCrdtCardNewRegAjax",
								dataType : "json",
								data : params,
								success : function(result){
									if(result.flag == 0) {
										makeAlert(2, "알림", "등록에 성공하였습니다", true, function() {
											reloadCrdtCardMgntList();
											closePopup(1);
										});
									} else {
										makeAlert(2, "알림", "등록에 실패하였습니다", true, function() {
											reloadCrdtCardMgntList();
											closePopup(1);
										});										
									}
								},
								error : function(request, status, error){
									console.log("status : " + request.status);
									console.log("text : " + request.responseText);
									console.log("error : " + error);
								}
							});	
						}
					});	// 신규 등록 makePopup (끝)
				});	// 신규등록 버튼 클릭 (끝)			
				
				// 수정 버튼 클릭				
				$("#updateBtn").on("click", function()	{
					var checkFlag = 0;
					
					$("#crdtCardMgntTable tbody input[type='checkbox']:checked").each(function() {
						checkFlag++;
					});
					
					if(checkFlag == 1) {
						// 수정 makePopup
						makePopup(1, "신용카드 수정", crdtCardUpdatePopup(), true, 500, 450, function() {
							// 카드번호에 - 자동 추가
							$("#cardNo").on("keyup", function(){
								if($(this).val().length > 4 && $(this).val().lastIndexOf("-") == -1){
									$(this).val($(this).val().substring(0, 4) + "-"
												+ $(this).val().substring(4, 8) + "-"
												+ $(this).val().substring(8, 12) + "-"
												+ $(this).val().substring(12, 16));
								} else if($(this).val().length == 4 || $(this).val().length == 9 || $(this).val().length == 14){
									$(this).val($(this).val() + "-");
								}
							});
							// 카드번호에 숫자만 입력하도록 (단, -은 가능)
							$("#cardNo").on("change", function(){
								var data = $(this).val();
								
	 							while(data.lastIndexOf("-") != -1){
	 								data = data.replace("-", '');
								}
								
								if(isNaN(data * 1)) {
									makeAlert(2	, "알림", "숫자만 입력해주세요", true, function() {
										$("#cardNo").val("");
										$("#cardNo").focus();
									});
								}
							});
							
							// datepicker 할당(calendar)
							$("#eprtnDate").datepicker({
								dateFormat : 'yy-mm-dd',
								duration: 200,
								onSelect:function(dateText, inst){
									$("#eprtnDateValue").val($("#eprtnDate").val());
								}
							});
							// 카드구분 리스트 가져오기
							$.ajax({
								type : "post",
								url : "getCmnCdAjax",
								dataType : "json",
								data : "cdL=6",
								success : function(result) {
									var html = "";
									for(var i = 0; i < result.cdList.length; i++) {
										if(i == 0) {
											html += "<input type=\"radio\" name=\"cardDivRadio\" value=\""
													+ result.cdList[i].CD_S + "\"/>" 
													+ result.cdList[i].CD_NAME;
										} else {
											html += "<input type=\"radio\" name=\"cardDivRadio\" value=\""
													+ result.cdList[i].CD_S + "\"/>" 
													+ result.cdList[i].CD_NAME;
										}
									}
									$("#cardDivRadio").html(html);
									
									// 카드사 리스트 가져오기
									$.ajax({
										type : "post",
										url : "BMCardCoListAjax",
										dataType : "json",
										success : function(result) {
											var html = "";
											for(var i = 0; i < result.cardCoList.length; i++) {
												html +=	"<option value=" + result.cardCoList[i].CARD_CO_NO + ">" 
														+ result.cardCoList[i].CARD_CO_NAME + "</option>"; 
											}
											
											$("#cardCoSlt").html(html);
											
											// 체크박스가 선택된 카드 정보 가져오기
											$("#sltedCardMgntNo").val($("#crdtCardMgntTable tbody input[type='checkbox']:checked").val());
											var params = $("#popupDataForm").serialize();
											$.ajax({
												type : "post",
												url : "BMSltedCardInfoAjax",
												dataType : "json",
												data : params,
												success : function(result) {
													$("[name='cardDivRadio'][value=" + result.data.CARD_DIV_NO + "]").prop("checked", true);
													$("#cardCoSlt").val(result.data.CRDT_CARD_CO_NO);
													$("#cardName").val(result.data.CARD_NAME);
													$("#cardNo").val(result.data.CARD_NO);
													$("#owner").val(result.data.OWNER);
													$("#userEmpNo").val(result.data.REAL_USER_EMP_NO);
													$("#user").val(result.data.REAL_USER);
													$("#eprtnDate").val(result.data.EPRTN_DATE);
												},
												error : function(request, status, error) {
													console.log("status : ", request.status);
													console.log("text : ", request.responseText);
													console.log("error : ", error);
												}
											});		// 체크박스가 선택된 카드 정보 가져오기 (끝)
										},
										error : function(request, status, error) {
											console.log("status : ", request.status);
											console.log("text : ", request.responseText);
											console.log("error : ", error);
										}
									});	// 카드사 리스트 가져오기 (끝)
								},
								error : function(request, status, error) {
									console.log("status : ", request.status);
									console.log("text : ", request.responseText);
									console.log("error : ", error);
								}
							}); // 카드 구분 리스트 가져오기 (끝)
							
							// 사원 검색 버튼 클릭
							$("#user, #empSearchBtn").on("click",function(){
								// 사원 검색 makePopup
								makePopup(2, "사원조회", empPopup() , true, 700, 386, function(){
									$("#selectEmpFlag").val("0");
									popUpSearch();
									
									$("#listDiv").slimScroll({
										height: "170px",
										axis: "both"
									});
									
									$("#search_btn").on("click", function(){
										popUpSearch();
									});
									
									$("#search_txt").keyup(function(event){
										if(event.keyCode == '13'){
											popUpSearch();
										}
									});
									
									$("#listCon tbody").on("click", "tr", function(){
										$("#listCon tr").css("background-color", "");
										$(this).css("background-color", "#B0DAEC");
										$("#selectEmpNo").val($(this).attr("name"));
										$("#selectEmpName").val($(this).children(".selectEmpName").html());
										$("#selectEmpFlag").val("1");
									});
								}, "선택", function(){ 
									if($("#selectEmpFlag").val() == "1"){
										$("#user").val($("#selectEmpName").val());
										$("#userEmpNo").val($("#selectEmpNo").val());
									}
									
									closePopup(2);
								});	// 사원 검색 makePopup (끝)
							});	// 사원 검색 버튼 클릭 (끝)
						}, "수정", function(){
							if($.trim($("#cardName").val()) == "") {
								makeAlert(2, "알림", "카드명을 입력해주세요", true, function() {
									$("#cardName").focus();									
								});
							} else if($.trim($("#cardNo").val()) == "") {
								makeAlert(2, "알림", "카드번호를 입력해주세요", true, function() {
									$("#cardNo").focus();																
								});
							} else if($.trim($("#cardNo").val().length) != 19) {
								makeAlert(2, "알림", "카드번호를 올바르게 입력해주세요", true, function() {
									$("#cardNo").focus();									
								});
							} else if($.trim($("#owner").val()) == "") {
								makeAlert(2, "알림", "소유주를 입력해주세요", true, function() {
									$("#owner").focus();									
								});
							} else if($.trim($("#user").val()) == "") {
								makeAlert(2, "알림", "사용자를 입력해주세요", true, function() {
									$("#user").focus();									
								});
							} else if($.trim($("#eprtnDate").val()) == "") {
								makeAlert(2, "알림", "유효기간을 입력해주세요", true, function() {
									$("#eprtnDate").focus();									
								});
							} else {
								var params = $("#popupDataForm").serialize();
								
								$.ajax({
									type : "post",
									url : "BMCrdtCardUpdateAjax",
									dataType : "json",
									data : params,
									success : function(result){
										if(result.flag == 0) {
											makeAlert(2, "알림", "수정에 성공하였습니다", true, function() {
												reloadCrdtCardMgntList();
												closePopup(1);											
											});											
										} else {
											makeAlert(2, "알림", "수정에 실패하였습니다", true, function() {
												reloadCrdtCardMgntList();
												closePopup(1);											
											});							
										}
									},
									error : function(request, status, error){
										console.log("status : " + request.status);
										console.log("text : " + request.responseText);
										console.log("error : " + error);
									}
								});	
							}
						});	// 수정 makePopup (끝)
					} else if(checkFlag == 0) {
						makeAlert(1, "알림", "데이터를 선택해주세요", true, null);
					} else {
						makeAlert(1, "알림", "데이터를 한 개만 선택해주세요", true, null);
					}
				});	// 수정 버튼 클릭 (끝)
				
				// 삭제 버튼 클릭
				$("#delBtn").on("click", function() {
					var checkFlag = 0;
					
					$("#crdtCardMgntTable tbody input[type='checkbox']:checked").each(function() {
						checkFlag++;
					});
					
					if(checkFlag != 0) {
						makeConfirm(1, "삭제", "삭제하시겠습니까?", true, function() {
							var crdtCardMgntNo = ""
							$("#crdtCardMgntTable tbody input[type='checkbox']:checked").each(function() {
								crdtCardMgntNo += "," + $(this).val();
							});		
							
							crdtCardMgntNo = crdtCardMgntNo.substring(1);
							
							$("#sltedCardMgntNo").val(crdtCardMgntNo);
							
							var params = $("#delDataForm").serialize();
							
							$.ajax({
								type : "post",
								url : "BMCrdtCardDelAjax",
								dataType : "json",
								data : params,
								success : function(result){
									if(result.flag == 0){
										makeAlert(2, "알림", "삭제에 성공하였습니다", true, function() {
											reloadCrdtCardMgntList();							
											closePopup(1);											
										});		
									} else{
										makeAlert(2, "알림", "삭제에 실패하였습니다", true, function() {
											reloadCrdtCardMgntList();							
											closePopup(1);											
										});													
									}
								},
								error : function(request, status, error){
									console.log("status : " + request.status);
									console.log("text : " + request.responseText);
									console.log("error : " + error);
								}
							});
						});
					} else {
						makeAlert(1, "알림", "데이터를 선택해주세요", true, null);
					}
				});		// 삭제 버튼 클릭 (끝)
				
				
				// 유효기간 calendar
				// datepicker 설정(영어로 나오는 것을 한글로 변경)
				$.datepicker.setDefaults({
					monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
					dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
					showMonthAfterYear:true,
					showOn: 'button',
					closeText: '닫기',
					buttonImage: 'resources/images/calender.png',
					buttonImageOnly: true,
					dateFormat: 'yy/mm/dd'    
				}); 
			});	// document ready (끝)
			
			// 함수 선언
			// 카드 구분 리스트 가져오기 (드롭다운)
			function reloadCardDivList() {
				$.ajax({
					type : "post",
					url : "getCmnCdAjax",
					dataType : "json",
					data : "cdL=6",
					success : function(result) {
						var html = "";
						html += "<option>전체</option>";
						for(var i = 0; i < result.cdList.length; i++) {
							html += "<option>" + result.cdList[i].CD_NAME + "</option>";	
						}
						$("#cardDiv").html(html);
					},
					error : function(request, status, error) {
						console.log("status : ", request.status);
						console.log("text : ", request.responseText);
						console.log("error : ", error);
					}
				});
			}	// 카드 구분 리스트 가져오기 (드롭다운) (끝)
			
			// 카드사 리스트 가져오기 (드롭다운)
			function reloadCardCoList() {
				$.ajax({
					type : "post",
					url : "BMCardCoListAjax",
					dataType : "json",
					success : function(result) {
						var html = "";
						html += "<option>전체</option>";
						for(var i = 0; i < result.cardCoList.length; i++) {
							html +=	"<option>" + result.cardCoList[i].CARD_CO_NAME + "</option>"; 
						}
						$("#cardCo").html(html);
					},
					error : function(request, status, error) {
						console.log("status : ", request.status);
						console.log("text : ", request.responseText);
						console.log("error : ", error);
					}
				});
			}	// 카드사 리스트 가져오기 (드롭다운) (끝)
			
			// 신용카드 관리 리스트 조회
			function reloadCrdtCardMgntList() {
				var params = $("#searchForm").serialize();
				
				$.ajax({
					type : "post",
					url : "BMCrdtCardMgntAjax",
					dataType : "json",
					data : params,
					success : function(result) {
						redrawCrdtCardMgntList(result.list);
						redrawPaging(result.pb);
					},
					error : function(request, status, error) {
						console.log("status : " + request.status);
						console.log("text : " + request.responseText);
						console.log("error : " + error);
					}
				});
			}	// 신용카드 관리 리스트 조회 (끝)
			
			// 신용카드 관리 리스트 redraw
			function redrawCrdtCardMgntList(list) {
				var html = "";

				if(list.length == 0) {
					html += "<tr><td colspan=\"8\">조회할 수 있는 데이터가 없습니다</td></tr>";
				} else {
					for(var i = 0; i < list.length; i++) {
						if(i%2 == 0) {
							html += "<tr class=\"top_tr\" name=\"" + list[i].CARD_MGNT_NO + "\">";
							html += "<td id=\"check" + i + "\"><input type=\"checkbox\" value=\""
									+ list[i].CARD_MGNT_NO + "\" /></td>";
							html += "<td>" + list[i].CD_NAME + "</td>";
							html += "<td>" + list[i].CARD_CO_NAME + "</td>";
							html += "<td>" + list[i].CARD_NAME + "</td>";
							html += "<td>" + list[i].CARD_NO + "</td>";
							html += "<td>" + list[i].EPRTN_DATE + "</td>";
							html += "<td>" + list[i].OWNER + "</td>";
							html += "<td>" + list[i].REAL_USER + "</td>";
							html += "</tr>";
						} else {
							html += "<tr class=\"bottom_tr\" name=\"" + list[i].CARD_MGNT_NO + "\">";
							html += "<td id=\"check" + i + "\"><input type=\"checkbox\" value=\""
									+ list[i].CARD_MGNT_NO + "\" /></td>";
							html += "<td>" + list[i].CD_NAME + "</td>";
							html += "<td>" + list[i].CARD_CO_NAME + "</td>";
							html += "<td>" + list[i].CARD_NAME + "</td>";
							html += "<td>" + list[i].CARD_NO + "</td>";
							html += "<td>" + list[i].EPRTN_DATE + "</td>";
							html += "<td>" + list[i].OWNER + "</td>";
							html += "<td>" + list[i].REAL_USER + "</td>";
							html += "</tr>";
						}
					}
				}
				
				$("#crdtCardMgntTable tbody").html(html);
			}	// 신용카드 관리 리스트 redraw (끝)
			
			// 페이징
			function redrawPaging(pb) {
				var html = "";
			    html += "<input type=\"button\" value=\"&lt&lt\" name=\"1\" >";
			      
				if($("#page").val() == "1"){
   					html += "<input type=\"button\" value=\"&lt\" name=\"1\" >";
				} else {
   					html += "<input type=\"button\" value=\"&lt\" name=\""
   			 				+ ($("#page").val() * 1 - 1) + "\">";
				}

				for(var i = pb.startPcount ; i <= pb.endPcount ; i++){
	   				if(i == $("#page").val()){
	      				html += "<input type=\"button\" value=\"" + i + "\" name=\"" 
	      						+ i + "\" disabled=\"disabled\" class=\"paging_on\">";
	   				} else {
	      				html += "<input type=\"button\" value=\"" + i + "\" name=\""
	      						+ i +  "\" class=\"paging_off\">";
	   				}
				}

				if($("#page").val() == pb.maxPcount) {
					html += "<input type=\"button\" value=\"&gt\" name=\"" 
   		 					+ pb.maxPcount +  "\">"; 
				}else {
					html += "<input type=\"button\" value=\"&gt\" name=\""
   		 					+ ($("#page").val() * 1 + 1) +   "\">";
				}
				html += "<input type=\"button\" value=\"&gt&gt\" name=\""
		      			+ pb.maxPcount +  "\">";
		      
		      	$("#pagingArea").html(html);
			}	// 페이징 (끝)

			// 신규등록 팝업 contents
			function crdtCardNewRegPopup() {
				var html = "";
				
				html += "<form action=\"#\" method=\"post\" id=\"popupDataForm\">";
				html += "<div class=\"regPage_contents_title\">카드구분(*)</div>";
				html += "<div class=\"regPage_contents_input\" id=\"cardDivRadio\" name=\"cardDivRadio\" \">";
				
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">카드사(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<select class=\"slt\" id=\"cardCoSlt\" name=\"cardCoSlt\">";
				
				html += "</select>";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">카드명(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"cardName\" name=\"cardName\" maxlength=\"20\" />";
				html += "</div>";
				html += "<br/>";
				
				html += "<div class=\"regPage_contents_title\">카드번호(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"cardNo\" name=\"cardNo\" maxlength=\"19\" />";
				html += "</div>";
				html += "<br/>";
				
				html += "<div class=\"regPage_contents_title\">소유주(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"owner\" name=\"owner\" maxlength=\"20\" />";
				html += "</div>";
				html += "<br/>";
				
				html += "<div class=\"regPage_contents_title\">사용자(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"user\" name=\"user\" maxlength=\"20\" />";
				html += "<input type=\"hidden\" id=\"userEmpNo\" name=\"userEmpNo\" />";
				html += "</div>";
				
				html += "<div class=\"regPage_contents_btn\">";
				html += "<input type=\"button\" value=\"사원검색\" id=\"empSearchBtn\" />";
				html += "</div>";
				html += "<br/>";
				
				html += "<div class=\"regPage_contents_title\">유효기간(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"eprtnDate\" name=\"eprtnDate\" value=\"\" readonly=\"readonly\" />";
				html += "</div>";
				html += "</form>";
				
				return html;
			}	// 신규등록 팝업 contents (끝)

			// 수정 팝업 contents
			function crdtCardUpdatePopup() {
				var html = "";
				
				html += "<form action=\"#\" method=\"post\" id=\"popupDataForm\">";
				html += "<input type=\"hidden\" id=\"sltedCardMgntNo\" name=\"sltedCardMgntNo\" value=\"\" />";
				html += "<div class=\"regPage_contents_title\">카드구분(*)</div>";
				html += "<div class=\"regPage_contents_input\" id=\"cardDivRadio\">";
				
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">카드사(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<select class=\"slt\" id=\"cardCoSlt\" name=\"cardCoSlt\">";
				
				html += "</select>";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">카드명(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"cardName\" name=\"cardName\""
						+ "maxlength=\"20\" value=\"\" />";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">카드번호(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"cardNo\" name=\"cardNo\""
						+ "maxlength=\"19\" value=\"\" />";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">소유주(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"owner\" name=\"owner\" maxlength=\"20\" />";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">사용자(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"user\" name=\"user\" maxlength=\"20\" />";
				html += "<input type=\"hidden\" id=\"userEmpNo\" name=\"userEmpNo\" />";
				html += "</div>";
				html += "<div class=\"regPage_contents_btn\">";
				html += "<input type=\"button\" value=\"사원검색\" id=\"empSearchBtn\" />";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">유효기간(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"eprtnDate\" name=\"eprtnDate\""
						+ "value=\"\" readonly=\"readonly\" />";
				html += "</div>";
				html += "</form>";
				
				return html;
			}	// 수정 팝업 contents (끝)
			
			// 사원 검색 팝업  처음 그리기
			function drawEmpSearchList(list){
				var html = "";
				
				if(list.length == 0){
					html += "<tr class=\"odd_row\"><td colspan=\"2\"></td></tr>";
					html += "<tr class=\"even_row\"><td colspan=\"2\"></td></tr>";
					html += "<tr class=\"odd_row\"><td colspan=\"2\"></td></tr>";
					html += "<tr class=\"even_row\"><td colspan=\"2\">검색결과가 없습니다</td></tr>";
					html += "<tr class=\"odd_row\"><td colspan=\"2\"></td></tr>";
					html += "<tr class=\"even_row\"><td colspan=\"2\"></td></tr>";
					html += "<tr class=\"odd_row\"><td colspan=\"2\"></td></tr>";
				}else {
					for(var i = 0 ; i < list.length ; i++){
						if(i % 2 == 0){
							html += "<tr class=\"odd_row\" name=\""+ list[i].EMP_NO + "\">";
						}else {
							html += "<tr class=\"even_row\" name=\""+ list[i].EMP_NO + "\">";
						}
						html += "<td>" + list[i].DEPT_NAME + "</td>";
						html += "<td class=\"selectEmpName\">" + list[i].NAME + "</td>";
						html += "</tr>";
					}
				}
				
				$("#listCon tbody").html(html);
			} // 사원 검색 팝업 처음 그리기 (끝)
			
			// 사원검색 팝업 contents
			function empPopup(){
				var html="";
				
				html += "<div id=\"empSearch\">";
				html += "<input type=\"text\" placeholder=\"이름을 입력해주세요\" id=\"search_txt\">";
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
			}	// 사원검색 팝업 contents (끝)
			
			// 사원 검색 리스트 가져오기
			function popUpSearch(){
				$("#empSearchTxt").val($.trim($("#search_txt").val()));
				
				var params = $("#empSearchForm").serialize(); 
				
				$.ajax({
					type : "post",
					url : "BMEmpSearchAjax",
					dataType : "json",
					data : params,
					success : function(result){
						drawEmpSearchList(result.list);
					},
					error : function(request, status, error){
						console.log("status : " + request.status);
						console.log("text : " + request.responseText);
						console.log("error : " + error);
					}
				});
			}	// 사원 검색 리스트 가져오기 (끝)
		</script>
	</head>
	<body>
		<form action="#" method="post" id="delDataForm">
			<input type="hidden" id="sltedCardMgntNo" name="sltedCardMgntNo" value="" />
		</form>
		<form action="#" method="post" id="empSearchForm">
			<input type="hidden" id="empSearchTxt" name="empSearchTxt" />
		</form>
		<input type="hidden" id="selectEmpNo" />
		<input type="hidden" id="selectEmpName" />		
		<input type="hidden" id="selectEmpFlag" value="0"/>
		
		<c:import url="/topLeft">
			<c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
			<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param>
		</c:import>	

		<!-- 내용 영역 -->
		<div class="content_area">
			<!-- 메뉴 네비게이션 -->
			<div class="content_nav">HeyWe &gt; 경영관리 &gt; 신용카드/계좌 관리 &gt; 신용카드 관리</div>
			<!-- 현재 메뉴 제목 -->
			<div class="content_title">신용카드 관리</div>
			<br/>
			<form action="#" method="post" id="searchForm">
				<input type="hidden" id="page" name="page" value="${page}" />
				<div class="data_search_area">
					<div class="data_search_menu">카드구분</div>
					<div class="data_search_input">
						<select class="slt" id="cardDiv" name="cardDiv"></select>
					</div>
					<div class="data_search_icon"></div>
					<div class="data_search_menu">카드사</div>
					<div class="data_search_input">
						<select class="slt" id="cardCo" name="cardCo"></select>
					</div>
					<div class="data_search_icon"></div>
					<br/>
					<div class="data_search_menu">카드명</div>
					<div class="data_search_input">
						<input type="text" class="txt" id="cardName" name="cardName"/>
					</div>
					<div class="data_search_icon"></div>
					<div class="data_search_menu">카드번호</div>
					<div class="data_search_input">
						<input type="text" class="txt" id="cardNo" name="cardNo"/>
					</div>
					<div class="data_search_icon"></div>
					<br/>
					<div class="data_search_menu">소유주</div>
					<div class="data_search_input">
						<input type="text" class="txt" id="owner" name="owner"/>
					</div>
					<div class="data_search_icon"></div>
					<div class="data_search_menu">사용자</div>
					<div class="data_search_input">
						<input type="text" class="txt" id="user" name="user"/>					
					</div>
					<div class="data_search_icon"></div>
					<div class="data_search_btn">
						<input type="button" value="검색" class="btn" id="searchBtn"/>
					</div>
				</div>
			</form>
			<br/>
			<div class="data_info_area">
				<table class="data_info_table" id="crdtCardMgntTable">
					<colgroup>
						<col width="50"/>
						<col width="70"/>
						<col width="70"/>
						<col width="160"/>
						<col width="190"/>
						<col width="80"/>
						<col width="100"/>
						<col width="80"/>
					</colgroup>
					<thead>
					<tr class="first_tr" height=45px>
						<td><input type="checkbox" id="checkAll"/></td>
						<th>카드구분</th>
						<th>카드사</th>
						<th>카드명</th>
						<th>카드번호</th>
						<th>유효기간</th>
						<th>소유주</th>
						<th>사용자</th>
					</tr>
					</thead>
					<tbody></tbody>
				</table>
				<div class="pagingArea" id="pagingArea"></div>
			</div>
			<br/>
			<div class="data_btn_area">
				<div class="left_btn_area">
					<div class="btn_area"><input type="button" value="삭제" class="btn" id="delBtn"/></div>
					<div class="btn_area"><input type="button" value="수정" class="btn" id="updateBtn"/></div>
				</div>
				<div class="right_btn_area">
					<div class="btn_area"><input type="button" value="신규등록" class="btn" id="newRegBtn"/></div>
				</div>
			</div>
		</div>
	</body>
</html>