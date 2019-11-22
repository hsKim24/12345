<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 경력증명서</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/hr/proofMgnt/HRCareerProof.css" />

<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	
   $(".신청").on("click",function(){
		   makeConfirm(1, "증명서신청", "신청하시겠습니까.", true, ProofApply);
   });
	
});
	

function ProofApply() {
	
	$("#contents").val($("#cons").val());
	var params = $("#dataForm").serialize();
	/* alert($("#contents").val()); */
	console.log(params);
	
	$.ajax({ 
		type : "post",  		//데이터 전송방식
		url : "HRCareerProofAjax",		//주소
		dataType : "json",		//데이터 전송 규격
		data : params,
		// json양식 -> {키:값,키:값,...}
		success : function(result) {  //성공했을 때 넘어오는 값을 result변수로 받겠다.
			
			if(result.msg=="" || result.msg== null){
			console.log(result.msg);
			makeAlert(2, "경력증명서", "신청되었습니다.", true, null);
			}else{
				alert(result.msg);
			}
		},
		
		error : function(request, status, error) {
			console.log("status :" + request.status);
			console.log("text :" + request.responseText);
			console.log("error :" + error);
			makeAlert(2, "경력증명서", "신청에실패하였습니다.", false, null);
			
		}
	});
};
</script>

<style type="text/css">
/* 
	DarkBlue : rgb(19, 64, 116), #134074
	DeepLightBlue : rgb(141, 169, 196), #8DA9C4
	LightBlue : rgb(222,230,239), #DEE6EF
	White : rgb(255,255,255), #FFFFFF
 */
</style>
</head>
<body>

<form action="#" id="dataForm" method="post">
<input type="hidden" name="sEmpNo" id="sEmpNo" value="${sEmpNo}" />
<input type="hidden" name="contents" id="contents" />
</form>

<c:import url="/topLeft">
	<c:param name="topMenuNo" value="49"></c:param>
	<c:param name="leftMenuNo" value="74"></c:param>
	<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
</c:import>
<div class="content_area">
	<div class="content_nav">HeyWe &gt; 인사 &gt; 증명서관리 &gt; 경력증명서</div>
	<!-- 내용 영역 -->
	<div class="content_title">
      <div class="content_title_text">증명서 관리 </div>
   </div>
   <br/>
<div class="content_down">
<div class="main_name">경력증명서</div>
<div class="인적사항">인적사항</div>
	<table class="content_down_table" border="1">
	<thead></thead>
	<tbody>
		<tr>
		<th class="gray_content" rowspan="2">성명</th>
		<th class="white_content" rowspan="2">${data.NAME} </th>
		<th class="gray_content" rowspan="2">주민등록번호</th>
		<th class="white_content" rowspan="2">${data.RRNUM1} - ${data.RRNUM2}</th>
		</tr>
		<tr>
		
		</tr>
		<tr>
		<th class="gray_content">주소</th>
		<th class="white_content"colspan="3">${data.ADDR}</th>
		</tr>
	</tbody>
	</table>

<div class="인적사항">경력사항</div>
	<table class="content_down_table" border="1">
	<thead></thead>
	<tbody>
		<tr>
		<th class="gray_content">회 사 명</th>
		<th class="white_content">${data2.CO_NAME}</th>
		<th class="gray_content">사업자 등록번호</th>
		<th class="white_content">${data2.CO_REG_NO}</th>
		</tr>
		<tr>
		<th class="gray_content">대 표 자</th>
		<th class="white_content">${data2.CO_RPSTNER} </th>
		<th class="gray_content">업  종</th>
		<th class="white_content">${data2.CO_TASK_KIND}</th>
		</tr>
		<tr>
		<th class="gray_content">소 재 지</th>
		<th class="white_content"colspan="3">${data2.ADDR}</th>
		</tr>
		<tr>
		<th class="gray_content">근무부서</th>
		<th class="white_content">${data.DEPT_NAME} </th>
		<th class="gray_content">직  위</th>
		<th class="white_content">${data.POSI_NAME }</th>
		</tr>
		<tr>
		<th class="gray_content">담당업무</th>
		<th class="white_content">경영 기획 </th>
		<th class="gray_content">  </th>
		<th class="white_content">  </th>
		</tr>
		<tr>
		<th class="gray_content">재직기간</th>
		<th class="white_content"colspan="3">${data.ST}~${data4.A}</th>
		</tr>
		<tr>
		<th class="gray_content">용도</th>
		<th class="white_content" colspan="3" >
		<input class ="day" type="text" id="cons"></th>
		</tr>
	
	</tbody>
	</table>
	
<div class="인적사항">발급처</div>
	<table class="content_down_table" border="1">
	<thead></thead>
	<tbody>
		<tr>
		<th class="gray_content">담당업무</th>
		<th class="white_content">${data3.DEPT_NAME } </th>
		<th class="gray_content">담 당 인</th>
		<th class="white_content">${data3.NAME }</th>
		</tr>
		<tr>
		<th class="gray_content">직  책</th>
		<th class="white_content">${data3.POSI_NAME }</th>
		<th class="gray_content">연 락 처</th>
		<th class="white_content">${data2.CO_CONTACT}</th>
		</tr>
	</tbody>
	</table>
<div class="고정">위와 같이 경력사항을 증명하며, 이 증명이 허위작성 또는 위조 등으로 다를 때에는 공,사문서의
<br/> 위조,변조,통행사 등으로 인한 형사 처분도 감수하겠습니다.</div>
<div class="고정">${data4.A}</div>
<div class="고정">(주)${data2.CO_NAME}
<br/>대표자 ${data2.CO_RPSTNER}
<br/>
<button class="신청">신 청</button>
</div>
</div>

<div id="popup"></div>
<div id = "popupBox">
   <div>신청하시겠습니까?</div>
   <input type="button" value = "예" id="yesBtn">
   <input type="button" value = "아니오" id="close">
	</div>
	
	<div class="여백"> </div>
</div>