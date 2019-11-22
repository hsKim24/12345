<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>HeyWe - 매입채무 관리</title>
      <link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
      <link rel="stylesheet" type="text/css" href="resources/css/erp/bm/loanMgnt/loantMgntStyle.css" />
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
			
			reloadPurcDebtMgntList();
			reloadCsptsList();
			reloadCstmList();
			
			
			$("#searchBtn").on("click", function(){
				$("#page").val("1");
				reloadPurcDebtMgntList()
			});
			
			//등록일자 초기화
			$("[alt='reset']").on("click", function() {
				$("#date_start").val("");
				$("#date_end").val("");
			});
			
			// 페이징
			$("#pagingArea").on("click", "input", function() {
				$("#page").val($(this).attr("name"));
				reloadPurcDebtMgntList();
			});
			
			// 체크박스 작업
			
			$("tbody").on("click", "td", function() {
				if($(this).parent().children().eq(0).children().is(":checked")) {
					$(this).parent().children().eq(0).children().prop("checked", false);
				} else {
					$(this).parent().children().eq(0).children().prop("checked", true);
				}
				// 모든 tr의 checkbox가 체크되면
				// th의 checkbox도 체크
				var checkFlag = 0;
				
				$("#purcDebtMgntTable tbody input[type='checkbox']").each(function() {
					if(!$(this).is(":checked")) {
						checkFlag++;
					}
				});
				
				if(checkFlag == 0) {
					$("#check_all").prop("checked", true);
				} else {
					$("#check_all").prop("checked", false);
				}
			});
			
			$("tbody").on("click", "[type='checkbox']", function() {
				if($(this).is(":checked")) {
					$(this).prop("checked", false);
				} else {
					$(this).prop("checked", true);
				}

				if($("#check_all").is(":checked")) {
					$("#check_all").prop("checked", false);
				}
			});

				$("#check_all").on("click",function(){
				if($(this).is(":checked")){
					$("tbody input").prop("checked",true);
				} else{
					$("tbody input").prop("checked",false);
				}
				
			});
				
				// 검색창 캘린더
				
					// 날짜
					$.datepicker.setDefaults({
						monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
						dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
						showMonthAfterYear:true,
						showOn: 'both',
						closeText: '닫기',
						buttonImage: 'resources/images/calender.png',
						buttonImageOnly: true,
						dateFormat: 'yy/mm/dd'
					}); 
					// 등록일자 시작일자
					$("#date_start").datepicker({
						dateFormat : 'yy-mm-dd',
						duration: 200,
						maxDate: new Date,
						onSelect:function(dateText, inst){
							var startDate = parseInt($("#date_end").val().replace("-", '').replace("-", ''));
							var endDate = parseInt(dateText.replace(/-/g,''));
							
							if (endDate > startDate) {
				            	makeAlert(1, "알림", "날짜를 잘못 입력하였습니다", true, null);
				            	//달력에 종료 날짜 넣어주기
				        		$("#date_start").val($("#stdt").val());
							} else {
								$("#stdt").val($("#date_start").val());
							}
						}
					});
					// 등록일자 마지막일자
					$("#date_end").datepicker({
						dateFormat : 'yy-mm-dd',
						duration: 200,
						maxDate: new Date,
						onSelect:function(dateText, inst){
							var startDate = parseInt($("#date_start").val().replace("-", '').replace("-", ''));
							var endDate = parseInt(dateText.replace(/-/g,''));
							if (startDate > endDate) {
				            	makeAlert(1, "알림", "날짜를 잘못 입력하였습니다", true, null);
				            	//달력에 종료 날짜 넣어주기
				        		$("#date_end").val($("#eddt").val());
							} else {
								$("#eddt").val($("#date_end").val());
							}
						}
					});

				// 신규등록 팝업
				$("#btn_newReg").on("click", function()	{
					makePopup(1, "매입매출 신규등록", loanNewRegPopup(), true, 500, 500, function() {
			
						
						// datepicker 할당(calendar)
						$("#dlineDay").datepicker({
							dateFormat : 'yy-mm-dd',
							duration: 200,
							minDate: new Date,
							onSelect:function(dateText, inst){
								$("#dlineDayValue").val($("#dlineDay").val());
							}
						});
						
						
						// 거래처 셀렉 리스트 가져오기
						$.ajax({
							type : "post",
							url : "BMPurcDebtMgntAjax",
							dataType : "json",
							success : function(result) {
								var html = "";
								for(var i = 0; i < result.CstmDivList.length; i++) {
									html +=	"<option value=" + result.CstmDivList[i].CSTM_NO+ ">" 
											+ result.CstmDivList[i].CSTM_NAME + "</option>"; 
								}
								
								$("#cstmSlt").html(html);
							},
							error : function(request, status, error) {
								console.log("status : ", request.status);
								console.log("text : ", request.responseText);
								console.log("error : ", error);
							}
						});
						
						// 적요명 셀렉 리스트 가져오기
						$.ajax({
							type : "post",
							url : "BMPurcDebtMgntAjax",
							dataType : "json",
							success : function(result) {
								var html = "";
								for(var i = 0; i < result.CsptsNameDivList.length; i++) {
									html +=	"<option value=" + result.CsptsNameDivList[i].CSPTS_NO+ ">" 
											+ result.CsptsNameDivList[i].CSPTS_NAME + "</option>"; 
								}
								
								$("#csptsNameSlt").html(html);
							},
							error : function(request, status, error) {
								console.log("status : ", request.status);
								console.log("text : ", request.responseText);
								console.log("error : ", error);
							}
						});
						
						// 대출유형 셀렉 리스트 가져오기
						$.ajax({
							type : "post",
							url : "BMPurcDebtMgntAjax",
							dataType : "json",
							success : function(result) {
								var html = "";
								for(var i = 0; i < result.loanTypeDivList.length; i++) {
									html +=	"<option value=" + result.loanTypeDivList[i].LOAN_TYPE_NO+ ">" 
											+ result.loanTypeDivList[i].LOAN_TYPE_NAME + "</option>"; 
								}
					
								$("#loanTypeSlt").html(html);
							},
							error : function(request, status, error) {
								console.log("status : ", request.status);
								console.log("text : ", request.responseText);
								console.log("error : ", error);
							}
						});				
					}, "등록", function(){
						
						if($.trim($("#dlineDay").val()) == "") {
							makeAlert(2, "알림", "마감날짜를 입력하세요", true, null);
							$("#dlineDay").focus();
						} else if($.trim($("#cstmSlt").val()) == "") {
							makeAlert(2, "알림", "거래처를 입력하세요", true, null);
							$("#cstmSlt").focus();
						} else if($.trim($("#csptsNameSlt").val()) == "") {
							makeAlert(2, "알림", "적요명을 입력하세요", true, null);
							$("#csptsNameSlt").focus();
						} else if($.trim($("#loanTypeSlt").val()) == "") {
							makeAlert(2, "알림", "대출유형을 입력하세요", true, null);
							$("#loanTypeSlt").focus();
						} else if($.trim($("#loanAmt").val()) == "") {
							makeAlert(2, "알림", "채무금액을 입력하세요", true, null);
							$("#loanAmt").focus();
						} else {
							var params = $("#popupDataForm").serialize();
							
							$.ajax({
								type : "post",
								url : "BMPurcDebtNewRegAjax",
								dataType : "json",
								data : params,
								success : function(result){
									makeAlert(2, "알림", result.msg , true, null);
									reloadPurcDebtMgntList();
									closePopup(1);
								},
								error : function(request, status, error){
									console.log("status : " + request.status);
									console.log("text : " + request.responseText);
									console.log("error : " + error);
								}
							});	
						}
					});					
				
				});
				
				// 수정 버튼 클릭				
				$("#updateBtn").on("click", function()	{
					var checkFlag = 0;
					$("#purcDebtMgntTable tbody input[type='checkbox']:checked").each(function() {
						checkFlag++;
					});
					
					if(checkFlag == 1) {
						// 수정 makePopup
						makePopup(1, "매입채무 수정", purcDebtUpdatePopup(), true, 500, 500, function() {
							// datepicker 할당(calendar)
							$("#dlineDay").datepicker({
								dateFormat : 'yy-mm-dd',
								duration: 200,
								onSelect:function(dateText, inst){
									$("#dlineDayValue").val($("#dlineDay").val());
								}
							});
							// 거래처 셀렉 리스트 가져오기
							$.ajax({
								type : "post",
								url : "BMPurcDebtMgntAjax",
								dataType : "json",
								success : function(result) {
									var html = "";
									for(var i = 0; i < result.CstmDivList.length; i++) {
										html +=	"<option value=" + result.CstmDivList[i].CSTM_NO+ ">" 
												+ result.CstmDivList[i].CSTM_NAME + "</option>"; 
									}
									
									$("#cstmSlt").html(html);
									
									// 적요명 셀렉 리스트 가져오기
									$.ajax({
										type : "post",
										url : "BMPurcDebtMgntAjax",
										dataType : "json",
										success : function(result) {
											var html = "";
											for(var i = 0; i < result.CsptsNameDivList.length; i++) {
												html +=	"<option value=" + result.CsptsNameDivList[i].CSPTS_NO+ ">" 
														+ result.CsptsNameDivList[i].CSPTS_NAME + "</option>"; 
											}
											
											$("#csptsNameSlt").html(html);
											
											// 대출유형 셀렉 리스트 가져오기
											$.ajax({
												type : "post",
												url : "BMPurcDebtMgntAjax",
												dataType : "json",
												success : function(result) {
													var html = "";
													for(var i = 0; i < result.loanTypeDivList.length; i++) {
														html +=	"<option value=" + result.loanTypeDivList[i].LOAN_TYPE_NO+ ">" 
																+ result.loanTypeDivList[i].LOAN_TYPE_NAME + "</option>"; 
													}
										
													$("#loanTypeSlt").html(html);
											
											// 체크박스가 선택된 매입채무 정보 가져오기
											$("#sltedPurcDebtNo").val($("#purcDebtMgntTable tbody input[type='checkbox']:checked").val());
											var params = $("#popupDataForm").serialize();								
											
											$.ajax({
												type : "post",
												url : "BMSltedPurcDebtInfoAjax",
												dataType : "json",
												data : params,
												success : function(result) {
													$("#dlineDay").val(result.data.DLINE_DAY);
													$("#cstmSlt").val(result.data.CSTM_NO);
													$("#csptsNameSlt").val(result.data.CSPTS_NO); 
													$("#loanTypeSlt").val(result.data.LOAN_TYPE_NO);
													$("#loanAmt").val(result.data.LOAN_AMT);
													$("#memo").val(result.data.MEMO);
												},
												error : function(request, status, error) {
													console.log("status : ", request.status);
													console.log("text : ", request.responseText);
													console.log("error : ", error);
												}
											});
										},
										error : function(request, status, error) {
											console.log("status : ", request.status);
											console.log("text : ", request.responseText);
											console.log("error : ", error);
										}
									});	
								},
								error : function(request, status, error) {
									console.log("status : ", request.status);
									console.log("text : ", request.responseText);
									console.log("error : ", error);
								}
							});
						},
						error : function(request, status, error) {
							console.log("status : ", request.status);
							console.log("text : ", request.responseText);
							console.log("error : ", error);
						}
					});
					}, "수정", function(){
						
						if($.trim($("#dlineDay").val()) == "") {
							makeAlert(2, "알림", "마감날짜를 입력하세요", true, null);
							$("#dlineDay").focus();
						} else if($.trim($("#cstmSlt").val()) == "") {
							makeAlert(2, "알림", "거래처를 입력하세요", true, null);
							$("#cstmSlt").focus();
						} else if($.trim($("#csptsNameSlt").val()) == "") {
							makeAlert(2, "알림", "적요명을 입력하세요", true, null);
							$("#csptsNameSlt").focus();
						} else if($.trim($("#loanTypeSlt").val()) == "") {
							makeAlert(2, "알림", "대출유형을 입력하세요", true, null);
							$("#loanTypeSlt").focus();
						} else if($.trim($("#loanAmt").val()) == "") {
							makeAlert(2, "알림", "채무금액을 입력하세요", true, null);
							$("#loanAmt").focus();
						} else {
							var params = $("#popupDataForm").serialize();
							
							$.ajax({
								type : "post",
								url : "BMPurcDebtUpdateAjax",
								dataType : "json",
								data : params,
								success : function(result){
									makeAlert(2, "알림", result.msg , true, null);
									reloadPurcDebtMgntList();
									closePopup(1);
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
					
					$("#purcDebtMgntTable tbody input[type='checkbox']:checked").each(function() {
						checkFlag++;
					});
					
					if(checkFlag == 1){
							makeConfirm(1,"알림","삭제하시겠습니까?",true, function(){	
								$("#sltedDelPurcDebtNo").val($("#purcDebtMgntTable tbody input[type='checkbox']:checked").val());	
		
										var params = $("#delDataForm").serialize();
										
										$.ajax({
											type : "post",
											url : "BMPurcDebtDelAjax",
											dataType : "json",
											data : params,
											success : function(result){
												if(result.flag == 0){
													makeAlert(2, "오류", "삭제할 수 없는 항목입니다", true, null);
													reloadPurcDebtMgntList();
												} else {
													//성공
													makeAlert(2, "완료", "삭제 되었습니다", true, null);
													reloadPurcDebtMgntList();
												}
											},
											error : function(request, status, error){
												console.log("status : " + request.status);
												console.log("text : " + request.responseText);
												console.log("error : " + error);
											}
										});	
									});
								} else if(checkFlag == 0) {
									makeAlert(1, "알림", "데이터를 선택해주세요", true, null);
								} else {
									makeAlert(1, "알림", "데이터를 한 개만 선택해주세요", true, null);
								}
						});                
											
				
				// 상환(반환)버튼 클릭
				$("#btn_rpayRtn").on("click",function(){
					var checkFlag = 0;
					$("#purcDebtMgntTable tbody input[type='checkbox']:checked").each(function() {
						checkFlag++;
				});
				
					if(checkFlag == 1){
					// 상환 makePopup
						makePopup(1, "매입채무 상환", purcDebtRpayPopup(), true, 400, 200, function(){
							// datepicker 할당(calendar)
							$("#rpayRtnDay").datepicker({
								dateFormat : 'yy-mm-dd',
								duration: 200,
								minDate: $("#purcDebtMgntTable input[type='checkbox']:checked").parent().parent().children().eq(1).children().children().html().replace(/[/]/g, '-'),
								maxDate: new Date,
								onSelect:function(dateText, inst){
									$("#rpayRtnDayValue").val($("#rpayRtnDay").val());
								}
							});
							
							$("#sltedRpayRtnNo").val($("#purcDebtMgntTable tbody input[type='checkbox']:checked").val());						
						
						}, "상환",function(){
							if($.trim($("#rpayRtnDay").val()) == "") { 
								makeAlert(2, "알림", "상환일을 입력하세요", true, null);
								$("#rpayRtnDay").focus();
							} else if($.trim($("#rpayRtnAmt").val()) == "") {
								makeAlert(2, "알림", "상환금액을 입력하세요", true, null);
								$("#rpayRtnAmt").focus();
							} else {
								var params = $("#popupDataForm").serialize();
								
								$.ajax({
									type : "post",
									url : "BMRpayRtnAjax",
									dataType : "json",
									data : params,
									success : function(result){
										makeAlert(2, "알림", result.msg, true, null); 
										reloadPurcDebtMgntList();
										closePopup(1);
									},
									error : function(request, status, error){
										console.log("status : " + request.status);
										console.log("text : " + request.responseText);
										console.log("error : " + error);
									}
								});	
							}
						});
					} else if(checkFlag == 0) {
							makeAlert(1, "알림", "데이터를 선택해주세요", true, null);
					} else {
							makeAlert(1, "알림", "데이터를 한 개만 선택해주세요", true, null);
						}
					});	
				
				// 날짜 클릭으로 상세보기
				$("#purcDebtMgntTable").on("click", "#dtlHist", function()	{					
					
					$("#sltedDtlHistNo").val($(this).attr("name"));
					
					makePopup(1, "상세내역", dtlHistPopup(), true, 700, 700, function() {
						
						// 상세내역 정보 가져오기 (상환내역 제외)
						var params = $("#dtlForm").serialize();
						
						
						$.ajax({
							type : "post",
							url : "BMDtlHistAjax",
							dataType : "json",
							data : params,
							success : function(result) {
								$("#regDay").val(result.data.WRITE_DAY);
								$("#dlineDay").val(result.data.DLINE_DAY);
								$("#cstm").val(result.data.CSTM_NAME); 
								$("#csptsName").val(result.data.CSPTS_NAME);
								$("#loanType").val(result.data.LOAN_TYPE_NAME);
								$("#loanAmt").val(result.data.LOAN_AMT);
								$("#totalPstvProvAmt").val(result.data.TOTAL_PSTV_PROV_AMT);
								$("#totalNstvProvAmt").val(result.data.TOTAL_NSTV_PROV_AMT);
								$("#dtlMemo").val(result.data.MEMO);
								
							},
							error : function(request, status, error) {
								console.log("status : ", request.status);
								console.log("text : ", request.responseText);
								console.log("error : ", error);
							}
						});
						
						$.ajax({
							type : "post",
							url : "BMRpayRtnHistAjax",
							dataType : "json",
							data : params,
							success : function(result) {
								if(result.list.length != 0){
									var html = "";
									var cnt = 1;
									for(var i = 0; i < result.list.length; i++) {
										html +=	cnt + ". 상환일 : " + result.list[i].RPAY_DAY + "        작성일 : " + result.list[i].WRITE_DAY + "\n" +
										        "   작성자 : " + result.list[i].NAME + "            상환금액 : " + result.list[i].AMT + "\n\n";
										cnt ++;        
									}
									$("#rpayHist").val(html);
									}
							},
							error : function(request, status, error) {
								console.log("status : ", request.status);
								console.log("text : ", request.responseText);
								console.log("error : ", error);
							}
						});
						
						
					}, "확인", function() {
						closePopup(1);
					});	
				
				});	
		});
				
				
				
		// 조회 작업
		
		<%-- 적요명(셀렉트바) 가져오기 --%>
			function reloadCsptsList() {
				var params = $("#actionForm").serialize();
				
				$.ajax({
					type : "post",
					url : "BMPurcDebtMgntAjax",
					dataType : "json",
					data : params,
					success : function(result) {
						var html = "";
						html += "<option>전체</option>";
						for(var i = 0; i < result.CsptsNameDivList.length; i++) {
							html += "<option value=\"" + result.CsptsNameDivList[i].CSPTS_NO + "\">" + result.CsptsNameDivList[i].CSPTS_NAME + "</option>";
						}
						$("#CsptsNameDiv").html(html);
					},
					error : function(request, status, error) {
						console.log("status : ", request.status);
						console.log("text : ", request.responseText);
						console.log("error : ", error);
					}
				});
			}
			
			
			<%-- 거래처(셀렉트바) 가져오기 --%>
			function reloadCstmList() {
				var params = $("#actionForm").serialize();
				
				$.ajax({
					type : "post",
					url : "BMPurcDebtMgntAjax",
					dataType : "json",
					data : params,
					success : function(result) {
						var html = "";
						html += "<option>전체</option>";
						for(var i = 0; i < result.CstmDivList.length; i++) {
							html +=	"<option value=\"" + result.CstmDivList[i].CSTM_NO + "\">" + result.CstmDivList[i].CSTM_NAME + "</option>";
						}
						$("#CstmDiv").html(html);
					},
					error : function(request, status, error) {
						console.log("status : ", request.status);
						console.log("text : ", request.responseText);
						console.log("error : ", error);
					}
				});
			}
			
			<%-- 매입채무 리스트 가져오기 --%>
			function reloadPurcDebtMgntList() {
				var params = $("#actionForm").serialize();
				
				$.ajax({
					type : "post",
					url : "BMPurcDebtMgntAjax",
					dataType : "json",
					data : params,
					success : function(result) {
						redrawPurcDebtMgntList(result.list);
						redrawPaging(result.pb);
					},
					error : function(request, status, error) {
						console.log("status : " + request.status);
						console.log("text : " + request.responseText);
						console.log("error : " + error);
					}
				});
			}
			
			function redrawPurcDebtMgntList(list) {
				var html = "";
				
				if(list.length == 0) {
					html += "<td colspan=\"7\">조회할 수 있는 데이터가 없습니다</td>";
				} else {
					for(var i = 0; i < list.length; i++) {
						if(i%2 == 0) {
							html += "<tr class=\"top_tr\" name=\"" + list[i].LOAN_NO + "\">";
							html += "<td id=\"check" + i + "\"><input type=\"checkbox\" value=\""
							+ list[i].LOAN_NO + "\" /></td>"; 
							html += "<th><span><ins id=\"dtlHist\" name=\"" + list[i].LOAN_NO + "\">" + list[i].WRITE_DAY + "</ins></span></th>";
							html += "<td>" + list[i].CSTM_NAME + "</td>";
							html += "<td>" + list[i].CSPTS_NAME + "</td>";
							html += "<td>" + list[i].DLINE_DAY + "</td>";
							html += "<td>" + list[i].TOTAL_PSTV_PROV_AMT + "</td>";
							html += "<td>" + list[i].TOTAL_NSTV_PROV_AMT + "</td>";
							html += "</tr>";
						} else {
							html += "<tr class=\"bottom_tr\" name=\"" + list[i].LOAN_NO + "\">";
							html += "<td id=\"check" + i + "\"><input type=\"checkbox\" value=\""
							+ list[i].LOAN_NO + "\" /></td>";
							html += "<th><span><ins id=\"dtlHist\" name=\"" + list[i].LOAN_NO + "\">" + list[i].WRITE_DAY + "</ins></span></th>";
							html += "<td>" + list[i].CSTM_NAME + "</td>";
							html += "<td>" + list[i].CSPTS_NAME + "</td>";
							html += "<td>" + list[i].DLINE_DAY + "</td>";
							html += "<td>" + list[i].TOTAL_PSTV_PROV_AMT + "</td>";
							html += "<td>" + list[i].TOTAL_NSTV_PROV_AMT + "</td>";
							html += "</tr>";
						}
					}
				} 
				
				$("#purcDebtMgntTable tbody").html(html);
			}
			
			<%-- 페이징 --%>
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
			   }
			
			
			// 신규등록 팝업 내용
			function loanNewRegPopup() {
				var html = "";
				
				html += "<form action=\"#\" method=\"post\" id=\"popupDataForm\">";
				
				html += "<div class=\"regPage_contents_title\">마감날짜(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"dlineDay\" name=\"dlineDay\" value=\"\" readonly=\"readonly\" />";
				html += "</div>";
				html += "<br/>";
				
				html += "<div class=\"regPage_contents_title\">거래처(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<select class=\"slt\" id=\"cstmSlt\" name=\"cstmSlt\">";
				html += "</select>";
				html += "</div>";
				html += "<br/>";
				
				html += "<div class=\"regPage_contents_title\">적요명(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<select class=\"slt\" id=\"csptsNameSlt\" name=\"csptsNameSlt\">";
				html += "</select>";
				html += "</div>";
				html += "<br/>";
				
				
				html += "<div class=\"regPage_contents_title\">대출유형(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<select class=\"slt\" id=\"loanTypeSlt\" name=\"loanTypeSlt\">";
				html += "</select>";
				html += "</div>";
				html += "<br/>";
				
				
				html += "<div class=\"regPage_contents_title\">채무금액(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"loanAmt\" name=\"loanAmt\">";
				html += "</div>";
				html += "<br/>";
				
				html += "<div class=\"regPage_contents_title\">메모</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<textarea class=\"txt\" id=\"memo\" name=\"memo\"></textarea>";
				html += "</div>";
				html += "<br/>";
				html += "</form>";
				
				return html;
			}
			
			
			// 수정 팝업 내용
			function purcDebtUpdatePopup() {
				var html = "";
				
				html += "<form action=\"#\" method=\"post\" id=\"popupDataForm\">";
				html += "<input type=\"hidden\" id=\"sltedPurcDebtNo\" name=\"sltedPurcDebtNo\" value=\"\" />";
				html += "<div class=\"regPage_contents_title\">마감날짜(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"dlineDay\" name=\"dlineDay\" value=\"\" readonly=\"readonly\" />";
				html += "</div>";
				html += "<br/>";
				
				html += "<div class=\"regPage_contents_title\">거래처(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<select class=\"slt\" id=\"cstmSlt\" name=\"cstmSlt\">";
				html += "</select>";
				html += "</div>";
				html += "<br/>";
				
				html += "<div class=\"regPage_contents_title\">적요명(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<select class=\"slt\" id=\"csptsNameSlt\" name=\"csptsNameSlt\">";
				html += "</select>";
				html += "</div>";
				html += "<br/>";
				
				
				html += "<div class=\"regPage_contents_title\">대출유형(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<select class=\"slt\" id=\"loanTypeSlt\" name=\"loanTypeSlt\">";
				html += "</select>";
				html += "</div>";
				html += "<br/>";
				
				
				html += "<div class=\"regPage_contents_title\">채무금액(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"loanAmt\" name=\"loanAmt\">";
				html += "</div>";
				html += "<br/>";
				
				html += "<div class=\"regPage_contents_title\">메모</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<textarea class=\"txt\" id=\"memo\" name=\"memo\"></textarea>";
				html += "</div>";
				html += "<br/>";
				html += "</form>";
				
				return html;
			}
			
			// 상환 팝업 내용
			function purcDebtRpayPopup() {
				var html = "";
				
				html += "<form action=\"#\" method=\"post\" id=\"popupDataForm\">";
				html += "<input type=\"hidden\" id=\"sltedRpayRtnNo\" name=\"sltedRpayRtnNo\" value=\"\" />";
				html += "<div class=\"regPage_contents_title\">상환일(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"rpayRtnDay\" name=\"rpayRtnDay\" value=\"\" readonly=\"readonly\" />";
				html += "</div>";
				html += "<br/>";
				
				html += "<div class=\"regPage_contents_title\">상환금액(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"rpayRtnAmt\" name=\"rpayRtnAmt\">"; 
				html += "</div>";
				html += "<br/>";
		
				return html;
			}
			
			
			// 상세보기
			function dtlHistPopup() {
				var html = "";
				
				html += "<form action=\"#\" method=\"post\" id=\"popupDataForm\">";
				html += "<div class=\"regPage_contents_title\">등록날짜</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"regDay\" name=\"regDay\" value=\"\" readonly=\"readonly\" />";
				html += "<div class=\"data_search_icon\"></div>"
				html += "</div>";
				
				
				html += "<div class=\"regPage_contents_title\">마감날짜</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"dlineDay\" name=\"dlineDay\" value=\"\" readonly=\"readonly\" />";
				html += "<div class=\"data_search_icon\"></div>"
				html += "</div>";
				html += "<br/>";
				
				html += "<div class=\"regPage_contents_title\">거래처</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"cstm\" name=\"cstm\" value=\"\" readonly=\"readonly\" />";
				html += "<div class=\"data_search_icon\"></div>"
				html += "</div>";
				
				html += "<div class=\"regPage_contents_title\">적요명</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"csptsName\" name=\"csptsName\" value=\"\" readonly=\"readonly\" />";
				html += "<div class=\"data_search_icon\"></div>"
				html += "</div>";
				html += "<br/>";
				
				html += "<div class=\"regPage_contents_title\">대출유형</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"loanType\" name=\"loanType\" value=\"\" readonly=\"readonly\" />";
				html += "<div class=\"data_search_icon\"></div>"
				html += "</div>";
				
				html += "<div class=\"regPage_contents_title\">채무금액</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"loanAmt\" name=\"loanAmt\" value=\"\" readonly=\"readonly\" />";
				html += "<div class=\"data_search_icon\"></div>"
				html += "</div>";
				html += "<br/>";
				
				html += "<div class=\"regPage_contents_title\">총기지급액</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"totalPstvProvAmt\" name=\"totalPstvProvAmt\" value=\"\" readonly=\"readonly\" />";
				html += "<div class=\"data_search_icon\"></div>"
				html += "</div>";
				
				html += "<div class=\"regPage_contents_title\">총미지급액</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"totalNstvProvAmt\" name=\"totalNstvProvAmt\" value=\"\" readonly=\"readonly\" />";
				html += "<div class=\"data_search_icon\"></div>"
				html += "</div>";
				html += "<br/>";
				
				html += "<div class=\"regPage_contents_title\">메모</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<textarea class=\"txt\" id=\"dtlMemo\" name=\"dtlMemo\" readonly=\"readonly\"></textarea>";
				html += "</div>";
				html += "<br/>";
				html += "<br/>";
				html += "<br/>";
				html += "<br/>";
				html += "<br/>";
				
				html += "<div class=\"regPage_contents_title\">상환내역</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<textarea class=\"txt\" id=\"rpayHist\" name=\"rpayHist\" readonly=\"readonly\"></textarea>";
				html += "</div>";
				html += "<br/>";
				html += "</form>";
				
				return html;
			}
									
			
		</script>
   
   </head>
   
   
   <body>

		<form action="#" method="post" id="delDataForm">
			<input type="hidden" id="sltedDelPurcDebtNo" name="sltedDelPurcDebtNo" value="" />
		</form>
		
		<form action="#" method="post" id="dtlForm">
			<input type="hidden" id="sltedDtlHistNo" name="sltedDtlHistNo" value="" />
		</form>
		
		<c:import url="/topLeft">
			<c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
			<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param>
		</c:import>	
		
      <!-- 내용 영역 -->
      <div class="content_area">
         <!-- 메뉴 네비게이션 -->
         <div class="content_nav">HeyWe &gt; 경영관리 &gt; 대출 관리 &gt; 매입채무 관리</div>
         <!-- 현재 메뉴 제목 -->
         <div class="content_title">매입채무 관리</div>
         <br/>

         <!-- 내용 영역 -->
         <form action="#" id="actionForm" method="post">
         <div class="data_search_area">
         
            <input type="hidden" id="stdt" name="stdt" value="${stdt}" />
			<input type="hidden" id="eddt" name="eddt" value="${eddt}" />
			<input type="hidden" id="page" name="page" >
			<!-- 기준일자 시작일 -->
			
            <div class="data_search_menu">등록날짜</div>
            <div class="data_search_input">
               <input type="text"  title="날짜선택" id="date_start" name="date_start" readonly="readonly" />
            </div>
            
            <div class="data_search_icon">~</div>
            
            
            <!-- 기준일자 마지막일 -->
            
            <div class="data_search_input">
               <input type="text"  title="날짜선택" id="date_end" name="date_end" readonly="readonly" />
            </div>
            <div class="data_search_icon">
               <img alt="reset" src="resources/images/erp/gw/ea/reset.png" />
            </div>
            
            <br/>
            
            <div class="data_search_menu">적요명</div>
            <div class="data_search_input">
               <select class="slt" id="CsptsNameDiv" name="CsptsNameDiv"></select>
            </div>
            
            <div class="data_search_menu">거래처</div>
            <div class="data_search_input">
               <select class="slt" id="CstmDiv" name="CstmDiv"></select>
            </div>
            
            <div class="data_search_btn">
               <input type="button" value="검색" class="searchBtn" id="searchBtn"/>
            </div>
         </div>
         </form>
         
         <br/>
         
         <div class="data_info_area">
            
            <table class="data_info_table" id="purcDebtMgntTable">
               <colgroup>
                  <col width="50"/>
                  <col width="150"/>
                  <col width="100"/>
                  <col width="150"/>
                  <col width="100"/>
                  <col width="200"/>
                  <col width="200"/>
               </colgroup>
               
               <thead>
               <tr class="first_tr">
                  <td><input type="checkbox" id="check_all"/></td>
                  <th>등록날짜</th>
                  <th>거래처</th>
                  <th>적요명</th>
                  <th>마감일</th>
                  <th>기지급액</th>
                  <th>미지급액</th>
               </tr>
               </thead>
               
               <tbody>

               </tbody>
            
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
               <div class="btn_area"><input type="button" value="상환하기" class="btn" id="btn_rpayRtn"/></div>
               <div class="btn_area"><input type="button" value="신규등록" class="btn" id="btn_newReg"/></div>
            </div>
         </div>
      </div>
   </body>
</html>