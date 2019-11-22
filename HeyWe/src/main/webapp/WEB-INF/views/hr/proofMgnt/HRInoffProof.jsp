<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>HeyWe - 재직증명서</title>
<link rel="stylesheet" type="text/css" href="resources/css/erp/common/main.css" />
<link rel="stylesheet" type="text/css" href="resources/css/erp/hr/proofMgnt/HRInoffProof.css" />


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
	console.log(params);
	
	$.ajax({ 
		type : "post",  		//데이터 전송방식
		url : "HRInoffProofAjax",		//주소
		dataType : "json",		//데이터 전송 규격
		data : params,
		// json양식 -> {키:값,키:값,...}
		success : function(result) {  //성공했을 때 넘어오는 값을 result변수로 받겠다.
			
			if(result.msg=="" || result.msg== null){
			console.log(result.msg);
			makeAlert(2, "재직증명서", "신청되었습니다.", true, null);
			}else{
				alert(result.msg);
			}
		},
		
		error : function(request, status, error) {
			console.log("status :" + request.status);
			console.log("text :" + request.responseText);
			console.log("error :" + error);
			makeAlert(2, "재직증명서", "신청에실패하였습니다.", false, null);
			
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
	<c:param name="leftMenuNo" value="73"></c:param>
	<%-- <c:param name="topMenuNo" value="${param.topMenuNo}"></c:param>
	<c:param name="leftMenuNo" value="${param.leftMenuNo}"></c:param> --%>
</c:import>

<div class="content_area">
	<div class="content_nav">HeyWe &gt; 인사 &gt; 증명서관리 &gt; 재직증명서</div>
	<!-- 내용 영역 -->
	<div class="content_title">
     
      <div class="content_title_text">증명서 관리 </div>
   </div>
   <br/>
<div class="content_down">
<div class="main_name">재직증명서</div>
<br/>
	<table class= "content_down_table" border="1">
	<thead></thead>
	<tbody>
	<tr>
	<th class="gray_content">성명</th>
	<th class="white_content">${data.NAME}</th>
	<th class="gray_content">주민등록번호</th>
	<th class="white_content">${data.RRNUM1} - ${data.RRNUM2}</th>
	</tr>
	<tr>
	<th class="gray_content">주소</th>
	<th class="white_content" colspan="3">${data.ADDR}</th>
	</tr>
	<tr>
	<th class="gray_content">부서</th>
	<th class="white_content">${data.DEPT_NAME}</th>
	<th class="gray_content">직위</th>
	<th class="white_content">${data.POSI_NAME }</th>
	</tr>
	<tr>
	<th class="gray_content2">재직기간</th>
	<th class="white_content" colspan="3">${data.ST} ~ ${data3.A}
	</th>
	</tr>
	</tbody>
	</table>
	<div class="상기인">
	<textarea class="상기인2" rows="7" cols="134">
	 
	 
	 
	상기인은 위와 같이 당사에 재직하고 있음을 증명합니다.</textarea>
	</div>
	<br/>
	<div class="용도">용도  :
	<input class="용도text" type="text" id="cons" />
	</div>
	<div class="용도">작성일자  : ${data3.A}</div>
	<div class="용도">주  소  :  ${data2.ADDR}</div>
	<div class="용도">회  사  명  :${data2.CO_NAME}</div>
	<div class="용도">대 표 이 사  : ${data2.CO_RPSTNER}</div>
	<div>
	<button class="신청">신 청</button>
	</div>
</div>
<div id="popup"></div>
<div id = "popupBox">
   <div>신청하시겠습니까?</div>
   <input type="button" value = "예" id="yesBtn">
   <input type="button" value = "아니오" id="close">
	</div>
<br/>
	<div class="여백"></div>
</div>

</body>
</html>