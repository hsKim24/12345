<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>비용 월간보고/연간보고</title>
		<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css"/>
		<link rel="stylesheet" type="text/css" href="resources/css/erp/bm/stc/stcStyle.css"/>
		<script type="text/javascript"
				src="resources/script/jquery/jquery-1.12.4.min.js"></script>
		<script type="text/javascript" src="resources/script/jquery/jquery-ui.min.js"></script>
		<!-- highcharts Script -->
		<script src="resources/script/highcharts/highcharts.js"></script>
		<script src="resources/script/highcharts/modules/exporting.js"></script>
		<!-- calendar Script -->
		<script type="text/javascript" src="resources/script/calendar/calendar.js"></script>
		<script type="text/javascript">
		
		$(document).ready(function () {
			// 검색
			$("#searchBtn").on("click", function() {
				reloadStcCostList();
				reloadStcCostConList();
				getData();
			});
			
			reloadYearList();
			reloadMonthList();
			reloadStcCostList();
			reloadStcCostConList();
			getData();
		});// document 끝
		// 차트그리기
		function getData() {
			var params =  $("#actionForm").serialize();
			$.ajax({
				type : "post",
				url : "BMStcCostTitleAjax",
				dataType : "json",
				data : params,
				success : function(result) {
					makeChart(result.list, result.cate);
				},
				error : function(request,status,error) {
					console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		}
		// 차트 Ajax 그리기
		function makeChart(list, cate) {
			console.log(list);
			$('#container').highcharts({
		        chart: {
		            type: 'column',
		            zoomType: 'x'
		        },
		        colors: ['#5CB3FF', '#D462FF', '#FBB917', '#00B3A2', '#FB558A', 
		                 '#2870E3', '#FF8F00', '#B5BF07', '#3F9D00', '#CE3C92'],
		        title: {
		            text: '비용'
		        },
		        subtitle: {
		            text: '- 계정과목 -'
		        },
		        xAxis: {
		        	categories: cate,
		            labels: {
		                formatter: function() {
		                    return this.value; // clean, unformatted number for year
		                }
		            }
		        },
		        yAxis: {
		        	min: 0,
		            title: {
		                text: '금액'
		            },
		            labels: {
		                formatter: function() {
		                    return this.value;
		                }
		            }
		        },
		        tooltip: {
		            pointFormat: '{series.name} produced <b>{point.y:,.0f}</b><br/>in {point.x}'
		        },
		        plotOptions: {
		            area: {
		                pointStart: 1,
		                marker: {
		                    enabled: false,
		                    symbol: 'circle',
		                    radius: 2,
		                    states: {
		                        hover: {
		                            enabled: true
		                        }
		                    }
		                }
		            }
		        },
		        series: list
		    });
		}
		// 비용관리 년 가져오기
		function reloadYearList() {
			var params = $("#actionForm").serialize();
			
			$.ajax({
				type : "post",
				url : "BMStcCostAjax",
				dataType : "json",
				data : params,
				success : function(result) {
					var html = "";
					for(var i = 0; i < result.yearlist.length; i++) {
						html +=	"<option>" 
						+ result.yearlist[i].COST_YEAR_DATE + "</option>"; 
					}
					$("#year").html(html);
					console.log(year);
				},
				error : function(request, status, error) {
					console.log("status : ", request.status);
					console.log("text : ", request.responseText);
					console.log("error : ", error);
				}
			});
		}
		// 비용관리 월 가져오기
		function reloadMonthList() {
			var params = $("#actionForm").serialize();
			
			$.ajax({
				type : "post",
				url : "BMStcCostAjax",
				dataType : "json",
				data : params,
				success : function(result) {
					var html = "";
					html += "<option>전체</option>";
					for(var i = 0; i < result.Monthlist.length; i++) {
						html +=	"<option>" 
						+ result.Monthlist[i].COST_MONTH_DATE + "</option>"; 
					}
					$("#month").html(html);
				},
				error : function(request, status, error) {
					console.log("status : ", request.status);
					console.log("text : ", request.responseText);
					console.log("error : ", error);
				}
			});
		}
		//초기화면
		<%-- 비용관리 제목 가져오기 --%>
		function reloadStcCostList() {
			var params = $("#actionForm").serialize();
			console.log(params);
			$.ajax({
				type : "post",
				url : "BMStcCostTitleAjax",
				dataType : "json",
				data : params,
				success : function(result) {
					console.log(result);
					console.log(result.unitSbjlist);
					redrawStcCostList(result.unitSbjlist);
				},
				error : function(request, status, error) {
					console.log("status : " + request.status);
					console.log("text : " + request.responseText);
					console.log("error : " + error);
				}
			});
		}
		<%-- 비용관리 내용 가져오기 --%>
		function reloadStcCostConList() {
			var params = $("#actionForm").serialize();
			
			console.log(params);
			$.ajax({
				type : "post",
				url : "BMStcCostTitleAjax",
				dataType : "json",
				data : params,
				success : function(result) {
					console.log(result);
					console.log(result.unitSbjConlist);
					redrawStcCostConList(result.unitSbjConlist);
				},
				error : function(request, status, error) {
					console.log("status : " + request.status);
					console.log("text : " + request.responseText);
					console.log("error : " + error);
				}
			});
		}
		<%-- 비용관리 제목 그리기 --%>
		function redrawStcCostList(unitSbjlist) {
			console.log(unitSbjlist.length);
			var html = "";
			if(unitSbjlist.length == 0) {
				html += "<th>조회할 수 있는 데이터가 없습니다</th>";
			}else{
				for(var i = 0; i < unitSbjlist.length; i++) {
					if(unitSbjlist.length == 1){
						html += "<tr class=\"first_tr\" id = \"first_tr\">";
						html += "<th id = \"graph\">구분</th>";
						html += "<th id = \"graph\">" + unitSbjlist[i].UNIT_SBJ_NAME + "</th>";
						html += "<th>합계</th>";
						html += "</tr>";
					}else{
						if(i == unitSbjlist.length - 1) {
							html += "<th id = \"graph\">" + unitSbjlist[i].UNIT_SBJ_NAME + "</th>";
							html += "<th>합계</th>";
							html += "</tr>";
						} else if(i == 0){
							html += "<tr class=\"first_tr\" id = \"first_tr\">";
							html += "<th id = \"graph\">구분</th>";
							html += "<th id = \"graph\">" + unitSbjlist[i].UNIT_SBJ_NAME + "</th>";
						} else {
							html += "<th id = \"graph\">" + unitSbjlist[i].UNIT_SBJ_NAME + "</th>";
						}
					}
				}
			}
			
			$("#StcCostTable thead").html(html);
		}
		
		<%-- 비용관리 리스트내용 그리기 --%>
		function redrawStcCostConList(unitSbjConlist) {
			var html = "";
			console.log(unitSbjConlist.length);
			if(unitSbjConlist.length == 0) {
				html += "<tr><td colspan=\"7\">조회할 수 있는 데이터가 없습니다</td></tr>";
			}else{
				var sum = 0 ;
				for(var i = 0; i < unitSbjConlist.length; i++) {
					if(unitSbjConlist.length == 1){
						html += "<tr class=\"top_tr\" id = \"top_tr\">";
						html += "<td id = \"graph\">" + unitSbjConlist[i].YEAR_DATE + "</td>";
						html += "<td id = \"graph\">" + unitSbjConlist[i].COST_AMT + "</td>";
						html += "<td id = \"graph\">" + unitSbjConlist[i].SUM_AMT + "</td>";
						html += "</tr>";
					}else{
						if(i == 0){
							html += "<tr class=\"top_tr\" id = \"top_tr\">";
							html += "<td id = \"graph\">" + unitSbjConlist[i].YEAR_DATE + "</td>";
							html += "<td id = \"graph\">" + unitSbjConlist[i].COST_AMT + "</td>";
						}else if(i != 0 && i < unitSbjConlist.length - 1){
							html += "<td id = \"graph\">" + unitSbjConlist[i].COST_AMT + "</td>";
						}else{
							html += "<td id = \"graph\">" + unitSbjConlist[i].COST_AMT + "</td>";
							html += "<td id = \"graph\">" + unitSbjConlist[i].SUM_AMT + "</td>";
							html += "</tr>";
						}
					}
				}
			}
			$("#StcCostTable tbody").html(html);
		}
		</script>
	</head>
	<body>
		<c:import url="/topLeft">
			<c:param name="topMenuNo" value="78"></c:param>
			<c:param name="leftMenuNo" value="88"></c:param>
		</c:import>	
		<div class="content_area">
			<form action="#" method="post" id="actionForm">
				 <!-- 메뉴 네비게이션 -->
		        <div class="content_nav">HeyWe &gt; 경영관리 &gt; 통계 &gt; 비용 월간보고/연간보고</div>
		         <!-- 현재 메뉴 제목 -->
		        <div class="content_title">비용 월간보고/연간보고</div>	
				<!-- 내용 영역 -->
				<br />
				<div class="statistic_top_area">
					<input type="button" class="top_btn"value="통계보고">
				</div>
				<br/>
				<div class="data_search_area">
					<div class="data_search_menu">날짜(*)</div>
					<div class="data_search_input">
						<select class="slt" id = "year" name = "year">
						</select>
					</div>
					<div class="data_search_icon">년도</div>
					<div class="data_search_icon"></div>
					<div class="data_search_input">
						<select class="slt" id = "month" name = "month">
						</select>
					</div>
					<div class="data_search_icon">월</div>
					<div class="data_search_icon"></div>
					<div class="data_search_btn">
						<input type="button" value="검색" class="btn" id = "searchBtn"/>
					</div>				
				</div>
			</form>
			<br />
			<div class="data_info_area" >
				<table class="data_info_table" id ="StcCostTable">
					<colgroup>
						<col width="100" />
						<col width="100" />
						<col width="100" />
						<col width="100" />
						<col width="100" />
						<col width="100" />
						<col width="100" />
						<col width="100" />
					</colgroup>
					<thead>
						
					</thead>
					<tbody>
					
					</tbody>
				</table>
   			</div>
   			<br/>
   			<div class="data_info_area"id="container" style="min-width: 310px; height: 400px;"></div>
		</div>
</body>
</html>