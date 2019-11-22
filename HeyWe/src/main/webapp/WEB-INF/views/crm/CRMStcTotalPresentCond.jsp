<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 종합 현황</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/crm/CRMStcTotalPresentCond.css" />
<!-- jQuery Script -->
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui.min.js"></script>
<!-- highcharts Script -->
<script src="resources/script/highcharts/highcharts.js"></script>
<script src="resources/script/highcharts/modules/exporting.js"></script>
<style type="text/css">
/* 
	DarkBlue : rgb(19, 64, 116), #134074
	SteelBlue : rgb(70, 130, 180), #4682b4
	DeepLightBlue : rgb(141, 169, 196), #8DA9C4
	LightBlue : rgb(222,230,239), #DEE6EF
	LightSkyBlue : rgb(176,218,236), #B0DAEC
	White : rgb(255,255,255), #FFFFFF
 */
</style>
<script type="text/javascript">
$(document).ready(function() {
	loadDept();
	drawGradeGraph();
	loadCstmGrade();
	loadMarkChance();
	
	var params = $("#dataForm").serialize();
	
	$("#check").change(function() { //담당자 드롭다운 메뉴
		loadEmp();
	});
	
	$("#cstmGrade").on("click", "th", function() {
		$("#gradeSelect").val($(this).attr("id"));
		loadCstmGrade();
	});
	
	$("#markState").on("click", "th", function() {
		$("#stateSelect").val($(this).attr("id"));
		loadMarkChance();
	});
	
	$("#searchBtn").on("click", function() {
		loadCstmGrade();
		loadMarkChance();
		drawGradeGraph();
	});
	
	
	//월별 활동 그래프 작성
	$.ajax({
		type : "post",
		url : "stcActGraphAjax",
		dataType : "json",
		data : params,
		success : function(graph) {
			$('.block_vertical1').highcharts({
				chart: {
					height: 275,
					type: 'column',
					marginTop: 50
					},
				    title: {text: ''},
				    xAxis: {categories: [graph.graphA[0].MON, graph.graphA[3].MON, graph.graphA[6].MON]},
				yAxis: {
					min: 0,
					title: {text: ''},
					stackLabels: {
						enabled: false
					}
				},
				legend: {
					x: -30,
					align: 'right',
				    verticalAlign: 'top',
				    floating: true,
				    backgroundColor: 'white',
				    borderColor: '#CCC',
				    borderWidth: 1,
				    shadow: false
				    },
				tooltip: {
					headerFormat: '<b>{point.x}</b><br/>',
					pointFormat: '{series.name}: {point.y}<br/>Total: {point.stackTotal}'
					},
				plotOptions: {column: {stacking: 'normal', dataLabels: {enabled: true}}},
				series: [
					{name: graph.graphA[0].ATNAME, data: [graph.graphA[0].CNT, graph.graphA[3].CNT, graph.graphA[6].CNT]},
					{name: graph.graphA[1].ATNAME, data: [graph.graphA[1].CNT, graph.graphA[4].CNT, graph.graphA[7].CNT]},
					{name: graph.graphA[2].ATNAME, data: [graph.graphA[2].CNT, graph.graphA[5].CNT, graph.graphA[8].CNT]}
				  ]
			}); 
		},
		error : function(request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + request.error);
		}
	});
	
	//월별 영업 그래프 작성
	$.ajax({
		type : "post",
		url : "stcMarkGraphAjax",
		dataType : "json",
		data : params,
		success : function(graph) {
			$('.block_vertical2').highcharts({
			    chart: {
					height: 275,
					type: 'column',
					marginTop: 50
			    },
			    title: {text: ''},
			    xAxis: {
			        categories: [graph.graphM[0].MON, graph.graphM[1].MON, graph.graphM[2].MON],
			        crosshair: true
			    },
			    yAxis: {
			        min: 0,
			        title: {text: ''}
			    },
			    legend: {
					x: -30,
					align: 'right',
				    verticalAlign: 'top',
				    floating: true,
				    backgroundColor: 'white',
				    borderColor: '#CCC',
				    borderWidth: 1,
				    shadow: false
				},
			    tooltip: {
			        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
			        pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
			            '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
			        footerFormat: '</table>',
			        shared: true,
			        useHTML: true
			    },
			    plotOptions: {
			        column: {
			            pointPadding: 0.2,
			            borderWidth: 0,
			            pointWidth: 50
			        }
			    },
			    series: [{name: '영업활동', data: [graph.graphM[0].CNT, graph.graphM[1].CNT, graph.graphM[2].CNT]}]
			});
		},
		error : function(request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + request.error);
		}
	});
});

