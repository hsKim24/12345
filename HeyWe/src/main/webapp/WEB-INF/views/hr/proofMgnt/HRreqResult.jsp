 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 신청결과</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/hr/proofMgnt/reqResult.css" />
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
	if($("#page").val() == ""){
		$("#page").val("1");
	}
	
	redrawResultload();
	
	$("#pagingArea").on("click", "input", function() {
		$("#page").val($(this).attr("name"));
		redrawResultload();
	});
	
	$("#printArea").css("display","none");
	$("#printAreaB").css("display","none");
	

});


function redrawResultload(){
	var params = $("#dataForm").serialize();
	   console.log(params);
	   $.ajax({
	      type : "post",
	      url : "HRReqResultAjax", 
	      dataType : "json",
	      data : params, 
	      success : function(result) {
	    	  redrawResultList(result.list2);
			  redrawPaging(result.pb);
	      },
	      error : function(request, status, error){
	         console.log("status : " + request.status);
	         console.log("text : " + request.responseText);
	         console.log("error : " + error);
	      }
	   });
}

function redrawResultList(list){
	
	var html = "";
	
	if(list.length == 0){
		html += "<tr class=\"not\" height=\"50\"><td colspan=\"7\">조회결과가없습니다</td></tr>";
	}else{
		for(var i = 0 ; i < list.length; i++){
			html +="<tr class=\"jmscnt\" name=\""+ list[i].PI_NO +"\">";
			html +="<td>"+list[i].NO +"</td>";
			html +="<td>" + list[i].NAME + "</td>";
			html +="<td>" + list[i].PROOF_NAME + "</td>";
			html +="<td>" + list[i].REQ_DATE + "</td>";
			html +="<td>" + list[i].CD_REQ + "</td>";
			html +="<td>";
			if(list[i].APV_DIV == '3'){
				html +="<input type=\"button\" value=\"인쇄\"  name=\"" + list[i].PROOF_NO + "\" class=\"printBtn\"/> </td>";
			}else{
				html += "-";
			}
			html +="<td>" + list[i].PRO_CON + "</td>"; 
			html +="</tr>";
		}
		
		
	}
	
	$(".jmstable tbody").html(html);
	$(".printBtn").on("click", function() {
		$("#proofType").val($(this).attr("name"));
		$("#proofNo").val($(this).parent().parent().attr("name"));
		if($("#dataForm #proofType").val() == '2'){
			proofPrint();
		}else {
			proofPrintB();
		}
		
	});
}



function oneProofPrint(data, data2){
	var html = "";

			
			html +="<div class=\"bg\">";
	 		html +="<div class=\"popup\">";
			html +="<div class=\"popuptitle\">" + data.PROOF_NAME + "</div>";
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
			
			html +="<div class=\"poptxt\">경력사항</div>";
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
			html +="<td>근무부서</td>";
			html +="<td>" + data.DEPT_NAME + "</td>";
			html +="<td>직 위</td>";
			html +="<td>" + data.POSI_NAME + "</td>";
			html +="</tr>";
			
			html +="<tr class=\"jmspopcnt\">";
			html +="<td>담당업부</td>";
			html +="<td>인사</td>";
			html +="<td></td>";
			html +="<td></td>";
			html +="</tr>";
			
			html +="<tr class=\"jmspopcnt\">";
			html +="<td>재직기간</td>";
			html +="<td colspan=\"3\">" + data.APNT_DATE + "~" + "</td>";
			html +="</tr>";
			
			html +="<tr class=\"jmspopcnt\">";
		 	html +="<td>용 도</td>";
			html +="<td colspan=\"3\">" + data.CON + "</td>";
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
			html +="<td>오 수 현</td>";
			html +="</tr>";
			
			html +="<tr class=\"jmspopcnt\">";
			html +="<td>직 책</td>";
			html +="<td>부 장</td>";
			html +="<td>연 락 처</td>";
			html +="<td>123-4567</td>";
			html +="</tr>";
			html +="</tbody>";
			html +="</table>";

			html +="<div class=\"poptxt2\"> <pre>위와 같이 퇴직사항을 증명하며, 이 증명이 허위작성 또는 위조 등으로 다를 때에는<br>"  
			html +="공,사문서의 위조, 변조, 통행사 등으로 인한 형사 처분도 감수하겠습니다.</pre>"
			html +="</div>"
			
			html +="<div class=\"date\">" + data.REQ_DATE + "</div>";

			html +="</div>";
			html +="</div>";
		
			$("#printArea").html(html);
			console.log("Aa");
			pageprint(); 
			
}

