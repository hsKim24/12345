<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>비용관리</title>
		<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.min.css" />
		<link rel="stylesheet" type="text/css" href="resources/css/common/calendar.css" />
		<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css"/>
		<link rel="stylesheet" type="text/css" href="resources/css/erp/bm/costMgnt/costStyle.css" />
		<script type="text/javascript"
				src="resources/script/jquery/jquery-1.12.4.min.js"></script>
		<script type="text/javascript" src="resources/script/jquery/jquery-ui.min.js"></script>
		<!-- calendar Script -->
		<script type="text/javascript" src="resources/script/calendar/calendar.js"></script>
		<script type="text/javascript">
			$(document).ready(function () {
				// 검색
				$("#searchBtn").on("click", function() {
					$("#page").val("1");
					reloadCostMgntList();
				});
				// 페이징
				$("#pagingArea").on("click", "input", function() {
					$("#page").val($(this).attr("name"));
					reloadCostMgntList();
				});
				// 비용관리 기준일자
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
				// 비용관리 시작일자
				$("#date_start").datepicker({
					dateFormat : 'yy-mm-dd',
					duration: 200,
					onSelect:function(dateText, inst){
						var startDate = parseInt($("#date_start").val().replace("-", '').replace("-", ''));
						$("#eprtnDateValue").val($("#date_start").val());
						console.log(startDate);
					}
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
					
					$("#costMgntTable tbody input[type='checkbox']").each(function() {
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
				
				// 상세보기
				$("#DivBtn").on("click", function name() {
					var checkFlag = 0;
					$("#costMgntTable tbody input[type='checkbox']:checked").each(function() {
								checkFlag++;
					});
	    			if(checkFlag == 1) {
						/* $("#costDivNo").val($(this).parent().attr("name")); */
						makeNoBtnPopup(1, "상세보기", costDivPopUp(), true, 500, 460, function() {
		    				$("#sltedCostMgntNo").val($("#costMgntTable tbody input[type='checkbox']:checked").val());
							console.log($("#sltedCostMgntNo").val());
							var params = $("#costDivForm").serialize();
							console.log(params);
							// 체크박스가 선택된 비용 정보 가져오기
							$.ajax({
								type : "post",
								url : "BMSltedCostInfoAjax",
								dataType : "json",
								data : params,
								success : function(result) {
									console.log(result);
									$("#popup_date_start").val(result.data.COST_DATE);
									$("#type").val(result.data.TYPE_NAME);
									$("#unitSbj").val(result.data.UNIT_SBJ_NAME);
									$("#expsType").val(result.data.EXPS_TYPE_NAME);
									$("#amt").val(result.data.AMT);
									$("#empName").val(result.data.EMP_NAME);
								},
								error : function(request, status, error) {
									console.log("status : ", request.status);
									console.log("text : ", request.responseText);
									console.log("error : ", error);
								}
							});
						}, function() {
							closePopup(1);
						});
					} else if(checkFlag == 0) {
						makeAlert(1, "알림", "데이터를 선택해주세요", true, null);
					} else {
						makeAlert(1, "알림", "데이터를 한 개만 선택해주세요", true, null);
					}
				});
				 
	                <%-- 신규등록 팝업 --%>
	    			$("#newReg").on("click", function()	{
	    				makePopup(1, "비용 신규등록", costMgntNewRegPopup(), true, 500, 460, function() {
	    					<%-- 분류(셀렉트바) 가져오기 --%>
	    					$.ajax({
	    						type : "post",
	    						url : "BMCostMgntAjax",
	    						dataType : "json",
	    						success : function(result) {
	    							var html = "";
	    							for(var i = 0; i < result.typeList.length; i++) {
	    								html +=	"<option value=" + result.typeList[i].TYPE_NO + ">" 
	    								+ result.typeList[i].TYPE_NAME + "</option>"; 
	    							}
	    							$("#type").html(html);
	    						},
	    						error : function(request, status, error) {
	    							console.log("status : ", request.status);
	    							console.log("text : ", request.responseText);
	    							console.log("error : ", error);
	    						}
	    					});
	    					<%-- 지출유형(셀렉트바) 가져오기 --%>
	    					$.ajax({
	    						type : "post",
	    						url : "BMCostMgntAjax",
	    						dataType : "json",
	    						success : function(result) {
	    							var html = "";
	    							for(var i = 0; i < result.expsTypeList.length; i++) {
	    								html +=	"<option value=" + result.expsTypeList[i].EXPS_NO + ">" 
	    								+ result.expsTypeList[i].EXPS_NAME + "</option>"; 
	    							}
	    							$("#expsType").html(html);
	    						},
	    						error : function(request, status, error) {
	    							console.log("status : ", request.status);
	    							console.log("text : ", request.responseText);
	    							console.log("error : ", error);
	    						}
	    					});
	    					<%-- 계정과목(셀렉트바) 가져오기 --%>
	    					$.ajax({
	    						type : "post",
	    						url : "BMCostMgntAjax",
	    						dataType : "json",
	    						success : function(result) {
	    							var html = "";
	    							for(var i = 0; i < result.unitSbjList.length; i++) {
	    								html +=	"<option value=" + result.unitSbjList[i].UNIT_SBJ_NO + ">" 
	    								+ result.unitSbjList[i].UNIT_SBJ_NAME + "</option>"; 
	    							}
	    							$("#unitSbj").html(html);
	    						},
	    						error : function(request, status, error) {
	    							console.log("status : ", request.status);
	    							console.log("text : ", request.responseText);
	    							console.log("error : ", error);
	    						}
	    					});
	    					<%-- 이름(셀렉트바) 가져오기 --%>
	    					$.ajax({
	    						type : "post",
	    						url : "BMCostMgntAjax",
	    						dataType : "json",
	    						success : function(result) {
	    							var html = "";
	    							for(var i = 0; i < result.empNameList.length; i++) {
	    								html +=	"<option value=" + result.empNameList[i].EMP_NO + ">" 
	    								+ result.empNameList[i].EMP_NAME + "</option>"; 
	    							}
	    							$("#empName").html(html);
	    						},
	    						error : function(request, status, error) {
	    							console.log("status : ", request.status);
	    							console.log("text : ", request.responseText);
	    							console.log("error : ", error);
	    						}
	    					});
	    					
	    					$("#popup_date_start").datepicker({
	    						dateFormat : 'yy-mm-dd',
	    						duration: 200,
	    						onSelect:function(dateText, inst){
	    							var startDate = parseInt($("#popup_date_start").val().replace("-", '').replace("-", ''));
	    						}
	    					});
	    				}, "등록", function(){
	    					
	    					if($.trim($("#popup_date_start").val()) == "") {
	    						makeAlert(2, "알림", "날짜를 선택해주세요", true, null);
	    						$("#popup_date_start").focus();
	    					} else if($.trim($("#type").val()) == "") {
	    						makeAlert(2, "알림", "분류를 선택해주세요", true, null);
	    						$("#type").focus();
	    					} else if($.trim($("#unitSbj").val()) == "") {
	    						makeAlert(2, "알림", "계정과목을 선택해주세요", true, null);
	    						$("#unitSbj").focus();
	    					} else if($.trim($("#expsType").val()) == "") {
	    						makeAlert(2, "알림", "지출유형을 선택해주세요", true, null);
	    						$("#expsType").focus();
	    					} else if($.trim($("#amt").val()) == "") {
	    						makeAlert(2, "알림", "금액을 선택해주세요", true, null);
	    						$("#amt").focus();
	    					} else if($.trim($("#empName").val()) == "") {
	    						makeAlert(2, "알림", "이름을 선택해주세요", true, null);
	    						$("#empName").focus();
	    					} else {
	    						var params = $("#popupDataForm").serialize();
	    						
	    						$.ajax({
	    							type : "post",
	    							url : "BMCostMgntNewRegAjax",
	    							dataType : "json",
	    							data : params,
	    							success : function(result){
	    								
	    								makeAlert(2, "알림", result.msg, true, null);	
	    								reloadCostMgntList();
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
	    			
    			// 비용관리 수정 시작
    			$("#UpdateBtn").on("click", function()	{
					var checkFlag = 0;
					
					$("#costMgntTable tbody input[type='checkbox']:checked").each(function() {
								checkFlag++;
					});
					
    			if(checkFlag == 1) {
					// 수정 makePopup
					makePopup(1, "비용관리 수정", costMgntUpdatePopup(), true, 500, 450, function() {
						// datepicker 할당(calendar)
						$("#popup_date_start").datepicker({
							dateFormat : 'yy-mm-dd',
							duration: 200,
							onSelect:function(dateText, inst){
								var startDate = parseInt($("#popup_date_start").val().replace("-", '').replace("-", ''));
							}
						});
						<%-- 분류(셀렉트바) 가져오기 --%>
    					$.ajax({
    						type : "post",
    						url : "BMCostMgntAjax",
    						dataType : "json",
    						success : function(result) {
    							var html = "";
    							for(var i = 0; i < result.typeList.length; i++) {
    								html +=	"<option value=" + result.typeList[i].TYPE_NO + ">" 
    								+ result.typeList[i].TYPE_NAME + "</option>"; 
    							}
    							$("#type").html(html);
    							
    							<%-- 지출유형(셀렉트바) 가져오기 --%>
    	    					$.ajax({
    	    						type : "post",
    	    						url : "BMCostMgntAjax",
    	    						dataType : "json",
    	    						success : function(result) {
    	    							var html = "";
    	    							for(var i = 0; i < result.expsTypeList.length; i++) {
    	    								html +=	"<option value=" + result.expsTypeList[i].EXPS_NO + ">" 
    	    								+ result.expsTypeList[i].EXPS_NAME + "</option>"; 
    	    							}
    	    							$("#expsType").html(html);
    	    							
    	    							<%-- 계정과목(셀렉트바) 가져오기 --%>
    	    	    					$.ajax({
    	    	    						type : "post",
    	    	    						url : "BMCostMgntAjax",
    	    	    						dataType : "json",
    	    	    						success : function(result) {
    	    	    							var html = "";
    	    	    							for(var i = 0; i < result.unitSbjList.length; i++) {
    	    	    								html +=	"<option value=" + result.unitSbjList[i].UNIT_SBJ_NO + ">" 
    	    	    								+ result.unitSbjList[i].UNIT_SBJ_NAME + "</option>"; 
    	    	    							}
    	    	    							$("#unitSbj").html(html);
    	    	    							
    	    	    							<%-- 이름(셀렉트바) 가져오기 --%>
    	    	    	    					$.ajax({
    	    	    	    						type : "post",
    	    	    	    						url : "BMCostMgntAjax",
    	    	    	    						dataType : "json",
    	    	    	    						success : function(result) {
    	    	    	    							var html = "";
    	    	    	    							for(var i = 0; i < result.empNameList.length; i++) {
    	    	    	    								html +=	"<option value=" + result.empNameList[i].EMP_NO + ">" 
    	    	    	    								+ result.empNameList[i].EMP_NAME + "</option>"; 
    	    	    	    							}
    	    	    	    							$("#empName").html(html);
    	    	    	    							
    	    	    	    							// 체크박스가 선택된 비용 정보 가져오기
    	    	    	    							$("#sltedCostMgntNo").val($("#costMgntTable tbody input[type='checkbox']:checked").val());
    	    	    	    							var params = $("#popupDataForm").serialize();
    	    	    	    							console.log(params);
    	    	    	    							$.ajax({
    	    	    	    								type : "post",
    	    	    	    								url : "BMSltedCostInfoAjax",
    	    	    	    								dataType : "json",
    	    	    	    								data : params,
    	    	    	    								success : function(result) {
    	    	    	    									console.log(result);
    	    	    	    									$("#popup_date_start").val(result.data.COST_DATE);
    	    	    	    									
    	    	    	    									$(".popup_mid #type option").each(function() {
    	    	    	    										if($(this).html() == result.data.TYPE_NAME) {
    	    	    	    											$(".popup_mid #type").val($(this).val());
    	    	    	    										}
    	    	    	    									});
    	    	    	    									
    	    	    	    									$(".popup_mid #unitSbj option").each(function() {
    	    	    	    										if($(this).html() == result.data.UNIT_SBJ_NAME) {
    	    	    	    											$(".popup_mid #unitSbj").val($(this).val());
    	    	    	    										}
    	    	    	    									});
    	    	    	    									
    	    	    	    									$(".popup_mid #expsType option").each(function() {
    	    	    	    										if($(this).html() == result.data.EXPS_TYPE_NAME) {
    	    	    	    											$(".popup_mid #expsType").val($(this).val());
    	    	    	    										}
    	    	    	    									});
    	    	    	    									
    	    	    	    									$(".popup_mid #empName option").each(function() {
    	    	    	    										if($(this).html() == result.data.EMP_NAME) {
    	    	    	    											$(".popup_mid #empName").val($(this).val());
    	    	    	    										}
    	    	    	    									});
    	    	    	    									
    	    	    	    									$("#amt").val(result.data.AMT);
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
    						},
    						error : function(request, status, error) {
    							console.log("status : ", request.status);
    							console.log("text : ", request.responseText);
    							console.log("error : ", error);
    						}
    					});
    					
    					$("#popup_date_start").datepicker({
    						dateFormat : 'yy-mm-dd',
    						duration: 200,
    						onSelect:function(dateText, inst){
    							var startDate = parseInt($("#popup_date_start").val().replace("-", '').replace("-", ''));
    						}
    					});
    				}, "등록", function(){
    					
    					if($.trim($("#popup_date_start").val()) == "") {
    						makeAlert(2, "알림", "날짜를 입력하세요", true, null);
    						$("#popup_date_start").focus();
    					} else if($.trim($("#type").val()) == "") {
    						makeAlert(2, "알림", "분류를 선택하세요", true, null);
    						$("#type").focus();
    					} else if($.trim($("#unitSbj").val()) == "") {
    						makeAlert(2, "알림", "계정과목을 선택하세요", true, null);
    						$("#unitSbj").focus();
    					} else if($.trim($("#expsType").val()) == "") {
    						makeAlert(2, "알림", "지출유형을 선택하세요", true, null);
    						$("#expsType").focus();
    					} else if($.trim($("#amt").val()) == "") {
    						makeAlert(2, "알림", "금액을 선택하세요", true, null);
    						$("#amt").focus();
    					} else if($.trim($("#empName").val()) == "") {
    						makeAlert(2, "알림", "이름을 선택하세요", true, null);
    						$("#empName").focus();
    					} else {
    						var params = $("#popupDataForm").serialize();
    						
    						$.ajax({
    							type : "post",
    							url : "BMCostMgntUpdateAjax",
    							dataType : "json",
    							data : params,
    							success : function(result){
    								makeAlert(2, "알림", result.msg, true, null);	
    								reloadCostMgntList();
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
   			}); // 수정 끝
  		// 삭제 버튼 클릭
		$("#delBtn").on("click", function() {
			var checkFlag = 0;
			
			$("#costMgntTable tbody input[type='checkbox']:checked").each(function() {
						checkFlag++;
			});
					
		   	if(checkFlag == 1) {
				$("#sltedCostMgntNo").val($("#costMgntTable tbody input[type='checkbox']:checked").val());
					makeConfirm(1, "삭제", "삭제하시겠습니까", true, function () {
						
						var params = $("#delDataForm").serialize();
						
						$.ajax({
							type : "post",
							url : "BMCostMgntDelAjax",
							dataType : "json",
							data : params,
							success : function(result){
								if(result.flag == 1){
									console.log(result);
									makeAlert(2, "알림", result.msg, true, null);									
									reloadCostMgntList();							
								} else{
									makeAlert(2, "알림", result.msg, true, null);								
								}
							},
							error : function(request, status, error){
								console.log("status : " + request.status);
								console.log("text : " + request.responseText);
								console.log("error : " + error);
							}
						});
					})
		   	} else if(checkFlag == 0) {
				makeAlert(1, "알림", "데이터를 선택해주세요", true, null);
						
			} else {
				makeAlert(1, "알림", "데이터를 한 개만 선택해주세요", true, null);
			}
		});
			 
			if($("#page").val() == "") {
				$("#page").val("1");
			}
			
			// 변수 부르기
			reloadCostMgntList();
			reloadunitSbjList();
			reloadexpsTypeList();
			reloadtypeList();
			reloadempNameList();
			
			});
			<%-- 계정과목(셀렉트바) 가져오기 --%> // 접대비, 외식 , 등등
			function reloadunitSbjList() {
				var params = $("#actionForm").serialize();
				
				$.ajax({
					type : "post",
					url : "BMCostMgntAjax",
					dataType : "json",
					data : params,
					success : function(result) {
						var html = "";
						html += "<option>전체</option>";
						for(var i = 0; i < result.unitSbjList.length; i++) {
							html +=	"<option value=" + result.unitSbjList[i].UNIT_SBJ_NO + ">" 
							+ result.unitSbjList[i].UNIT_SBJ_NAME + "</option>"; 
						}
						$("#unitSbj").html(html);
					},
					error : function(request, status, error) {
						console.log("status : ", request.status);
						console.log("text : ", request.responseText);
						console.log("error : ", error);
					}
				});
			}
			
			<%-- 지출유형(셀렉트바) 가져오기 --%> // 카드 , 현금
			function reloadexpsTypeList() {
				var params = $("#actionForm").serialize();
				
				$.ajax({
					type : "post",
					url : "BMCostMgntAjax",
					dataType : "json",
					data : params,
					success : function(result) {
						var html = "";
						html += "<option>전체</option>";
						for(var i = 0; i < result.expsTypeList.length; i++) {
							html +=	"<option value=" + result.expsTypeList[i].EXPS_NO + ">" 
							+ result.expsTypeList[i].EXPS_NAME + "</option>"; 
						}
						$("#expsType").html(html);
					},
					error : function(request, status, error) {
						console.log("status : ", request.status);
						console.log("text : ", request.responseText);
						console.log("error : ", error);
					}
				});
			}
			
			<%-- 분류유형(셀렉트바) 가져오기 --%> // 개인 , 공용
			function reloadtypeList() {
				var params = $("#actionForm").serialize();
				
				$.ajax({
					type : "post",
					url : "BMCostMgntAjax",
					dataType : "json",
					data : params,
					success : function(result) {
						var html = "";
						html += "<option>전체</option>";
						for(var i = 0; i < result.typeList.length; i++) {
							html +=	"<option value=" + result.typeList[i].TYPE_NO + ">" 
							+ result.typeList[i].TYPE_NAME + "</option>"; 
						}
						$("#type").html(html);
					},
					error : function(request, status, error) {
						console.log("status : ", request.status);
						console.log("text : ", request.responseText);
						console.log("error : ", error);
					}
				});
			}
			<%-- 이름(셀렉트바) 가져오기 --%> // 개인 , 공용
			function reloadempNameList() {
				var params = $("#actionForm").serialize();
				
				$.ajax({
					type : "post",
					url : "BMCostMgntAjax",
					dataType : "json",
					data : params,
					success : function(result) {
						var html = "";
						html += "<option>전체</option>";
						for(var i = 0; i < result.empNameList.length; i++) {
							html +=	"<option value=" + result.empNameList[i].EMP_NO + ">" 
							+ result.empNameList[i].EMP_NAME + "</option>"; 
						}
						$("#empName").html(html);
					},
					error : function(request, status, error) {
						console.log("status : ", request.status);
						console.log("text : ", request.responseText);
						console.log("error : ", error);
					}
				});
			}
			
			<%-- 비용관리 리스트 가져오기 --%>
			function reloadCostMgntList() {
				var params = $("#actionForm").serialize();
				
				$.ajax({
					type : "post",
					url : "BMCostMgntAjax",
					dataType : "json",
					data : params,
					success : function(result) {
						console.log(result.pb);
						redrawCostMgntList(result.list);
						redrawPaging(result.pb);
					},
					error : function(request, status, error) {
						console.log("status : " + request.status);
						console.log("text : " + request.responseText);
						console.log("error : " + error);
					}
				});
			}
			
			<%-- 비용관리 리스트 그리기 --%>
			function redrawCostMgntList(list) {
				var html = "";
				if(list.length == 0) {
					html += "<tr><td colspan=\"7\">조회할 수 있는 데이터가 없습니다</td></tr>";
				}else{
					for(var i = 0; i < list.length; i++) {
						if(i%2 == 0) {
							html += "<tr class=\"top_tr\" id = \"costNo\"name=\"" + list[i].COST_NO + "\">";
							html += "<td id=\"check" + i + "\"><input type=\"checkbox\" value=\""
									+ list[i].COST_NO + "\" /></td>";
							html += "<td id = \"costDiv\">" + list[i].COST_DATE + "</td>";
							html += "<td>" + list[i].TYPE_NAME + "</td>";
							html += "<td>" + list[i].EXPS_TYPE_NAME + "</td>";
							html += "<td>" + list[i].UNIT_SBJ_NAME + "</td>";
							html += "<td>" + list[i].AMT + "</td>";
							html += "</tr>";
						} else {
							html += "<tr class=\"bottom_tr\" id = \"costNo\"name=\"" + list[i].COST_NO + "\">";
							html += "<td id=\"check" + i + "\"><input type=\"checkbox\" value=\""
									+ list[i].COST_NO + "\" /></td>";
							html += "<td id = \"costDiv\">" + list[i].COST_DATE + "</td>";
							html += "<td>" + list[i].TYPE_NAME + "</td>";
							html += "<td>" + list[i].EXPS_TYPE_NAME + "</td>";
							html += "<td>" + list[i].UNIT_SBJ_NAME + "</td>";
							html += "<td>" + list[i].AMT + "</td>";
							html += "</tr>";
						}
					}
				}
				
				$("#costMgntTable tbody").html(html);
			}
		
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
			
			
			// 신규등록 팝업 내용
			function costMgntNewRegPopup() {
				var html = "";
				
				html += "<form action=\"#\" method=\"post\" id=\"popupDataForm\">";
				html += "<div class=\"regPage_contents_title\">날짜(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\"  title=\"시작기간선택\" id=\"popup_date_start\" name=\"popup_date_start\" value=\"\" readonly=\"readonly\" />";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">분류(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<select class=\"slt\" id=\"type\" name=\"type\">";
				html += "</select>";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">계정과목(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<select class=\"slt\" id=\"unitSbj\" name=\"unitSbj\">";
				html += "</select>";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">지출유형(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<select class=\"slt\" id=\"expsType\" name=\"expsType\">";
				html += "</select>";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">이름(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<select class=\"slt\" id=\"empName\" name=\"empName\">";
				html += "</select>";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">금액(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"amt\" name=\"amt\"/>";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">메모</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"memo\" name=\"memo\"/>";
				html += "</div>";
				html += "</form>";
				
				return html;
			}		
			
			// 수정 팝업 contents
			function costMgntUpdatePopup() {
				var html = "";
				
				html += "<form action=\"#\" method=\"post\" id=\"popupDataForm\">";
				html += "<input type=\"hidden\" id=\"sltedCostMgntNo\" name=\"sltedCostMgntNo\" value=\"\" />";
				html += "<div class=\"regPage_contents_title\">날짜(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\"  title=\"시작기간선택\" id=\"popup_date_start\" name=\"popup_date_start\"\"value=\" readonly=\"readonly\"\"/>";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">분류(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<select class=\"slt\" id=\"type\" name=\"type\"value=\"\">";
				html += "</select>";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">계정과목(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<select class=\"slt\" id=\"unitSbj\" name=\"unitSbj\" value=\"\">";
				html += "</select>";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">지출유형(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<select class=\"slt\" id=\"expsType\" name=\"expsType\"value=\"\">";
				html += "</select>";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">이름(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<select class=\"slt\" id=\"empName\" name=\"empName\"value=\"\">";
				html += "</select>";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">금액(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"amt\" name=\"amt\"/value=\"\">";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">메모</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"memo\" name=\"memo\"/value=\"\">";
				html += "</div>";
				html += "</form>";
				
				return html;
			}	// 수정 팝업 contents (끝)
			
			// 상세보기 팝업 contents
			function costDivPopUp() {
				var html = "";
				
				html += "<form action=\"#\" method=\"post\" id=\"costDivForm\">";
				html += "<input type=\"hidden\" id=\"sltedCostMgntNo\" name=\"sltedCostMgntNo\" value=\"\" />";
				html += "<div class=\"regPage_contents_title\">날짜(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"popup_date_start\" name=\"popup_date_start\"/value=\"\"readonly=\"readonly\">";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">분류(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"type\" name=\"type\"/value=\"\"readonly=\"readonly\">";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">계정과목(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"unitSbj\" name=\"unitSbj\"/value=\"\"readonly=\"readonly\">";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">지출유형(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"expsType\" name=\"expsType\"/value=\"\"readonly=\"readonly\">";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">이름(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"empName\" name=\"empName\"/value=\"\"readonly=\"readonly\">";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">금액(*)</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"amt\" name=\"amt\"/value=\"\"readonly=\"readonly\">";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">메모</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"memo\" name=\"memo\"/value=\"\"readonly=\"readonly\">";
				html += "</div>";
				html += "</form>";
				
				return html;
			}	// 상세보기(끝)
		</script>
	</head>
	<body>
		<form action="#" method="post" id="delDataForm">
			<input type="hidden" id="sltedCostMgntNo" name="sltedCostMgntNo" value="" />
		</form>
		<c:import url="/topLeft">
			<c:param name="topMenuNo" value="78"></c:param>
			<c:param name="leftMenuNo" value="84"></c:param>
		</c:import>	
		<div class="content_area">
		<form action="#" method="post" id="actionForm">
			<input type="hidden" id="page" name="page" value="${page}" />
			<div class="content_nav">HeyWe &gt; 경영관리 &gt; 비용관리 </div>
			<!-- 내용 영역 -->
				<div class="content_title">비용 관리</div>
			<br />
			<div class="data_search_area">
			<!-- 날짜 검색 영역 -->
				<div class="data_search_menu">날짜</div>
				<div class="data_search_input1">
					<input type="text"  title="시작기간선택" id="date_start" name="date_start" value="" readonly="readonly" />
				</div>
			<!-- 적요명 검색 영역 -->
				<div class="data_search_menu">계정과목</div>
				<div class="data_search_input">
					<select class="slt" id ="unitSbj" name="unitSbj"></select>
				</div>
				<div class="data_search_icon"></div>
				<br />
				
			<!-- 분류 영역 -->
				<div class="data_search_menu">분류</div>
				<div class="data_search_input">
					<select class="slt" id ="type" name="type"></select>
				</div>
				<div class="data_search_icon"></div>
				
			<!-- 적요명 영역 -->
				<div class="data_search_menu">지출유형</div>
				<div class="data_search_input">
					<select class="slt" id="expsType" name="expsType"></select>
				</div>
				<div class="data_search_icon"></div>
				<div class="data_search_btn">
					<input type="button" value="검색" class="btn" id = "searchBtn" />
				</div>
			</div>
		</form>
			<br />
			<div class="data_info_area">
				<table class="data_info_table" id = "costMgntTable" >
					<colgroup>
						<col width="50" />
						<col width="150" />
						<col width="150" />
						<col width="150" />
						<col width="150" />
						<col width="150" />
					</colgroup>
					<thead>
					<!-- 조회화면 제목 -->
						<tr class="first_tr">
							<td><input type="checkbox" id="checkAll"/></td>
							<th>날짜</th>
							<th>분류</th>
							<th>지출유형</th>
							<th>계정과목</th>
							<th>금액</th>
						</tr>
					</thead>
					<tbody>
					
					</tbody>
				</table>
			<br/>
			<div class="pagingArea" id="pagingArea"></div>
			<br/>
		</div>
		<!-- 하단 영역 구분 -->
		<div class="data_btn_area">
   				<div class="left_btn_area">
       			<div class="btn_area"><input type="button" value="삭제" class="btn" id = "delBtn"/></div>
       			<div class="btn_area"><input type="button" value="수정" class="btn" id = "UpdateBtn"/></div>
       			<div class="btn_area"><input type="button" value="상세보기" class="btn" id = "DivBtn"/></div>
     			</div>
     			<div class="right_btn_area">
       			<div class="btn_area"><input type="button" value="신규등록" class="btn" id="newReg"/></div>
     			</div>
		</div>
	</div>
</body>
</html>