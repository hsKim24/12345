<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>매출액 매인</title>
		<!-- calendar select css -->
		<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.min.css" />
		<link rel="stylesheet" type="text/css" href="resources/css/common/calendar.css" />
		<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css"/>
		<link rel="stylesheet" type="text/css" href="resources/css/erp/bm/salesMgnt/salesStyle.css"/>
		<script type="text/javascript"
				src="resources/script/jquery/jquery-1.12.4.min.js"></script>
		<script type="text/javascript" src="resources/script/jquery/jquery-ui.min.js"></script>
		<!-- calendar Script -->
		<script type="text/javascript" src="resources/script/calendar/calendar.js"></script>
		<script type="text/javascript">
		$(document).ready(function(){
			showCalendar(d.getFullYear(),(d.getMonth() + 1));
		});
		</script>
<!-- 기준일자 css -->
<style>
#date_start{
	width: 95px;
	height: 20px;
}
#date_end{
	width: 95px;
	height: 20px;
}
</style>
		<script type="text/javascript">
		
			$(document).ready(function () {
				// 검색
				$("#searchBtn").on("click", function() {
					$("#page").val("1");
					reloadSalesAmtMgntList()
				});
				// 페이징
				$("#pagingArea").on("click", "input", function() {
					$("#page").val($(this).attr("name"));
					reloadSalesAmtMgntList();
				});
				// 매출액관리 기준일자
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
				// 매출액관리 시작일자
				$("#date_start").datepicker({
					dateFormat : 'yy-mm-dd',
					duration: 200,
					onSelect:function(dateText, inst){
						var startDate = parseInt($("#date_end").val().replace("-", '').replace("-", ''));
						var endDate = parseInt(dateText.replace(/-/g,''));
						
			            if (endDate > startDate) {
			            	alert("조회 기간은 과거로 설정하세요.");
			            	//달력에 종료 날짜 넣어주기
			        		$("#date_start").val($("#stdt").val());
						} else {
							$("#stdt").val($("#date_start").val());
						}
					}
				});
				// 매출액관리 마지막일자
				$("#date_end").datepicker({
					dateFormat : 'yy-mm-dd',
					duration: 200,
					onSelect:function(dateText, inst){
						var startDate = parseInt($("#date_start").val().replace("-", '').replace("-", ''));
						var endDate = parseInt(dateText.replace(/-/g,''));
						
			            if (startDate > endDate) {
			            	alert("조회 기간은 과거로 설정하세요.");
			            	//달력에 종료 날짜 넣어주기
			        		$("#date_end").val($("#eddt").val());
						} else {
							$("#eddt").val($("#date_end").val());
						}
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
					
					$("#SalesAmtMgntTable tbody input[type='checkbox']").each(function() {
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
					$("#SalesAmtMgntTable tbody input[type='checkbox']:checked").each(function() {
								checkFlag++;
					});
	    			if(checkFlag == 1) {
						makeNoBtnPopup(1, "상세보기", salesDivPopUp(), true, 650, 500, function() {
		    				$("#sltedSalesNo").val($("#SalesAmtMgntTable tbody input[type='checkbox']:checked").val());
							console.log($("#sltedSalesNo").val());
							var params = $("#salesDivForm").serialize();
							console.log(params);
							// 체크박스가 선택된 매출관리 정보 가져오기
							$.ajax({
								type : "post",
								url : "BMSltedSalesInfoAjax",
								dataType : "json",
								data : params,
								success : function(result) {
									console.log(result);
									$("#contDate").val(result.data.CONT_DATE);
									$("#startDate").val(result.data.START_DATE);
									$("#finishDate").val(result.data.FINISH_DATE);
									$("#amt").val(result.data.AMT);
									$("#payProvCond").val(result.data.PAY_PROV_COND);
									$("#cstmName").val(result.data.CSTM_NAME);
									$("#bsnsNo").val(result.data.BSNS_NO);
									$("#empName").val(result.data.EMP_NAME);
									$("#deptName").val(result.data.DEPT_NAME);
									$("#posiName").val(result.data.POSI_NAME);
									$("#salesDiv").val(result.data.SALES_DIV_NAME);
									$("#flowDate").val(result.data.FLAW_ASSUR_DATE);
									$("#acntName").val(result.data.ACNT_NAME);
									$("#acntNo").val(result.data.ACNT_NO);
									$("#duty").val(result.data.DUTY);
									$("#name").val(result.data.NAME);
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
				
				// 계좌연동
				$("#acntBtn").on("click", function name() {
					var checkFlag = 0;
					$("#SalesAmtMgntTable tbody input[type='checkbox']:checked").each(function() {
								checkFlag++;
					});
	    			if(checkFlag == 1) {
						makePopup(1, "계좌연동", salesAcnt(), true, 300, 150, function() {
		    				$("#sltedSalesAcntNo").val($("#SalesAmtMgntTable tbody input[type='checkbox']:checked").val());
							console.log($("#sltedSalesAcntNo").val());
							var params = $("#salesAcntForm").serialize();
							console.log(params);
								<%-- 계좌명(셀렉트바) 가져오기 --%>
								$.ajax({
									type : "post",
									url : "BMSalesAmtMgntAjax",
									dataType : "json",
									data : params,
									success : function(result) {
										var html = "";
										for(var i = 0; i < result.AcntList.length; i++) {
											html +=	"<option value = "+ result.AcntList[i].ACNT_MGNT_NO +">" + result.AcntList[i].ACNT_NAME + "</option>"; 
										}
										$("#acnt").html(html);
									},
									error : function(request, status, error) {
										console.log("status : ", request.status);
										console.log("text : ", request.responseText);
										console.log("error : ", error);
									}
								});
							}, "연동", function() {
							if($.trim($("#acnt").val()) == "") {
	    						makeAlert(2, "알림", "계좌명을 선택해주세요.", true, null);
	    						$("#acnt").focus();
	    					}else{
	    						var params = $("#salesAcntForm").serialize();
	    						console.log(params);
	    						// 수정
	    						$.ajax({
	    							type : "post",
	    							url : "BMSalesAcntUpdateAjax",
	    							dataType : "json",
	    							data : params,
	    							success : function(result){
	    								makeAlert(2, "알림", result.msg, true, null);	
	    								reloadSalesAmtMgntList();
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
				 
                if($("#page").val() == "") {
					$("#page").val("1");
				}
    			
				// 변수 부르기
				reloadSalesAmtMgntList();
				reloadCstmList();
				reloadCsptsList();
				reloadPayProvList();
				reloadDeptList();
				
				
			});
			<%-- 고객사(셀렉트바) 가져오기 --%>
			function reloadCstmList() {
				var params = $("#actionForm").serialize();
				
				$.ajax({
					type : "post",
					url : "BMSalesAmtMgntAjax",
					dataType : "json",
					data : params,
					success : function(result) {
						var html = "";
						html += "<option>전체</option>";
						for(var i = 0; i < result.CstmList.length; i++) {
							html += "<option>" + result.CstmList[i].CSTM_NAME + "</option>";	
						}
						$("#Cstm").html(html);
					},
					error : function(request, status, error) {
						console.log("status : ", request.status);
						console.log("text : ", request.responseText);
						console.log("error : ", error);
					}
				});
			}
			<%-- 매출구분(셀렉트바) 가져오기 --%>
			function reloadCsptsList() {
				var params = $("#actionForm").serialize();
				
				$.ajax({
					type : "post",
					url : "BMSalesAmtMgntAjax",
					dataType : "json",
					data : params,
					success : function(result) {
						var html = "";
						html += "<option>전체</option>";
						for(var i = 0; i < result.CsptsList.length; i++) {
							html +=	"<option>" + result.CsptsList[i].SALES_NAME + "</option>"; 
						}
						$("#Cspts").html(html);
					},
					error : function(request, status, error) {
						console.log("status : ", request.status);
						console.log("text : ", request.responseText);
						console.log("error : ", error);
					}
				});
			}
			<%-- 지급방법(셀렉트바) 가져오기 --%>
			function reloadPayProvList() {
				var params = $("#actionForm").serialize();
				
				$.ajax({
					type : "post",
					url : "BMSalesAmtMgntAjax",
					dataType : "json",
					data : params,
					success : function(result) {
						var html = "";
						html += "<option>전체</option>";
						for(var i = 0; i < result.PayProvList.length; i++) {
							html +=	"<option>" + result.PayProvList[i].PAY_PROV_COND + "</option>"; 
						}
						$("#payProvCond").html(html);
					},
					error : function(request, status, error) {
						console.log("status : ", request.status);
						console.log("text : ", request.responseText);
						console.log("error : ", error);
					}
				});
			}
			<%-- 부서(셀렉트바) 가져오기 --%>
			function reloadDeptList() {
				var params = $("#actionForm").serialize();
				
				$.ajax({
					type : "post",
					url : "BMSalesAmtMgntAjax",
					dataType : "json",
					data : params,
					success : function(result) {
						var html = "";
						html += "<option>전체</option>";
						for(var i = 0; i < result.DeptList.length; i++) {
							html +=	"<option>" + result.DeptList[i].DEPT_NAME + "</option>"; 
						}
						$("#dept").html(html);
					},
					error : function(request, status, error) {
						console.log("status : ", request.status);
						console.log("text : ", request.responseText);
						console.log("error : ", error);
					}
				});
			}
			
			<%-- 매출액관리 리스트 가져오기 --%>
			function reloadSalesAmtMgntList() {
				var params = $("#actionForm").serialize();
				
				$.ajax({
					type : "post",
					url : "BMSalesAmtMgntAjax",
					dataType : "json",
					data : params,
					success : function(result) {
						console.log(params);
						console.log(result);
						redrawSalesAmtMgntList(result.list);
						redrawPaging(result.pb);
					},
					error : function(request, status, error) {
						console.log("status : " + request.status);
						console.log("text : " + request.responseText);
						console.log("error : " + error);
					}
				});
			}
			
			<%-- 매출액관리 리스트 그리기 --%>
			function redrawSalesAmtMgntList(list) {
				var html = "";
				
				if(list.length == 0) {
					html += "<tr><td colspan=\"10\">조회할 수 있는 데이터가 없습니다</td></tr>";
				} else {
					for(var i = 0; i < list.length; i++) {
						if(i%2 == 0) {
							html += "<tr class=\"top_tr\" name=\"\">";
							html += "<td><input type=\"checkbox\" value=\""
								    + list[i].MARK_NO + "\"></td>";
							html += "<td>" + list[i].START_DATE + "</td>";
							html += "<td>" + list[i].FINISH_DATE + "</td>";
							html += "<td>" + list[i].CSTM_NAME + "</td>";
							html += "<td>" + list[i].BSNS_NO + "</td>";
							html += "<td>" + list[i].SALES_DIV_NAME + "</td>";
							html += "<td>" + list[i].AMT + "</td>";
							html += "<td>" + list[i].PAY_PROV_COND + "</td>";
							html += "<td>" + list[i].DEPT_NAME + "</td>";
							html += "<td>" + list[i].EMP_NAME + "</td>";
							html += "<td>" + list[i].ACNT_NAME + "</td>";
							html += "</tr>";
						} else {
							html += "<tr class=\"button_tr\" name=\"\">";
							html += "<td><input type=\"checkbox\" value=\""
							    	+ list[i].MARK_NO + "\"></td>";
							html += "<td>" + list[i].START_DATE + "</td>";
							html += "<td>" + list[i].FINISH_DATE + "</td>";
							html += "<td>" + list[i].CSTM_NAME + "</td>";
							html += "<td>" + list[i].BSNS_NO + "</td>";
							html += "<td>" + list[i].SALES_DIV_NAME + "</td>";
							html += "<td>" + list[i].AMT + "</td>";
							html += "<td>" + list[i].PAY_PROV_COND + "</td>";
							html += "<td>" + list[i].DEPT_NAME + "</td>";
							html += "<td>" + list[i].EMP_NAME + "</td>";
							html += "<td>" + list[i].ACNT_NAME + "</td>";
							html += "</tr>";
						}
					}
				}
				
				$("#SalesAmtMgntTable tbody").html(html);
			}
			
			// 상세보기 팝업 contents
			function salesDivPopUp() {
				var html = "";
				
				html += "<form action=\"#\" method=\"post\" id=\"salesDivForm\">";
				html += "<input type=\"hidden\" id=\"sltedSalesNo\" name=\"sltedSalesNo\" value=\"\" />";
				html += "<div class=\"regPage_contents_title\">계약일</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"contDate\" name=\"contDate\"/value=\"\"readonly=\"readonly\">";
				html += "</div>";
				html += "<div class=\"regPage_contents_title\">이행일</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"startDate\" name=\"startDate\"/value=\"\"readonly=\"readonly\">";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">마감일</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"finishDate\" name=\"finishDate\"/value=\"\"readonly=\"readonly\">";
				html += "</div>";
				html += "<div class=\"regPage_contents_title\">보증기간</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"flowDate\" name=\"flowDate\"/value=\"\"readonly=\"readonly\">";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">매출구분</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"salesDiv\" name=\"salesDiv\"/value=\"\"readonly=\"readonly\">";
				html += "</div>";
				html += "<div class=\"regPage_contents_title\">금액</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"amt\" name=\"amt\"/value=\"\"readonly=\"readonly\">";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">계좌명</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"acntName\" name=\"acntName\"/value=\"\"readonly=\"readonly\">";
				html += "</div>";
				html += "<div class=\"regPage_contents_title\">계좌번호</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"acntNo\" name=\"acntNo\"/value=\"\"readonly=\"readonly\">";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">지급방법</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"payProvCond\" name=\"payProvCond\"/value=\"\"readonly=\"readonly\">";
				html += "</div>";
				html += "<div class=\"regPage_contents_title\">고객사</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"cstmName\" name=\"cstmName\"/value=\"\"readonly=\"readonly\">";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">사업자번호</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"bsnsNo\" name=\"bsnsNo\"/value=\"\"readonly=\"readonly\">";
				html += "</div>";
				html += "<div class=\"regPage_contents_title\">고객사담당자</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"empName\" name=\"empName\"/value=\"\"readonly=\"readonly\">";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">직급</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"posiName\" name=\"posiName\"/value=\"\"readonly=\"readonly\">";
				html += "</div>";
				html += "<div class=\"regPage_contents_title\">담당자부서</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"deptName\" name=\"deptName\"/value=\"\"readonly=\"readonly\">";
				html += "</div>";
				html += "<br/>";
				html += "<div class=\"regPage_contents_title\">담당자</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"name\" name=\"name\"/value=\"\"readonly=\"readonly\">";
				html += "</div>";
				html += "<div class=\"regPage_contents_title\">담당자직급</div>";
				html += "<div class=\"regPage_contents_input\">";
				html += "<input type=\"text\" class=\"txt\" id=\"duty\" name=\"duty\"/value=\"\"readonly=\"readonly\">";
				html += "</div>";
				html += "</form>";
				
				return html;
			}	// 수정 팝업 contents (끝)
			
			// 계좌연동
			function salesAcnt() {
				var html = "";
				
				html += "<form action=\"#\" method=\"post\" id=\"salesAcntForm\">";
				html += "<input type=\"hidden\" id=\"sltedSalesAcntNo\" name=\"sltedSalesAcntNo\" value=\"\" />";
				html += "<select class=\"slt\" id=\"acnt\" name = \"acnt\">";
				html += "</select>";
				html += "</form>";
				
				return html;
			}	// 수정 팝업 contents (끝)
			
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
			
		</script>
	</head>
	<body>
	<input type="hidden" id="sltedSalesNo" name="sltedSalesNo" value="" />
		<c:import url="/topLeft">
			<c:param name="topMenuNo" value="78"></c:param>
			<c:param name="leftMenuNo" value="83"></c:param>
		</c:import>	
		<div class="content_area">
			<form action="#" method="post" id="actionForm">
				<input type="hidden" id="page" name="page" value="${page}" />
				 <!-- 메뉴 네비게이션 -->
		        <div class="content_nav">HeyWe &gt; 경영관리 &gt; 매출액 관리</div>
		         <!-- 현재 메뉴 제목 -->
		        <div class="content_title">매출액 관리</div>	
				<!-- 내용 영역 -->
				<br />
				<div class="data_search_area">
					<input type="hidden" id="stdt" name="stdt" value="${stdt}" />
					<input type="hidden" id="eddt" name="eddt" value="${eddt}" />
					<div class="data_search_menu">계약일</div>
					<div class="data_search_input2">
					<input type="text"  title="시작기간선택" id="date_start" name="date_start" value="" readonly="readonly" />
					</div>
					~
					<div class="data_search_input2">
					<input type="text" title="종료기간선택" id="date_end" name="date_end" value="" readonly="readonly" />
					</div>
					<div class="data_search_menu1">고객사</div>
					<div class="data_search_input">
						<select class="slt" id="Cstm" name = "Cstm">
						</select>
					</div>
					<div class="data_search_icon"></div>
					<br />
					<div class="data_search_menu">매출구분</div>
					<div class="data_search_input">
						<select class="slt" id="Cspts" name ="Cspts">
						</select>
					</div>
					<div class="data_search_menu2">지급방법</div>
					<div class="data_search_input">
						<select class="slt" id="payProvCond" name = "payProvCond">
						</select>
					</div>
					<br/>
					<div class="data_search_menu">부서</div>
					<div class="data_search_input">
						<select class="slt" id="dept" name = "dept">
						</select>
					</div>
					<div class="data_search_icon"></div>
					<div class="data_search_btn">
						<input type="button" value="검색" class="btn" id = "searchBtn"/>
					</div>				
				</div>
			</form>
			<br />
			<div class="data_info_area">
				<table class="data_info_table" id ="SalesAmtMgntTable">
					<colgroup>
						<col width="50" />
						<col width="140" />
						<col width="140" />
						<col width="130" />
						<col width="140" />
						<col width="100" />
						<col width="100" />
						<col width="130" />
						<col width="130" />
						<col width="130" />
						<col width="130" />
					</colgroup>
					<thead>
						<tr class="first_tr">
							<th><input type="checkbox" id="checkAll"/></th>
							<th>시작일</th>
							<th>종료일</th>
							<th>고객사</th>
							<th>사업자번호</th>
							<th>매출구분</th>
							<th>매출액</th>
							<th>지급방법</th>
							<th>부서</th>
							<th>관리자</th>
							<th>계좌명</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
				<div class="pagingArea" id="pagingArea"></div>
				<br/>
   			</div>
   			<!-- 하단 영역 구분 -->
		<div class="data_btn_area">
 			<div class="left_btn_area">
      			<div class="btn_area"><input type="button" value="상세보기" class="btn" id = "DivBtn"/></div>
    		</div>
    		<div class="right_btn_area">
      			<div class="btn_area"><input type="button" value="계좌연동" class="btn" id = "acntBtn"/></div>
      		</div>
    	</div>
	</div>
</body>
</html>