//부서 드롭다운 메뉴
function loadDept() {
	var params = $("#dataForm").serialize();

	$.ajax({
		type : "post",
		url : "CRMCstmGetDeptAjax",
		dataType : "json",
		data : params,
		success : function(dept) {
			reselectDept(dept.listD);
		},
		error : function(request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + request.error);
		}
	});
}
function reselectDept(listD) {
	var html = '';
	
	html += "<option value=\"\">부서(전체)</option>";
	for (var i = 0; i < listD.length; i++) {
		html += "<option value=\"" + listD[i].DEPT_NO +"\">" + listD[i].DEPT_NAME + "</option>";
	}
	html += "</select>";
	
	$("#check").html(html);
}

//담당자 드롭다운 메뉴
function loadEmp() {
	var params = $("#dataForm").serialize();

	$.ajax({
		type : "post",
		url : "CRMCstmGetEmpAjax",
		dataType : "json",
		data : params,
		success : function(emp) {
			reselectEmp(emp.listE);
		},
		error : function(request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + request.error);
		}
	});
}
function reselectEmp(listE) {
	var html = '';

	html += "<option value=\"\">사원(전체)</option>";
	for (var i = 0; i < listE.length; i++) {
		html += "<option value=\"" + listE[i].EMP_NO +"\">" + listE[i].NAME + "</option>";
	}
	html += "</select>";

	$("#empSelect").html(html);
}

//등급 통계 그래프 작성
function drawGradeGraph() {
	var params = $("#dataForm").serialize();
	
	//등급 통계 그래프 색 (Make monochrome colors)
	var pieColors = (function () {
	  var colors = [],
	    base = Highcharts.getOptions().colors[0],
	    i;

	  for (i = 0; i < 10; i += 1) {
	    // Start out with a darkened base color (negative brighten), and end
	    // up with a much brighter color
	    colors.push(Highcharts.Color(base).brighten((i - 3) / 7).get());
	  }
	  return colors;
	}());
	
	$.ajax({
		type : "post",
		url : "stcGradeGraphAjax",
		dataType : "json",
		data : params,
		success : function(graph) {
			$("#cstmCnt").html(graph.cnt)
			if (graph.graphG[0].CCNT == 0) {
				var html = ""
				html += "데이터가 존재하지 않습니다."
				$("#container").html(html);
			} else {
				$('#container').highcharts({
					  chart: {
					    plotBackgroundColor: null,
					    plotBorderWidth: null,
					    plotShadow: false,
					    type: 'pie',
					    spacingBottom: 0,
				        spacingTop: 0,
				        spacingLeft: 0,
				        spacingRight: 0,
				        marginLeft: 0,
				        marginRight: 0
					  },
					  title: {text: ''},
					  tooltip: {pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'},
					  plotOptions: {
					    pie: {
					      allowPointSelect: true,
					      cursor: 'pointer',
					      colors: pieColors,
					      fontSize: '8pt',
					      center: [95, 75],
					      size: 170,
					      dataLabels: {
					      	color: "#fff",
					        enabled: true,
					        format: '<b>{point.name}급</b>({point.y:.0f})',
					        distance: -30,
					        filter: {property: 'percentage', operator: '>', value: 4}
					      }
					    }
					  },
					  series: [{
					    name: 'Share',
					    data: [
					    	{name: graph.graphG[0].NAME, y: graph.graphG[0].CNT},
					    	{name: graph.graphG[1].NAME, y: graph.graphG[1].CNT},
					    	{name: graph.graphG[2].NAME, y: graph.graphG[2].CNT},
					    	{name: graph.graphG[3].NAME, y: graph.graphG[3].CNT},
					    	{name: graph.graphG[4].NAME, y: graph.graphG[4].CNT}
					    ]
					  }]
				});
			}
		},
		error : function(request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + request.error);
		}
	});
}

//고객 등급 데이터
function loadCstmGrade() {
	var params = $("#dataForm").serialize();
	
	$.ajax({
		type : "post",
		url : "stcCstmGradeAjax",
		dataType : "json",
		data : params,
		success : function(grade) {
			var html = "";
			
			for(var i = 0; i < grade.stcG.length; i++) {
				if(i%2 == 0){
					html += "<tr class=\"TW1\"><td>" + grade.stcG[i].CCNAME + "</td>";
					html += "<td>" + grade.stcG[i].GRADE + "</td><td>" + grade.stcG[i].MCNT + "건</td></tr>"
				} else {
					html += "<tr class=\"TW2\"><td>" + grade.stcG[i].CCNAME + "</td>";
					html += "<td>" + grade.stcG[i].GRADE + "</td><td>" + grade.stcG[i].MCNT + "건</td></tr>"
				}
			}
			
			$("#gradeTable").html(html);
			
			//스크롤
			$("#gradeTable").slimScroll({
				height: "270",
				axis: "both"
			});
		},
		error : function(request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + request.error);
		}
	});
}

