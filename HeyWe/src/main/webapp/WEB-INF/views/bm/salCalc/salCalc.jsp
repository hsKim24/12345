<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>HeyWe > 경영관리 > 급여 계산</title>
		<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
		<link rel="stylesheet" type="text/css" href="resources/css/erp/bm/salCalc/salCalcStyle.css"/>
		<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.min.css" />
		<link rel="stylesheet" type="text/css" href="resources/css/common/calendar.css" />
		
		<style type="text/css">
			.ui-datepicker select.ui-datepicker-year {
				width: 50%;
			}
			
			.ui-datepicker select.ui-datepicker-month {
			    width: 40%;
			}
			
			table.ui-datepicker-calendar { display:none; }
		</style>
		
		<script type="text/javascript"
				src="resources/script/jquery/jquery-1.12.4.min.js"></script>
		<script type="text/javascript" src="resources/script/jquery/jquery-ui.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				if($("#page").val() == "") {
					$("#page").val("1");
				}
				
				var now = new Date();
				
				var year = now.getFullYear();
				var month = (now.getMonth() + 1);
				
				if(month < 10) {
					month = "0" + month;
				}
				
				$("#stdDate").val(year + "-" + month);
				
				reloadSalCalcList();
				reloadDeptList();
				reloadPosiList();

				// 기준일자 calendar
				// datepicker 설정(영어로 나오는 것을 한글로 변경)
				$.datepicker.setDefaults({
					monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
					dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
					showMonthAfterYear:true,
					showOn: 'both',
					buttonImage: 'resources/images/calender.png',
					buttonImageOnly: true,
					changeYear: true,
					changeMonth: true,
					showButtonPanel: true,
					closeText: '선택',
					dateFormat: 'yy/mm'
				}); 
				// datepicker
				$("#stdDate").datepicker({
					dateFormat : 'yy-mm',
					duration: 200,
				    onClose : function (dateText, inst) {
	                    var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
	                    var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
	                    $(this).datepicker("option", "defaultDate", new Date(year, month, 1));
	                    $(this).datepicker('setDate', new Date(year, month, 1));
	                }
				});
				
				// 검색
				$("#searchBtn").on("click", function() {
					$("#page").val("1");
					reloadSalCalcList();
				});
				
				// 페이징
				$("#pagingArea").on("click", "input", function() {
					$("#page").val($(this).attr("name"));
					reloadSalCalcList();
				});
				
				// 급여자동계산 버튼 클릭
				$("#salAutoCalcBtn").on("click", function() {
					$.ajax({
						type : "post",
						url : "BMSalAutoCalcAjax",
						dataType : "json",
						success : function(result) {
							if(result.flag == 0) {
								makeAlert(1, "알림", "급여 계산에 성공하였습니다", true, null);
								reloadSalCalcList();
							} else {
								makeAlert(1, "알림", "급여 계산에 실패하였습니다", true, null);
								reloadSalCalcList();
							}
						},
						error : function(request, status, error){
							console.log("status : " + request.status);
							console.log("text : " + request.responseText);
							console.log("error : " + error);
						}						
					});
				});
				
				// 급여 명세 내역 (팝업)
				$("tbody").on("click", "tr", function() {
					$("#sltedSalCalcNo").val($(this).attr("name"));
					
					if($.trim($(this).children().eq(6).html()) != "0") {
						makeNoBtnPopup(1, "급여 명세 내역", salBkdwnHist(), true, 770, 470, function() {
							// 클릭한 tr의 급여 명세 정보 가져오기
							var params = $("#actionForm").serialize();
							$.ajax({
								type : "post",
								url : "BMSalBkdwnHistAjax",
								dataType : "json",
								data : params,
								success : function(result) {
									redrawSalBkdwnHist(result.data);
								},
								error : function(request, status, error) {
									console.log("status : ", request.status);
									console.log("text : ", request.responseText);
									console.log("error : ", error);
								}
							});		// ajax 끝
						}, function() {
							reloadSalCalcList();
							closePopup(1);
						});		// makeNoBtnPopup (끝)
					} else {
						makeAlert(1, "알림", "급여 계산이 되지 않은 데이터입니다", true, null);
					}
				});	// 급여 명세 내역 (팝업) (끝)
				
				// 결재요청
				$("#apvReqBtn").click(function() {
					makeConfirm(1, "확인", "결재를 요청하시겠습니까?", "true", function() {
						$("#apvStdDate").val($("#stdDate").val());
						var params = $("#apvForm").serialize();
						
						$.ajax({
							type : "post",
							url : "BMSalApvReqAjax",
							dataType : "json",
							data : params,
							success : function() {
								makeAlert(2, "알림", "결재 요청에 성공하였습니다", false, function() {
									closePopup(1);											
								});
							}, error : function(request, status, error){
								makeAlert(2, "실패", "결재 요청에 실패하였습니다.", false, function() {
									closePopup(1);
								});
								console.log("status : " + request.status);
								console.log("text : " + request.responseText);
								console.log("error : " + request.error);
							}
						});
					});
				});	// 결재요청 (끝)
			});	// document ready (끝)
			
			// 함수 선언
			// 부서 리스트 가져오기 (드롭다운)
			function reloadDeptList() {
				$.ajax({
					type : "post",
					url : "BMDeptListAjax",
					dataType : "json",
					success : function(result) {
						var html = "";
						html += "<option>전체</option>";
						for(var i = 0; i < result.deptList.length; i++) {
							html += "<option>" + result.deptList[i].DEPT_NAME + "</option>";
						}
						$("#dept").html(html);
					},
					error : function(request, status, error) {
						console.log("status : ", request.status);
						console.log("text : ", request.responseText);
						console.log("error : ", error);
					}
				});
			}	// 부서 리스트 가져오기 (드롭다운) (끝)
			
			// 직위 리스트 가져오기 (드롭다운)
			function reloadPosiList() {
				$.ajax({
					type : "post",
					url : "BMPosiListAjax",
					dataType : "json",
					success : function(result) {
						var html = "";
						html += "<option>전체</option>";
						for(var i = 0; i < result.posiList.length; i++) {
							html += "<option>" + result.posiList[i].POSI_NAME + "</optin>";
						}
						$("#posi").html(html);
					},
					error : function(request, status, error) {
						console.log("status : ", request.status);
						console.log("text : ", request.responseText);
						console.log("error : ", error);
					}
				});
			}	// 직위 리스트 가져오기 (드롭다운) (끝)
			
			// 급여 계산 리스트 조회
			function reloadSalCalcList() {
				var params = $("#searchForm").serialize();
				
				$.ajax({
					type : "post",
					url : "BMSalCalcAjax",
					dataType : "json",
					data : params,
					success : function(result) {
						$("#apvState").val(result.apvState);
						redrawSalCalcList(result.list);
						redrawPaging(result.pb);
					},
					error : function(request, status, error) {
						console.log("status : " + request.status);
						console.log("text : " + request.responseText);
						console.log("error : " + error);
					}
				});
			}	// 급여 계산 리스트 조회 (끝)
			
			// 급여 계산 리스트 redraw
			function redrawSalCalcList(list) {
				var html = "";

				if(list.length == 0) {
					html += "<tr><td colspan=\"7\">조회할 수 있는 데이터가 없습니다</td></tr>"
				} else {
					for(var i = 0; i < list.length; i++) {
						if(i%2 == 0) {
							html += "<tr class=\"top_tr\" name=\"" + list[i].SAL_CALC_NO + "\">";
							html += "<td>" + list[i].EMP_NO + "</td>";
							html += "<td>" + list[i].NAME + "</td>";
							html += "<td>" + list[i].DEPT_NAME + "</td>";
							html += "<td>" + list[i].POSI_NAME + "</td>";
							html += "<td>" + list[i].STD_DATE + "</td>";
							html += "<td>" + list[i].TAX_PREV_SAL + "</td>";
							html += "<td>" + list[i].TAX_NEXT_SAL + "</td>";
							html += "</tr>";
						} else {
							html += "<tr class=\"bottom_tr\" name=\"" + list[i].SAL_CALC_NO + "\">";
							html += "<td>" + list[i].EMP_NO + "</td>";
							html += "<td>" + list[i].NAME + "</td>";
							html += "<td>" + list[i].DEPT_NAME + "</td>";
							html += "<td>" + list[i].POSI_NAME + "</td>";
							html += "<td>" + list[i].STD_DATE + "</td>";
							html += "<td>" + list[i].TAX_PREV_SAL + "</td>";
							html += "<td>" + list[i].TAX_NEXT_SAL + "</td>";
							html += "</tr>";
						}
					}
				}
				$("#salCalcTable tbody").html(html);
			}	// 급여 계산 리스트 redraw (끝)
			
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
			
			// 급여 명세 내역 contents
			function salBkdwnHist(data) {
				var html = "";
				
				html += "<table class=\"salBkdwnHistTable\">";
				html += "</table>";
				
				return html;
			}
			
			function redrawSalBkdwnHist(data) {
				var html = "";
				
				html += "<table class=\"salBkdwnHistTable\">";
				html += "<colgroup>";
				html += "<col width=\"150\"/>";
				html += "<col width=\"150\"/>";
				html += "<col width=\"150\"/>";
				html += "<col width=\"150\"/>";
				html += "<col width=\"150\"/>";
				html += "</colgroup>";
				html += "<tbody>";
				html += "<tr class=\"tr\" height=\"50\">";
				html += "<th class=\"th\" colspan=\"5\" name=\"stdYearMon\">" + data.STD_YEAR_MON + " 급여 명세 내역</th>";
				html += "</tr>";
				html += "<tr class=\"tr\" height=\"25\">";
				html += "<th class=\"th\">성명</th>";
				html += "<th class=\"th\" colspan=\"2\" name=\"name\">" + data.NAME + "</th>";
				html += "<th class=\"th\" name=\"dept\">부서</th>";
				html += "<th class=\"th\">" + data.DEPT_NAME + "</th>";
				html += "</tr>";
				html += "<tr class=\"tr\" height=\"25\">";
				html += "<th class=\"th\">직위</th>";
				html += "<th class=\"th\" colspan=\"2\" name=\"posi\">" + data.POSI_NAME + "</th>";
				html += "<th class=\"th\">입사일</th>";
				html += "<th class=\"th\" colspan=\"2\" name=\"entryDate\">" + data.ENTRY_DATE + "</th>";
				html += "</tr>";
				html += "<tr class=\"tr\" height=\"25\">";
				html += "<th class=\"th\" colspan=\"2\">지급내역</th>";
				html += "<th class=\"th\" colspan=\"2\">공제내역</th>";
				html += "<th class=\"th\">비고</th>";
				html += "</tr>";
				html += "<tr class=\"tr\" height=\"25\">";
				html += "<th class=\"th\">기본급</th>";
				html += "<td class=\"td\" name=\"basicSal\">" + data.BASIC_SAL + "&nbsp&nbsp</td>";
				html += "<th class=\"th\">국민연금</th>";
				html += "<td class=\"td\" name=\"ntnPnsn\">" + data.NTN_PNSN + "&nbsp&nbsp</td>";
				html += "<td class=\"td\"></td>";
				html += "</tr>";
				html += "<tr class=\"tr\" height=\"25\">";
				html += "<th class=\"th\">비과세액</th>";
				html += "<td class=\"td\" name=\"taxDduct\">" + data.TAX_DDUCT + "&nbsp&nbsp</td>";
				html += "<th class=\"th\">건강보험</th>";
				html += "<td class=\"td\" name=\"hthInsrnce\">" + data.HTH_INSRNCE + "&nbsp&nbsp</td>";
				html += "<td class=\"td\"></td>";
				html += "</tr>";
				html += "<tr class=\"tr\" height=\"25\">";
				html += "<th class=\"th\"></th>";
				html += "<td class=\"td\"></td>";
				html += "<th class=\"th\">장기요양</th>";
				html += "<td class=\"td\" name=\"ltmCare\">" + data.LTM_CARE + "&nbsp&nbsp</td>";
				html += "<td class=\"td\"></td>";
				html += "</tr>";
				html += "<tr class=\"tr\" height=\"25\">";
				html += "<th class=\"th\"></th>";
				html += "<td class=\"td\"></td>";
				html += "<th class=\"th\">고용보험</th>";
				html += "<td class=\"td\" name=\"empmtInsrnce\">" + data.EMPMT_INSRNCE + "&nbsp&nbsp</td>";
				html += "<td class=\"td\"></td>";
				html += "</tr>";
				html += "<tr class=\"tr\" height=\"25\">";
				html += "<th class=\"th\"></th>";
				html += "<td class=\"td\"></td>";
				html += "<th class=\"th\">소득세</th>";
				html += "<td class=\"td\" name=\"incmTax\">" + data.INCM_TAX + "&nbsp&nbsp</td>";
				html += "<td class=\"td\"></td>";
				html += "</tr>";
				html += "<tr class=\"tr\" height=\"25\">";
				html += "<th class=\"th\"></th>";
				html += "<td class=\"td\"></td>";
				html += "<th class=\"th\">지방소득세</th>";
				html += "<td class=\"td\" name=\"areaIncmTax\">" + data.AREA_INCM_TAX + "&nbsp&nbsp</td>";
				html += "<td class=\"td\"></td>";
				html += "</tr>";
				html += "<tr class=\"tr\" height=\"25\">";
				html += "<th class=\"th\"></th>";
				html += "<td class=\"td\"></td>";
				html += "<th class=\"th\"></th>";
				html += "<td class=\"td\"></td>";
				html += "<td class=\"td\"></td>";
				html += "</tr>";
				html += "<tr class=\"tr\" height=\"25\">";
				html += "<th class=\"th\"></th>";
				html += "<td class=\"td\"></td>";
				html += "<th class=\"th\">공제액 합계</th>";
				html += "<td class=\"td\" name=\"dductSum\">" + data.DDUCT_SUM + "&nbsp&nbsp</td>";
				html += "<td class=\"td\"></td>";
				html += "</tr>";
				html += "<tr class=\"tr\" height=\"25\">";
				html += "<th class=\"th\">세전 지급 합계</th>";
				html += "<td class=\"td\" name=\"taxPrevProvSum\">" + data.TAX_PREV_PROV_SUM + "&nbsp&nbsp</td>";
				html += "<th class=\"th\">실 수령액</th>";
				html += "<td class=\"td\" name=\"realSal\">" + data.REAL_SAL + "&nbsp&nbsp</td>";
				html += "<td class=\"td\"></td>";
				html += "</tr>";
				html += "</tbody>";
				html += "</table>";
				
				$(".salBkdwnHistTable").html(html);
			}
			
		</script>
	</head>
	<body>
		<form action="#" method="post" id="actionForm">
			<input type="hidden" id="sltedSalCalcNo" name="sltedSalCalcNo" />
		</form>
		
		<form action="#" method="post" id="apvForm">
			<input type="hidden" id="title" name="title" value="급여결재" />
			<input type="hidden" id="apvDocTypeNo" name="apvDocTypeNo"  value=""/>
			<input type="hidden" id="con" name="con" value="급여결재" />
			<input type="hidden" id="impDate" name="impDate" value=""  /> <!-- start date 박자 -->
			<input type="hidden" id="expCon" name="expCon"/>
			<input type="hidden" id="outApvTypeNo" name="outApvTypeNo"  value="2"/> <!-- 급여결재는 2 -->
			<input type="hidden" id="connectNo" name="connectNo" value="0"/>
			<input type="hidden" id="apverNos" name="apverNos" />
			<input type="hidden" id="allApvWhether" name="allApvWhether" value="1" /><!-- 전결가능여부 -->
			<input type="hidden" id="apvStdDate" name="apvStdDate"/>
		</form>
	
		<c:import url="/topLeft">
			<c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
			<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param>
		</c:import>	
		
		<!-- 내용 영역 -->
		<div class="content_area">
			<!-- 메뉴 네비게이션 -->
			<div class="content_nav">HeyWe &gt; 경영관리 &gt; 급여 계산</div>
			<!-- 현재 메뉴 제목 -->
			<div class="content_title">급여 계산</div>
			<br/>
			<form action="#" method="post" id="searchForm">
				<input type="hidden" id="page" name="page" value="${page}" />
				<div class="data_search_area">
					<div class="data_search_menu">기준일자</div>
					<div class="data_search_input">
						<input type="text" class="txt" id="stdDate" name="stdDate" readonly="readonly"/>
					</div>
					<div class="data_search_icon"></div>
					<div class="data_search_menu">결재상태</div>
					<div class="data_search_input">
						<input type="text" class="txt" id="apvState" name="apvState" readonly="readonly" />
					</div>
					<div class="data_search_icon"></div>
					<div class="data_search_btn">
						<input type="button" value="검색" class="btn" id="searchBtn"/>
					</div>
				</div>
			</form>
			<br/>
			<div class="data_info_area">
				<table class="data_info_table" id="salCalcTable">
					<colgroup>
						<col width="100"/>
						<col width="100"/>
						<col width="130"/>
						<col width="80"/>
						<col width="90"/>
						<col width="150"/>
						<col width="150"/>
					</colgroup>
					<thead>
					<tr class="first_tr" height=45px>
						<th>사원번호</th>
						<th>사원명</th>
						<th>부서</th>
						<th>직위</th>
						<th>기준일자</th>
						<th>세전급여</th>
						<th>실급여</th>
					</tr>
					</thead>
					<tbody></tbody>
				</table>
				<div class="pagingArea" id="pagingArea"></div>
			</div>
			<br/>
			<div class="data_btn_area">
				<input type="button" value="결재요청" class="btn" id="apvReqBtn" />
				<input type="button" value="급여자동계산" class="btn" id="salAutoCalcBtn" />
			</div>
		</div>
	</body>
</html>