function proofPrint(){    
	var params = $("#dataForm").serialize();
	   console.log(params);
	   $.ajax({
	      type : "post",
	      url : "HRProofDtlAjax", 
	      dataType : "json",
	      data : params, 
	      success : function(result) {
	    	  oneProofPrint(result.data, result.data2);
	      },
	      error : function(request, status, error){
	         console.log("status : " + request.status);
	         console.log("text : " + request.responseText);
	         console.log("error : " + error);
	      }
	   });
}


function twoProofPrint(data, data2){
	var html = "";

	html +="<div class=\"content_down\">";
	html +="<div id=\"proofPopup\">";
	html +="<div class=\"main_name\">재직증명서</div>";
	html +="<table class=\"content_down_table\" border=\"1\">";
	html +="<tbody>";			
	html +="<tr>";
	html +="<th class=\"gray_content\">성명</th>";
	html +="<th class=\"white_content\">" + data.NAME + "</th>";
	html +="<th class=\"gray_content\">주민등록번호</th>";
	html +="<th class=\"white_content\">" + data.RRNUM1 + "-" + data.RRNUM2  + "</th>";
	html +="</tr>";
	html +="<tr>";
	html +="<th class=\"gray_content\">주소</th>";
	html +="<th class=\"white_content\" colspan=\"3\">" + data.ADDR + "</th>";
	html +="</tr>";
	html +="<tr>";
	html +="<th class=\"gray_content\">부서</th>";
	html +="<th class=\"white_content\">" + data.DEPT_NAME + "</th>";
	html +="<th class=\"gray_content\">직위</th>";
	html +="<th class=\"white_content\">" + data.POSI_NAME + "</th>";
	html +="</tr>"; 
	html +="<tr>";
	html +="<th class=\"gray_content2\">재직기간</th>";
	html +="<th class=\"white_content\" colspan=\"3\">" + data.APNT_DATE + " ~ " + data.A + "</th>";
	html +="</tr>";
	html +="</tbody>";
	html +="</table>";
	html +="<div class=\"상기인\">";
	html +="<textarea class=\"상기인2\" rows=\"7\" cols=\"134\">";
	html += "상기인은 위와같이 당사에 재직하고 있음을 증명합니다.</textarea>";
	html +="</div>";
	
	html +="<br>";
	html +="<div class=\"용도\">용도 :" + data.CON + "</div>";
	html +="<div class=\"용도\">작성일자 :" + data.APNT_DATE + "</div>";
	html +="<div class=\"용도\">주 소 :" + data2.ADDR + "</div>";
	html +="<div class=\"용도\">회 사 명 :" + data2.CO_NAME + "</div>";
	html +="<div class=\"용도\">대 표 이 사 :" + data2.CO_RPSTNER + "</div>";
	html +="</div>";
	html +="</div>";
	
	
	$("#printAreaB").html(html);
	pageprint(); 

}

function proofPrintB(){    
	var params = $("#dataForm").serialize();
	   console.log(params);
	   $.ajax({
	      type : "post",
	      url : "HRProofDtlAjax", 
	      dataType : "json",
	      data : params, 
	      success : function(result) {
	    	  twoProofPrint(result.data, result.data2);
	      },
	      error : function(request, status, error){
	         console.log("status : " + request.status);
	         console.log("text : " + request.responseText);
	         console.log("error : " + error);
	      }
	   });
}


