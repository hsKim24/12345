<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>HeyWe > 경영관리 > 급여 조회</title>
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
			
			table.ui-datepicker-calendar {
				display:none;
			}
		</style>
		
		<script type="text/javascript"
				src="resources/script/jquery/jquery-1.12.4.min.js"></script>
		<script type="text/javascript" src="resources/script/jquery/jquery-ui.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				var now = new Date();
				
				var year = now.getFullYear();
				var month = (now.getMonth() + 1);
				
				if(month < 10) {
					month = "0" + month;
				}
				
				$("#stdDate").val(year + "-" + month);
				
				salAskDraw();

				// 검색
				$("#searchBtn").on("click", function() {
					salAskDraw();
				});
				
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
			});	// document ready (끝)
				
			// 급여 조회 그리기
			function salAskDraw() {
				var params = $("#searchForm").serialize();
				
				$.ajax({
					type : "post",
					url : "BMSalAskAjax",
					dataType : "json",
					data : params,
					success : function(result) {
						$("#apvState").val(result.apvState);
						if(result.data != null) {
							redrawSalBkdwnHist(result.data);							
						} else {
							makeAlert(1, "알림", "조회할 데이터가 없습니다", true, null);
						}
					},
					error : function(request, status, error) {
						console.log("status : ", request.status);
						console.log("text : ", request.responseText);
						console.log("error : ", error);
					}
				});	
			}
			
			// 급여 명세 내역 contents
			function redrawSalBkdwnHist(data) {
				var html = "";
				
				html += "<table class=\"salBkdwnHistTable\">";
				html += "<colgroup>";
				html += "<col width=\"160\"/>";
				html += "<col width=\"160\"/>";
				html += "<col width=\"160\"/>";
				html += "<col width=\"160\"/>";
				html += "<col width=\"160\"/>";
				html += "</colgroup>";
				html += "<thead>";
				html += "<tr class=\"tr\" height=\"50\">";
				html += "<th class=\"title\" colspan=\"5\" name=\"stdYearMon\">" + data.STD_YEAR_MON + " 급여 명세 내역</th>";
				html += "</tr>";
				html += "<tr class=\"tr\" height=\"25\">";
				html += "<th class=\"menu\">성명</th>";
				html += "<td class=\"td\" colspan=\"2\" name=\"name\">" + data.NAME + "</td>";
				html += "<th class=\"menu\" name=\"dept\">부서</th>";
				html += "<td class=\"td\">" + data.DEPT_NAME + "</td>";
				html += "</tr>";
				html += "<tr class=\"tr\" height=\"25\">";
				html += "<th class=\"menu\">직위</th>";
				html += "<td class=\"td\" colspan=\"2\" name=\"posi\">" + data.POSI_NAME + "</td>";
				html += "<th class=\"menu\">입사일</th>";
				html += "<td class=\"td\" colspan=\"2\" name=\"entryDate\">" + data.ENTRY_DATE + "</td>";
				html += "</tr>";
				html += "</thead>";
				html += "<tbody>";
				html += "<tr height=\"25\"></tr>";
				html += "<tr class=\"tr\" height=\"25\">";
				html += "<th class=\"subTitle\" colspan=\"2\">지급내역</th>";
				html += "<th class=\"subTitle\" colspan=\"2\">공제내역</th>";
				html += "<th class=\"subTitle\">비고</th>";
				html += "</tr>";
				html += "<tr class=\"tr\" height=\"25\">";
				html += "<th class=\"menu\">기본급</th>";
				html += "<td class=\"td\" name=\"basicSal\">" + data.BASIC_SAL + "&nbsp&nbsp</td>";
				html += "<th class=\"menu\">국민연금</th>";
				html += "<td class=\"td\" name=\"ntnPnsn\">" + data.NTN_PNSN + "&nbsp&nbsp</td>";
				html += "<td class=\"td\"></td>";
				html += "</tr>";
				html += "<tr class=\"tr\" height=\"25\">";
				html += "<th class=\"menu\">비과세액</th>";
				html += "<td class=\"td\" name=\"taxDduct\">" + data.TAX_DDUCT + "&nbsp&nbsp</td>";
				html += "<th class=\"menu\">건강보험</th>";
				html += "<td class=\"td\" name=\"hthInsrnce\">" + data.HTH_INSRNCE + "&nbsp&nbsp</td>";
				html += "<td class=\"td\"></td>";
				html += "</tr>";
				html += "<tr class=\"tr\" height=\"25\">";
				html += "<th class=\"th\"></th>";
				html += "<td class=\"td\"></td>";
				html += "<th class=\"menu\">장기요양</th>";
				html += "<td class=\"td\" name=\"ltmCare\">" + data.LTM_CARE + "&nbsp&nbsp</td>";
				html += "<td class=\"td\"></td>";
				html += "</tr>";
				html += "<tr class=\"tr\" height=\"25\">";
				html += "<th class=\"th\"></th>";
				html += "<td class=\"td\"></td>";
				html += "<th class=\"menu\">고용보험</th>";
				html += "<td class=\"td\" name=\"empmtInsrnce\">" + data.EMPMT_INSRNCE + "&nbsp&nbsp</td>";
				html += "<td class=\"td\"></td>";
				html += "</tr>";
				html += "<tr class=\"tr\" height=\"25\">";
				html += "<th class=\"th\"></th>";
				html += "<td class=\"td\"></td>";
				html += "<th class=\"menu\">소득세</th>";
				html += "<td class=\"td\" name=\"incmTax\">" + data.INCM_TAX + "&nbsp&nbsp</td>";
				html += "<td class=\"td\"></td>";
				html += "</tr>";
				html += "<tr class=\"tr\" height=\"25\">";
				html += "<th class=\"th\"></th>";
				html += "<td class=\"td\"></td>";
				html += "<th class=\"menu\">지방소득세</th>";
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
				html += "<th class=\"menu\">공제액 합계</th>";
				html += "<td class=\"td\" name=\"dductSum\">" + data.DDUCT_SUM + "&nbsp&nbsp</td>";
				html += "<td class=\"td\"></td>";
				html += "</tr>";
				html += "<tr class=\"tr\" height=\"25\">";
				html += "<th class=\"menu\">세전 지급 합계</th>";
				html += "<td class=\"td\" name=\"taxPrevProvSum\">" + data.TAX_PREV_PROV_SUM + "&nbsp&nbsp</td>";
				html += "<th class=\"menu\">실 수령액</th>";
				html += "<td class=\"td\" name=\"realSal\">" + data.REAL_SAL + "&nbsp&nbsp</td>";
				html += "<td class=\"td\"></td>";
				html += "</tr>";
				html += "</tbody>";
				html += "</table>";
				
				$(".data_info_area").html(html);
			}
		</script>
	</head>
	<body>
		<c:import url="/topLeft">
			<c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
			<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param>
		</c:import>	
		
		<!-- 내용 영역 -->
		<div class="content_area">
			<!-- 메뉴 네비게이션 -->
			<div class="content_nav">HeyWe &gt; 경영관리 &gt; 급여 조회</div>
			<!-- 현재 메뉴 제목 -->
			<div class="content_title">급여 조회</div>
			<br/>
			<form action="#" method="post" id="searchForm">
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
			<div class="data_info_area"></div>
			<br/>
			<div class="data_btn_area"></div>
		</div>
	</body>
</html>