//진행 별 영업 데이터 조회
function loadMarkChance() {
	var params = $("#dataForm").serialize();
	$.ajax({
		type : "post",
		url : "stcMarkChanceAjax",
		dataType : "json",
		data : params,
		success : function(mark) {
			console.log(mark.cnt);
			
			var html2 = "";
			var html3 = "";
			
			for(var i = 0; i < mark.cnt.length; i++) {
				html2 += "<div class=\"stateBox" + i + "\"><table class=\"stepTable\">";
				html2 += "<tr><th rowspan=\"2\" id=\"stateBox\"><img src=\"resources/images/erp/crm/state" + i
						 + ".png\" id=\"stateImg\" /></th><th>" + mark.cnt[i].NAME + "</th></tr>";
				html2 += "<tr><td>" + mark.cnt[i].CNT + "</td></tr></table></div>";
			}
			$("#stateCntTable").html(html2);
			
			for(var j = 0; j < mark.stcC.length; j++) {
				if(j%2 == 0){
					html3 += "<tr class=\"TW1\"><td>" + mark.stcC[j].CNAME + "</td>";
					html3 += "<td>" + mark.stcC[j].MNAME + "</td><td>" + mark.stcC[j].PNAME + "</td></tr>"
				} else {
					html3 += "<tr class=\"TW2\"><td>" + mark.stcC[j].CNAME + "</td>";
					html3 += "<td>" + mark.stcC[j].MNAME + "</td><td>" + mark.stcC[j].PNAME + "</td></tr>"
				}
			}
			
			$("#stateTable").html(html3);
			
			//스크롤
			$("#stateTable").slimScroll({
				height: "270",
				axis: "both"
			});
		},
		error : function(request, status, error) {
			console.log("status : " + request.status);
			console.log("text : " + request.responseText);
			console.log("error : " + request.error);
		}
	});
}


</script>
</head>
<body>
<c:import url="/topLeft">
	<c:param name="topMenuNo" value="17"></c:param>
	<c:param name="leftMenuNo" value="34"></c:param>
</c:import>

	<div class="content_area">
		<!-- 메뉴 네비게이션 -->
		<div class="content_nav">HeyWe &gt; 통계 &gt; 종합 현황</div>
		<!-- 현재 메뉴 제목 -->
		<div class="content_title">종합 현황</div>
		<!-- 내용 영역 -->
		<form action="#" id="dataForm" method="post">
		<input type="hidden" id="gradeSelect" name="gradeSelect" />
		<input type="hidden" id="stateSelect" name="stateSelect" />
			<div class="search_bar">
				<select id="check" name="check"></select> 부서
				<select id="empSelect" name="empSelect"><option value="">사원(전체)</option></select> 담당자
				<img src="resources/images/erp/crm/search.png" id="searchBtn" />
			</div>
		<br />
		<div class="inbody">
			<div class="area1">
				<div class="title">▌고객</div>
				<div class="block1">
					<div class="coustomer_value">
						<table class="cTbl">
							<thead>
								<tr class="cTbl1">
									<th><img class="users" src="resources/images/erp/crm/users.png"></th>
								</tr>
							</thead>
							<tbody>
								<tr class="cTbl2">
									<th>고객 수</th>
								</tr>
								<tr class="cTbl2" >
									<th id="cstmCnt"></th>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="coustomer_graph" id="container"></div>
				</div>
				<div class="block2">
					<table class="grade" id="cstmGrade" name="cstmGrade">
						<tr>
							<th id="0">S급</th>
							<th id="1">A급</th>
							<th id="2">B급</th>
							<th id="3">C급</th>
							<th>전체</th>
						</tr>
					</table>
				</div>
				<div class="block3">
					<table class="Table">
						<thead id="tablehead">
							<tr class="TW">
								<th>고객사 명</th>
								<th>등급</th>
								<th>완료건 수</th>
							</tr>
						</thead>
						<tbody id="gradeTable">
						</tbody>
					</table>
				</div>
			</div>
			<div class="area2">
				<div class="title">▌영업기회</div>
				<div class="block1" id="stateCntTable" >
				</div>
				<div class="block2">
					<table class="grade" id="markState" name="markState">
						<tr>
							<th id="0">진행</th>
							<th id="1">성공</th>
							<th id="2">실패</th>
							<th id="3">보류</th>
							<th>전체</th>
						</tr>
					</table>
				</div>
				<div class="block3">
					<table class="Table">
						<thead id="tablehead">
							<tr class="TW">
								<th>고객사 명</th>
								<th>영업 활동</th>
								<th>단계</th>
							</tr>
						</thead>
						<tbody id="stateTable">
						</tbody>
					</table>
				</div>
			</div>
			<div class="area3">
				<div class="title">▌영업현황</div>
				<div class="block_vertical1"></div>
				<div class="block_vertical2"></div>
			</div>
		</div>
		</form>
	</div>
</body>
</html>