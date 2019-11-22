<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 퇴직증명서</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/hr/proofMgnt/retireProof.css" />
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
<script type="text/javascript">
$(document).ready(function(){
	
	reloadRetireProof();
});

function reloadRetireProof(){    // 인적사항 
	var params = $("#dataForm").serialize();
	   
	   $.ajax({
	      type : "post",
	      url : "HRRetireProofAjax", 
	      dataType : "json",
	      data : params, 
	      success : function(result) {
	    	  redrawRetireProof(result.data, result.data2);
	      },
	      error : function(request, status, error){
	         console.log("status : " + request.status);
	         console.log("text : " + request.responseText);
	         console.log("error : " + error);
	      }
	   });
}


function redrawRetireProof(data, data2){
	var html = "";
	
	html +="<div class=\"bg\">";
	html +="<div class=\"popup\">";
	html +="<div class=\"popuptitle\">퇴직증명서</div>";
	html +="<div class=\"poptxt\">인적사항</div>";
	html +="<table class=\"jmspoptable\" border=\"1\" cellspacing=\"0\">";
	html +="<colgroup>";
	html +="<col width=\"70px\" />";
	html +="<col width=\"100px\" />";
	html +="<col width=\"70px\" />";
	html +="<col width=\"100px\" />";
	html +="</colgroup>";

	html +="<tbody>";	
	html +="<tr class=\"jmspopcnt\">";
	html +="<td>성&nbsp;&nbsp;&nbsp;명</td>";
	html +="<td>" + data.NAME + "</td>";
	html +="<td>주민등록번호</td>";
	html +="<td>" + data.RRNUM1 + "-" + data.RRNUM2 + "</td>";
	html +="</tr>";
	
	html +="<tr class=\"jmspopcnt\">";
	html +="<td>주&nbsp;&nbsp;&nbsp;소</td>";
	html +="<td colspan=\"3\">" + data.ADDR + data.DTL_ADDR + "</td>";
	html +="</tr>";
	html +="</tbody>";
	html +="</table>";
	
	html +="<div class=\"poptxt\">퇴직사항</div>";
	html +="<table class=\"jmspoptable\" border=\"1\" cellspacing=\"0\">";
	html +="<colgroup>";
	html +="<col width=\"70px\" />";
	html +="<col width=\"100px\" />";
	html +="<col width=\"70px\" />";
	html +="<col width=\"100px\" />";
	html +="</colgroup>";	
	
	html +="<tbody>";	
	html +="<tr class=\"jmspopcnt\">";
	html +="<td>회 사 명</td>";
	html +="<td>" + data2.CO_NAME + "</td>";
	html +="<td rowspan=\"2\">사업자등록번호</td>";
	html +="<td rowspan=\"2\">" + data2.CO_REG_NO + "</td>";
	html +="</tr>";
	
	html +="<tr class=\"jmspopcnt\">";
	html +="<td>대 표 자</td>";
	html +="<td>" + data2.CO_RPSTNER + "</td>";
	html +="</tr>";

	html +="<tr class=\"jmspopcnt\">";
	html +="<td>소 재 지</td>";
	html +="<td colspan=\"3\">" + data2.ADDR + "</td>";
	html +="</tr>";
	
	html +="<tr class=\"jmspopcnt\">";
	html +="<td>소속</td>";
	html +="<td>" + data.DEPT_NAME + "</td>";
	html +="<td>직 위</td>";
	html +="<td>" + data.POSI_NAME + "</td>";
	html +="</tr>";
	
	html +="<tr class=\"jmspopcnt\">";
	html +="<td>입 사 일</td>";
	html +="<td colspan=\"3\">" + data.APNT_DATE + "</td>";
	html +="</tr>";
	
	html +="<tr class=\"jmspopcnt\">";
	html +="<td>퇴 사 일</td>";
	html +="<td colspan=\"3\">" + data.FNSH_DATE + "</td>";
	html +="</tr>";
	
	html +="<tr class=\"jmspopcnt\">";
	html +="<td>퇴 직 사 유</td>";
	html +="<td colspan=\"3\"><input type=\"text\" size=\"75\"></td>";
	html +="</tr>";
	html +="</tbody>";
	html +="</table>";
	
	html +="<div class=\"poptxt\">발급처</div>";
	html +="<table class=\"jmspoptable\" border=\"1\" cellspacing=\"0\">";
	html +="<colgroup>";
	html +="<col width=\"70px\" />";
	html +="<col width=\"100px\" />";
	html +="<col width=\"70px\" />";
	html +="<col width=\"100px\" />";
	html +="</colgroup>";
	
	html +="<tbody>";	
	html +="<tr class=\"jmspopcnt\">";
	html +="<td>담 담 부 서</td>";
	html +="<td>인 사 부</td>";
	html +="<td>담 당 자</td>";
	html +="<td>김 철 수</td>";
	html +="</tr>";
	
	html +="<tr class=\"jmspopcnt\">";
	html +="<td>직 책</td>";
	html +="<td>과 장</td>";
	html +="<td>연 락 처</td>";
	html +="<td>123-4567</td>";
	html +="</tr>";
	html +="</tbody>";
	html +="</table>";

	html +="<div class=\"poptxt2\"> <pre>위와 같이 퇴직사항을 증명하며, 이 증명이 허위작성 또는 위조 등으로 다를 때에는"  
	html +="공,사문서의 위조, 변조, 통행사 등으로 인한 형사 처분도 감수하겠습니다.</pre>"
	html +="</div>"
	
	html +="<div class=\"date\">" + data.ISSUE_DATE + "</div>";


	html +="<table class=\"jmspoptable2\" border=\"1\" cellspacing=\"0\">";
	html +="<tbody>";	
	html +="<tr class=\"jmspopcnt\">";
	html +="<td>담 당 자</td>";
	html +="<td>확 인 자</td>";
	html +="</tr>";
	
	html +="<tr class=\"jmspopcnt\">";
	html +="<td>김 철 수</td>";
	html +="<td>김 칠 수</td>";
	html +="</tr>";
	html +="</tbody>";
	html +="</table>";

	html +="</div>";
	html +="</div>";
	
	$(".jms").html(html);
	
}
</script>
</head>
<body>
<c:import url="/topLeft">
	<c:param name="topMenuNo" value="49"></c:param>
	<c:param name="leftMenuNo" value="51"></c:param>
	<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
</c:import>

<div class="content_area">
<form action="#" id="dataForm" method="post">
	<input type="hidden" id="empNo" name="empNo" value="${sEmpNo}" />
</form>
	<!-- 메뉴 네비게이션 -->
	<div class="content_nav">HeyWe &gt; 인사 &gt; 증명서관리 &gt; 증명서관리</div>
	<!-- 현재 메뉴 제목 -->
	<div class="content_title">
        <div class="content_title_text">퇴직증명서</div>
   </div>
	<!-- 내용 영역 -->

	
<!-- <div class="tabbtn_area"> -->
<input  type="button" value="신청" id="ReqBtn">
<!-- </div> -->		
<div class="jms">	
</div> <!-- jms -->

</div> <!--내용  -->

</body>
</html>