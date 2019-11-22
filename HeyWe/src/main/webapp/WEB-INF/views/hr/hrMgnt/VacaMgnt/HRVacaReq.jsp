<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 휴가신청</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/hr/hrMgnt/VacaMgnt/HRVacaReq.css" />
<!-- calendar select css -->
<link rel="stylesheet" type="text/css" href="resources/css/jquery/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css" href="resources/css/common/calendar.css" />
<style type="text/css">
/* 
	DarkBlue : rgb(19, 64, 116), #134074
	DeepLightBlue : rgb(141, 169, 196), #8DA9C4
	LightBlue : rgb(222,230,239), #DEE6EF
	White : rgb(255,255,255), #FFFFFF
 */
 
</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui.min.js"></script>
<!-- calendar Script -->
<script type="text/javascript" src="resources/script/calendar/calendar.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	/* 달력부분 */
	/* 달력부분 */
	$.datepicker.setDefaults({
		monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		showMonthAfterYear:true,
		showOn: 'both',
		closeText: '닫기',
		minDate : new Date(),
		buttonImage: 'resources/images/calender.png',
		buttonImageOnly: true,
		dateFormat: 'yy/mm/dd'    
	}); 
	
	$("#date_start").datepicker({
		dateFormat : 'yy-mm-dd',
		duration: 200,
		onSelect:function(dateText, inst){
			var startDate = parseInt($("#date_end").val().replace("-", '').replace("-", ''));
			var endDate = parseInt(dateText.replace(/-/g,''));
			
            if (endDate > startDate) {
            	makeAlert(1,"확인","기간은 과거로 설정할 수 없습니다","false",null);
            	//달력에 종료 날짜 넣어주기
        		$("#date_start").val($("#startDate").val());
			} else {
				$("#startDate").val($("#date_start").val());
			}
		}
	});
	
	$("#date_end").datepicker({
		dateFormat : 'yy-mm-dd',
		duration: 200,
		onSelect:function(dateText, inst){
			var startDate = parseInt($("#date_start").val().replace("-", '').replace("-", ''));
			var endDate = parseInt(dateText.replace(/-/g,''));
			
            if (startDate > endDate) {
            	makeAlert(1,"확인","기간은 과거로 설정할 수 없습니다","false",null);
            	//달력에 종료 날짜 넣어주기
        		$("#date_end").val($("#endDate").val());
			} else {
				$("#endDate").val($("#date_end").val());
			}
		}
	});
	/* 달력부분 */
	/* 달력부분 */
	 
	
	 
	 $("#empSearchBtn").on("click",function(){
			makePopup(1, "사원조회", empPopup() , true, 700, 386, function(){
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
					$("#dptyNo").val($(this).attr("name"));
					$("#dptyDeptName").val($(this).children().eq(0).html());
					$("#dptyName").val($(this).children().eq(1).html());
					$("#selectEmpFlag").val("1");
				});
				
			}, "선택", function(){ 
				if($("#selectEmpFlag").val() == "1"){
					$("#person_select_txt").val($("#selectEmpNo").val());
					$("#formEmpNo").val($("#selectEmpNo").val());
				}
				
				closePopup(1);
			});
			
			/* makeAlert(1, "test", "test중입니다.", true, null); */
			
			/* makeConfirm(1, "test", "test중입니다.", true, function(){
				alert("aa");
			}); */		
		});
	 
	 
		$("#reqBtn").on("click",function(){
			if($.trim($("#date_start").val()) != "" || $.trim($("#date_end").val()) != ""
	 			|| $.trim($("#dptyName").val()) != ""
	 				|| $.trim($("#dptyDeptName").val()) != ""
	 					|| $.trim($("#dptyNo").val()) != ""
	 						|| $.trim($("#why").val()) != ""){
				makeConfirm(1,"확인","신청하시겠습니까?","false",reqVaca);
		 	}else{
		 		/* 컨펌 팝업으로 */
		 		makeConfirm(1,"거절","빈칸을 채워주세요.","false",null);
		 	}
		});
		
	 
	});
	/* 신청 버튼 누를 시 실행 될 ajax */
	function reqVaca(){

		$("#expCon").val(apvVaca());
		$("#impDate").val($("#dataForm [name='startDate']").val());
		var params = $("#dataForm").serialize(); 
		 $.ajax({
			type : "post",
			url : "HRvacaReqAjax",
			dataType : "json",
			data : params,
			success : function(result){
				if(result.checkLeftError == "" || result.checkLeftError == null){
					
					makeAlert(2,"확인","신청이 완료되었습니다.","false",function() {
						
						location.reload();
					});
				}else{
					makeAlert(2,"실패",result.checkLeftError,"false",null);
				}
				
			},
			error : function(request, status, error){
				
				makeConfirm(2,"실패","신청이 실패하였습니다.","false",null);
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		}); 
	}
/* 	function apvStart(){
		$("#expCon").val(apvVaca());
		$("#impDate").val($("#dataForm [name='startDate']").val());
		var params = $("#apvForm").serialize(); 
		$.ajax({
			type : "post",
			url : "HRApvVacaAjax",
			dataType : "json",
			data : params,
			success : function(result){
				
				
			},
			error : function(request, status, error){
				console.log("status : " + request.status);
				console.log("text : " + request.responseText);
				console.log("error : " + error);
			}
		});
	} */
function apvVaca(){
	var expCon="";
	expCon += "<table border=\"1\" cellpadding=\"1\" cellspacing=\"0\">";
	expCon += "   <tbody>";
	expCon += "      <tr>";
	expCon += "         <td style=\"background-color:#dee6ef; border-color:#134074; text-align:center; width:150px\"><span style=\"font-size:14px\"><strong>항목</strong></span></td>";
	expCon += "         <td style=\"background-color:#dee6ef; border-color:#134074; text-align:center; width:550px\"><span style=\"font-size:14px\"><strong>상세 내용</strong></span></td>";
	expCon += "      </tr>";
	expCon += "      <tr>";
	expCon += "         <td style=\"border-color:#134074; height:50px; text-align:center\">휴가명</td>";
	expCon += "         <td style=\"border-color:#134074; height:50px; text-align:center\">" + $('#vacaGbn option[value='+ $("select[name='vacaGbn']").val() +']').html() + "</td>";
	expCon += "      </tr>";
	expCon += "      <tr>";
	expCon += "         <td style=\"border-color:#134074; height:50px; text-align:center\">직무대행자명</td>";
	expCon += "         <td style=\"border-color:#134074; height:50px; text-align:center\">" + $("#dataForm [name='dptyName']").val()+ "</td>";
	expCon += "      </tr>";
	expCon += "      <tr>";
	expCon += "         <td style=\"border-color:#134074; height:50px; text-align:center\">기간</td>";
	expCon += "        <td style=\"border-color:#134074; height:50px; text-align:center\">" + $("#dataForm [name='startDate']").val() + " ~ " + $("#dataForm [name='endDate']").val() + "</td>";
	expCon += "     </tr>";
	expCon += "     <tr>";
	expCon += "         <td style=\"border-color:#134074; height:50px; text-align:center\">휴가사유</td>";
	expCon += "         <td style=\"border-color:#134074; height:50px; text-align:center\">" + $("#dataForm [name='vacaReason']").val()+ "</td>";
	expCon += "      </tr>";
	expCon += "   </tbody>";
	expCon += "</table>";
	return expCon;
}

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
				html += "<td>" + list[i].NAME + "</td>";
				html += "</tr>";
			}
		}
		
		$("#listCon tbody").html(html);
}
	
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
	}
	
	function popUpSearch(){
		$("#empSearchTxt").val($.trim($("#search_txt").val()));
		
		var params = $("#dataForm").serialize(); 
		
		$.ajax({
			type : "post",
			url : "HRempSearch1Ajax",
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
	}



</script>
</head>
<body>

<c:import url="/topLeft"> <%-- top이란 주소를 넣어 보여주는 것. --%>
   <%-- <c:param name="topMenuNo" value="49"></c:param>
   <c:param name="leftMenuNo" value="55"></c:param> --%>
   <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
   <c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> 
</c:import>


<div class="content_area">
	
	<div class="content_nav">HeyWe &gt; 인사 &gt; 인사관리 &gt; 휴가관리&gt; 휴가신청</div>
	<!-- 내용 영역 -->
	<div class="content_title">
		<div class="content_title_txt">휴가 신청</div>
	</div>
	<!-- form의 시작 -->
	<!-- form의 시작 -->
	<!-- form의 시작 -->
	<form action="#"  method="post" id="dataForm" >
	<div class="content_area_table_area">
		<table id = "table_va" border = "1" cellspacing="0">
			<colgroup>
				<c:forEach var="data" items="${vList}">
					<col width="100"/>
				</c:forEach>
				
			</colgroup>
			<thead></thead>
			<tbody>
				<tr height= "20" id = "table_color">
					<!-- vacaStd 가져올 것 -->
					<c:forEach var="data" items="${vList}">
					<!-- 수정수정수정 -->
					<!-- 수정수정수정 -->
					<!-- 수정수정수정 -->
					<!-- 수정수정수정 -->
					<!-- 수정수정수정 -->
					<!-- 수정수정수정 -->
					<!-- 수정수정수정 -->
					<!-- 수정수정수정 -->
						<th name = "${data.VACA_STD_NO}">${data.VACA_NAME}</th>
					</c:forEach>
				</tr>
				<tr height= "20">
					<!-- vacaStd 가져올 것 -->
					<c:forEach var="data" items="${vList}">
					<!-- 디비로 BASIC_DAY에서 VACA_REQ_REC 기록을 빼서 계산된 값 가져오기 -->
						<th name = "${data.LEFT_VACA}">${data.LEFT_VACA}</th>
					</c:forEach>
				</tr>
			</tbody>
		</table>
	</div>
	
	<input type="hidden" id="title" name="title" value="휴가신청" />
	<input type="hidden" id="apvDocTypeNo" name="apvDocTypeNo"  value=""/>
	<input type="hidden" id="con" name="con" value="휴가신청" />
	<input type="hidden" id="impDate" name="impDate"  /> <!-- start date 박자 -->
	<input type="hidden" id="expCon" name="expCon"/> <!-- apvVaca() 박자  -->
	<input type="hidden" id="outApvTypeNo" name="outApvTypeNo"  value="1"/> <!-- 휴가신청은 1 -->
	<input type="hidden" id="connectNo" name="connectNo"/>
	<input type="hidden" id="apverNos" name="apverNos" />
	<input type="hidden" id="allApvWhether" name="allApvWhether" value="1" /><!-- 전결가능여부 -->
	<input type="hidden" id="startDate" name="startDate" value="${stdt}" />
	<input type="hidden" id="endDate" name="endDate" value="${eddt}" />
	<input type="hidden" id="empSearchTxt" name="empSearchTxt" />
	<div id= "content_area_input_area">
		<div class= "content_area_input_area_sub_parent">
		<div id = "info">신청자 정보</div>
			<div class = "content_area_input_area_sub">
				<div>이름</div>
				<input type="text" class = "txt_disabled" disabled="disabled" value = "${sName}"/>
			</div>
			<div class = "content_area_input_area_sub">
				<div>부서명</div>
				<input type="text" class = "txt_disabled" disabled="disabled" value = "${sDeptName}"/>
			</div>
			<div class = "content_area_input_area_sub">
				<div>직위명</div>
				<input type="text" class = "txt_disabled" disabled="disabled" value = "${sPosiName}"/>
			</div>
			<div class = "content_area_input_area_sub">
				<div>휴가종류</div>
				<select name = "vacaGbn" id = "vacaGbn">
				
					<c:forEach var="data"  items="${vList}">
						<option value="${data.VACA_STD_NO}">${data.VACA_NAME}</option>
					</c:forEach>
				</select>
			</div>
			<div class = "content_area_input_area_sub">
				<div>기간</div>

				<input type="text" width="80px" title="시작기간선택" id="date_start" name="date_start" value="" readonly="readonly" />
				~
				<input type="text" title="종료기간선택" id="date_end" name="date_end" value="" readonly="readonly" />
			</div>
		</div>
		
		<div class= "content_area_input_area_sub_parent">
			<div id = "info">직무 대행자 정보</div>
			<div class = "content_area_input_area_sub">
				<div>직무대행자명</div>
				<input type="text" id="dptyName" name="dptyName" readonly>
			</div>
			<div class = "content_area_input_area_sub">
				<div>대행자코드</div>
				<input type="text"  id="dptyNo" name="dptyNo" readonly>
			</div>
			<div class = "content_area_input_area_sub">
				<div>부서명</div>
				<input type="text" id="dptyDeptName" readonly>
				<%-- <select id = "deptGbn">
					<c:forEach var="data"  items="${deptList}">
					<!-- 부서이름 뽑아오기 -->
						<option value="${data.DEPT_NO}">${data.DEPT_NAME}</option>
					</c:forEach>
				</select> --%>
			</div>
		<%-- 	<div class = "content_area_input_area_sub">
				<div>직위명</div>
				<input type="text"  disabled="disabled" id="dptyPosiName" />
				<select id = "posiGbn">
				
					<c:forEach var="data"  items="${posiList}">
					<!-- 부서이름 뽑아오기 -->
						<option value="${data.RANGE_SEQ}">${data.POSI_NAME}</option>
					</c:forEach>
					
				</select>
			</div> --%>
			<input type = "button" id="empSearchBtn" value = "검색"/> 
		</div> 
		
		<div class= "content_area_input_area_sub_parent">
			<div class = "content_area_input_area_sub">
				<div>사유</div>
				<input type="text"  id = "why" name="vacaReason"/>
			</div>
		</div>
		<div class= "content_area_input_area_sub_parent2">
			<input type = "button" id="reqBtn" value = "신청"/>
		</div>
	</div>
	<!-- form의 끝 -->
	<!-- form의 끝 -->
	<!-- form의 끝 -->
	</form>
</div>
<!-- 결재용 form -->
<%-- <form action="#" method="post" id="apvForm">
	<input type="hidden" id="title" name="title" value="휴가신청" />
	<input type="hidden" id="apvDocTypeNo" name="apvDocTypeNo"  value=""/>
	<input type="hidden" id="con" name="con" value="휴가신청" />
	<input type="hidden" id="impDate" name="impDate"  /> <!-- start date 박자 -->
	<input type="hidden" id="expCon" name="expCon"/> <!-- apvVaca() 박자  -->
	<input type="hidden" id="outApvTypeNo" name="outApvTypeNo"  value="1"/> <!-- 휴가신청은 1 -->
	<input type="hidden" id="connectNo" name="connectNo"/>
	<input type="hidden" id="exceptEmpNo" name="exceptEmpNo" value="${sEmpNo}"/>
	<input type="hidden" id="allApvWhether" name="allApvWhether" value="1" /><!-- 전결가능여부 -->
</form> --%>
</body>
</html>