var initBody;

function beforePrint()
{
    initBody = document.body.innerHTML;
    if($("#proofType").val() == "2"){
		document.body.innerHTML = printArea.innerHTML;
    } else if ($("#proofType").val() == "1"){
	    document.body.innerHTML = printAreaB.innerHTML;
    }
    
}

function afterPrint()
{
 	document.body.innerHTML = initBody;
 	history.go(0);
}	

function pageprint()
{
	window.onbeforeprint = beforePrint;
    window.onafterprint = afterPrint;
    window.print();
}



function redrawPaging(pb) {
	var html = "";
	
	html += "<input type=\"button\" value=\"&lt&lt\" name=\"1\" />";
	
	if($("#page").val() == "1"){
		html += "<input type=\"button\" value=\"&lt\" name=\"1\" />";
	}else{
		html += "<input type=\"button\" value=\"&lt\" name=\""
							+ ($("#page").val() * 1 - 1) + "\" />";
	}
	
	for(var i = pb.startPcount ; i <= pb.endPcount ; i++){
		if(i == $("#page").val()){
			html += "<input type=\"button\" value=\"" + i + "\" name=\""
											+ i + "\" disabled=\"disabled\" class=\"paging_on\" />";
		}else{
			html += "<input type=\"button\" value=\"" + i + "\" name=\"" + i + "\" class=\"paging_off\" />";
			
		}
		
	}
	
	if($("#page").val() == pb.maxPcount){
		html += "<input type=\"button\" value=\"&gt\" name=\"" + pb.maxPcount + "\" />";
	}else{
		html += "<input type=\"button\" value=\"&gt\" name=\""
											+ ($("#page").val() * 1 + 1) + "\" />";
	}
	
	html += "<input type=\"button\" value=\"&gt&gt\" name=\"" + pb.maxPcount + "\" />";
	
	$("#pagingArea").html(html);
	
}



</script>
</head>
<body>
<c:import url="/topLeft">
	<c:param name="topMenuNo" value="49"></c:param>
	<c:param name="leftMenuNo" value="77"></c:param>
	<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
</c:import>


<div class="content_area">
	<form action="#" id="dataForm" method="post">
  		<input type="hidden" id="empNo" name="empNo"  value="${sEmpNo}" /> 
  		<input type="hidden" name="page" id="page" value="${page}" />
  		<input type="hidden" name="proofNo" id="proofNo"/> 
		<input type="hidden" name="proofType" id="proofType" value="" />
   	</form>
	
	<!-- 메뉴 네비게이션 -->
	<div class="content_nav">HeyWe &gt; 인사 &gt; 증명서관리 &gt; 신청결과</div>
	<!-- 현재 메뉴 제목 -->
	<div class="content_title">
        <div class="content_title_text">신청결과</div>
   </div>
	<!-- 내용 영역 -->


	
<!-- 신청결과 ---->	


	<div class="jms">
   
   		<table class="jmstable" border="1" cellspacing="0" >
   			<colgroup>
   				<col width="30px" />
   				<col width="70px" />
   				<col width="100px" />
   				<col width="100px" />
   				<col width="100px" />
   				<col width="100px" />
   			</colgroup>
   			<thead>
   				<tr class="jmstitle">
   					<th>NO</th>
   					<th>이름</th>
   					<th>증명서종류</th>
   					<th>신청날짜</th>
   					<th>신청상태</th>
   					<th>인쇄</th>
   					<th>처리내용</th> 
   				</tr>
   			</thead>
   			<tbody>
			</tbody>
		</table>
		<div id="pagingArea">
		</div>
	</div> <!-- jms -->
 	
 	
<!--  인쇄 페이지  -->
 



 	
<div class="jms" id="printArea">
</div>
 <div class="jms" id="printAreaB">
</div>
 	
 	
</div><!-- 내용 --> 

</body>
</html>